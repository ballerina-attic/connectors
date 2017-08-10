package org.wso2.ballerina.connectors.basicauth;

import ballerina.doc;
import ballerina.lang.messages;
import ballerina.net.http;
import ballerina.utils;

@doc:Description{ value : "Basic Auth client connector"}
@doc:Param{ value : "baseUrl: The endpoint base url"}
@doc:Param{ value : "userName: The user name of the account"}
@doc:Param{ value : "password: The password of the account"}
connector ClientConnector (string baseUrl, string userName, string password) {

    http:ClientConnector httpConnectorEP = create http:ClientConnector(baseUrl);

    string encodedBasicAuthValue;

    @doc:Description{ value : "Get with basic authentication"}
    @doc:Param{ value : "path: The endpoint path"}
    @doc:Param{ value : "request: The request of the method"}
    @doc:Return{ value : "response object"}
    action get(string path, message request) (message) {

        message response;

        encodedBasicAuthValue = constructBasicAuthHeader (request, encodedBasicAuthValue, userName, password);
        response = httpConnectorEP.get(path, request);

        return response;
    }

    @doc:Description{ value : "Post with basic authentication"}
    @doc:Param{ value : "path: The endpoint path"}
    @doc:Param{ value : "request: The request of the method"}
    @doc:Return{ value : "response object"}
    action post(string path, message request) (message) {

        message response;

        encodedBasicAuthValue = constructBasicAuthHeader (request, encodedBasicAuthValue, userName, password);
        response = httpConnectorEP.post(path, request);

        return response;
    }

    @doc:Description{ value : "Put with basic authentication"}
    @doc:Param{ value : "path: The endpoint path"}
    @doc:Param{ value : "request: The request of the method"}
    @doc:Return{ value : "response object"}
    action put(string path, message request) (message) {

        message response;

        encodedBasicAuthValue = constructBasicAuthHeader (request, encodedBasicAuthValue, userName, password);
        response = httpConnectorEP.put(path, request);

        return response;
    }

    @doc:Description{ value : "Delete with basic authentication"}
    @doc:Param{ value : "path: The endpoint path"}
    @doc:Param{ value : "request: The request of the method"}
    @doc:Return{ value : "response object"}
    action delete(string path, message request)(message) {

        message response;

        encodedBasicAuthValue = constructBasicAuthHeader (request, encodedBasicAuthValue, userName, password);
        response = httpConnectorEP.delete(path, request);

        return response;
    }
}

function constructBasicAuthHeader(message request, string encodedBasicAuthValue, string userName, string password) (string) {

    if (encodedBasicAuthValue == "") {
        encodedBasicAuthValue = utils:base64encode(userName + ":" + password);
    }

    messages:setHeader(request, "Authorization", "Basic "+ encodedBasicAuthValue);

    return encodedBasicAuthValue;
}
