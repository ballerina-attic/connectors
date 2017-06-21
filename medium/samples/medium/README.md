
# Medium Connector Samples

This repository consists of the samples that can be referred in using the Ballerina Medium Connector.

# Contents:
  - samples.bal - Ballerina file with main function that utilizes all actions incorporated in the connector
  - medium_test.bal - Testerina file for the connector
  - set_env_vars.sh - Environment variable setter
 
### Important
The test functions contain hard-coded values for the user id, publication id etc. These values should be changed before running the test file.
To get the publication ID, follow https://help.medium.com/hc/en-us/articles/226875507-How-to-find-your-publication-ID-for-IFTTT-  

# Steps to run the test file

 1. Clone the Connector repo and download the latest Ballerina-Tools distribution.
 2. Create a Medium application by visiting the Settings page of your Medium profile.
 3. Obtain the following parameters (More Details on: https://github.com/Medium/medium-api-docs#2-authentication)
	Client ID
	Cleint Secret
	Access Token
	Refresh Token
 4. Enter the above details in set_env_vars.sh.
 5. Source the set_env_vars.sh in a terminal.
 6. Navigate to $BALLERINA_TOOLS_HOME/bin
 7. Run tests in the same terminal as:
 ./ballerina test ${path_to_test_file_in_connector_repo}/medium_test.bal
