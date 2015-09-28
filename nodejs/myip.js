#!/usr/bin/env node

// Require the dns module
var dns = require('dns');

// Set DNS servers to OpenDNS nes
var servers4 = dns.setServers(["208.67.222.222", "208.67.220.220"])

// Check where myip.opendns.com resolves to and I think this is a function
// that takes arguments err and addresses.
dns.resolve4('myip.opendns.com', function (err, addresses) {
    
    // In case of error throw the error message?
    if (err) throw err;

    // Print the first thing in array addresses as it has our IPv4
    // address.
    console.log(addresses[0]);

});

/*

// This code makes node codedump for some reason, maybe it has a bug
// with IPv6 handling or it doesn't like my system not having native
// or not-Teredo IPv6 connectivity.

var servers6 = dns.setServers(["2620:0:ccc::2", "2620:0:ccd::2"])

dns.resolve6('myip.opendns.com', function (err, addresses) {
  if (err) throw err;

  console.log(addresses[0]);

});

*/
