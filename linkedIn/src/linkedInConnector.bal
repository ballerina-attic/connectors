package org.wso2.ballerina.connectors.linkedIn;

import ballerina.lang.xml;
import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.system;
import ballerina.net.http;

connector Linkedin (string accessToken) {

    http:ClientConnector linkedInEP = create http:ClientConnector("https://api.linkedin.com");

    action getProfileInfo(Linkedin t, string format) (message) {

        string oauthHeader;
        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/people/~?format=" + format;
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(linkedInEP, getProfileInfoPath, request);

        return response;
    }

    action getCompanyInfo(Linkedin t, string company_id, string format) (message) {

        string oauthHeader;
        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/companies/" + company_id + "?format=" + format;
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(linkedInEP, getProfileInfoPath, request);

        return response;
    }

    action isCompanyShareEnabled(Linkedin t, string company_id, string format) (message) {

        string oauthHeader;
        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/companies/" + company_id + "/is-company-share-enabled?format=" + format;
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(linkedInEP, getProfileInfoPath, request);

        return response;
    }

    action isMemberAdmin(Linkedin t, string company_id, string format) (message) {

        string oauthHeader;
        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/companies/" + company_id + "/relation-to-viewer/is-company-share-enabled?format=" + format;
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(linkedInEP, getProfileInfoPath, request);

        return response;
    }

    action profileShare(Linkedin t, json payload) (message) {

        string oauthHeader;
        string profileSharePath;
        message request = {};
        message response;

        profileSharePath = "/v1/people/~/shares?format=json";
        message:setHeader(request, "Content-Type", "application/json");
        message:setHeader(request, "x-li-format", "json");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        message:setJsonPayload(request, payload);
        response = http:ClientConnector.post(linkedInEP, profileSharePath, request);

        return response;
    }

    action profileShare(Linkedin t, xml payload) (message) {

        string oauthHeader;
        string profileSharePath;
        message request = {};
        message response;

        profileSharePath = "/v1/people/~/shares?format=xml";
        message:setHeader(request, "Content-Type", "application/xml");
        message:setHeader(request, "x-li-format", "xml");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        message:setXmlPayload(request, payload);
        response = http:ClientConnector.post(linkedInEP, profileSharePath, request);

        return response;
    }

    action companyShare(Linkedin t, string company_id, json payload) (message) {

        string oauthHeader;
        string companySharePath;
        message request = {};
        message response;

        companySharePath = "/v1/companies/" + company_id + "/shares?format=json";
        message:setHeader(request, "Content-Type", "application/json");
        message:setHeader(request, "x-li-format", "json");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        message:setJsonPayload(request, payload);
        response = http:ClientConnector.post(linkedInEP, companySharePath, request);

        return response;
    }

    action companyShare(Linkedin t, string company_id, xml payload) (message) {

        string oauthHeader;
        string companySharePath;
        message request = {};
        message response;

        companySharePath = "/v1/companies/" + company_id + "/shares?format=xml";
        message:setHeader(request, "Content-Type", "application/xml");
        message:setHeader(request, "x-li-format", "xml");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        message:setXmlPayload(request, payload);
        response = http:ClientConnector.post(linkedInEP, companySharePath, request);

        return response;
    }

}

function validateFormat(string format) (string) {

    if ( format == "xml") {
        return format;
    }
	else{
        return "json";
	}
}

function printJsonResponse(message linkedInResponse) (string) {

    json linkedInJSONResponse;
    linkedInJSONResponse = message:getJsonPayload(linkedInResponse);
    system:println(json:toString(linkedInJSONResponse));
}

function printXmlResponse(message linkedInResponse) (string) {

    xml linkedInXMLResponse;
    linkedInXMLResponse = message:getXmlPayload(linkedInResponse);
    system:println(xml:toString(linkedInXMLResponse));
}

function runGETSamples(Linkedin linkedInConnector, string company_id) (string) {

    message linkedInResponse;

    system:println("---------------");
    system:println("  GET actions");
    system:println("---------------");
    system:println(" ");

    system:println(" ");
    system:println("Get Profile Info in XML format");
    linkedInResponse = Linkedin.getProfileInfo(linkedInConnector, "xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get Profile Info in JSON format");
    linkedInResponse = Linkedin.getProfileInfo(linkedInConnector, "json");
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Get Company Info in XML format");
    linkedInResponse = Linkedin.getCompanyInfo(linkedInConnector, company_id, "xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get Company Info in JSON format");
    linkedInResponse = Linkedin.getCompanyInfo(linkedInConnector, company_id, "json");
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsCompanyShareEnabled in XML format");
    linkedInResponse = Linkedin.isCompanyShareEnabled(linkedInConnector, company_id, "xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsCompanyShareEnabled in JSON format");
    linkedInResponse = Linkedin.isCompanyShareEnabled(linkedInConnector, company_id, "json");
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsMemberAdmin in XML format");
    linkedInResponse = Linkedin.isMemberAdmin(linkedInConnector, company_id, "xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsMemberAdmin in JSON format");
    linkedInResponse = Linkedin.isMemberAdmin(linkedInConnector, company_id, "json");
    printJsonResponse(linkedInResponse);
    system:println(" ");
}

function runPOSTSamples(Linkedin linkedInConnector, string company_id) (string) {

    message linkedInResponse;
	xml short_xml_payload;
	json short_json_payload;
	xml full_xml_payload;
	json full_json_payload;

	short_xml_payload = `<share> <visibility> <code>anyone</code> </visibility> <comment>xml test simple payload http://wso2.com</comment> </share>`;
    short_json_payload = `{comment: 'json test simple payload http://wso2.com',visibility: {code: anyone}}`;
    full_xml_payload = `<share> <visibility> <code>anyone</code> </visibility> <comment>xml test full payload</comment> <content> <submitted-url>https://www.wso2.com</submitted-url> <title>Test Share with Content</title> <description>content description</description> <submitted-image-url>https://www.example.com/img.jpg</submitted-image-url> </content> </share>`;
    full_json_payload = `{ visibility: { code: anyone }, comment: 'json test full payload', content: { submitted-url: 'https://www.wso2.com', title: 'Test Share with Content', description: 'content description', submitted‐image-­url: 'https://www.example.com/img.jpg' } }`;

	system:println(" ");
	system:println("----------------");
	system:println("  POST actions");
	system:println("----------------");
	system:println(" ");

    system:println("Share Short Profile Post in XML format");

    linkedInResponse = Linkedin.profileShare(linkedInConnector, short_xml_payload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Short Profile Post in JSON format");
    linkedInResponse = Linkedin.profileShare(linkedInConnector, short_json_payload);
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Profile Post in XML format");
    linkedInResponse = Linkedin.profileShare(linkedInConnector, full_xml_payload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Profile Post in JSON format");
    linkedInResponse = Linkedin.profileShare(linkedInConnector, full_json_payload);
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Short Company Post in XML format");
    linkedInResponse = Linkedin.companyShare(linkedInConnector, company_id, short_xml_payload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Short Company Post in JSON format");
    linkedInResponse = Linkedin.companyShare(linkedInConnector, company_id, short_json_payload);
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Company Post in XML format");
    linkedInResponse = Linkedin.companyShare(linkedInConnector, company_id, full_xml_payload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Company Post in JSON format");
    linkedInResponse = Linkedin.companyShare(linkedInConnector, company_id, full_json_payload);
    printJsonResponse(linkedInResponse);
    system:println(" ");
}

function main (string[] args) {

    Linkedin linkedInConnector = create Linkedin(args[0]);
    string company_id;
    company_id = args[1];
    
    runGETSamples(linkedInConnector, company_id);
    runPOSTSamples(linkedInConnector, company_id);
}
