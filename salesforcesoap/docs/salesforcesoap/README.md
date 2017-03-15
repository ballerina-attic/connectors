# Sales Force Soap Connector
  The Sales Force soap connector allows you to access the Sales SOAP API through ballerina. And the actions are being invoked
  with a ballerina main function. The following section provide you the details on connector operations.

## Describe Global
 This Salesforce action lists the available objects and their metadata for your organization’s data.

###### Properties
  * headers - SOAP headers
     
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_describeglobal.htm>

## Describe SObjects
  This Salesforce action describes metadata (field list and object properties) for the specified object or array of objects.

###### Properties
  * headers - SOAP headers
  * type - SObject Name

###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_describesobjects.htm>

## Create Record
 This Sales Force action adds one or more new records to your organization’s data.

###### Properties
  * headers - SOAP headers
  * fields - Map of fields of records

###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_create.htm>

## Describe SObject
  This Salesforce action describes metadata (field list and object properties) for the specified object.

###### Properties
  * headers - SOAP headers
  * type - SObject Name

###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_describesobject.htm>

## Search
  This Salesforce action executes a text search in your organization’s data.

###### Properties
  * headers - SOAP headers
  * query - Search String
      
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_search.htm>

## Retrieve Record
  This Salesforce action retrieves one or more records based on the specified ID.

###### Properties
  * headers - SOAP headers
  * fieldList - List of fields that needs to be retrieved
  * type - SObject Name
  * id - Id of Record

###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_retrieve.htm>

## Query SObjects
  This Salesforce action executes a query against the specified object and returns data that matches the specified criteria.

###### Properties
  * headers - SOAP headers
  * query - Query String
  
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_query.htm>

## Query All SObjects
  This Salesforce action retrieves data from specified objects, whether or not they have been deleted.

###### Properties
  * headers - SOAP headers
  * query - Query String
  
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_queryall.htm>

## Query More
  This Salesforce action retrieves the next batch of objects from a query.

###### Properties
  * headers - SOAP headers
  * queryLocator - Url to retrieve the balance query results
  
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_querymore.htm>

## Update Record
  This Salesforce action updates one or more existing records in your organization’s data.

###### Properties
  * headers - SOAP headers
  * fields - Map of fields of records
  
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_update.htm>

## Upsert Record
  This Salesforce action creates new records and updates existing records.

###### Properties
  * headers - SOAP headers
  * id - External Id
  * fields - Map of fields of records
  
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_upsert.htm>

## Delete Record
  This Salesforce action deletes one or more records from your organization’s data.

###### Properties
  * headers - SOAP headers
  * id - Id of Record to be deleted
  
###### Related Salesforce documentation
  * <https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_delete.htm>

## How to use

###### Prerequisites
1. Obtain the following parameters
  * Username
  * Password
  * Security Token

###### Run the Sample
- copy Salesforce/sample/Salesforce/samples.bal into <ballerina_home>/bin$ folder
- Run the following commands to execute the relevant action.
  1. describe global:
  `bin$ ./ballerina run main samples.bal describeGlobal <userName> <password+securityToken>`
  2. describe SObject:
  `bin$ ./ballerina run main samples.bal describeSObject <userName> <password+securityToken> <SObjectName>`
  3. create record:
  `bin$ ./ballerina run main samples.bal createRecord <userName> <password+securityToken> <SObjectName> <RecordName>`
  4. describe SObjects:
  `bin$ ./ballerina run main samples.bal describeSObjects <userName> <password+securityToken> <SObjectName>`
  5. search:
  `bin$ ./ballerina run main samples.bal search <userName> <password+securityToken> <searchString>`
  6. retrieve:
  `bin$ ./ballerina run main samples.bal retrieve <userName> <password+securityToken> <fieldNames> <SObjectName> <RecordId>`
  7. delete record:
  `bin$ ./ballerina run main samples.bal deleteRecord <userName> <password+securityToken> <RecordId>`
  8. query:
  `bin$ ./ballerina run main samples.bal query <userName> <password+securityToken> <queryString>`
  5. query all:
  `bin$ ./ballerina run main samples.bal queryAll <userName> <password+securityToken> <queryString>`
  5. query more:
  `bin$ ./ballerina run main samples.bal queryMore <userName> <password+securityToken> <queryLocator>`
  6. update record:
  `bin$ ./ballerina run main samples.bal updateRecord <userName> <password+securityToken> <recordId> <recordName> <SObjectName>`
  7. upsert record:
  `bin$ ./ballerina run main samples.bal upsertRecord <userName> <password+securityToken> <externalId> <recordName> <SObjectName>`