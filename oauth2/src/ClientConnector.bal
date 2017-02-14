package org.wso2.ballerina.connectors.OAuth2;

import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.system;
import ballerina.net.http;

@doc:Description("OAuth2 client connector")
@doc:Param("accessToken: The access token of the account")
@doc:Param("clientId: The client Id of the account")
@doc:Param("clientSecret: The client secret of the account")
@doc:Param("refreshToken: The refresh token of the account")
@doc:Param("refreshTokenEP: The refresh token endpoint url")
connector ClientConnector (string accessToken, string clientId, string clientSecret,
                                 string refreshToken, string refreshTokenEP) {

    http:ClientConnector httpConnectorEP = create http:ClientConnector("");

    string accessTokenValue;

    @doc:Description("Get with OAuth2 authentication")
    @doc:Param("url: The endpoint url")
    @doc:Param("request: The request of the method")
    @doc:Return("response object")
    action get (ClientConnector clientConnector, string url, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:ClientConnector.get(httpConnectorEP, url, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
             response = http:ClientConnector.get(httpConnectorEP, url, request);
        }

        return response;
    }

    @doc:Description("Post with OAuth2 authentication")
    @doc:Param("url: The endpoint url")
    @doc:Param("request: The request of the method")
    @doc:Return("response object")
    action post (ClientConnector clientConnector, string url, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:ClientConnector.post(httpConnectorEP, url, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
             accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
             response = http:ClientConnector.post(httpConnectorEP, url, request);
        }

        return response;
    }

    @doc:Description("Put with OAuth2 authentication")
    @doc:Param("url: The endpoint url")
    @doc:Param("request: The request of the method")
    @doc:Return("response object")
    action put (ClientConnector clientConnector, string url, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:ClientConnector.put(httpConnectorEP, url, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
            response = http:ClientConnector.put(httpConnectorEP, url, request);
        }

        return response;
    }

    @doc:Description("Delete with OAuth2 authentication")
    @doc:Param("url: The endpoint url")
    @doc:Param("request: The request of the method")
    @doc:Return("response object")
    action delete (ClientConnector clientConnector, string url, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:ClientConnector.delete(httpConnectorEP, url, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
            response = http:ClientConnector.delete(httpConnectorEP, url, request);
        }

        return response;
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

    http:ClientConnector refreshTokenHTTPEP = create http:ClientConnector("");
    message refreshTokenRequest = {};
    message refreshTokenResponse;
    string accessTokenFromRefreshTokenReq;
    json accessTokenFromRefreshTokenJSONResponse;

    accessTokenFromRefreshTokenReq = refreshTokenEP + "?refresh_token=" + refreshToken
                                     + "&grant_type=refresh_token&client_secret="
                                     + clientSecret + "&client_id=" + clientId;

    http:setContentLength(refreshTokenRequest, 0);
    refreshTokenResponse = http:ClientConnector.post(refreshTokenHTTPEP, accessTokenFromRefreshTokenReq,
                                                   refreshTokenRequest);
    accessTokenFromRefreshTokenJSONResponse = message:getJsonPayload(refreshTokenResponse);
    accessToken = json:getString(accessTokenFromRefreshTokenJSONResponse, "$.access_token");

    message:setHeader(request, "Authorization", "Bearer " + accessToken);
    return accessToken;

}

function main (string[] args) {

    message request = {};
    message userProfileResponse;
    json userProfileJSONResponse;

    ClientConnector clientConnector = create ClientConnector (args[1], args[2], args[3], args[4], args[5]);

    if (args[0] == "get"){
        userProfileResponse = ClientConnector.get(clientConnector, args[6], request);
        userProfileJSONResponse = message:getJsonPayload(userProfileResponse);
        system:println(json:toString(userProfileJSONResponse));
    }
}