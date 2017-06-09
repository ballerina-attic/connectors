
# JIRA Connector Samples

This repository consists of the samples that can be referred in using the Ballerina JIRA Connector.

# Contents:
  - samples.bal - Ballerina file with main function that utilizes all actions incorporated in the connector
  - jira_test.bal - Testerina file for the connector
  - set_env_vars.sh - Environment variable setter
 
### Important
The test functions contain sample values for the Issue ID, Payloads etc. These values can be changed according to your requirement before running the test file.
  
# Steps to run the test file

 1. Set the URL of the JIRA, Username and Password in set_env_vars.sh file
 2. Source the set_env_vars.sh file in a terminal
 3. Clone the connector repo and download the latest ballerina-tools distribution
 4. Navigate to $BALLERINA_TOOLS_HOME/bin
 5. Run tests in the same terminal as: 
 ./ballerina test $path_to_test_file/jira_test.bal
