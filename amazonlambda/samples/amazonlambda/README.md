
# Amazon Lambda Connector Samples

This repository consists of the samples that can be referred in using the Ballerina Amazon Lambda Connector.

# Contents:
  - samples.bal - Ballerina file with main function that utilizes all actions incorporated in the connector
  - lambda_test.bal - Testerina file for the connector
  - set_env_vars.sh - Environment variable setter
 
### Important
The test functions contain hard-coded values for the function name. This value can be changed according to your requirement before running the test file.
  
# Steps to run the test file

 1. Clone the Connector repo and download the latest Ballerina-Tools distribution
 2. Enter your Amazon Lambda account details (access key, secret access key and region) on set_env_vars.sh.
 3. Source the set_env_vars.sh file in the terminal.
 4. Login to the Lambda account and create a blank function with the details below.
 5. Navigate to $BALLERINA_TOOLS_HOME/bin
 6. Run tests in the same terminal as:
 ./ballerina test ${path_to_test_file_in_connector_repo}/lambda_test.bal

Function details -

Name - BallerinaTestFunction

Runtime - Node.js 6.10

Code -

```
	exports.handler = (event, context, callback) => {
	    if (event.name === undefined){
	        callback(null, 'Hello');
	    }else{
	        callback(null, 'Hello from Lambda to ' + event.name);
	    }
	};
```
