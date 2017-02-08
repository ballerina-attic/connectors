Description
===========
This is a sample Soap connector with salesforce login using soap connector. And the action is being invoked in a ballerina main function.

Prerequisites
=============
1. Create a Salesforce account.
2. Obtain the following parameters
    * Username
    * Password
    * SecurityToken

How to run this sample
======================
bin$ ./ballerina run ../samples/soapConnector/soapConnector.bal <username> <password+securityToken>