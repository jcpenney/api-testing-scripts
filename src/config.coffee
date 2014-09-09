module.exports =

  credentials:
    email: 'jcp.dummy@gmail.com'
    password: 'whenitfits1'

  environments: [
    {
      name: 'Akamai'
      baseURL: 'http://m-dt-test1.jcpenney.com/v2'
    }
    , {
      name: 'Production'
      baseURL: 'https://api.jcpenney.com/v2'
    }
  ]