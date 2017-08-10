import ballerina.lang.system;
import ballerina.lang.messages;
import ballerina.net.http;
import org.wso2.ballerina.connectors.amazons3;

function main (string[] args) {

    amazons3:ClientConnector s3Connector;

    message s3Response;
    int s3Status;
    string s3StringResponse;

    if (args[0] == "getBucketList") {
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        s3Response = s3Connector.getBucketList ();

    } else if (args[0] == "getObjectList") {
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.getObjectList (bucketName);

    } else if (args[0] == "createBucket") {
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.createBucket (bucketName);

    } else if (args[0] == "deleteBucket") {
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.deleteBucket (bucketName);

    } else if (args[0] == "getObject") {
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.getObject (bucketName, "test.txt");

    } else if (args[0] == "deleteObject") {
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.deleteObject (bucketName, "test.txt");

    } else if (args[0] == "putObject") {
        s3Connector = create amazons3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = s3Connector.putObject (bucketName, "test.txt", "Sample Content");

    } else {
        system:println("Invalid Action");
    }
    s3Status = http:getStatusCode(s3Response);
    system:println(s3Status);
    s3StringResponse = messages:getStringPayload(s3Response);
    system:println(s3StringResponse);
}