package org.wso2.ballerina.connectors.basicauth;

import ballerina.lang.messages;
import ballerina.net.http;
import ballerina.util;

@doc:Description("Basic Auth client connector")
@doc:Param("userName: The user name of the account")
@doc:Param("password: The password of the account")
connector ClientConnector (string userName, string password) {

    http:ClientConnector httpConnectorEP = create http:ClientConnector("");

    string encodedBasicAuthValue;

    @doc:Description("Get with basic authentication")
    @doc:Param("url: The endpoint url")
    @doc:Param("request: The request of the method")
    @doc:Return("response object")
    action get(ClientConnector clientConnector, string url, message request) (message) {

        message response;

        encodedBasicAuthValue = constructBasicAuthHeader (request, encodedBasicAuthValue, userName, password);
        response = http:ClientConnector.get(httpConnectorEP, url, request);

        return response;
    }

    @doc:Description("Post with basic authentication")
    @doc:Param("url: The endpoint url")
    @doc:Param("request: The request of the method")
    @doc:Return("response object")
    action post(ClientConnector clientConnector, string url, message request) (message) {

        message response;

        encodedBasicAuthValue = constructBasicAuthHeader (request, encodedBasicAuthValue, userName, password);
        response = http:ClientConnector.post(httpConnectorEP, url, request);

        return response;
    }

    @doc:Description("Put with basic authentication")
    @doc:Param("url: The endpoint url")
    @doc:Param("request: The request of the method")
    @doc:Return("response object")
    action put(ClientConnector clientConnector, string url, message request) (message) {

        message response;

        encodedBasicAuthValue = constructBasicAuthHeader (request, encodedBasicAuthValue, userName, password);
        response = http:ClientConnector.put(httpConnectorEP, url, request);

        return response;
    }

    @doc:Description("Delete with basic authentication")
    @doc:Param("url: The endpoint url")
    @doc:Param("request: The request of the method")
    @doc:Return("response object")
    action delete(ClientConnector clientConnector, string url, message request)(message) {

        message response;

        encodedBasicAuthValue = constructBasicAuthHeader (request, encodedBasicAuthValue, userName, password);
        response = http:ClientConnector.delete(httpConnectorEP, url, request);

        return response;
    }
}

function constructBasicAuthHeader(message request, string encodedBasicAuthValue, string userName, string password) (string) {

    if (encodedBasicAuthValue == "") {
        encodedBasicAuthValue = util:base64encode(userName + ":" + password);
    }

    messages:setHeader(request, "Authorization", "Basic "+ encodedBasicAuthValue);

    return encodedBasicAuthValue;
}
