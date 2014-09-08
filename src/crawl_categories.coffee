##################################################################
# Imports
##################################################################
_ = require 'lodash'
Async = require 'async'
Colors = require 'colors'
Request = require 'request'


##################################################################
# Config and Variables
##################################################################

config =
  API_BASE_URL: "https://api.jcpenney.com/v2"

totalCategoriesFetched = 0
lameCategories = []


##################################################################
# Crawl Categories
##################################################################
 
getAllDepartmentsWithCategories = (callback, maxLevel=99999) ->

  fetchCategory = (category, currentLevel, callback) ->

      totalCategoriesFetched++

      # If the max level has been exceeded, we're done here
      return callback() if currentLevel > maxLevel

      # Fetch detailed category data from API
      Request "#{ config.API_BASE_URL }/categories/#{ category.id }", (err, res, body) ->

        # Abandon ship in the event of an error
        return callback(err) if err

        # Parse the response body
        jsonCategory = JSON.parse(body)

        # Determine whether category is valid, based on its url property
        o = "#{ totalCategoriesFetched }: #{ Array(currentLevel + 1).join('...') }#{ category.name } (#{ category.id }) ".white
        if _.isEmpty category.url
          lameCategories.push category
          console.log o + "does not have a valid URL: #{ category.url }".red
        else
          console.log o + "has a valid URL: #{ category.url }".green

        # Merge sub-categories from API response with original category object
        category.categories = jsonCategory.categories

        # If the category has no sub-categories, we're done here
        return callback() if _.isEmpty category.categories

        # Iterate over sub-categories, fetch sub-sub-categories for each
        Async.eachSeries category.categories, (category, callback) ->
          fetchCategory category, currentLevel + 1, (err) -> callback err
        , (err) ->
          # Finished fetching all sub-categories for category
          callback err

    # Fetch all departments from API
    Request "#{ config.API_BASE_URL }/departments", (err, res, body) ->

      # Abandon ship in the event of an error
      return callback(err) if err

      # Parse API departments
      departments = JSON.parse body

      # Iterate over departments, fetching categories for each
      Async.eachSeries departments, (department, callback) ->

        fetchCategory department, 0, (err) ->
          # Finished fetching categories for department
          callback err

      , (err) ->
        
        # Finished fetching categories for all departments
        departments = null if err
        callback err, departments


##################################################################
# Script Flow
##################################################################

console.log "\nFetching category tree...\n".cyan
getAllDepartmentsWithCategories (err, callback) ->
  return console.error "\nError crawling categories:".red, JSON.stringify(err).red if err
  console.log "\nFinished crawling categories\n".green
  if _.isEmpty lameCategories
    console.log "\nAll categories appear to be valid!"
  else
    console.log "\nThese are the invalid ones:"
    for category in lameCategories
      console.log "...#{ category.name } (#{ category.id })"