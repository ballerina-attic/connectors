import ballerina.lang.system;
import org.wso2.ballerina.connectors.linkedin;
import ballerina.lang.messages;
import ballerina.test;
import ballerina.net.http;
import ballerina.lang.xmls;

string companyId = "2414183";
message linkedInResponse;
xml linkedInXMLResponse;
json linkedInJSONResponse;
xml shortXmlPayload;
json shortJsonPayload;
xml fullXmlPayload;
json fullJsonPayload;

function init () (linkedin:ClientConnector){

    string accessToken = system:getEnv("LINKEDIN_ACCESS_TOKEN");
    linkedin:ClientConnector linkedInConnector = create linkedin:ClientConnector(accessToken);
    return linkedInConnector;

}

function testGetProfileInfoXML () {

    linkedin:ClientConnector linkedInConnector = init();
    linkedInResponse = linkedInConnector.getProfileInfo ("xml");
    linkedInXMLResponse = messages:getXmlPayload(linkedInResponse);
    system:println(xmls:toString(linkedInXMLResponse));
    int status = http:getStatusCode(linkedInResponse);
    test:assertIntEquals(status, 200, "GetProfileInfoXML Failed");
    system:println("===testGetProfileInfoXML completed===\n");

}

function testGetProfileInfoJSON () {

    linkedin:ClientConnector linkedInConnector = init();
    linkedInResponse = linkedInConnector.getProfileInfo ("json");
    linkedInJSONResponse = messages:getJsonPayload(linkedInResponse);
    system:println(linkedInJSONResponse);
    int status = http:getStatusCode(linkedInResponse);
    test:assertIntEquals(status, 200, "GetProfileInfoJSON Failed");
    system:println("===testGetProfileInfoJSON completed===\n");

}

function testGetCompanyInfoXML () {

    linkedin:ClientConnector linkedInConnector = init();
    linkedInResponse = linkedInConnector.getCompanyInfo (companyId, "xml");
    linkedInXMLResponse = messages:getXmlPayload(linkedInResponse);
    system:println(xmls:toString(linkedInXMLResponse));
    int status = http:getStatusCode(linkedInResponse);
    test:assertIntEquals(status, 200, "GetCompanyInfoXML Failed");
    system:println("===testGetCompanyInfoXML completed===\n");

}

function testGetCompanyInfoJSON () {

    linkedin:ClientConnector linkedInConnector = init();
    linkedInResponse = linkedInConnector.getCompanyInfo (companyId, "json");
    linkedInJSONResponse = messages:getJsonPayload(linkedInResponse);
    system:println(linkedInJSONResponse);
    int status = http:getStatusCode(linkedInResponse);
    test:assertIntEquals(status, 200, "GetCompanyInfoJSON Failed");
    system:println("===testGetCompanyInfoJSON completed===\n");

}

function testIsCompanyShareEnabledXML () {

    linkedin:ClientConnector linkedInConnector = init();
    linkedInResponse = linkedInConnector.isCompanyShareEnabled (companyId, "xml");
    linkedInXMLResponse = messages:getXmlPayload(linkedInResponse);
    system:println(xmls:toString(linkedInXMLResponse));
    int status = http:getStatusCode(linkedInResponse);
    test:assertIntEquals(status, 200, "IsCompanyShareEnabledXML Failed");
    system:println("===testIsCompanyShareEnabledXML completed===\n");

}

function testIsCompanyShareEnabledJSON () {

    linkedin:ClientConnector linkedInConnector = init();
    linkedInResponse = linkedInConnector.isCompanyShareEnabled (companyId, "json");
    linkedInJSONResponse = messages:getJsonPayload(linkedInResponse);
    system:println(linkedInJSONResponse);
    int status = http:getStatusCode(linkedInResponse);
    test:assertIntEquals(status, 200, "IsCompanyShareEnabledJSON Failed");
    system:println("===testIsCompanyShareEnabledJSON completed===\n");

}

function testIsMemberAdminXML () {

    linkedin:ClientConnector linkedInConnector = init();
    linkedInResponse = linkedInConnector.isMemberAdmin (companyId, "xml");
    linkedInXMLResponse = messages:getXmlPayload(linkedInResponse);
    system:println(xmls:toString(linkedInXMLResponse));
    int status = http:getStatusCode(linkedInResponse);
    test:assertIntEquals(status, 200, "IsMemberAdminXML Failed");
    system:println("===testIsMemberAdminXML completed===\n");

}

function testIsMemberAdminJSON () {

    linkedin:ClientConnector linkedInConnector = init();
    linkedInResponse = linkedInConnector.isMemberAdmin (companyId, "json");
    linkedInJSONResponse = messages:getJsonPayload(linkedInResponse);
    system:println(linkedInJSONResponse);
    int status = http:getStatusCode(linkedInResponse);
    test:assertIntEquals(status, 200, "IsMemberAdminJSON Failed");
    system:println("===testIsMemberAdminJSON completed===\n");

}