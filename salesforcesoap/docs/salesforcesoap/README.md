# Sales Force Soap Connector
  The Sales Force soap connector allows you to access the Sales SOAP API through ballerina. And the actions are being invoked
  with a ballerina main function. The following section provide you the details on connector operations.

## Describe Global
 This Salesforce action lists the available objects and their metadata for your organization’s data.

###### Properties
     
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_describeglobal.htm>

## Describe SObjects
  This Salesforce action describes metadata (field list and object properties) for the specified object or array of objects.

###### Properties
  * type - Type of SObject

###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_describesobjects.htm>

## Create SObject
 This Sales Force action adds one or more new records to your organization’s data.

###### Properties
  * type - Type of SObject
  * name - Name of SObject

###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_create.htm>

## Describe SObject
  This Salesforce action describes metadata (field list and object properties) for the specified object.

###### Properties
  * type - Type of SObject

###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_describesobject.htm>

## Search
  This Salesforce action executes a text search in your organization’s data.

###### Properties
  * query - Search String
      
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_search.htm>

## Retrieve SObjects
  This Salesforce action retrieves one or more records based on the specified IDs.

###### Properties
  * fieldList - List of fields that needs to be retrieved
  * type - Type of SObject
  * id - Id of SObject* payload - The payload containing the information of the post that should be shared. (Should be given in _json_)

###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_retrieve.htm>

## Query SObjects
  This Salesforce action executes a query against the specified object and returns data that matches the specified criteria.

###### Properties
  * query - Query String
  
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_query.htm>

## Query All SObjects
  This Salesforce action retrieves data from specified objects, whether or not they have been deleted.

###### Properties
  * query - Query String
  
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_queryall.htm>

## Update SObject
  This Salesforce action updates one or more existing records in your organization’s data.

###### Properties
  * id - Id of SObject
  * newName - New name of SObject
  * type - Type of SObject
  
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_update.htm>

## Upsert SObjects
  This Salesforce action creates new records and updates existing records.

###### Properties
  * id - External Id
  * newName - New name of SObject
  * type - Type of SObject
  
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_upsert.htm>

## Delete SObjects
  This Salesforce action deletes one or more records from your organization’s data.

###### Properties
  * id - Id of SObject to be deleted
  
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_delete.htm>

## How to use

###### Prerequisites
1. Obtain the following parameters  (For more Details on obtaining access token: <https://github.com/Salesforce/Salesforce-api-docs#2-authentication>)
  * Username
  * Password
  * Security Token

###### Run the Sample
- copy Salesforce/sample/Salesforce/samples.bal into <ballerina_home>/bin$ folder
- Run the following commands to execute the relevant action.
  1. run all actions:
  `bin$ ./ballerina run main samples.bal describeGlobal <userName> <password+securityToken>`
  2. run get actions:
  `bin$ ./ballerina run main samples.bal describeSObject <userName> <password+securityToken>`
  3. run post actions:
  `bin$ ./ballerina run main samples.bal createSObject <userName> <password+securityToken>`
  4. get profile info:
  `bin$ ./ballerina run main samples.bal describeSObjects <userName> <password+securityToken>`
  5. get contributors:
  `bin$ ./ballerina run main samples.bal search <userName> <password+securityToken>`
  6. get publications:
  `bin$ ./ballerina run main samples.bal retrieve <userName> <password+securityToken>`
  7. create profile post:
  `bin$ ./ballerina run main samples.bal deleteSObject <userName> <password+securityToken>`
  8. create publication post:
  `bin$ ./ballerina run main samples.bal query <userName> <password+securityToken>`
  5. get contributors:
  `bin$ ./ballerina run main samples.bal queryAll <userName> <password+securityToken>`
  6. get publications:
  `bin$ ./ballerina run main samples.bal updateSObject <userName> <password+securityToken>`
  7. create profile post:
  `bin$ ./ballerina run main samples.bal upsertSObject <userName> <password+securityToken>`