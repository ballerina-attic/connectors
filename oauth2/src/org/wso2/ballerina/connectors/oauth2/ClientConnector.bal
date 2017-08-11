package org.wso2.ballerina.connectors.oauth2;

import ballerina.doc;
import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.net.http;

@doc:Description { value:"OAuth2 client connector"}
@doc:Param { value:"baseUrl: The endpoint base url"}
@doc:Param { value:"accessToken: The access token of the account"}
@doc:Param { value:"clientId: The client Id of the account"}
@doc:Param { value:"clientSecret: The client secret of the account"}
@doc:Param { value:"refreshToken: The refresh token of the account"}
@doc:Param { value:"refreshTokenEP: The refresh token endpoint url"}
connector ClientConnector (string baseUrl, string accessToken, string clientId, string clientSecret,
                           string refreshToken, string refreshTokenEP) {

    http:ClientConnector httpConnectorEP = create http:ClientConnector(baseUrl);

    string accessTokenValue;

    @doc:Description { value:"Get with OAuth2 authentication"}
    @doc:Param { value:"path: The endpoint path"}
    @doc:Param { value:"request: The request of the method"}
    @doc:Return { value:"response object"}
    action get (string path, message request) (message) {
        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = httpConnectorEP.get (path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "" || refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                              refreshTokenEP);
            response = httpConnectorEP.get (path, request);
        }

        return response;
    }

    @doc:Description { value:"Post with OAuth2 authentication"}
    @doc:Param { value:"path: The endpoint path"}
    @doc:Param { value:"request: The request of the method"}
    @doc:Return { value:"response object"}
    action post (string path, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = httpConnectorEP.post (path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "" || refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                              refreshTokenEP);
            response = httpConnectorEP.post (path, request);
        }

        return response;
    }

    @doc:Description { value:"Put with OAuth2 authentication"}
    @doc:Param { value:"path: The endpoint path"}
    @doc:Param { value:"request: The request of the method"}
    @doc:Return { value:"response object"}
    action put (string path, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = httpConnectorEP.put (path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "" || refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                              refreshTokenEP);
            response = httpConnectorEP.put (path, request);
        }

        return response;
    }

    @doc:Description { value:"Delete with OAuth2 authentication"}
    @doc:Param { value:"path: The endpoint path"}
    @doc:Param { value:"request: The request of the method"}
    @doc:Return { value:"response object"}
    action delete (string path, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = httpConnectorEP.delete (path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "" || refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                              refreshTokenEP);
            response = httpConnectorEP.delete (path, request);
        }

        return response;
    }

    @doc:Description { value:"Patch with OAuth2 authentication"}
    @doc:Param { value:"path: The endpoint path"}
    @doc:Param { value:"request: The request of the method"}
    @doc:Return { value:"response object"}
    action patch (string path, message request) (message) {

        message response;

        accessTokenValue = constructAuthHeader (request, accessTokenValue, accessToken);
        response = httpConnectorEP.patch (path, request);

        if ((http:getStatusCode(response) == 401) && (refreshToken != "" || refreshToken != "null")) {
            accessTokenValue = getAccessTokenFromRefreshToken(request, accessToken, clientId, clientSecret, refreshToken,
                                                              refreshTokenEP);
            response = httpConnectorEP.patch (path, request);
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
    refreshTokenResponse = refreshTokenHTTPEP.post (accessTokenFromRefreshTokenReq, refreshTokenRequest);
    accessTokenFromRefreshTokenJSONResponse = messages:getJsonPayload(refreshTokenResponse);
    accessToken = jsons:toString(accessTokenFromRefreshTokenJSONResponse.access_token);
    messages:setHeader(request, "Authorization", "Bearer " + accessToken);
    return accessToken;

}
