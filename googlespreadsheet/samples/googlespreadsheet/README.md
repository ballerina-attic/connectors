# Google Spread Sheet Connector Samples

This repo consists of the samples that can be referred in using the Ballerina Google Spread Sheet Connector.

# Contents:
  - samples.bal - Ballerina file with main function that utilizes all actions incorporated in the connector
  - GoogleSpreadSheet_test.bal - Testerina file for the connector
  - set_env_vars.sh - Environment variable setter
 
### Important
The test functions contain hardcoded payload values, sheet ids, etc... These has to be changed accordingly with relevant values before running the test file.
  
# Steps to Run the test file
 1. Enter your google developer account credentials (client id, client secret, google spreadsheet api access token and refresh token) on set_env_vars.sh as relevant.
 2. Source the set_env_vars.sh using a terminal
 3. Change payloads and other sheet related values accordingly.
 4. Clone the connector repo and download the latest ballerina-tools distribution
 5. Navigate to $BALLERINA_TOOLS_HOME/bin
 6. Run tests as: ./ballerina test ${path_to_test_file_in_connector_repo}/GoogleSpreadSheet_test.bal
