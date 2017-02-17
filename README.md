# ballerina-connectors

A connector allows you to interact with a third-party product's functionality 
and data and enabling you to connect to and interact with the APIs of services such as Twitter, 
Gmail, and Facebook.

# How to run

This will be a part of Ballerina distribution.
For the time being, you can copy the built connectors-0.8.0-SNAPSHOT.jar
file to <ballerina_home>/bre/lib and test. 

To test a connector action written in Ballerina language use the run 
command as follows.

Create a main function that import connector packages and call the connector 
actions in test.bal file with four args. Then can run the main function as 
follows

$ bin ./ballerina run main test.bal args[0] args[1] args[3] args[4]
