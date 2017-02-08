Description
===========
This is a sample medium connector with the following actions. And the actions are being invoked in a ballerina main function.

	* getProfileInfo : Getting the authenticated user’s details
	* getContributors : Fetching contributors for a publication
	* getPublications : Returns a full list of publications that the user is related to in some way: (This includes all publications the user is subscribed to, writes to, or edits.)
	* createProfilePost : Creates a post on the authenticated user’s profile.
	* createPublicationPost : Creates a post associated with a Medium publication.

Prerequisites
=============
1. Create a Medium application by visiting the Settings page of your Medium profile.
2. Obtain the following parameters (For more Details on obtaining access token: https://github.com/Medium/medium-api-docs#2-authentication)

    * Access Token

IMPORTANT: This access token can be used to make API requests on your own account's behalf. Do not share your access token with anyone.


How to run this sample
======================

 1. Place the mediumConnector into {BALLERINA_HOME}/samples.
 2. bin$ ./ballerina run ../samples/mediumConnector/mediumConnector.bal <accessToken> <user_id> <publication_id>


