package org.wso2.ballerina.connectors;

import ballerina.lang.system;
import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.string;
import ballerina.net.http;
import ballerina.net.uri;
import ballerina.util;



connector AmazonLambda(string accessKeyId, string secretAccessKey,string region, string serviceName,
                                        string terminationString) {

    string endpoint = "https://lambda." + region + ".amazonaws.com";
    AmazonAuthConnector amazonAuthConnector = create AmazonAuthConnector(accessKeyId, secretAccessKey, region, "lambda", "aws4_request", endpoint);

    action invokeFunction(AmazonLambda amz, string arn) (message) throws exception {

        string signature;
        string httpMethod;
        string requestURI;
    	string host;
        message requestMsg = {};
        message response = {};
    	host = "lambda." + region + ".amazonaws.com";

        httpMethod = "POST";
        requestURI = "/2015-03-31/functions/" + arn + "/invocations";

        message:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }
    action deleteFunction(AmazonLambda amz, string arn) (message) throws exception {

        string signature;
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

        message:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }
    action getAccountDetails(AmazonLambda amz) (message) throws exception {

        string signature;
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

        message:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }
    action getFunction(AmazonLambda amz, string arn) (message) throws exception {

        string signature;
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

        message:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }
    action listFunctions(AmazonLambda amz) (message) throws exception {

        string signature;
        string httpMethod;
        string requestURI;
    	string host;
        message requestMsg = {};
        message response = {};
    	host = "lambda." + region + ".amazonaws.com";

        httpMethod = "GET";
        requestURI = "/2015-03-31/functions/";

        message:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }
    action getFunctionVersions(AmazonLambda amz, string arn) (message) throws exception {

        string signature;
        string httpMethod;
        string requestURI;
    	string host;
        message requestMsg = {};
        message response = {};
    	host = "lambda." + region + ".amazonaws.com";

        httpMethod = "GET";
        requestURI = "/2015-03-31/functions/" + arn + "/versions";

        message:setHeader(requestMsg, "Host", host);
        response = AmazonAuthConnector.req(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");

        return response;
    }
}

connector AmazonAuthConnector(string accessKeyId, string secretAccessKey,
                string region, string serviceName, string terminationString, string endpoint) {


    http:ClientConnector awsEP = create http:ClientConnector(endpoint);

    action req(AmazonAuthConnector amz, message requestMsg, string httpMethod, string requestURI, string payload) (message) throws exception {

        message response;

        requestMsg = generateSignature(requestMsg, accessKeyId, secretAccessKey, region, serviceName, terminationString, httpMethod, requestURI, "");

        if(string:equalsIgnoreCase(httpMethod,"POST")){
            response = http:ClientConnector.post(awsEP, requestURI, requestMsg);
        }else if(string:equalsIgnoreCase(httpMethod,"GET")){
            response = http:ClientConnector.get(awsEP, requestURI, requestMsg);
        }else if(string:equalsIgnoreCase(httpMethod,"PUT")){
            response = http:ClientConnector.put(awsEP, requestURI, requestMsg);
        }else if(string:equalsIgnoreCase(httpMethod,"DELETE")){
            response = http:ClientConnector.delete(awsEP, requestURI, requestMsg);
        }

        return response;

    }

}


function main (string[] args) {

    AmazonLambda amzLamConnector = create AmazonLambda(args[1], args[2], args[3], "lambda", "aws4_request");
    message lambdaResponse;
    json lambdaJSONResponse;

    if (args[0] == "invokeFunction"){
        lambdaResponse = AmazonLambda.invokeFunction(amzLamConnector, args[4]);
        lambdaJSONResponse = message:getJsonPayload(lambdaResponse);
        system:println(json:toString(lambdaJSONResponse));
    }
    if (args[0] == "deleteFunction"){
            lambdaResponse = AmazonLambda.deleteFunction(amzLamConnector, args[4]);
            lambdaJSONResponse = message:getJsonPayload(lambdaResponse);
            system:println(json:toString(lambdaJSONResponse));
    }
    if (args[0] == "listFunctions"){
        lambdaResponse = AmazonLambda.listFunctions(amzLamConnector);
        lambdaJSONResponse = message:getJsonPayload(lambdaResponse);
        system:println(json:toString(lambdaJSONResponse));
    }
    if (args[0] == "listFunctionVersions"){
        lambdaResponse = AmazonLambda.getFunctionVersions(amzLamConnector, args[4]);
        lambdaJSONResponse = message:getJsonPayload(lambdaResponse);
        system:println(json:toString(lambdaJSONResponse));
    }
    if (args[0] == "getFunction"){
        lambdaResponse = AmazonLambda.getFunction(amzLamConnector, args[4]);
        lambdaJSONResponse = message:getJsonPayload(lambdaResponse);
        system:println(json:toString(lambdaJSONResponse));
    }
    if (args[0] == "getAccountDetails"){
        lambdaResponse = AmazonLambda.getAccountDetails(amzLamConnector);
        lambdaJSONResponse = message:getJsonPayload(lambdaResponse);
        system:println(json:toString(lambdaJSONResponse));
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

    message:setHeader(msg, "X-Amz-Date", amzDate);

    canonicalRequest = httpMethod;
    canonicalRequest = canonicalRequest + "\n";
    canonicalRequest = canonicalRequest + string:replaceAll(uri:encode(requestURI), "%2F", "/");
    canonicalRequest = canonicalRequest + "\n";

    canonicalQueryString = "";

    canonicalRequest = canonicalRequest + canonicalQueryString;
    canonicalRequest = canonicalRequest + "\n";

    if(payload != ""){
            canonicalHeaders = canonicalHeaders + string:toLowerCase("Content-Type");
            canonicalHeaders = canonicalHeaders + ":";
            canonicalHeaders = canonicalHeaders + (message:getHeader(msg, string:toLowerCase("Content-Type")));
            canonicalHeaders = canonicalHeaders + "\n";
            signedHeader = signedHeader + string:toLowerCase("Content-Type");
            signedHeader = signedHeader + ";";
    }

    canonicalHeaders = canonicalHeaders + string:toLowerCase("Host");
    canonicalHeaders = canonicalHeaders + ":";
    canonicalHeaders = canonicalHeaders + message:getHeader(msg, string:toLowerCase("Host"));
    canonicalHeaders = canonicalHeaders + "\n";
    signedHeader = signedHeader + string:toLowerCase("Host");
    signedHeader = signedHeader + ";";

    canonicalHeaders = canonicalHeaders + string:toLowerCase("X-Amz-Date");
    canonicalHeaders = canonicalHeaders + ":";
    canonicalHeaders = canonicalHeaders + (message:getHeader(msg, string:toLowerCase("X-Amz-Date")));
    canonicalHeaders = canonicalHeaders + "\n";
    signedHeader = signedHeader + string:toLowerCase("X-Amz-Date");
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

    canonicalRequest = canonicalRequest + string:toLowerCase(util:getHash(requestPayload, algorithm));

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
    stringToSign = stringToSign + string:toLowerCase(util:getHash(canonicalRequest, algorithm));

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
    authHeader = authHeader + string:toLowerCase(util:getHmacBase16(stringToSign, signingKey, algorithm));

    message:setHeader(msg, "Authorization", authHeader);
    return msg;
}






