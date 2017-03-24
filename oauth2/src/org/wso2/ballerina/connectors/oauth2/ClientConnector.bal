package org.wso2.ballerina.connectors.oauth2;

import ballerina.doc;
import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.net.http;

@doc:Description{ value : "OAuth2 client connector"}
@doc:Param{ value : "baseUrl: The endpoint base url"}
@doc:Param{ value : "accessToken: The access token of the account"}
@doc:Param{ value : "clientId: The client Id of the account"}
@doc:Param{ value : "clientSecret: The client secret of the account"}
@doc:Param{ value : "refreshToken: The refresh token of the account"}
@doc:Param{ value : "refreshTokenEP: The refresh token endpoint url"}
connector ClientConnector (string baseUrl, string accessToken, string clientId, string clientSecret,
                                 string refreshToken, string refreshTokenEP) {

    http:ClientConnector httpConnectorEP = create http:ClientConnector(baseUrl);

    string accessTokenValue;

    @doc:Description{ value : "Get with OAuth2 authentication"}
    @doc:Param{ value : "clientConnector: The oauth2 Connector instance"}
    @doc:Param{ value : "path: The endpoint path"}
    @doc:Param{ value : "request: The request of the method"}
    @doc:Return{ value : "response object"}
    action get (ClientConnector clientConnector, string path, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:ClientConnector.get(httpConnectorEP, path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
             response = http:ClientConnector.get(httpConnectorEP, path, request);
        }

        return response;
    }

    @doc:Description{ value : "Post with OAuth2 authentication"}
    @doc:Param{ value : "clientConnector: The oauth2 Connector instance"}
    @doc:Param{ value : "path: The endpoint path"}
    @doc:Param{ value : "request: The request of the method"}
    @doc:Return{ value : "response object"}
    action post (ClientConnector clientConnector, string path, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:ClientConnector.post(httpConnectorEP, path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
             accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
             response = http:ClientConnector.post(httpConnectorEP, path, request);
        }

        return response;
    }

    @doc:Description{ value : "Put with OAuth2 authentication"}
    @doc:Param{ value : "clientConnector: The oauth2 Connector instance"}
    @doc:Param{ value : "path: The endpoint path"}
    @doc:Param{ value : "request: The request of the method"}
    @doc:Return{ value : "response object"}
    action put (ClientConnector clientConnector, string path, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:ClientConnector.put(httpConnectorEP, path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
            response = http:ClientConnector.put(httpConnectorEP, path, request);
        }

        return response;
    }

    @doc:Description{ value : "Delete with OAuth2 authentication"}
    @doc:Param{ value : "clientConnector: The oauth2 Connector instance"}
    @doc:Param{ value : "path: The endpoint path"}
    @doc:Param{ value : "request: The request of the method"}
    @doc:Return{ value : "response object"}
    action delete (ClientConnector clientConnector, string path, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:ClientConnector.delete(httpConnectorEP, path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                          refreshTokenEP);
            response = http:ClientConnector.delete(httpConnectorEP, path, request);
        }

        return response;
    }

    @doc:Description{ value : "Patch with OAuth2 authentication"}
    @doc:Param{ value : "clientConnector: The oauth2 Connector instance"}
    @doc:Param{ value : "path: The endpoint path"}
    @doc:Param{ value : "request: The request of the method"}
    @doc:Return{ value : "response object"}
    action patch (ClientConnector clientConnector, string path, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = http:ClientConnector.patch(httpConnectorEP, path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                              refreshTokenEP);
            response = http:ClientConnector.patch(httpConnectorEP, path, request);
        }

        return response;
    }
}

function constructAuthHeader (message request, string accessTokenValue, string accessToken) (string) {

    if (accessTokenValue == "") {
        accessTokenValue = accessToken;
    }

    messages:setHeader(request, "Authorization", "Bearer " + accessTokenValue);

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
    accessTokenFromRefreshTokenJSONResponse = messages:getJsonPayload(refreshTokenResponse);
    accessToken = jsons:getString(accessTokenFromRefreshTokenJSONResponse, "$.access_token");

    messages:setHeader(request, "Authorization", "Bearer " + accessToken);
    return accessToken;

}
