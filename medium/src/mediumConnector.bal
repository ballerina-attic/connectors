package org.wso2.ballerina.connectors.medium;

import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.system;
import ballerina.net.http;

connector ClientConnector (string accessToken) {

    http:ClientConnector mediumEP = create http:ClientConnector("https://api.medium.com");

    action getProfileInfo(ClientConnector t) (message) {

        string getProfileInfoPath;
        message request = {};
        message response;
        getProfileInfoPath = "/v1/me";
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(mediumEP, getProfileInfoPath, request);

        return response;
    }

    action getContributors(ClientConnector t, string publicationId) (message) {

        string getContributorsPath;
        message request = {};
        message response;

        getContributorsPath = "/v1/publications/" + publicationId + "/contributors";
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(mediumEP, getContributorsPath, request);

        return response;
    }

    action getPublications(ClientConnector t, string userId) (message) {

        string getPublicationsPath;
        message request = {};
        message response;

        getPublicationsPath = "/v1/users/" + userId + "/publications";
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(mediumEP, getPublicationsPath, request);

        return response;
    }

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
        mediumConnector = create ClientConnector(args[1]);
        userId = args[2];
        publicationId = args[3];
        runGETSamples(mediumConnector, publicationId, userId);

    } else if (args[0]=="post") {
        mediumConnector = create ClientConnector(args[1]);
        userId = args[2];
        publicationId = args[3];
        runPOSTSamples(mediumConnector, publicationId, userId);

    } else if (args[0]=="getProfileInfo") {
        mediumConnector = create ClientConnector(args[1]);
        mediumResponse = ClientConnector.getProfileInfo(mediumConnector);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="getContributors") {
        mediumConnector = create ClientConnector(args[1]);
        publicationId = args[2];
        mediumResponse = ClientConnector.getContributors(mediumConnector, publicationId);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="getPublications") {
        mediumConnector = create ClientConnector(args[1]);
        userId = args[2];
        mediumResponse = ClientConnector.getPublications(mediumConnector, userId);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="createProfilePost") {
        mediumConnector = create ClientConnector(args[1]);
        userId = args[2];
        fullJsonPayload = `{title: 'Sample Payload',contentFormat: html,content: '<h1>Sample Payload</h1><p>This is a sample payload</p>',canonicalUrl: 'http://wso2.com',tags: [sample, test],publishStatus: public}`;
        mediumResponse = ClientConnector.createProfilePost(mediumConnector, userId, fullJsonPayload);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="createPublicationPost") {
        mediumConnector = create ClientConnector(args[1]);
        publicationId = args[2];
        fullJsonPayload = `{title: 'Sample Payload',contentFormat: html,content: '<h1>Sample Payload</h1><p>This is a sample payload</p>',canonicalUrl: 'http://wso2.com',tags: [sample, test],publishStatus: public}`;
        mediumResponse = ClientConnector.createPublicationPost(mediumConnector, publicationId, fullJsonPayload);
        printJsonResponse(mediumResponse);

    } else {
        mediumConnector = create ClientConnector(args[0]);
        userId = args[1];
        publicationId = args[2];
        runGETSamples(mediumConnector, publicationId, userId);
        runPOSTSamples(mediumConnector, publicationId, userId);
    }

}
