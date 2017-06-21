# Etcd Connector Samples

This repo consists of the samples that can be referred in using the Ballerina Etcd Connector.

# Contents:
  - samples.bal - Ballerina file with main function that utilizes all actions incorporated in the connector
  - EtcdConnector_test.bal - Testerina file for the connector
  - set_env_vars.sh - Environment variable setter
 
### Important
The test functions contain hardcoded values for some of the parameters. The values should be changed accordingly prior to using the test files or the sample.

# Steps to Run the test file
 1. Clone the connector repo and download the latest ballerina-tools distribution
 2. Enter your etcd server connection details on set_env_vars.sh as relevant.
 3. Source set_env_vars.sh
 3. Change parameters in test functions accordingly (EtcdConnector_test.bal)
 4. Navigate to $BALLERINA_TOOLS_HOME/bin
 5. Run tests as: ballerina test $path_to_test_file/EtcdConnector_test.bal
