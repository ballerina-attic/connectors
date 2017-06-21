
# LinkedIn Connector Samples

This repository consists of the samples that can be referred in using the Ballerina LinkedIn Connector.

# Contents:
  - samples.bal - Ballerina file with main function that utilizes all actions incorporated in the connector
  - linkedin_test.bal - Testerina file for the connector
  - set_env_vars.sh - Environment variable setter
 
### Important
The test functions contain hard-coded values for the Company ID etc. This value can be changed according to your requirement before running the test file.
  
# Steps to run the test file

 1. Create a LinkedIn app by visiting https://developer.linkedin.com/
 2. Obtain the Access Token (For more Details on obtaining access token: https://developer.linkedin.com/docs/oauth2)
 3. Create a company page in order to get the company ID or use the following company as a sample
	https://www.linkedin.com/company-beta/2414183/
 4. Set the Access Token in set_env_vars.sh
 5. Source the set_env_vars.sh file in a terminal
 6. Clone the connector repo and download the latest ballerina-tools distribution
 7. Navigate to $BALLERINA_TOOLS_HOME/bin
 8. Run tests in the same terminal as: 
 ./ballerina test $path_to_test_file/linkedin_test.bal
