Description
===========
The OAuth2 ClientConnector allows you to handle the authentication flow. This connector will be used in ClientConnectors
for authentication flow. This connector allows to handle the access token in the request and to refresh the access token
if get 401 responses to the actual call. In client connector, you can persist the new token in a service level variable.

How to run this sample
======================
bin$ ./ballerina run ../samples/ClientConnector/ClientConnector.bal <API_URL> <Access_Token> <Client_ID> <Client_Secret> <Refresh_Token> <Refresh_Token_Url>



