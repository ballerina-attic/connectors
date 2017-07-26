# Medium Connector
  The Medium connector allows you to access the Medium REST API through ballerina. And the actions are being invoked
  with a ballerina main function. The following section provide you the details on connector operations.

## Get Profile Info
  This Medium action allows to obtain profile information of the authenticated user.

###### Properties

###### Related Medium documentation
  * <https://github.com/Medium/medium-api-docs#31-users>

## Get Contributors
 This Medium action returns a list of contributors for a given publication.

###### Properties
  * publicationId - The relevant publication ID

###### Related Medium documentation
  * <https://github.com/Medium/medium-api-docs#32-publications>

## Get Publications
  This Medium action Returns a full list of publications that the user is related to in some way: (This includes all publications the user is subscribed to, writes to, or edits.)

###### Properties
  * userId - The relevant user ID

###### Related Medium documentation
  * <https://github.com/Medium/medium-api-docs#32-publications>

## Post on Profile
 This Medium action creates a post on the authenticated user’s profile.

###### Properties
  * userId - The relevant user ID
  * payload - The payload containing the information of the post that should be shared. (Should be given in _json_)

###### Related Medium documentation
  * <https://github.com/Medium/medium-api-docs#33-posts>

## Post on a Publication
  This Medium action Creates a post associated with a Medium publication.

###### Properties
  * publicationId - The relevant publication ID
  * payload - The payload containing the information of the post that should be shared. (Should be given in _json_)

###### Related Medium documentation
  * <https://github.com/Medium/medium-api-docs#33-posts>

## How to use

###### Prerequisites
1. Create a Medium application by visiting the Settings page of your Medium profile.
2. Obtain the following parameters  (For more Details on obtaining access token: <https://github.com/Medium/medium-api-docs#2-authentication>)
  * Access Token

   **IMPORTANT:** This access token can be used to make API requests on your own account's behalf. Do not share your access token with anyone.

###### Run the Sample
- copy medium/sample/medium/samples.bal into <ballerina_home>/bin$ folder
- Run the following commands to execute the relevant action.
  1. run all actions:
  `bin$ ./ballerina run samples.bal <accessToken> <clientId> <clientSecret> <refreshToken> <userId> <publicationId>`
  2. run get actions:
  `bin$ ./ballerina run samples.bal get <accessToken> <clientId> <clientSecret> <refreshToken> <userId> <publicationId>`
  3. run post actions:
  `bin$ ./ballerina run samples.bal post <accessToken> <clientId> <clientSecret> <refreshToken> <userId> <publicationId>`
  4. get profile info:
  `bin$ ./ballerina run samples.bal getProfileInfo <accessToken> <clientId> <clientSecret> <refreshToken>`
  5. get contributors:
  `bin$ ./ballerina run samples.bal getContributors <accessToken> <clientId> <clientSecret> <refreshToken> <publicationId>`
  6. get publications:
  `bin$ ./ballerina run samples.bal getPublications <accessToken> <clientId> <clientSecret> <refreshToken> <userId>`
  7. create profile post:
  `bin$ ./ballerina run samples.bal createProfilePost <accessToken> <clientId> <clientSecret> <refreshToken> <userId>`
  8. create publication post:
  `bin$ ./ballerina run samples.bal createPublicationPost <accessToken> <clientId> <clientSecret> <refreshToken> <publicationId>`