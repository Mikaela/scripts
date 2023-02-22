#!/usr/bin/env node

// Require the dns module
var dns = require("dns");

// Function for IPv4
var myip4 = function () {
	// Set DNS servers to OpenDNS IPv4
	var servers4 = dns.setServers(["208.67.222.222", "208.67.220.220"]);

	// Check where myip.opendns.com resolves to and I think this is a
	// function that takes arguments err and addresses.
	dns.resolve4("myip.opendns.com", function (err, addresses) {
		// if err contains a truthy value, an error has occurred
		if (err) throw err;

		// Print the first thing in array addresses as it has our IPv4
		// address.
		console.log(addresses[0]);
	});
};

// IPv6 part is broken because of node bug.
// https://github.com/nodejs/node/issues/894

/*
// Function for IPv6
var myip6 = function () {

    // Set DNS servers to OpenDNS IPv6
    var servers6 = dns.setServers(["2620:0:ccc::2", "2620:0:ccd::2"])

    // Check where myip.opendns.com resolves to and I think this is a function
    // that takes arguments err and addresses.
    dns.resolve6('myip.opendns.com', function (err, addresses) {
    
    // if err contains a truthy value, an error has occurred
    if (err) throw err;

    // Print the first thing in array addresses as it has our IPv4
    // address.
    console.log(addresses[0]);

    });
}
*/

// Call the functions
myip4();
//myip6();
