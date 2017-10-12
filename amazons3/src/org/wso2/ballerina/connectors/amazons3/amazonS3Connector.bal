package org.wso2.ballerina.connectors.amazons3;

import org.wso2.ballerina.connectors.amazonauth;
import ballerina.doc;
import ballerina.net.http;
import ballerina.net.http.request;

@doc:Description { value:"Amazon S3 client connector"}
@doc:Param { value:"accessKeyId: The access key ID of the Amazon Account"}
@doc:Param { value:"secretAccessKey: The secret access key of the Amazon Account"}
@doc:Param { value:"region: The region to which the request is made"}
public connector ClientConnector (string accessKeyId, string secretAccessKey, string region) {

    amazonauth:ClientConnector amazonAuthConnector;

    @doc:Description { value:"Get List of Buckets"}
    @doc:Return { value:"response object"}
    action getBucketList () (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};
        string httpMethod = "GET";
        string requestURI = "/";
        string host = "s3.amazonaws.com:443";
        string endpoint = "https://" + host;
        amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3",
                                                                "aws4_request", endpoint);
        request:setHeader(requestMsg, "Host", host);
        request:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "UNSIGNED-PAYLOAD");

        return response;
    }

    @doc:Description { value:"Get List of Objects in a bucket"}
    @doc:Param { value:"bucketName: The relevant bucket name"}
    @doc:Return { value:"response object"}
    action getObjectList (string bucketName) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};
        string httpMethod = "GET";
        string requestURI = "/";
        string host = bucketName + ".s3.amazonaws.com:443";
        string endpoint = "https://" + host;
        amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3",
                                                                "aws4_request", endpoint);

        request:setHeader(requestMsg, "Host", host);
        request:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "UNSIGNED-PAYLOAD");

        return response;
    }

    @doc:Description { value:"Create new Bucket"}
    @doc:Param { value:"bucketName: The relevant bucket name"}
    @doc:Return { value:"response object"}
    action createBucket (string bucketName) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};
        string httpMethod = "PUT";
        string requestURI = "/";
        string host = bucketName + ".s3.amazonaws.com:443";
        string endpoint = "https://" + host;
        amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3",
                                                                "aws4_request", endpoint);
        request:setHeader(requestMsg, "Host", host);
        request:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "UNSIGNED-PAYLOAD");

        return response;
    }

    @doc:Description { value:"Delete a Bucket"}
    @doc:Param { value:"bucketName: The relevant bucket name"}
    @doc:Return { value:"response object"}
    action deleteBucket (string bucketName) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string httpMethod = "DELETE";
        string requestURI = "/";
        string host = bucketName + ".s3.amazonaws.com:443";
        string endpoint = "https://" + host;
        amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3",
                                                                "aws4_request", endpoint);
        request:setHeader(requestMsg, "Host", host);
        request:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "UNSIGNED-PAYLOAD");

        return response;
    }

    @doc:Description { value:"Get an Object"}
    @doc:Param { value:"bucketName: The relevant bucket name"}
    @doc:Param { value:"objectName: The relevant object name"}
    @doc:Return { value:"response object"}
    action getObject (string bucketName, string objectName) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string httpMethod = "GET";
        string requestURI = "/" + objectName;
        string host = bucketName + ".s3.amazonaws.com:443";
        string endpoint = "https://" + host;
        amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3",
                                                                "aws4_request", endpoint);
        request:setHeader(requestMsg, "Host", host);
        request:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "UNSIGNED-PAYLOAD");

        return response;
    }

    @doc:Description { value:"Delete an Object"}
    @doc:Param { value:"bucketName: The relevant bucket name"}
    @doc:Param { value:"objectName: The relevant object name"}
    @doc:Return { value:"response object"}
    action deleteObject (string bucketName, string objectName) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string httpMethod = "DELETE";
        string requestURI = "/" + objectName;
        string host = bucketName + ".s3.amazonaws.com:443";
        string endpoint = "https://" + host;
        amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3",
                                                                "aws4_request", endpoint);
        request:setHeader(requestMsg, "Host", host);
        request:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "UNSIGNED-PAYLOAD");

        return response;
    }

    @doc:Description { value:"Put an Object"}
    @doc:Param { value:"bucketName: The relevant bucket name"}
    @doc:Param { value:"objectName: The relevant object name"}
    @doc:Param { value:"payload: The file that needed to be uploaded"}
    @doc:Return { value:"response object"}
    action putObject (string bucketName, string objectName, string payload) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string httpMethod = "PUT";
        string requestURI = "/" + objectName;
        string host = bucketName + ".s3.amazonaws.com:443";
        string endpoint = "https://" + host;
        amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3",
                                                                "aws4_request", endpoint);
        request:setStringPayload(requestMsg, payload);
        request:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
        request:setHeader(requestMsg, "Host", host);
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "UNSIGNED-PAYLOAD");

        return response;
    }
}