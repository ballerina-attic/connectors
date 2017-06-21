
# Amazon S3 Connector Samples

This repository consists of the samples that can be referred in using the Ballerina Amazon S3 Connector.

# Contents:
  - samples.bal - Ballerina file with main function that utilizes all actions incorporated in the connector
  - amazonS3_test.bal - Testerina file for the connector
  - set_env_vars.sh - Environment variable setter
 
### Important
The test functions contain hard-coded values for the Bucket Name, File Name, Content etc. These values can be changed according to your requirement before running the test file.
  
# Steps to run the test file

 1. Clone the Connector repo and download the latest Ballerina-Tools distribution
 2. Enter your Amazon S3 account details (access key, secret access key and region) on set_env_vars.sh.
 3. Source the set_env_vars.sh file in a terminal.
 4. Navigate to $BALLERINA_TOOLS_HOME/bin
 5. Run tests in the same terminal as:
 ./ballerina test ${path_to_test_file_in_connector_repo}/amazonS3_test.bal

