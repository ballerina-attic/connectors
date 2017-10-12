import ballerina.lang.system;
import ballerina.net.http;
import ballerina.net.http.response;

import org.wso2.ballerina.connectors.amazons3;

function main (string[] args) {

    amazons3:ClientConnector s3Connector;

    http:Response s3Response;
    int s3Status;
    string s3StringResponse;

    if (args[0] == "getBucketList") {
        system:println("-----Calling getBucketList action-----");
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        s3Response = s3Connector.getBucketList ();
    } else if (args[0] == "getObjectList") {
        system:println("-----Calling getObjectList action-----");
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.getObjectList (bucketName);
    } else if (args[0] == "createBucket") {
        system:println("-----Calling createBucket action-----");
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.createBucket (bucketName);
    } else if (args[0] == "deleteBucket") {
        system:println("-----Calling deleteBucket action-----");
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.deleteBucket (bucketName);
    } else if (args[0] == "getObject") {
        system:println("-----Calling getObject action-----");
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.getObject (bucketName, "test.txt");
    } else if (args[0] == "deleteObject") {
        system:println("-----Calling deleteObject action-----");
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.deleteObject (bucketName, "test.txt");
    } else if (args[0] == "putObject") {
        system:println("-----Calling putObject action-----");
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.putObject (bucketName, "test.txt", "Sample Content");
    } else {
        system:println("Invalid Action");
    }

    s3Status = response:getStatusCode(s3Response);
    system:println(s3Status);
    s3StringResponse = response:getStringPayload(s3Response);
    system:println(s3StringResponse);
}