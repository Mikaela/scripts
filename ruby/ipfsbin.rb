#!/usr/bin/env ruby

# Prompt for the whatever
print "Enter the IPFS hash/addr: "
# Get the input without \n
ipfsthing = gets.chomp
ipfsgateway = "https://ipfs.io/ipfs/"

# Output the address
puts ipfsgateway + ipfsthing
