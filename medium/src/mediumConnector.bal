package org.wso2.ballerina.connectors.medium;

import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.system;
import ballerina.net.http;

@doc:Description("Medium client connector")
@doc:Param("accessToken: The access token of the Medium Application")
@doc:Param("clientId: Client Id of the Medium Application")
@doc:Param("clientSecret: Client Secret of the Medium Application")
@doc:Param("refreshToken: The refresh token of the Medium Application")
connector ClientConnector (string accessToken, string clientId, string clientSecret, string refreshToken) {

    http:ClientConnector mediumEP = create http:ClientConnector("https://api.medium.com");

    @doc:Description("Get Profile Information")
    @doc:Return("response object")
    action getProfileInfo(ClientConnector t) (message) {

        string getProfileInfoPath;
        message request = {};
        message response;
        getProfileInfoPath = "/v1/me";
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(mediumEP, getProfileInfoPath, request);

        return response;
    }

    @doc:Description("Get List of Contributors for a Publication")
    @doc:Param("publicationId: ID of relevant publication")
    @doc:Return("response object")
    action getContributors(ClientConnector t, string publicationId) (message) {

        string getContributorsPath;
        message request = {};
        message response;

        getContributorsPath = "/v1/publications/" + publicationId + "/contributors";
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(mediumEP, getContributorsPath, request);

        return response;
    }

    @doc:Description("Get List of Publications the user have contributed")
    @doc:Param("userId: ID of authenticated user")
    @doc:Return("response object")
    action getPublications(ClientConnector t, string userId) (message) {

        string getPublicationsPath;
        message request = {};
        message response;

        getPublicationsPath = "/v1/users/" + userId + "/publications";
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(mediumEP, getPublicationsPath, request);

        return response;
    }

    @doc:Description("Create Post in authenticated User's profile")
    @doc:Param("userId: ID of authenticated user")
    @doc:Param("payload: json payload containing the post")
    @doc:Return("response object")
    action createProfilePost(ClientConnector t, string userId, json payload) (message) {

        string createProfilePostPath;
        message request = {};
        message response;

        createProfilePostPath = "/v1/users/" + userId + "/posts";
        message:setHeader(request, "Content-Type", "application/json");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        message:setJsonPayload(request, payload);
        response = http:ClientConnector.post(mediumEP, createProfilePostPath, request);

        return response;
    }

    @doc:Description("Get List of Contributors for a Publication")
    @doc:Param("publicationId: ID of relevant publication")
    @doc:Param("payload: json payload containing the post")
    @doc:Return("response object")
    action createPublicationPost(ClientConnector t, string publicationId, json payload) (message) {

        string createPublicationPostPath;
        message request = {};
        message response;

        createPublicationPostPath = "/v1/publications/" + publicationId + "/posts";
        message:setHeader(request, "Content-Type", "application/json");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        message:setJsonPayload(request, payload);
        response = http:ClientConnector.post(mediumEP, createPublicationPostPath, request);

        return response;
    }
}


function printJsonResponse(message mediumResponse) (string) {

    json mediumJSONResponse;
    mediumJSONResponse = message:getJsonPayload(mediumResponse);
    system:println(json:toString(mediumJSONResponse));
}

function runGETSamples(ClientConnector mediumConnector, string publicationId, string userId) (string) {

    message mediumResponse;

    system:println("---------------");
    system:println("  GET actions");
    system:println("---------------");
    system:println(" ");

    system:println(" ");
    system:println("Get Profile Info");
    mediumResponse = ClientConnector.getProfileInfo(mediumConnector);
    printJsonResponse(mediumResponse);
    system:println(" ");

    system:println("Get Contributors of a Publication");
    mediumResponse = ClientConnector.getContributors(mediumConnector, publicationId);
    printJsonResponse(mediumResponse);
    system:println(" ");

    system:println("Get List of Publications");
    mediumResponse = ClientConnector.getPublications(mediumConnector, userId);
    printJsonResponse(mediumResponse);
    system:println(" ");
}

function runPOSTSamples(ClientConnector mediumConnector, string publicationId, string userId) (string) {

    message mediumResponse;
    json fullJsonPayload;

    fullJsonPayload = `{title: 'Sample Payload',contentFormat: html,content: '<h1>Sample Payload</h1><p>This is a sample payload</p>',canonicalUrl: 'http://wso2.com',tags: [sample, test],publishStatus: public}`;

    system:println(" ");
    system:println("----------------");
    system:println("  POST actions");
    system:println("----------------");
    system:println(" ");

    system:println("Post in Profile");
    mediumResponse = ClientConnector.createProfilePost(mediumConnector, userId, fullJsonPayload);
    printJsonResponse(mediumResponse);
    system:println(" ");

    system:println("Post in publication");
    mediumResponse = ClientConnector.createPublicationPost(mediumConnector, publicationId, fullJsonPayload);
    printJsonResponse(mediumResponse);
    system:println(" ");
}

function main (string[] args) {

    ClientConnector mediumConnector;
    string userId;
    string publicationId;
    message mediumResponse;
    json fullJsonPayload;

    if (args[0]=="get") {
        mediumConnector = create ClientConnector(args[1], args[2], args[3], args[4]);
        userId = args[5];
        publicationId = args[6];
        runGETSamples(mediumConnector, publicationId, userId);

    } else if (args[0]=="post") {
        mediumConnector = create ClientConnector(args[1], args[2], args[3], args[4]);
        userId = args[5];
        publicationId = args[6];
        runPOSTSamples(mediumConnector, publicationId, userId);

    } else if (args[0]=="getProfileInfo") {
        mediumConnector = create ClientConnector(args[1], args[2], args[3], args[4]);
        mediumResponse = ClientConnector.getProfileInfo(mediumConnector);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="getContributors") {
        mediumConnector = create ClientConnector(args[1], args[2], args[3], args[4]);
        publicationId = args[5];
        mediumResponse = ClientConnector.getContributors(mediumConnector, publicationId);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="getPublications") {
        mediumConnector = create ClientConnector(args[1], args[2], args[3], args[4]);
        userId = args[5];
        mediumResponse = ClientConnector.getPublications(mediumConnector, userId);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="createProfilePost") {
        mediumConnector = create ClientConnector(args[1], args[2], args[3], args[4]);
        userId = args[5];
        fullJsonPayload = `{title: 'Sample Payload',contentFormat: html,content: '<h1>Sample Payload</h1><p>This is a sample payload</p>',canonicalUrl: 'http://wso2.com',tags: [sample, test],publishStatus: public}`;
        mediumResponse = ClientConnector.createProfilePost(mediumConnector, userId, fullJsonPayload);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="createPublicationPost") {
        mediumConnector = create ClientConnector(args[1], args[2], args[3], args[4]);
        publicationId = args[5];
        fullJsonPayload = `{title: 'Sample Payload',contentFormat: html,content: '<h1>Sample Payload</h1><p>This is a sample payload</p>',canonicalUrl: 'http://wso2.com',tags: [sample, test],publishStatus: public}`;
        mediumResponse = ClientConnector.createPublicationPost(mediumConnector, publicationId, fullJsonPayload);
        printJsonResponse(mediumResponse);

    } else {
        mediumConnector = create ClientConnector(args[0], args[1], args[2], args[3]);
        userId = args[4];
        publicationId = args[5];
        runGETSamples(mediumConnector, publicationId, userId);
        runPOSTSamples(mediumConnector, publicationId, userId);
    }

}
