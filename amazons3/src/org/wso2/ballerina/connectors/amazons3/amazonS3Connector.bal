package org.wso2.ballerina.connectors.amazons3;

import org.wso2.ballerina.connectors.amazonauth;
import ballerina.doc;
import ballerina.lang.messages;

@doc:Description{ value : "Amazon S3 client connector"}
@doc:Param{ value : "accessKeyId: The access key ID of the Amazon Account"}
@doc:Param{ value : "secretAccessKey: The secret access key of the Amazon Account"}
@doc:Param{ value : "region: The region to which the request is made"}
connector ClientConnector(string accessKeyId, string secretAccessKey, string region) {

    amazonauth:ClientConnector amazonAuthConnector;

    @doc:Description{ value : "Get List of Buckets"}
    @doc:Param{ value : "s3Connector: The amazonS3 Connector instance"}
    @doc:Return{ value : "response object"}
    action getBucketList(ClientConnector s3Connector) (message) throws exception {

            string signature;
            string httpMethod;
            string requestURI;
            string host;
            string endpoint;
            message requestMsg = {};
            message response;

            httpMethod = "GET";
            requestURI = "/";
            host = "s3.amazonaws.com:443";
            endpoint = "https://"+host;
            amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
            "UNSIGNED-PAYLOAD");

            return response;
    }

    @doc:Description{ value : "Get List of Objects in a bucket"}
    @doc:Param{ value : "s3Connector: The amazonS3 Connector instance"}
    @doc:Param{ value : "bucketName: The relevant bucket name"}
    @doc:Return{ value : "response object"}
    action getObjectList(ClientConnector s3Connector, string bucketName) (message) throws exception {

            string signature;
            string httpMethod;
            string requestURI;
            string host;
            string endpoint;
            message requestMsg = {};
            message response;

            httpMethod = "GET";
            requestURI = "/";
            host = bucketName + ".s3.amazonaws.com:443";
            endpoint = "https://"+host;
            amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);

            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    }

    @doc:Description{ value : "Create new Bucket"}
    @doc:Param{ value : "s3Connector: The amazonS3 Connector instance"}
    @doc:Param{ value : "bucketName: The relevant bucket name"}
    @doc:Return{ value : "response object"}
    action createBucket(ClientConnector s3Connector, string bucketName) (message) throws exception {

            string signature;
            string httpMethod;
            string requestURI;
            string host;
            string endpoint;
            message requestMsg = {};
            message response;

            httpMethod = "PUT";
            requestURI = "/";
            host = bucketName + ".s3.amazonaws.com:443";
            endpoint = "https://"+host;
            amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    }

    @doc:Description{ value : "Delete a Bucket"}
    @doc:Param{ value : "s3Connector: The amazonS3 Connector instance"}
    @doc:Param{ value : "bucketName: The relevant bucket name"}
    @doc:Return{ value : "response object"}
    action deleteBucket(ClientConnector s3Connector, string bucketName) (message) throws exception {

            string signature;
            string httpMethod;
            string requestURI;
            string host;
            string endpoint;
            message requestMsg = {};
            message response;

            httpMethod = "DELETE";
            requestURI = "/";
            host = bucketName + ".s3.amazonaws.com:443";
            endpoint = "https://"+host;
            amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    }

    @doc:Description{ value : "Get an Object"}
    @doc:Param{ value : "s3Connector: The amazonS3 Connector instance"}
    @doc:Param{ value : "bucketName: The relevant bucket name"}
    @doc:Param{ value : "objectName: The relevant object name"}
    @doc:Return{ value : "response object"}
    action getObject(ClientConnector s3Connector, string bucketName, string objectName) (message) throws exception {

            string signature;
            string httpMethod;
            string requestURI;
            string host;
            string endpoint;
            message requestMsg = {};
            message response;

            httpMethod = "GET";
            requestURI = "/" + objectName;
            host = bucketName + ".s3.amazonaws.com:443";
            endpoint = "https://"+host;
            amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    }

    @doc:Description{ value : "Delete an Object"}
    @doc:Param{ value : "s3Connector: The amazonS3 Connector instance"}
    @doc:Param{ value : "bucketName: The relevant bucket name"}
    @doc:Param{ value : "objectName: The relevant object name"}
    @doc:Return{ value : "response object"}
    action deleteObject(ClientConnector s3Connector, string bucketName, string objectName) (message) throws exception {

            string signature;
            string httpMethod;
            string requestURI;
            string host;
            string endpoint;
            message requestMsg = {};
            message response;

            httpMethod = "DELETE";
            requestURI = "/" + objectName;
            host = bucketName + ".s3.amazonaws.com:443";
            endpoint = "https://"+host;
            amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    }

    @doc:Description{ value : "Put an Object"}
    @doc:Param{ value : "s3Connector: The amazonS3 Connector instance"}
    @doc:Param{ value : "bucketName: The relevant bucket name"}
    @doc:Param{ value : "objectName: The relevant object name"}
    @doc:Param{ value : "payload: The file that needed to be uploaded"}
    @doc:Return{ value : "response object"}
    action putObject(ClientConnector s3Connector, string bucketName, string objectName, string payload) (message)
     throws exception {

            string httpMethod;
            string requestURI;
            string host;
            string endpoint;
            message requestMsg = {};
            message response;

            httpMethod = "PUT";
            requestURI = "/" + objectName;
            host = bucketName + ".s3.amazonaws.com:443";
            endpoint = "https://" + host;
            amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setStringPayload(requestMsg, payload);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            messages:setHeader(requestMsg, "Host", host);
            response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
     }
}