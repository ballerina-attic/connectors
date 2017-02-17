import ballerina.lang.system;
import ballerina.lang.messages;
import ballerina.net.http;
import org.wso2.ballerina.connectors.amazonS3;

function main (string[] args) {

    amazonS3:ClientConnector s3Connector;

    message s3Response;
    int s3Status;
    string s3StringResponse;

    if (args[0]=="getBucketList") {
        s3Connector = create amazonS3:ClientConnector(args[1], args[2], args[3]);
        s3Response = amazonS3:ClientConnector.getBucketList(s3Connector);

    } else if (args[0]=="getObjectList") {
        s3Connector = create amazonS3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = amazonS3:ClientConnector.getObjectList(s3Connector, bucketName);

    } else if (args[0]=="createBucket") {
        s3Connector = create amazonS3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = amazonS3:ClientConnector.createBucket(s3Connector, bucketName);

    } else if (args[0]=="deleteBucket") {
        s3Connector = create amazonS3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = amazonS3:ClientConnector.deleteBucket(s3Connector, bucketName);

    } else if (args[0]=="getObject") {
        s3Connector = create amazonS3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = amazonS3:ClientConnector.getObject(s3Connector, bucketName, "test.txt");

    } else if (args[0]=="deleteObject") {
        s3Connector = create amazonS3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = amazonS3:ClientConnector.deleteObject(s3Connector, bucketName, "test.txt");

    } else if (args[0]=="putObject") {
        s3Connector = create amazonS3:ClientConnector(args[1], args[2], args[3]);
        string bucketName = args[4];
        s3Response = amazonS3:ClientConnector.putObject(s3Connector, bucketName, "test.txt", "Sample Content");

    } else {
        system:println("Invalid Action");
    }
    s3Status = http:getStatusCode(s3Response);
    system:println(s3Status);
    s3StringResponse = messages:getStringPayload(s3Response);
    system:println(s3StringResponse);
}