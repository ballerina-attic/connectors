package org.wso2.ballerina.connectors.amazonLambda;

import ballerina.lang.system;
import ballerina.lang.jsonutils;
import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.net.http;
import ballerina.net.uri;
import ballerina.util;

@doc:Description("Amazon Lambda client connector")
@doc:Param("accessKeyId: The access key ID in amazon account security credentials")
@doc:Param("secretAccessKey: The secret access key in amazon account security credentials")
@doc:Param("region: The region of the the amazon account server.")
connector ClientConnector(string accessKeyId, string secretAccessKey,string region) {

    string endpoint = "https://lambda." + region + ".amazonaws.com";
    AmazonAuthConnector amazonAuthConnector = create AmazonAuthConnector(accessKeyId, secretAccessKey, region, "lambda",
     "aws4_request", endpoint);

    @doc:Description("Invokes a amazon lambda function")
    @doc:Param("arn: The amazon resource name of the function to invoke")
    @doc:Return("response message")
    action invokeFunction(ClientConnector amz, string arn) (message) throws exception {

        string httpMethod;
        string requestURI;
    	string host;
        message requestMsg = {};
        message response = {};
    	host = "lambda." + region + ".amazonaws.com";

        httpMethod = "POST";
        requestURI = "/2015-03-31/functions/" + arn + "/invocations";

        messages:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }

    @doc:Description("Deletes a lambda function")
    @doc:Param("arn: The amazon resource name of the function to invoke")
    @doc:Return("response message")
    action deleteFunction(ClientConnector amz, string arn) (message) throws exception {

        string httpMethod;
        string requestURI;
    	string host;
        message requestMsg = {};
        message response = {};
    	host = "lambda." + region + ".amazonaws.com";

        httpMethod = "DELETE";
        requestURI = "/2015-03-31/functions/" + arn;
        host = "lambda.us-east-1.amazonaws.com";
        endpoint = "https://lambda." + region + ".amazonaws.com";

        messages:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }

    @doc:Description("Returns the users' account information")
    @doc:Return("response message")
    action getAccountDetails(ClientConnector amz) (message) throws exception {

        string httpMethod;
        string requestURI;
    	string host;
        message requestMsg = {};
        message response = {};
    	host = "lambda." + region + ".amazonaws.com";

        httpMethod = "GET";
        requestURI = "/2016-08-19/account-settings/";
        host = "lambda.us-east-1.amazonaws.com";
        endpoint = "https://lambda." + region + ".amazonaws.com";

        messages:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }

    @doc:Description("Gets the configuration information of a lambda function")
    @doc:Param("arn: The amazon resource name of the function to invoke")
    @doc:Return("response message")
    action getFunction(ClientConnector amz, string arn) (message) throws exception {

        string httpMethod;
        string requestURI;
    	string host;
        message requestMsg = {};
        message response = {};
    	host = "lambda." + region + ".amazonaws.com";

        httpMethod = "GET";
        requestURI = "/2015-03-31/functions/" + arn;
        host = "lambda.us-east-1.amazonaws.com";
        endpoint = "https://lambda." + region + ".amazonaws.com";

        messages:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }

    @doc:Description("Gets the list of functions and their configuration information")
    @doc:Param("arn: The amazon resource name of the function to invoke")
    @doc:Return("response message")
    action listFunctions(ClientConnector amz) (message) throws exception {

        string httpMethod;
        string requestURI;
    	string host;
        message requestMsg = {};
        message response = {};
    	host = "lambda." + region + ".amazonaws.com";

        httpMethod = "GET";
        requestURI = "/2015-03-31/functions/";

        messages:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }

    @doc:Description("Lists all versions of a amazon lambda function")
    @doc:Return("response message")
    action getFunctionVersions(ClientConnector amz, string arn) (message) throws exception {

        string httpMethod;
        string requestURI;
    	string host;
        message requestMsg = {};
        message response = {};
    	host = "lambda." + region + ".amazonaws.com";

        httpMethod = "GET";
        requestURI = "/2015-03-31/functions/" + arn + "/versions";

        messages:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }
}

connector AmazonAuthConnector(string accessKeyId, string secretAccessKey,
                string region, string serviceName, string terminationString, string endpoint) {

    http:ClientConnector awsEP = create http:ClientConnector(endpoint);

    action req(AmazonAuthConnector amz, message requestMsg, string httpMethod, string requestURI, string payload)
     (message) throws exception {

        message response;

        requestMsg = generateSignature(requestMsg, accessKeyId, secretAccessKey, region, serviceName, terminationString,
         httpMethod, requestURI, "");

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

    if(payload != ""){
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

    canonicalRequest = canonicalRequest + strings:toLowerCase(util:getHash(requestPayload, algorithm));

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






