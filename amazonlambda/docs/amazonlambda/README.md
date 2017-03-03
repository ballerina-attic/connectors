# Amazon Lambda Connector

The Amazon Lambda connector allows you to access the Amazon Lambda API through Ballerina. The actions can be invoked by
 the main function. Given below are detailed information on the actions that can be invoked.

## Invoke function
Invokes a amazon lambda function.

###### Properties
  * arn - Amazon resource name of function to be invoked.
  * payload (Optional) - The json payload containing key values of parameters to amazon lambda function.

###### Related Amazon documentation
<http://docs.aws.amazon.com/lambda/latest/dg/API_Invoke.html>

## Delete a function
Deletes a lambda function.

###### Properties
  * arn - Amazon resource name of function to be invoked.

###### Related Amazon documentation
<http://docs.aws.amazon.com/lambda/latest/dg/API_DeleteFunction.html>

## Get Function
Gets the configuration information of a lambda function.

###### Properties
  * query - Query string to retrieve the related tweets.

###### Related Amazon documentation
<http://docs.aws.amazon.com/lambda/latest/dg/API_GetFunction.html>

## List functions
Gets the list of functions and their configuration information.

###### Properties

###### Related Amazon documentation
<http://docs.aws.amazon.com/lambda/latest/dg/API_ListFunctions.html>

## List function versions
Lists all versions of a amazon lambda function.

###### Properties
  * arn - Amazon resource name of function to be invoked.

###### Related Amazon documentation
<http://docs.aws.amazon.com/lambda/latest/dg/API_ListVersionsByFunction.html>

## Get account details
Returns the users' account information.

###### Properties

###### Related Amazon documentation
<http://docs.aws.amazon.com/lambda/latest/dg/API_GetAccountSettings.html>

## How to use

###### Prerequisites
1. Create a amazon lambda account by visiting [Amazon Lambda](https://aws.amazon.com/lambda/)
2. Obtain the following parameters:
  * Security Credentials (Access key ID, Secret access key).
  * Server region.

**IMPORTANT:** The security credentials can be used to make API requests on your own account's behalf.
 Do not share your security credentials with anyone.

###### Invoke the actions
- copy amazonLambda/samples/amazonLambda/samples.bal into `<ballerina_home>`/bin$ folder
- To run the following commands to execute the relevant action.
  1. invokeFunction:
  `bin$ ./ballerina run main samples.bal invokeFunction <accessKeyId> <secretAccessKey> <region> <functionARN>`

  2. deleteFunction:
  `bin$ ./ballerina run main samples.bal deleteFunction <accessKeyId> <secretAccessKey> <region> <functionARN>`

  3. listFunctions:
  `bin$ ./ballerina run main samples.bal listFunctions <accessKeyId> <secretAccessKey> <region>`

  4. listFunctionVersions:
  `bin$ ./ballerina run main samples.bal listFunctionVersions <accessKeyId> <secretAccessKey> <region> <functionARN>`

  5. getFunction:
  `bin$ ./ballerina run main samples.bal getFunction <accessKeyId> <secretAccessKey> <region> <functionARN>`

  6. getAccountDetails:
  `bin$ ./ballerina run main samples.bal getAccountDetails <accessKeyId> <secretAccessKey> <region>`