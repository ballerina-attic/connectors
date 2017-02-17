package org.wso2.ballerina.connectors.amazonS3;

import ballerina.lang.system;
import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.net.http;
import ballerina.net.uri;
import ballerina.util;

@doc:Description("Amazon S3 client connector")
@doc:Param("accessKeyId: The access key ID of the Amazon Account")
@doc:Param("secretAccessKey: The secret access key of the Amazon Account")
@doc:Param("region: The region to which the request is made")
connector ClientConnector(string accessKeyId, string secretAccessKey, string region) {

    AmazonAuthConnector amazonAuthConnector;

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
            amazonAuthConnector = create AmazonAuthConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
	        messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI,
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
            amazonAuthConnector = create AmazonAuthConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);

            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI,
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
            amazonAuthConnector = create AmazonAuthConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI,
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
            amazonAuthConnector = create AmazonAuthConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI,
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
            amazonAuthConnector = create AmazonAuthConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI,
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
            amazonAuthConnector = create AmazonAuthConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setHeader(requestMsg, "Host", host);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI,
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
            amazonAuthConnector = create AmazonAuthConnector(accessKeyId, secretAccessKey, region, "s3", "aws4_request",
             endpoint);
            messages:setStringPayload(requestMsg, payload);
            messages:setHeader(requestMsg, "X-Amz-Content-Sha256", "UNSIGNED-PAYLOAD");
            messages:setHeader(requestMsg, "Host", host);
            response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI,
             "UNSIGNED-PAYLOAD");

            return response;
    	}
}

connector AmazonAuthConnector(string accessKeyId, string secretAccessKey,
                string region, string serviceName, string terminationString, string endpoint) {
    http:ClientConnector awsEP = create http:ClientConnector(endpoint);

    action req(AmazonAuthConnector amazonAuthConnector, message requestMsg, string httpMethod, string requestURI, string payload) (message) throws exception {

        message response;

        requestMsg = generateSignature(requestMsg, accessKeyId, secretAccessKey, region, serviceName, terminationString, httpMethod, requestURI, payload);

        if(strings:equalsIgnoreCase(httpMethod,"POST")){
            response = http:ClientConnector.post(awsEP, requestURI, requestMsg);
        }else if(strings:equalsIgnoreCase(httpMethod,"GET")){
            response = http:ClientConnector.get(awsEP, requestURI, requestMsg);
        }else if(strings:equalsIgnoreCase(httpMethod,"PUT")){
            response = http:ClientConnector.put(awsEP, requestURI, requestMsg);
        }else if(strings:equalsIgnoreCase(httpMethod,"DELETE")){
            response = http:ClientConnector.delete(awsEP, requestURI, requestMsg);
        }
        return response;
    }
}

function generateSignature(message msg, string accessKeyId, string secretAccessKey, string region, string serviceName,
    string terminationString, string httpMethod, string requestURI, string payload) (message) throws exception {

    string canonicalRequest;
    string canonicalQueryString;
    string stringToSign;
    string payloadBuilder;
    string payloadStrBuilder;
    string authHeader;
    string algorithm;
    string amzDate;
    string shortDate;
    string signedHeader;
    string canonicalHeaders;
    string signedHeaders;
    string requestPayload;
    string signingKey;

    algorithm = "SHA256";

    amzDate = system:getDateFormat("yyyyMMdd'T'HHmmss'Z'");
    shortDate = system:getDateFormat("yyyyMMdd");
    messages:setHeader(msg, "X-Amz-Date", amzDate);
    canonicalRequest = httpMethod;
    canonicalRequest = canonicalRequest + "\n";
    canonicalRequest = canonicalRequest + strings:replaceAll(uri:encode(requestURI), "%2F", "/");
    canonicalRequest = canonicalRequest + "\n";
    canonicalQueryString = "";
    canonicalRequest = canonicalRequest + canonicalQueryString;
    canonicalRequest = canonicalRequest + "\n";
    if(!(payload == "" || payload == "UNSIGNED-PAYLOAD")){
        canonicalHeaders = canonicalHeaders + strings:toLowerCase("Content-Type");
        canonicalHeaders = canonicalHeaders + ":";
        canonicalHeaders = canonicalHeaders + (messages:getHeader(msg, strings:toLowerCase("Content-Type")));
        canonicalHeaders = canonicalHeaders + "\n";
        signedHeader = signedHeader + strings:toLowerCase("Content-Type");
        signedHeader = signedHeader + ";";
    }
    canonicalHeaders = canonicalHeaders + strings:toLowerCase("Host");
    canonicalHeaders = canonicalHeaders + ":";
    canonicalHeaders = canonicalHeaders + messages:getHeader(msg, strings:toLowerCase("Host"));
    canonicalHeaders = canonicalHeaders + "\n";
    signedHeader = signedHeader + strings:toLowerCase("Host");
    signedHeader = signedHeader + ";";

    canonicalHeaders = canonicalHeaders + strings:toLowerCase("X-Amz-Content-Sha256");
    canonicalHeaders = canonicalHeaders + ":";
    canonicalHeaders = canonicalHeaders + messages:getHeader(msg, strings:toLowerCase("X-Amz-Content-Sha256"));
    canonicalHeaders = canonicalHeaders + "\n";
    signedHeader = signedHeader + strings:toLowerCase("x-amz-content-sha256");
    signedHeader = signedHeader + ";";

    canonicalHeaders = canonicalHeaders + strings:toLowerCase("X-Amz-Date");
    canonicalHeaders = canonicalHeaders + ":";
    canonicalHeaders = canonicalHeaders + (messages:getHeader(msg, strings:toLowerCase("X-Amz-Date")));
    canonicalHeaders = canonicalHeaders + "\n";
    signedHeader = signedHeader + strings:toLowerCase("X-Amz-Date");
    signedHeader = signedHeader;

    canonicalRequest = canonicalRequest + canonicalHeaders;
    canonicalRequest = canonicalRequest + "\n";
    signedHeaders = "";
    signedHeaders = signedHeader;
    canonicalRequest = canonicalRequest + signedHeaders;
    canonicalRequest = canonicalRequest + "\n";
    payloadBuilder = payload;
    requestPayload = "";
    requestPayload = payloadBuilder;

    if (payloadBuilder == "UNSIGNED-PAYLOAD") {
        requestPayload = payloadBuilder;
    } else {
        requestPayload = strings:toLowerCase(util:getHash(payloadBuilder, algorithm));
    }

    canonicalRequest = canonicalRequest + requestPayload;

    //Start creating the string to sign

    stringToSign = stringToSign + "AWS4-HMAC-SHA256";
    stringToSign = stringToSign + "\n";
    stringToSign = stringToSign + amzDate;
    stringToSign = stringToSign + "\n";
    stringToSign = stringToSign + shortDate;
    stringToSign = stringToSign + "/";
    stringToSign = stringToSign + region;
    stringToSign = stringToSign + "/";
    stringToSign = stringToSign + serviceName;
    stringToSign = stringToSign + "/";
    stringToSign = stringToSign + terminationString;
    stringToSign = stringToSign + "\n";
    stringToSign = stringToSign + strings:toLowerCase(util:getHash(canonicalRequest, algorithm));

    signingKey =  util:getHmacFromBase64( terminationString,util:getHmacFromBase64( serviceName,
    util:getHmacFromBase64( region,util:getHmacFromBase64(shortDate,util:base64encode("AWS4" + secretAccessKey),
    algorithm), algorithm), algorithm), algorithm);

    authHeader = authHeader + ("AWS4-HMAC-SHA256");
    authHeader = authHeader + (" ");
    authHeader = authHeader + ("Credential");
    authHeader = authHeader + ("=");
    authHeader = authHeader + (accessKeyId);
    authHeader = authHeader + ("/");
    authHeader = authHeader + (shortDate);
    authHeader = authHeader + ("/");
    authHeader = authHeader + (region);
    authHeader = authHeader + ("/");
    authHeader = authHeader + (serviceName);
    authHeader = authHeader + ("/");
    authHeader = authHeader + (terminationString);
    authHeader = authHeader + (",");
    authHeader = authHeader + (" SignedHeaders");
    authHeader = authHeader + ("=");
    authHeader = authHeader + (signedHeaders);
    authHeader = authHeader + (",");
    authHeader = authHeader + (" Signature");
    authHeader = authHeader + ("=");
    authHeader = authHeader + strings:toLowerCase(util:base64ToBase16Encode(util:getHmacFromBase64(stringToSign,
     signingKey, algorithm)));
    messages:setHeader(msg, "Authorization", authHeader);
    return msg;
}