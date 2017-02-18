package org.wso2.ballerina.connectors.amazonlambda;

import org.wso2.ballerina.connectors.amazonauth;
import ballerina.lang.jsonutils;
import ballerina.lang.messages;

@doc:Description("Amazon Lambda client connector")
@doc:Param("accessKeyId: The access key ID in amazon account security credentials")
@doc:Param("secretAccessKey: The secret access key in amazon account security credentials")
@doc:Param("region: The region of the the amazon account server.")
connector ClientConnector(string accessKeyId, string secretAccessKey,string region) {

    string endpoint = "https://lambda." + region + ".amazonaws.com";
    amazonauth:ClientConnector amazonAuthConnector = create amazonauth:ClientConnector(accessKeyId, secretAccessKey,
     region, "lambda", "aws4_request", endpoint);

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
        response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");
        return response;
    }

    @doc:Description("Invokes a amazon lambda function by sending parameters")
    @doc:Param("arn: The amazon resource name of the function to invoke")
    @doc:Param("payload: The json payload containing key values of parameters to amazon lambda function")
    @doc:Return("response message")
    action invokeFunction(ClientConnector amz, string arn, json payload) (message) throws exception {
        string httpMethod;
        string requestURI;
      	string host;
        message requestMsg = {};
        message response = {};
      	host = "lambda." + region + ".amazonaws.com";
        httpMethod = "POST";
        requestURI = "/2015-03-31/functions/" + arn + "/invocations";
        messages:setHeader(requestMsg, "Host", host);
        messages:setJsonPayload(requestMsg, payload);
        response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI,
         jsonutils:toString(payload));
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
        response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");
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
        response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");
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
        response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");
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
        response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");
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
        response = amazonauth:ClientConnector.request(amazonAuthConnector, requestMsg, httpMethod, requestURI, "");
        return response;
    }
}