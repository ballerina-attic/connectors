package org.wso2.ballerina.connectors.basicauth;

import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.util;

connector ClientConnector (string userName, string password) {

    http:ClientConnector httpConnectorEP = create http:ClientConnector("");

    string encodedBasicAuthValue;

    action get(ClientConnector clientConnector, string url, message request) (message) {

    	message response;

    	encodedBasicAuthValue = constructBasicAuthHeader (request, encodedBasicAuthValue, userName, password);
    	response = http:ClientConnector.get(httpConnectorEP, url, request);

    	return response;
    }

    action post(ClientConnector clientConnector, string url, message request) (message) {

	    message response;

    	encodedBasicAuthValue = constructBasicAuthHeader (request, encodedBasicAuthValue, userName, password);
    	response = http:ClientConnector.post(httpConnectorEP, url, request);

    	return response;
    }

    action put(ClientConnector clientConnector, string url, message request) (message) {

    	message response;

    	encodedBasicAuthValue = constructBasicAuthHeader (request, encodedBasicAuthValue, userName, password);
    	response = http:ClientConnector.put(httpConnectorEP, url, request);

    	return response;
    }

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

	message:setHeader(request, "Authorization", "Basic "+ encodedBasicAuthValue);

	return encodedBasicAuthValue;
}

function main (string[] args) {

   	ClientConnector basicAuthConnector = create ClientConnector(args[0], args[1]);

	message request = {};
	message basicAuthResponse;
	json basicJSONResponse;

	basicAuthResponse = ClientConnector.get(basicAuthConnector, args[2], request);

	basicJSONResponse = message:getJsonPayload(basicAuthResponse);
	system:println(json:toString(basicJSONResponse));
}
