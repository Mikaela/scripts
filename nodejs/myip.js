#!/usr/bin/env node

// Require the dns module
var dns = require('dns');

// Set DNS servers to OpenDNS IPv4
var servers4 = dns.setServers(["208.67.222.222", "208.67.220.220"])

// Check where myip.opendns.com resolves to and I think this is a function
// that takes arguments err and addresses.
dns.resolve4('myip.opendns.com', function (err, addresses) {
    
    // if err contains a truthy value, an error has occurred
    if (err) throw err;

    // Print the first thing in array addresses as it has our IPv4
    // address.
    console.log(addresses[0]);

});

// This code makes node codedump for some reason, maybe it has a bug
// with IPv6 handling or it doesn't like my system not having native
// or not-Teredo IPv6 connectivity.

// node: ../deps/cares/src/ares_destroy.c:102: ares__destroy_servers_state: Assertion `ares__is_list_empty(&server->queries_to_server)' failed.
// zsh: abort (core dumped)  ./myip.js

/*

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
*/
