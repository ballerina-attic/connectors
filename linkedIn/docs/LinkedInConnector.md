# Linked In Connector
  The Linked In connector allows you to access the Linked In REST API through ballerina. And the actions are being invoked
  with a ballerina main function. The following section provide you the details on connector operations.

## Get Profile Info
  The Linked In action allows to obtain profile information of the authenticated user.

###### Properties
  * format - The format of the response payload. (Either _json_ or _xml_)

###### Related Linked In documentation
  * <https://developer.linkedin.com/docs/signin-with-linkedin>

## Get Company Info
 The Linked In action allows to obtain page information of a specific company.

###### Properties
  * companyId - The relevant company ID
  * format - The format of the response payload. (Either _json_ or _xml_)

###### Related Linked In documentation
  * <https://developer.linkedin.com/docs/company-pages>

## Share on Profile
 The Linked In action allows to share a post on the profile of the authenticated user.

###### Properties
  * payload - The payload containing the information of the post that should be shared. (Either _json_ or _xml_)

###### Related Linked In documentation
  * <https://developer.linkedin.com/docs/share-on-linkedin>

## Share on Company Page
  The Linked In action allows to share a post on a company page. To invoke this action the authenticated user should be an admin of the company page.

###### Properties
  * companyId - The relevant company ID
  * payload - The payload containing the information of the post that should be shared. (Either _json_ or _xml_)

###### Related Linked In documentation
  * <https://developer.linkedin.com/docs/company-pages>

## Check if Sharing is enabled for a Company
  The Linked In action allows to check if Sharing is enabled for a specific Company.

###### Properties
  * companyId - The relevant company ID
  * format - The format of the response payload. (Either _json_ or _xml_)

###### Related Linked In documentation
  * <https://developer.linkedin.com/docs/company-pages>

## Check if user is a company administrator
  The Linked In action allows to Check if the authenticated user is a company administrator.

###### Properties
  * companyId - The relevant company ID
  * format - The format of the response payload. (Either _json_ or _xml_)

###### Related Linked In documentation
  * <https://developer.linkedin.com/docs/company-pages>


## How to use

###### Prerequisites
1. Create a Linked In app by visiting <https://developer.linkedin.com/>
2. Obtain the following parameters  (For more Details on obtaining access token: <https://developer.linkedin.com/docs/oauth2>)
  * Access Token

   **IMPORTANT:** This access token can be used to make API requests on your own account's behalf. Do not share your access token with anyone.

###### Run the Sample
- Place the linkedIn directory into {BALLERINA_HOME}/samples.
- To run the following command to run the sample.

  `bin$ ./ballerina run ../samples/linkedIn/src/linkedInConnector.bal <accessToken> <companyId>`
