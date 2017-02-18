package org.wso2.ballerina.connectors.amazonS3;

import org.wso2.ballerina.connectors.amazonAuth;
import ballerina.lang.messages;

@doc:Description("Amazon S3 client connector")
@doc:Param("accessKeyId: The access key ID of the Amazon Account")
@doc:Param("secretAccessKey: The secret access key of the Amazon Account")
@doc:Param("region: The region to which the request is made")
connector ClientConnector(string accessKeyId, string secretAccessKey, string region) {

    amazonAuth:ClientConnector amazonAuthConnector;

    @doc:Description("Get List of Buckets")
    @doc:Return("response object")
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
            amazonAuthConnector = create amazonAuth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
	        messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonAuth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
            "UNSIGNED-PAYLOAD");

            return response;
    	}

    @doc:Description("Get List of Objects in a bucket")
    @doc:Param("bucketName: The relevant bucket name")
    @doc:Return("response object")
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
            amazonAuthConnector = create amazonAuth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);

            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonAuth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    	}

    @doc:Description("Create new Bucket")
    @doc:Param("bucketName: The relevant bucket name")
    @doc:Return("response object")
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
            amazonAuthConnector = create amazonAuth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonAuth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    	}

    @doc:Description("Delete a Bucket")
    @doc:Param("bucketName: The relevant bucket name")
    @doc:Return("response object")
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
            amazonAuthConnector = create amazonAuth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonAuth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    	}

    @doc:Description("Get an Object")
    @doc:Param("bucketName: The relevant bucket name")
    @doc:Param("objectName: The relevant object name")
    @doc:Return("response object")
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
            amazonAuthConnector = create amazonAuth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonAuth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    	}

    @doc:Description("Delete an Object")
    @doc:Param("bucketName: The relevant bucket name")
    @doc:Param("objectName: The relevant object name")
    @doc:Return("response object")
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
            amazonAuthConnector = create amazonAuth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = amazonAuth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    	}

    @doc:Description("Put an Object")
    @doc:Param("bucketName: The relevant bucket name")
    @doc:Param("objectName: The relevant object name")
    @doc:Param("payload: The file that needed to be uploaded")
    @doc:Return("response object")
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
            amazonAuthConnector = create amazonAuth:ClientConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setStringPayload(requestMsg, payload);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            messages:setHeader(requestMsg, "Host", host);
            response = amazonAuth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    	}
}