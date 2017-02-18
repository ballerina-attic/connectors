#Amazon Auth Client Connector

The Amazon Auth Connector gives the ability to generate and add the authorization header to the message and send the
  message to the required amazon server. This connector can be used for any amazon service which used Signature 4
  authentication.

## request
The request action gives the ability to add authentication header and send the request.

###### Properties
  * requestMsg
  * httpMethod
  * requestURI
  * payload

## How to use

###### Prerequisites
1. Use this Amazon Auth client connector instead of generating, adding Authorization header and sending request.
2. Obtain the following parameters:
    * Security Credentials (Access key ID, Secret access key).
    * Server region.
    * Service Name
    * Termination String
    * Endpoint