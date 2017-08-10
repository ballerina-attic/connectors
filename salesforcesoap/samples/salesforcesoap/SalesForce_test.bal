import org.wso2.ballerina.connectors.salesforcesoap;
import ballerina.lang.system;
import ballerina.lang.xmls;
import ballerina.lang.strings;
import ballerina.test;


string username = system:getEnv("USER_NAME");
string password = system:getEnv("USER_PASSWORD");
string login_url = system:getEnv("LOGIN_URL");
string convertedString;
string type = "Account";
string name = "testAccountWSO2";
xml[] headers = [];
xml soapResponse = {};
boolean result = false;

function init () (salesforcesoap:ClientConnector sales){
    sales = create salesforcesoap:ClientConnector(username, password, login_url, "1.1");
    return;
}

function testDescribeGlobal () {
    salesforcesoap:ClientConnector connectorInstance = init();
    soapResponse = connectorInstance.describeGlobal (headers);
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "describeGlobalResponse") && strings:contains(convertedString
                                                                                                    , "sobjects"));
}

function testDescribeSObject () {
    salesforcesoap:ClientConnector connectorInstance = init();
    soapResponse = connectorInstance.describeSObject (headers, type);
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "describeSObjectResponse")
                    && strings:contains(convertedString, "childRelationships")
                    && strings:contains(convertedString, "fields"));
}

function testCreateRecord () {
    xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
    xml allowFieldTruncationHeader = `<urn:AllowFieldTruncationHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allowFieldTruncation>0</urn:allowFieldTruncation></urn:AllowFieldTruncationHeader>`;
    headers = [allOrNoneHeader, allowFieldTruncationHeader];
    salesforcesoap:ClientConnector connectorInstance = init();
    map fields = {"type":type, "Name":name};
    soapResponse = connectorInstance.createRecord (headers, fields);
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "createResponse") && strings:contains(convertedString, "result")
                    && strings:contains(convertedString, "id"));
}

function testDescribeSObjects () {
    salesforcesoap:ClientConnector connectorInstance = init();
    soapResponse = connectorInstance.describeSObjects (headers, type);
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "describeSObjectsResponse") && strings:contains(convertedString, "result")
                    && strings:contains(convertedString, "childRelationships"));
}

function testSearch () {
    salesforcesoap:ClientConnector connectorInstance = init();
    string arg1 = "FIND {Kesavan}";
    soapResponse = connectorInstance.search (headers, arg1);
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "searchResponse") && strings:contains(convertedString, "result")
                    && strings:contains(convertedString, "searchRecords"));
}

function testRetrieve () {
    salesforcesoap:ClientConnector connectorInstance = init();
    string arg1 = "Id,Name";
    string arg2 = "Account";
    string arg3 = "0012800000jkIZY";
    soapResponse = connectorInstance.retrieve (headers, arg1, arg2, arg3);
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "retrieveResponse") && strings:contains(convertedString, "result")
                    && strings:contains(convertedString, "sf:type"));
}

function testDeleteRecord () {
    salesforcesoap:ClientConnector connectorInstance = init();
    xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
    string arg1 = "0012800001HxFPP";
    headers = [allOrNoneHeader];
    soapResponse = connectorInstance.deleteRecord (headers, arg1);
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "deleteResponse") && strings:contains(convertedString, "result")
                    && strings:contains(convertedString, "entity is deleted"));
}

function testQuery () {
    salesforcesoap:ClientConnector connectorInstance = init();
    xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
    headers = [queryOptions];
    string arg1 = "select name from Account";
    soapResponse = connectorInstance.query (headers, arg1);
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "queryResponse") && strings:contains(convertedString, "records")
                    && strings:contains(convertedString, "sf:type"));
}

function testQueryAll () {
    salesforcesoap:ClientConnector connectorInstance = init();
    xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
    headers = [queryOptions];
    string arg1 = "select name from Account";
    soapResponse = connectorInstance.queryAll (headers, arg1);
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "queryAllResponse") && strings:contains(convertedString, "records")
                    && strings:contains(convertedString, "sf:type"));
}

function testQueryMore () {
    salesforcesoap:ClientConnector connectorInstance = init();
    xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
    headers = [queryOptions];
    string arg1 = "01g2800002d7e8nAAA-200";
    soapResponse = connectorInstance.queryMore (headers, arg1);
    system:println(xmls:toString(soapResponse));
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "queryMoreResponse") && strings:contains(convertedString, "records")
                    && strings:contains(convertedString, "sf:type"));
}


function testUpdateRecord () {
    salesforcesoap:ClientConnector connectorInstance = init();
    xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
    xml allowFieldTruncationHeader = `<urn:AllowFieldTruncationHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allowFieldTruncation>0</urn:allowFieldTruncation></urn:AllowFieldTruncationHeader>`;
    headers = [allOrNoneHeader, allowFieldTruncationHeader];
    string arg1 = "0012800000jkIZY";
    map fields = {"type":type, "Name":name, "Id":arg1};
    soapResponse = connectorInstance.updateRecord (headers, fields);
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "updateResponse") && strings:contains(convertedString, "result")
                    && strings:contains(convertedString, "id"));

}

function testUpsertRecord () {
    salesforcesoap:ClientConnector connectorInstance = init();
    map fields = {"type":"Contact", "Languages__c":"english", "Email":"abcd@asd.com"};
    string arg1 = "0012800000jkIZY";
    soapResponse = connectorInstance.upsertRecord (headers, "Languages__c", fields);
    convertedString = xmls:toString(soapResponse);
    test:assertTrue(strings:contains(convertedString, "upsertResponse") && strings:contains(convertedString, "result")
                    && strings:contains(convertedString, "id"));
}



