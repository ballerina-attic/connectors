# LinkedIn Connector
  The LinkedIn connector allows you to access the LinkedIn REST API through ballerina. And the actions are being invoked
  with a ballerina main function. The following section provide you the details on connector operations.

## Get Profile Info
  The LinkedIn action allows to obtain profile information of the authenticated user.

###### Properties
  * format - The format of the response payload. (Either _json_ or _xml_)

###### Related LinkedIn documentation
  * <https://developer.linkedin.com/docs/signin-with-linkedin>

## Get Company Info
 The LinkedIn action allows to obtain page information of a specific company.

###### Properties
  * companyId - The relevant company ID
  * format - The format of the response payload. (Either _json_ or _xml_)

###### Related LinkedIn documentation
  * <https://developer.linkedin.com/docs/company-pages>

## Share on Profile
 The LinkedIn action allows to share a post on the profile of the authenticated user.

###### Properties
  * payload - The payload containing the information of the post that should be shared. (Either _json_ or _xml_)

###### Related LinkedIn documentation
  * <https://developer.linkedin.com/docs/share-on-linkedin>

## Share on Company Page
  The LinkedIn action allows to share a post on a company page. To invoke this action the authenticated user should be an admin of the company page.

###### Properties
  * companyId - The relevant company ID
  * payload - The payload containing the information of the post that should be shared. (Either _json_ or _xml_)

###### Related LinkedIn documentation
  * <https://developer.linkedin.com/docs/company-pages>

## Check if Sharing is enabled for a Company
  The LinkedIn action allows to check if Sharing is enabled for a specific Company.

###### Properties
  * companyId - The relevant company ID
  * format - The format of the response payload. (Either _json_ or _xml_)

###### Related LinkedIn documentation
  * <https://developer.linkedin.com/docs/company-pages>

## Check if user is a company administrator
  The LinkedIn action allows to Check if the authenticated user is a company administrator.

###### Properties
  * companyId - The relevant company ID
  * format - The format of the response payload. (Either _json_ or _xml_)

###### Related LinkedIn documentation
  * <https://developer.linkedin.com/docs/company-pages>


## How to use

###### Prerequisites
1. Create a LinkedIn app by visiting <https://developer.linkedin.com/>
2. Obtain the following parameters  (For more Details on obtaining access token: <https://developer.linkedin.com/docs/oauth2>)
  * Access Token

   **IMPORTANT:** This access token can be used to make API requests on your own account's behalf. Do not share your access token with anyone.

###### Run the Sample
- copy linkedin/sample/linkedin/samples.bal into <ballerina_home>/bin$ folder
- Run the following commands to execute the relevant action.
  1. run all actions:
  `bin$ ./ballerina run samples.bal <accessToken> <companyId>`
  2. run get actions:
  `bin$ ./ballerina run samples.bal get <accessToken> <companyId>`
  3. run post actions:
  `bin$ ./ballerina run samples.bal post <accessToken> <companyId>`
  4. get profile info:
  `bin$ ./ballerina run samples.bal getProfileInfo <accessToken>`
  5. get company info:
  `bin$ ./ballerina run samples.bal getCompanyInfo <accessToken> <companyId>`
  6. get is company share enabled:
  `bin$ ./ballerina run samples.bal isCompanyShareEnabled <accessToken> <companyId>`
  7. get is member a company admin:
  `bin$ ./ballerina run samples.bal isCompanyShareEnabled <accessToken> <companyId>`
  8. create profile share:
  `bin$ ./ballerina run samples.bal profileShare <accessToken>`
  9. create company share:
  `bin$ ./ballerina run samples.bal companyShare <accessToken> <companyId>`
