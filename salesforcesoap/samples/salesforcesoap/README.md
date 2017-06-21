# SalesForce Soap Connector Samples

This repo consists of the samples that can be referred in using the Ballerina SalesForce soap Connector.

# Contents:
  - samples.bal - Ballerina file with main function that utilizes all actions incorporated in the connector
  - SalesForce_test.bal - Testerina file for the connector
  - set_env_vars.sh - Environment variable setter
 
### Important
The test functions contain hardcoded values for some of the parameters. Please change them accordingly when using.
  
# Steps to Run the test file
 1. Clone the connector repo and download the latest ballerina-tools distribution
 2. Enter your salesforce developer account credentials (username, password) and login url on set_env_vars.sh as relevant.
 3. Source the set_env_vars.sh
 4. Change parameters in test functions accordingly (SalesForce_test.bal)
 5. Navigate to $BALLERINA_TOOLS_HOME/bin
 6. Run tests as: ballerina test $path_to_test_file/SalesForce_test.bal.bal
