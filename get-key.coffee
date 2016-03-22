NodeRSA = require 'node-rsa'
crypto = require 'crypto'


easyHash = (text) ->
  crypto.createHash('md5').update(text).digest().toString('base64')

getEnvironmentVariable = (text) ->
  new Buffer(text).toString 'base64'

getKeyRecord = (key, newEnv) ->
  key: key
  hash: easyHash key
  environment: getEnvironmentVariable key
  newEnvironment: newEnv

base64Key        = process.argv[2]

rsaKey           = new Buffer(base64Key, 'base64')
inputKey         = rsaKey.toString()
key              = new NodeRSA rsaKey
publicKey        = key.exportKey 'public'
publicKeyNewEnv  = key.exportKey('public-der').toString 'base64'

try
  privateKey = key.exportKey()
  privateKeyNewEnv = key.exportKey('private-der').toString 'base64'
catch Error
  privateKey = ''
  privateKeyNewEnv = ''

info =
  input: getKeyRecord inputKey
  public: getKeyRecord publicKey, publicKeyNewEnv
  private: getKeyRecord privateKey, privateKeyNewEnv


console.log JSON.stringify info, null, 2
