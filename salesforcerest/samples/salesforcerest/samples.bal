import org.wso2.ballerina.connectors.salesforcerest;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    message response;
    json JSONResponse;

    string accessToken = args[1];
    string clientID = args[2];
    string clientSecret = args[3];
    string refreshToken = args[4];
    string apiInstance = args[5];
    string refreshEndpoint = args[6];

    salesforcerest:ClientConnector salesforceClient = create salesforcerest:ClientConnector(accessToken, clientID, clientSecret, refreshToken, apiInstance, refreshEndpoint);

    if (args[0] == "describeGlobal"){
        response = salesforcerest:ClientConnector.describeGlobal(salesforceClient, args[7]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }
    
    if (args[0] == "sObjectDescribe"){
        response = salesforcerest:ClientConnector.sObjectDescribe(salesforceClient, args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }
    
    if (args[0] == "listAvailableApiVersion"){
        response = salesforcerest:ClientConnector.listAvailableApiVersion(salesforceClient);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }
    
    if (args[0] == "listOrganizationLimits"){
        response = salesforcerest:ClientConnector.listOrganizationLimits(salesforceClient, args[7]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }
    
    if (args[0] == "listResourcesByApiVersion"){
        response = salesforcerest:ClientConnector.listResourcesByApiVersion(salesforceClient, args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectBasicInfo"){
        response = salesforcerest:ClientConnector.sObjectBasicInfo(salesforceClient, args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectGetDeleted"){
        response = salesforcerest:ClientConnector.sObjectGetDeleted(salesforceClient, args[7], args[8], args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectGetUpdated"){
        response = salesforcerest:ClientConnector.sObjectGetUpdated(salesforceClient, args[7], args[8], args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectPlatformAction"){
        response = salesforcerest:ClientConnector.sObjectPlatformAction(salesforceClient, args[7]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectRows"){
        response = salesforcerest:ClientConnector.sObjectRows(salesforceClient, args[7], args[8], args[9]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "sObjectRowsByExternalId"){
        response = salesforcerest:ClientConnector.sObjectRowsByExternalId(salesforceClient, args[7], args[8], args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "listviewQueryPerformanceFeedback"){
        response = salesforcerest:ClientConnector.listviewQueryPerformanceFeedback(salesforceClient, args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "query"){
        response = salesforcerest:ClientConnector.query(salesforceClient, args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "queryAll"){
        response = salesforcerest:ClientConnector.queryAll(salesforceClient, args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "queryAllMore"){
        response = salesforcerest:ClientConnector.queryAllMore(salesforceClient, args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "queryMore"){
        response = salesforcerest:ClientConnector.queryMore(salesforceClient, args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "queryPerformanceFeedback"){
        response = salesforcerest:ClientConnector.queryPerformanceFeedback(salesforceClient, args[7], args[8]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "createRecord"){
        json sampleCreateRecord = `{"Name":"TestingBallerina"}`;
        response = salesforcerest:ClientConnector.createRecord(salesforceClient, args[7], "Account", sampleCreateRecord);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "createMultipleRecords"){
        json sampleCreateMultipleRecords = `{"records" :[{"attributes" : {"type" : "Account", "referenceId" : "ref1"}, "name" : "SampleAccount1"}, {"attributes" : {"type" : "Account", "referenceId" : "ref2"}, "name" : "SampleAccount2"}]}`;
        response = salesforcerest:ClientConnector.createMultipleRecords(salesforceClient, args[7], "Account", sampleCreateMultipleRecords);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "delete"){
        response = salesforcerest:ClientConnector.delete(salesforceClient, args[7], args[8], args[9]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "retrieveFieldValues"){
        response = salesforcerest:ClientConnector.retrieveFieldValues(salesforceClient, args[7], args[8], args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "retrieveFieldValuesFromExternalObject"){
        response = salesforcerest:ClientConnector.retrieveFieldValuesFromExternalObject(salesforceClient, args[7], args[8],
         args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "retrieveStandardFieldValuesFromExternalObjectWithExternalId"){
        response = salesforcerest:ClientConnector.retrieveStandardFieldValuesFromExternalObjectWithExternalId(
        salesforceClient, args[7], args[8], args[9], args[10]);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "update"){
        json sampleUpdate = `{"Name":"TestUpdate"}`;
        response = salesforcerest:ClientConnector.update(salesforceClient, args[7], "Account", args[8], sampleUpdate);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

    if (args[0] == "upsert"){
        json sampleUpsert = `{"Name":"TestUpdate", "Type" : "New Customer"}`;
        response = salesforcerest:ClientConnector.upsert(salesforceClient, args[7], args[8], args[9], args[10], sampleUpsert);
        JSONResponse = messages:getJsonPayload(response);
        system:println(jsons:toString(JSONResponse));
    }

}