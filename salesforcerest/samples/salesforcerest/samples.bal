import org.wso2.ballerina.connectors.salesforcerest;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;
import ballerina.net.http;

function main (string[] args) {

    message response;
    json JSONResponse;

    string accessToken = args[1];
    string clientID = args[2];
    string clientSecret = args[3];
    string refreshToken = args[4];
    string apiInstance = args[5];
    string refreshEndpoint = args[6];

    salesforcerest:ClientConnector salesforceClient = create salesforcerest:ClientConnector(
                                                      accessToken, clientID, clientSecret, refreshToken, apiInstance,
                                                      refreshEndpoint);

    if (args[0] == "describeGlobal") {
        response = salesforceClient.describeGlobal (args[7]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectDescribe") {
        response = salesforceClient.sObjectDescribe (args[8], args[7]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "listAvailableApiVersion") {
        response = salesforceClient.listAvailableApiVersion ();
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "listOrganizationLimits") {
        response = salesforceClient.listOrganizationLimits (args[7]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "listResourcesByApiVersion") {
        response = salesforceClient.listResourcesByApiVersion (args[7]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectBasicInfo") {
        response = salesforceClient.sObjectBasicInfo (args[8], args[7]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectGetDeleted") {
        response = salesforceClient.sObjectGetDeleted (args[7], args[8], args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectGetUpdated") {
        response = salesforceClient.sObjectGetUpdated (args[7], args[8], args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectPlatformAction") {
        response = salesforceClient.sObjectPlatformAction (args[7]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectRows") {
        response = salesforceClient.sObjectRows (args[7], args[8], args[9]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectRowsByExternalId") {
        response = salesforceClient.sObjectRowsByExternalId (args[7], args[8], args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "listviewQueryPerformanceFeedback") {
        response = salesforceClient.listviewQueryPerformanceFeedback (args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "query") {
        response = salesforceClient.query (args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "queryAll") {
        response = salesforceClient.queryAll (args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "queryAllMore") {
        response = salesforceClient.queryAllMore (args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "queryMore") {
        response = salesforceClient.queryMore (args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "queryPerformanceFeedback") {
        response = salesforceClient.queryPerformanceFeedback (args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "createRecord") {
        json sampleCreateRecord = {"Name":"TestingBallerina"};
        response = salesforceClient.createRecord (args[7], "Account", sampleCreateRecord);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "createMultipleRecords") {
        json sampleCreateMultipleRecords = {"records":[{"attributes":{"type":"Account", "referenceId":"ref1"}, "name":"SampleAccount1"}, {"attributes":{"type":"Account", "referenceId":"ref2"}, "name":"SampleAccount2"}]};
        response = salesforceClient.createMultipleRecords (args[7], "Account", sampleCreateMultipleRecords);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "delete") {
        response = salesforceClient.delete (args[7], args[8], args[9]);
        system:println(http:getStatusCode(response));
    }

    if (args[0] == "retrieveFieldValues") {
        response = salesforceClient.retrieveFieldValues (args[7], args[8], args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "retrieveFieldValuesFromExternalObject") {
        response = salesforceClient.retrieveFieldValuesFromExternalObject (args[7], args[8],
                                                                           args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "retrieveStandardFieldValuesFromExternalObjectWithExternalId") {
        response = salesforceClient.retrieveStandardFieldValuesFromExternalObjectWithExternalId (args[7], args[8],
                                                                                                 args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "update") {
        json sampleUpdate = {"Name":"TestUpdate"};
        response = salesforceClient.update (args[7], "Account", args[8], sampleUpdate);
        system:println(http:getStatusCode(response));
    }

    if (args[0] == "upsert") {
        json sampleUpsert = {"Name":"TestUpdate", "Type":"New Customer"};
        response = salesforceClient.upsert (args[7], args[8], args[9], args[10], sampleUpsert);
        system:println(http:getStatusCode(response));
    }

}
