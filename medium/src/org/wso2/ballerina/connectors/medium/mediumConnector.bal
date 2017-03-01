package org.wso2.ballerina.connectors.medium;

import org.wso2.ballerina.connectors.oauth2;
import ballerina.lang.messages;

@doc:Description("Medium client connector")
@doc:Param("accessToken: The access token of the Medium Application")
@doc:Param("clientId: Client Id of the Medium Application")
@doc:Param("clientSecret: Client Secret of the Medium Application")
@doc:Param("refreshToken: The refresh token of the Medium Application")
connector ClientConnector (string accessToken, string clientId, string clientSecret, string refreshToken) {

    string refreshTokenEP = "https://api.medium.com/v1/tokens";
    string baseURL = "https://api.medium.com";
    oauth2:ClientConnector mediumEP = create oauth2:ClientConnector(baseURL, accessToken, clientId, clientSecret,
        refreshToken, refreshTokenEP);

    @doc:Description("Get Profile Information")
    @doc:Param("t: The medium Connector instance")
    @doc:Return("response object")
    action getProfileInfo(ClientConnector t) (message) {

        string getProfileInfoPath;
        message request = {};
        message response;
        getProfileInfoPath = "/v1/me";
        response = oauth2:ClientConnector.get(mediumEP, getProfileInfoPath, request);

        return response;
    }

    @doc:Description("Get List of Contributors for a Publication")
    @doc:Param("t: The medium Connector instance")
    @doc:Param("publicationId: ID of relevant publication")
    @doc:Return("response object")
    action getContributors(ClientConnector t, string publicationId) (message) {

        string getContributorsPath;
        message request = {};
        message response;

        getContributorsPath = "/v1/publications/" + publicationId + "/contributors";
        response = oauth2:ClientConnector.get(mediumEP, getContributorsPath, request);

        return response;
    }

    @doc:Description("Get List of Publications the user have contributed")
    @doc:Param("t: The medium Connector instance")
    @doc:Param("userId: ID of authenticated user")
    @doc:Return("response object")
    action getPublications(ClientConnector t, string userId) (message) {

        string getPublicationsPath;
        message request = {};
        message response;

        getPublicationsPath = "/v1/users/" + userId + "/publications";
        response = oauth2:ClientConnector.get(mediumEP, getPublicationsPath, request);

        return response;
    }

    @doc:Description("Create Post in authenticated User's profile")
    @doc:Param("t: The medium Connector instance")
    @doc:Param("userId: ID of authenticated user")
    @doc:Param("payload: json payload containing the post")
    @doc:Return("response object")
    action createProfilePost(ClientConnector t, string userId, json payload) (message) {

        string createProfilePostPath;
        message request = {};
        message response;

        createProfilePostPath = "/v1/users/" + userId + "/posts";
        messages:setHeader(request, "Content-Type", "application/json");
        messages:setJsonPayload(request, payload);
        response = oauth2:ClientConnector.post(mediumEP, createProfilePostPath, request);

        return response;
    }

    @doc:Description("Get List of Contributors for a Publication")
    @doc:Param("t: The medium Connector instance")
    @doc:Param("publicationId: ID of relevant publication")
    @doc:Param("payload: json payload containing the post")
    @doc:Return("response object")
    action createPublicationPost(ClientConnector t, string publicationId, json payload) (message) {

        string createPublicationPostPath;
        message request = {};
        message response;

        createPublicationPostPath = "/v1/publications/" + publicationId + "/posts";
        messages:setHeader(request, "Content-Type", "application/json");
        messages:setJsonPayload(request, payload);
        response = oauth2:ClientConnector.post(mediumEP, createPublicationPostPath, request);

        return response;
    }
}

