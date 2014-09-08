## Installing Dependencies

After installing [Node](http://nodejs.org/) and [NPM](https://github.com/npm/npm), run `npm install` from the project's root to install all dependencies.


## Compilation

Run `gulp` from the project's root to compile all coffeescripts and watch for changes to relevant files.


## Testing Address Deletion Service

Run `node build/delete_first_address` from the project root. You will be prompted to provide your jcpenney.com credentials, then the first existing address will be deleted from the authenticated account.

## Crawling Categories

Run `node build/crawl_categories` from the project root.