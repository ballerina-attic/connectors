# OAuth2 Client Connector

The OAuth2 connector allows you to handle the authentication flow with oauth2 authentication.
This can be used in other client connectors which use oauth2 authentication.

## get
The get action allows to use http get action with oauth2 authentication flow.

###### Properties
  * url
  * request

## post
The post action allows to use http post action with oauth2 authentication flow.

###### Properties
  * url
  * request

## put
The put action allows to use http put action with oauth2 authentication flow.

###### Properties
  * url
  * request

## delete
The delete action allows to use http delete action with oauth2 authentication flow.

###### Properties
  * url
  * request

## How to use

###### Prerequisites
1. Use this OAuth2 client connector instead of http client authenticator in other client connectors.
2. Obtain the following parameters:
    * Access Token
    * Client Id
    * Client Secret
    * Refresh Token
    * Refresh Token Endpoint

###### Invoke the actions
- copy oauth2/sample/oauth2/samples.bal into `<ballerina_home>`/bin$ folder
- Run the following commands to execute the relevant action.
    1. get:
    `bin$ ./ballerina run main samples.bal get <accessToken> <clientId> <clientSecret> <refreshToken> <refreshTokenEP> <url>`
    2. post:
    `bin$ ./ballerina run main samples.bal post <accessToken> <clientId> <clientSecret> <refreshToken> <refreshTokenEP> <url>`
    3. put:
    `bin$ ./ballerina run main samples.bal put <accessToken> <clientId> <clientSecret> <refreshToken> <refreshTokenEP> <url>`
    4. delete:
    `bin$ ./ballerina run main samples.bal delete <accessToken> <clientId> <clientSecret> <refreshToken> <refreshTokenEP> <url>`

Note: If you are not passing refresh token in the request, access token won't be refreshed.