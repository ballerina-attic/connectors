
# Twitter Connector Samples

This repository consists of the samples that can be referred in using the Ballerina Twitter Connector.

# Contents:
  - samples.bal - Ballerina file with main function that utilizes all actions incorporated in the connector
  - twitter_test.bal - Testerina file for the connector
  - set_env_vars.sh - Environment variable setter
 
### Important
The test functions contain hard-coded values for the Twitter message and search query which can be changed according to your requirement before running the test file.

# Steps to run the test file

 1. Clone the Connector repo and download the latest Ballerina-Tools distribution
 2. Create a twitter app by visiting https://apps.twitter.com/ and obtain the following parameters:
	Consumer Key (API Key)
	Consumer Secret (API Secret)
	Access Token
	Access Token Secret
 3. Set the above twitter account details in the set_env_vars.sh.
 4. Source the set_env_vars.sh file in the terminal.
 5. Navigate to $BALLERINA_TOOLS_HOME/bin
 6. Run tests in the same terminal as:
 ./ballerina test ${path_to_test_file_in_connector_repo}/twitter_test.bal
