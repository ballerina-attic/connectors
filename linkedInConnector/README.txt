Description
===========
This is a sample Linked In connector with the following actions. And the actions are being invoked in a ballerina main function.

    * getProfileInfo : Get profile information of the user
    * getCompanyInfo : Get company information
    * profileShare : Share on the profile of the user
    * companyShare : Share on a company page
    * isCompanyShareEnabled : Check if sharing is enabled for a company
    * isMemberAdmin : Check if the member is a company administrator

Prerequisites
=============
1. Create a Linked In app by visiting https://developer.linkedin.com/
2. Obtain the following parameters (For more Details on obtaining access token: https://developer.linkedin.com/docs/oauth2)

    * Access Token

IMPORTANT: This access token can be used to make API requests on your own account's behalf. Do not share your access token with anyone.


How to run this sample
======================

1. Place the linkedInConnector into {BALLERINA_HOME}/samples.
2. bin$ ./ballerina run ../samples/linkedInConnector/linkedInConnector.bal <accessToken> <company_id>
