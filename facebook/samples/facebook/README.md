
# Facebook Connector Samples

This repository consists of the samples that can be referred in using the Ballerina Facebook Connector.

# Contents:
  - samples.bal - Ballerina file with main function that utilizes all actions incorporated in the connector
  - facebook_test.bal - Testerina file for the connector
  - set_env_vars.sh - Environment variable setter
 
### Important
The test functions contain hard-coded values for posts, comments, object ID's etc. which can be changed according to your requirement before running the test file. The postID should be obtained after running the test once.

These tests can be improved to use the same Object ID generated in the testCreatePost for all the other tests when the global variables are supported for Testarina, so that all the tests can be run in one attempt.
  
# Steps to run the test file

 1. Clone the Connector repo and download the latest Ballerina-Tools distribution
 2. Create a facebook app and a sample Facebook page 
 3. Get the AccessToken for the created Facebook page from https://developers.facebook.com/tools/explorer. Make sure to set the required permissions.
 4. Set the access token in the set_env_vars.sh.
 5. Source the set_env_vars.sh in a terminal.
 6. Navigate to $BALLERINA_TOOLS_HOME/bin
 7. Run tests in the same terminal as:
 ./ballerina test ${path_to_test_file_in_connector_repo}/facebook_test.bal
 8. Get the Object ID which will be printed on the console
 9. Replace the "postID" value with the Object ID obtained in the test file and run the test again

