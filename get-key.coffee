NodeRSA = require 'node-rsa'

base64Key = process.argv[2]
console.log base64Key

rsaKey = new Buffer(base64Key, 'base64')
privKey = rsaKey.toString()
console.log privKey

key = new NodeRSA rsaKey
pubKey = key.exportKey 'public'
console.log pubKey

console.log "pubKey base64"
console.log new Buffer(pubKey).toString 'base64'
