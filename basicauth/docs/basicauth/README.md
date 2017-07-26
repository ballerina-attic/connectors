# Basic Auth Client Connector

The Basic Auth client connector allows you to handle the authentication flow with basic authentication.
This can be used in other client connectors which use basic authentication.

## get
The get action allows to use http get action with basic authentication flow.

###### Properties
  * path - The path of the endpoint.
  * request - The request.

## post
The post action allows to use http post action with basic authentication flow.

###### Properties
  * path -  The path of the endpoint.
  * request -  The request message.

## put
The put action allows to use http put action with basic authentication flow.

###### Properties
  * path - The path of the endpoint.
  * request - The request message.

## delete
The delete action allows to use http delete action with basic authentication flow.

###### Properties
  * path - The path of the endpoint.
  * request - The request message.

## How to use

###### Prerequisites
1. Use this basic auth client connector instead of http client authenticator in other client connectors.
2. Obtain the following parameters:
    * Username
    * Password

###### Invoke the actions
- copy basicauth/sample/basicauth/samples.bal into `<ballerina_home>`/bin$ folder
- Run the following commands to execute the relevant action.
  1. get:
  `bin$ ./ballerina run samples.bal get <baseUrl> <username> <password> <path>`
  2. post:
  `bin$ ./ballerina run samples.bal post <baseUrl> <username> <password> <path>`
  3. put:
  `bin$ ./ballerina run samples.bal put <baseUrl> <username> <password> <path>`
  4. delete:
  `bin$ ./ballerina run samples.bal delete <baseUrl> <username> <password> <path>`
