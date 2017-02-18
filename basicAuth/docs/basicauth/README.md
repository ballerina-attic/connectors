# Basic Auth Client Connector

The Basic Auth client connector allows you to handle the authentication flow with basic authentication.
This can be used in other client connectors which use basic authentication.

## get
The get action allows to use http get action with basic authentication flow.

###### Properties
  * url
  * request

## post
The post action allows to use http post action with basic authentication flow.

###### Properties
  * url
  * request

## put
The put action allows to use http put action with basic authentication flow.

###### Properties
  * url
  * request

## delete
The delete action allows to use http delete action with basic authentication flow.

###### Properties
  * url
  * request

## How to use

###### Prerequisites
1. Use this basic auth client connector instead of http client authenticator in other client connectors.
2. Obtain the following parameters:
    * Username
    * Password

###### Invoke the actions
- Place the basicAuth directory into {BALLERINA_HOME}/samples.
- Run the following commands to execute the relevant action.
  1. get:
  `bin$ ./ballerina run ../samples/basicAuth/src/ClientConnector.bal get <username> <password> <url>`
  2. post:
  `bin$ ./ballerina run ../samples/basicAuth/src/ClientConnector.bal post <username> <password> <url>`
  3. put:
  `bin$ ./ballerina run ../samples/basicAuth/src/ClientConnector.bal put <username> <password> <url>`
  4. delete:
  `bin$ ./ballerina run ../samples/basicAuth/src/ClientConnector.bal delete <username> <password> <url>`