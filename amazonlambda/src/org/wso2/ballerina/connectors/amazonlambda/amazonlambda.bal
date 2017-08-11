package org.wso2.ballerina.connectors.amazonlambda;

import org.wso2.ballerina.connectors.amazonauth;
import ballerina.doc;
import ballerina.lang.jsons;
import ballerina.lang.messages;

@doc:Description { value:"Amazon Lambda client connector"}
@doc:Param { value:"accessKeyId: The access key ID in amazon account security credentials"}
@doc:Param { value:"secretAccessKey: The secret access key in amazon account security credentials"}
@doc:Param { value:"region: The region of the the amazon account server."}
connector ClientConnector (string accessKeyId, string secretAccessKey, string region) {

    string endpoint = "https://lambda." + region + ".amazonaws.com";
    amazonauth:ClientConnector amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey,
                                                                                       region, "lambda", "aws4_request",
                                                                                       endpoint);

    @doc:Description { value:"Invokes a amazon lambda function"}
    @doc:Param { value:"arn: The amazon resource name of the function to invoke"}
    @doc:Return { value:"response message"}
    action invokeFunction (string arn) (message) {
        message requestMsg = {};
        message response = {};

        string host = "lambda." + region + ".amazonaws.com";
        string httpMethod = "POST";
        string requestURI = "/2015-03-31/functions/" + arn + "/invocations";
        messages:setHeader(requestMsg, "Host", host);
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "");
        return response;
    }

    @doc:Description { value:"Invokes a amazon lambda function by sending parameters"}
    @doc:Param { value:"arn: The amazon resource name of the function to invoke"}
    @doc:Param { value:"payload: The json payload containing key values of parameters to amazon lambda function"}
    @doc:Return { value:"response message"}
    action invokeFunctionWithParam (string arn, json payload) (message) {
        message requestMsg = {};
        message response = {};

        string host = "lambda." + region + ".amazonaws.com";
        string httpMethod = "POST";
        string requestURI = "/2015-03-31/functions/" + arn + "/invocations";
        messages:setHeader(requestMsg, "Host", host);
        messages:setJsonPayload(requestMsg, payload);
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, jsons:toString(payload));
        return response;
    }

    @doc:Description { value:"Deletes a lambda function"}
    @doc:Param { value:"arn: The amazon resource name of the function to invoke"}
    @doc:Return { value:"response message"}
    action deleteFunction (string arn) (message) {
        message requestMsg = {};
        message response = {};

        string host = "lambda." + region + ".amazonaws.com";
        string httpMethod = "DELETE";
        string requestURI = "/2015-03-31/functions/" + arn;
        host = "lambda.us-east-1.amazonaws.com";
        endpoint = "https://lambda." + region + ".amazonaws.com";
        messages:setHeader(requestMsg, "Host", host);
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "");
        return response;
    }

    @doc:Description { value:"Returns the users' account information"}
    @doc:Return { value:"response message"}
    action getAccountDetails () (message) {
        message requestMsg = {};
        message response = {};

        string host = "lambda." + region + ".amazonaws.com";
        string httpMethod = "GET";
        string requestURI = "/2016-08-19/account-settings/";
        host = "lambda.us-east-1.amazonaws.com";
        endpoint = "https://lambda." + region + ".amazonaws.com";
        messages:setHeader(requestMsg, "Host", host);
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "");
        return response;
    }

    @doc:Description { value:"Gets the configuration information of a lambda function"}
    @doc:Param { value:"arn: The amazon resource name of the function to invoke"}
    @doc:Return { value:"response message"}
    action getFunction (string arn) (message) {
        message requestMsg = {};
        message response = {};

        string host = "lambda." + region + ".amazonaws.com";
        string httpMethod = "GET";
        string requestURI = "/2015-03-31/functions/" + arn;
        host = "lambda.us-east-1.amazonaws.com";
        endpoint = "https://lambda." + region + ".amazonaws.com";
        messages:setHeader(requestMsg, "Host", host);
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "");
        return response;
    }

    @doc:Description { value:"Gets the list of functions and their configuration information"}
    @doc:Return { value:"response message"}
    action listFunctions () (message) {
        message requestMsg = {};
        message response = {};

        string host = "lambda." + region + ".amazonaws.com";
        string httpMethod = "GET";
        string requestURI = "/2015-03-31/functions/";
        messages:setHeader(requestMsg, "Host", host);
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "");
        return response;
    }

    @doc:Description { value:"Lists all versions of a amazon lambda function"}
    @doc:Param { value:"arn: The amazon resource name of the function to invoke"}
    @doc:Return { value:"response message"}
    action getFunctionVersions (string arn) (message) {
        message requestMsg = {};
        message response = {};

        string host = "lambda." + region + ".amazonaws.com";
        string httpMethod = "GET";
        string requestURI = "/2015-03-31/functions/" + arn + "/versions";
        messages:setHeader(requestMsg, "Host", host);
        response = amazonAuthConnector.request (requestMsg, httpMethod, requestURI, "");
        return response;
    }
}