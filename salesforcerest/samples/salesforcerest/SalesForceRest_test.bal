import org.wso2.ballerina.connectors.salesforcerest;
import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.lang.system;
import ballerina.lang.strings;
import ballerina.test;

message response = {};
json JSONResponse = {};
string accessToken = system:getEnv("ACCESS_TOKEN");
string clientID = system:getEnv("CLIENT_ID");
string clientSecret = system:getEnv("CLIENT_SECRET");
string refreshToken = system:getEnv("REFRESH_TOKEN");
string apiInstance = system:getEnv("API_INSTANCE");
string refreshEndpoint = system:getEnv("REFRESH_ENDPOINT");

function init () (salesforcerest:ClientConnector salesforceClient){
    salesforceClient = create salesforcerest:ClientConnector(accessToken, clientID, clientSecret
                                                             , refreshToken, apiInstance, refreshEndpoint);
    return;
}

function testDescribeGlobal () {
    string args1 = "v32.0";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.describeGlobal (args1);
    JSONResponse = messages:getJsonPayload(response);
    string returnedValue_1 = (string)JSONResponse.sobjects[0].activateable;
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(!strings:equalsIgnoreCase(returnedValue_1, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testListAvailableApiVersion () {
    string args1 = "v32.0";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.listAvailableApiVersion ();
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    string returnedLabel = (string)JSONResponse[0].label;
    string returnedUrl = (string)JSONResponse[0].url;
    string returnedVersion = (string)JSONResponse[0].version;
    test:assertTrue(!strings:equalsIgnoreCase(returnedLabel, "") && !strings:equalsIgnoreCase(returnedUrl, "")
                    && !strings:equalsIgnoreCase(returnedVersion, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testListOrganizationLimits () {
    string args1 = "v32.0";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.listOrganizationLimits (args1);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    string returnedValue_1 = (string)JSONResponse.ConcurrentAsyncGetReportInstances.Max;
    test:assertTrue(!strings:equalsIgnoreCase(returnedValue_1, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testListResourcesByApiVersion () {
    string args1 = "v32.0";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.listResourcesByApiVersion (args1);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    string returnedValue_1 = (string)JSONResponse.tooling;
    test:assertTrue(!strings:equalsIgnoreCase(returnedValue_1, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testSObjectBasicInfo () {
    string args1 = "v32.0";
    string args2 = "Account";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.sObjectBasicInfo (args2, args1);
    JSONResponse = messages:getJsonPayload(response);
    string returnedValue_1 = (string)JSONResponse.objectDescribe.activateable;
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(!strings:equalsIgnoreCase(returnedValue_1, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testSObjectGetDeleted () {
    string args1 = "v32.0";
    string args2 = "Account";
    string args3 = "2017-05-01T00:00:00Z";
    string args4 = "2017-05-15T00:00:00Z";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.sObjectGetDeleted (args1, args2, args3, args4);
    JSONResponse = messages:getJsonPayload(response);
    string returnedValue_1 = (string)JSONResponse.deletedRecords[0].id;
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(!strings:equalsIgnoreCase(returnedValue_1, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testSObjectPlatformAction () {
    string args1 = "v32.0";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.sObjectPlatformAction (args1);
    JSONResponse = messages:getJsonPayload(response);
    string returnedValue_1 = (string)JSONResponse.objectDescribe.activateable;
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(!strings:equalsIgnoreCase(returnedValue_1, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testSObjectRows () {
    string args1 = "v32.0";
    string args2 = "Account";
    string args3 = "0012800001HxHFC";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.sObjectRows (args1, args2, args3);
    JSONResponse = messages:getJsonPayload(response);
    string returnedValue_1 = (string)JSONResponse.attributes.url;
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(!strings:equalsIgnoreCase(returnedValue_1, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testSObjectRowsByExternalId () {
    string args1 = "v32.0";
    string args2 = "Contact";
    string args3 = "Languages__c";
    string args4 = "tamil";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.sObjectRowsByExternalId (args1, args2, args3, args4);
    JSONResponse = messages:getJsonPayload(response);
    string returnedValue_1 = (string)JSONResponse.attributes.url;
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(!strings:equalsIgnoreCase(returnedValue_1, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testListviewQueryPerformanceFeedback () {
    string args1 = "v32.0";
    string args2 = "00B2800000AVUaa";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.listviewQueryPerformanceFeedback (args1, args2);
    JSONResponse = messages:getJsonPayload(response);
    string returnedValue_1 = (string)JSONResponse.plans[0].cardinality;
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(!strings:equalsIgnoreCase(returnedValue_1, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testQuery () {
    string args1 = "v32.0";
    string args2 = "SELECT+Name+FROM+account";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.query (args1, args2);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testQueryAll () {
    string args1 = "v32.0";
    string args2 = "SELECT+Name+FROM+account";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.queryAll (args1, args2);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testQueryAllMore () {
    string args1 = "v32.0";
    string args2 = "01g2800002j2XJPAA2-2000";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.queryAllMore (args1, args2);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testQueryMore () {
    string args1 = "v32.0";
    string args2 = "01g2800002j2XJPAA2-2000";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.queryMore (args1, args2);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testQueryPerformanceFeedback () {
    string args1 = "v32.0";
    string args2 = "SELECT+Name+FROM+account";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.queryPerformanceFeedback (args1, args2);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testCreateRecord () {
    string args1 = "v32.0";
    json sampleCreateRecord = {"Name":"TestingBallerina2"};
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.createRecord (args1, "Account", sampleCreateRecord);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testDelete () {
    string args1 = "v32.0";
    string args2 = "Account";
    string args3 = "0012800000GQpV2AAL";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.delete (args1, args2, args3);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testRetrieveFieldValues () {
    string args1 = "v32.0";
    string args2 = "Account";
    string args3 = "0012800000GQpqw";
    string args4 = "Name";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.retrieveFieldValues (args1, args2, args3, args4);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testRetrieveFieldValuesFromExternalObject () {
    string args1 = "v32.0";
    string args2 = "Invoice_Statement__c";
    string args3 = "a002800000lnj6u";
    string args4 = "Name";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.retrieveFieldValuesFromExternalObject (args1, args2, args3, args4);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testRetrieveStandardFieldValuesFromExternalObjectWithExternalId () {
    string args1 = "v32.0";
    string args2 = "Invoice_Statement__c";
    string args3 = "a002800000lnj6u";
    string args4 = "Description__c";
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.retrieveStandardFieldValuesFromExternalObjectWithExternalId (args1, args2, args3,
                                                                                              args4);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testUpdate () {
    string args1 = "v32.0";
    string args2 = "0012800001IoxHMAAZ";
    json sampleUpdate = {"Name":"TestUpdate"};
    salesforcerest:ClientConnector connectorInstance = init();
    response = connectorInstance.update (args1, "Account", args2, sampleUpdate);
    JSONResponse = messages:getJsonPayload(response);
    string statusCode = (string)http:getStatusCode(response);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}





