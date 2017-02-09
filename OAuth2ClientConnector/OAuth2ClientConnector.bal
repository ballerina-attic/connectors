package org.wso2.ballerina.connectors;

import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.string;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.net.uri;
import ballerina.util;

connector OAuth2ClientConnector (string accessToken, string clientId, string clientSecret,
                                 string refreshToken, string refreshTokenEP) {

    http:HTTPConnector httpConnectorEP = new http:HTTPConnector("");

    string accessTokenValue;

    action get (OAuth2ClientConnector oAuth2ClientConnector, string path, message request) (message, string) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:HTTPConnector.get(httpConnectorEP, path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
             response = http:HTTPConnector.get(httpConnectorEP, path, request);
        }

        return response, accessTokenValue ;
    }

    action post (OAuth2ClientConnector oAuth2ClientConnector, string path, message request) (message, string) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:HTTPConnector.post(httpConnectorEP, path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
             accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
             response = http:HTTPConnector.post(httpConnectorEP, path, request);
        }

        return response, accessTokenValue ;
    }

    action put (OAuth2ClientConnector oAuth2ClientConnector, string path, message request) (message, string) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:HTTPConnector.put(httpConnectorEP, path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
            response = http:HTTPConnector.put(httpConnectorEP, path, request);
        }

        return response, accessTokenValue ;
    }

    action delete (OAuth2ClientConnector oAuth2ClientConnector, string path, message request) (message, string) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:HTTPConnector.delete(httpConnectorEP, path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
            response = http:HTTPConnector.delete(httpConnectorEP, path, request);
        }

        return response, accessTokenValue ;
    }
}

function constructAuthHeader (message request, string accessTokenValue, string accessToken) (string) {

    if (accessTokenValue == "") {
        accessTokenValue = accessToken;
    }

    message:setHeader(request, "Authorization", "Bearer " + accessTokenValue);

    return accessTokenValue;
}

function getAccessTokenFromRefreshToken (message request, string accessToken, string clientId, string clientSecret,
                                         string refreshToken, string refreshTokenEP) (string) {

    http:HTTPConnector refreshTokenHTTPEP = new http:HTTPConnector("");
    message refreshTokenRequest;
    message refreshTokenResponse;
    string accessTokenFromRefreshTokenReq;
    json accessTokenFromRefreshTokenJSONResponse;

    accessTokenFromRefreshTokenReq = refreshTokenEP + "?refresh_token=" + refreshToken
                                     + "&grant_type=refresh_token&client_secret="
                                     + clientSecret + "&client_id=" + clientId;

    http:setContentLength(refreshTokenRequest, 0);
    refreshTokenResponse = http:HTTPConnector.post(refreshTokenHTTPEP, accessTokenFromRefreshTokenReq,
                                                   refreshTokenRequest);
    accessTokenFromRefreshTokenJSONResponse = message:getJsonPayload(refreshTokenResponse);
    accessToken = json:getString(accessTokenFromRefreshTokenJSONResponse, "$.access_token");

    message:setHeader(request, "Authorization", "Bearer " + accessToken);
    return accessToken;

}


function main (string[] args) {

    connectors:OAuth2ClientConnector oauth2Connector = new connectors:OAuth2ClientConnector (args[1], args[2], args[3],
                                                                                            args[4], args[5]);

    message request;
    message userProfileResponse;
    json userProfileJSONResponse;
    string accessToken;

    request = new message ();
    userProfileResponse, accessToken = connectors:OAuth2ClientConnector.get
                          (oauth2Connector, args[0], request);

    userProfileJSONResponse = message:getJsonPayload(userProfileResponse);
    system:println(json:toString(userProfileJSONResponse));

}
