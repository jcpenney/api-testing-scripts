/****************************************************************/
/* Imports */
/****************************************************************/
var Colors = require('colors');
var Prompt = require('cli-prompt');
var Request = require('request').defaults({ jar: true });


/****************************************************************/
/* Config */
/****************************************************************/

var config = {
  BASE_API_URL: "https://api.jcpenney.com/v2"
};


/****************************************************************/
/* Sign In */
/****************************************************************/

signIn = function(email, password, callback) {

  reqOpts = {
    uri: config.BASE_API_URL + "/session"
    , json: { email: email, password: password }
  };

  Request.post(reqOpts, function(err, httpResponse, body) {
    if (err) return callback(err);
    var cookie = httpResponse.headers['set-cookie'][0];
    Request.cookie(cookie); // Assigns global cookie, applied to all subsequent requests
    callback(null, cookie);
  });

};


/****************************************************************/
/* Get Addresses */
/****************************************************************/

getAddresses = function(callback) {

  reqOpts = {
    uri: config.BASE_API_URL + "/customer/addresses"
  };

  Request.get(reqOpts, function(err, httpResponse, body) {
    if (err) return callback(err);
    callback(null, JSON.parse(body));
  });

};


/****************************************************************/
/* Delete Address */
/****************************************************************/

deleteAddress = function(addressId, callback) {

  reqOpts = {
    uri: config.BASE_API_URL + "/customer/address/" + addressId
    , headers: { 'Content-Type': 'application/json' }
  };

  Request.del(reqOpts, function(err, httpResponse, body) {
    console.log("\n" + body.red);
    if (err) return callback(err);
    callback();
  });

};


/****************************************************************/
/* App Flow */
/****************************************************************/

Prompt("\nEnter your JCP email: ".cyan, function (email) {
  Prompt.password("Enter your JCP password: ".cyan, function (password) {
    console.log("\nSigning in...".yellow);
    signIn(email, password, function(err, cookie) {
      if (err) return console.error("Error signing in:".red, JSON.stringify(err).red);
      console.log("\nSigned in successfully.".green);
      console.log("\nFetching existing addresses...".yellow);
      getAddresses(function(err, addresses) {
        if (err) return console.error("Error fetching addresses:".red, JSON.stringify(err).red);
        console.log("\nAddresses retrieved successfully:\n".green, addresses);
        if (addresses.length > 0) {
          var addressId = addresses[0].id;
          console.log("\nDeleting address ".green + addressId.green + "...".green);
          deleteAddress(addressId, function(err) {
            if (err) return console.error("Error deleting address:".red, JSON.stringify(err).red);
            console.log("\nAddress deleted successfully\n".green);
          });
        } else {
          console.log("\nNo addresses to delete\n".green);
        }
      });
    });
  });
});