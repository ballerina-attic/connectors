package org.wso2.ballerina.connectors.linkedIn;

import ballerina.lang.xml;
import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.system;
import ballerina.net.http;

@doc:Description("LinkedIn client connector")
@doc:Param("accessToken: The access token of the LinkedIn Application")
connector ClientConnector (string accessToken) {

    http:ClientConnector linkedInEP = create http:ClientConnector("https://api.linkedin.com");

    @doc:Description("Get Profile Information")
    @doc:Param("format: Format of the response expected (json/xml)")
    @doc:Return("response object")
    action getProfileInfo(ClientConnector t, string format) (message) {

        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/people/~?format=" + format;
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(linkedInEP, getProfileInfoPath, request);

        return response;
    }

    @doc:Description("Get Company Page Information")
    @doc:Param("companyId: ID of the relevant company")
    @doc:Param("format: Format of the response expected (json/xml)")
    @doc:Return("response object")
    action getCompanyInfo(ClientConnector t, string companyId, string format) (message) {

        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/companies/" + companyId + "?format=" + format;
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(linkedInEP, getProfileInfoPath, request);

        return response;
    }

    @doc:Description("Check if Sharing is enabled for a company page")
    @doc:Param("companyId: ID of the relevant company")
    @doc:Param("format: Format of the response expected (json/xml)")
    @doc:Return("response object")
    action isCompanyShareEnabled(ClientConnector t, string companyId, string format) (message) {

        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/companies/" + companyId + "/is-company-share-enabled?format=" + format;
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(linkedInEP, getProfileInfoPath, request);

        return response;
    }

    @doc:Description("Check if the user is an admin of Company Page")
    @doc:Param("companyId: ID of the relevant company")
    @doc:Param("format: Format of the response expected (json/xml)")
    @doc:Return("response object")
    action isMemberAdmin(ClientConnector t, string companyId, string format) (message) {

        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/companies/" + companyId + "/relation-to-viewer/is-company-share-enabled?format=" + format;
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        response = http:ClientConnector.get(linkedInEP, getProfileInfoPath, request);

        return response;
    }

    @doc:Description("Post on the profile of the authenticated user")
    @doc:Param("payload: json payload containing the post that needed to be shared")
    @doc:Return("response object")
    action profileShare(ClientConnector t, json payload) (message) {

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

    @doc:Description("Post on the profile of the authenticated user")
    @doc:Param("payload: xml payload containing the post that needed to be shared")
    @doc:Return("response object")
    action profileShare(ClientConnector t, xml payload) (message) {

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

    @doc:Description("Post on a Company Page")
    @doc:Param("companyId: ID of the relevant company")
    @doc:Param("payload: json payload containing the post that needed to be shared")
    @doc:Return("response object")
    action companyShare(ClientConnector t, string companyId, json payload) (message) {

        string companySharePath;
        message request = {};
        message response;

        companySharePath = "/v1/companies/" + companyId + "/shares?format=json";
        message:setHeader(request, "Content-Type", "application/json");
        message:setHeader(request, "x-li-format", "json");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);
        message:setJsonPayload(request, payload);
        response = http:ClientConnector.post(linkedInEP, companySharePath, request);

        return response;
    }

    @doc:Description("Post on a Company Page")
    @doc:Param("companyId: ID of the relevant company")
    @doc:Param("payload: xml payload containing the post that needed to be shared")
    @doc:Return("response object")
    action companyShare(ClientConnector t, string companyId, xml payload) (message) {

        string companySharePath;
        message request = {};
        message response;

        companySharePath = "/v1/companies/" + companyId + "/shares?format=xml";
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

function runGETSamples(ClientConnector linkedInConnector, string companyId) (string) {

    message linkedInResponse;

    system:println("---------------");
    system:println("  GET actions");
    system:println("---------------");
    system:println(" ");

    system:println(" ");
    system:println("Get Profile Info in XML format");
    linkedInResponse = ClientConnector.getProfileInfo(linkedInConnector, "xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get Profile Info in JSON format");
    linkedInResponse = ClientConnector.getProfileInfo(linkedInConnector, "json");
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Get Company Info in XML format");
    linkedInResponse = ClientConnector.getCompanyInfo(linkedInConnector, companyId, "xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get Company Info in JSON format");
    linkedInResponse = ClientConnector.getCompanyInfo(linkedInConnector, companyId, "json");
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsCompanyShareEnabled in XML format");
    linkedInResponse = ClientConnector.isCompanyShareEnabled(linkedInConnector, companyId, "xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsCompanyShareEnabled in JSON format");
    linkedInResponse = ClientConnector.isCompanyShareEnabled(linkedInConnector, companyId, "json");
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsMemberAdmin in XML format");
    linkedInResponse = ClientConnector.isMemberAdmin(linkedInConnector, companyId, "xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsMemberAdmin in JSON format");
    linkedInResponse = ClientConnector.isMemberAdmin(linkedInConnector, companyId, "json");
    printJsonResponse(linkedInResponse);
    system:println(" ");
}

function runPOSTSamples(ClientConnector linkedInConnector, string companyId) (string) {

    message linkedInResponse;
	xml shortXmlPayload;
	json shortJsonPayload;
	xml fullXmlPayload;
	json fullJsonPayload;

	shortXmlPayload = `<share> <visibility> <code>anyone</code> </visibility> <comment>xml test simple payload http://wso2.com</comment> </share>`;
    shortJsonPayload = `{comment: 'json test simple payload http://wso2.com',visibility: {code: anyone}}`;
    fullXmlPayload = `<share> <visibility> <code>anyone</code> </visibility> <comment>xml test full payload</comment> <content> <submitted-url>https://www.wso2.com</submitted-url> <title>Test Share with Content</title> <description>content description</description> <submitted-image-url>https://www.example.com/img.jpg</submitted-image-url> </content> </share>`;
    fullJsonPayload = `{ visibility: { code: anyone }, comment: 'json test full payload', content: { submitted-url: 'https://www.wso2.com', title: 'Test Share with Content', description: 'content description', submitted‐image-­url: 'https://www.example.com/img.jpg' } }`;

	system:println(" ");
	system:println("----------------");
	system:println("  POST actions");
	system:println("----------------");
	system:println(" ");

    system:println("Share Short Profile Post in XML format");

    linkedInResponse = ClientConnector.profileShare(linkedInConnector, shortXmlPayload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Short Profile Post in JSON format");
    linkedInResponse = ClientConnector.profileShare(linkedInConnector, shortJsonPayload);
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Profile Post in XML format");
    linkedInResponse = ClientConnector.profileShare(linkedInConnector, fullXmlPayload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Profile Post in JSON format");
    linkedInResponse = ClientConnector.profileShare(linkedInConnector, fullJsonPayload);
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Short Company Post in XML format");
    linkedInResponse = ClientConnector.companyShare(linkedInConnector, companyId, shortXmlPayload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Short Company Post in JSON format");
    linkedInResponse = ClientConnector.companyShare(linkedInConnector, companyId, shortJsonPayload);
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Company Post in XML format");
    linkedInResponse = ClientConnector.companyShare(linkedInConnector, companyId, fullXmlPayload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Company Post in JSON format");
    linkedInResponse = ClientConnector.companyShare(linkedInConnector, companyId, fullJsonPayload);
    printJsonResponse(linkedInResponse);
    system:println(" ");
}

function main (string[] args) {

    ClientConnector linkedInConnector;
    string companyId;
    message linkedInResponse;
	xml shortXmlPayload;
	json shortJsonPayload;
	xml fullXmlPayload;
	json fullJsonPayload;

	shortXmlPayload = `<share> <visibility> <code>anyone</code> </visibility> <comment>xml test simple payload http://wso2.com</comment> </share>`;
    shortJsonPayload = `{comment: 'json test simple payload http://wso2.com',visibility: {code: anyone}}`;
    fullXmlPayload = `<share> <visibility> <code>anyone</code> </visibility> <comment>xml test full payload</comment> <content> <submitted-url>https://www.wso2.com</submitted-url> <title>Test Share with Content</title> <description>content description</description> <submitted-image-url>https://www.example.com/img.jpg</submitted-image-url> </content> </share>`;
    fullJsonPayload = `{ visibility: { code: anyone }, comment: 'json test full payload', content: { submitted-url: 'https://www.wso2.com', title: 'Test Share with Content', description: 'content description', submitted‐image-­url: 'https://www.example.com/img.jpg' } }`;


    if (args[0]=="get") {
        linkedInConnector = create ClientConnector(args[1]);
        companyId = args[2];
        runGETSamples(linkedInConnector, companyId);

    } else if (args[0]=="post") {
        linkedInConnector = create ClientConnector(args[1]);
        companyId = args[2];
        runPOSTSamples(linkedInConnector, companyId);

    } else if (args[0]=="getProfileInfo") {
        linkedInConnector = create ClientConnector(args[1]);

        system:println(" ");
        system:println("Get Profile Info in XML format");
        linkedInResponse = ClientConnector.getProfileInfo(linkedInConnector, "xml");
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Get Profile Info in JSON format");
        linkedInResponse = ClientConnector.getProfileInfo(linkedInConnector, "json");
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else if (args[0]=="getCompanyInfo") {
        linkedInConnector = create ClientConnector(args[1]);
        companyId = args[2];

        system:println(" ");
        system:println("Get Company Info in XML format");
        linkedInResponse = ClientConnector.getCompanyInfo(linkedInConnector, companyId, "xml");
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Get Company Info in JSON format");
        linkedInResponse = ClientConnector.getCompanyInfo(linkedInConnector, companyId, "json");
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else if (args[0]=="isCompanyShareEnabled") {
        linkedInConnector = create ClientConnector(args[1]);
        companyId = args[2];

        system:println(" ");
        system:println("Get IsCompanyShareEnabled in XML format");
        linkedInResponse = ClientConnector.isCompanyShareEnabled(linkedInConnector, companyId, "xml");
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Get IsCompanyShareEnabled in JSON format");
        linkedInResponse = ClientConnector.isCompanyShareEnabled(linkedInConnector, companyId, "json");
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else if (args[0]=="isMemberAdmin") {
        linkedInConnector = create ClientConnector(args[1]);
        companyId = args[2];

        system:println(" ");
        system:println("Get IsMemberAdmin in XML format");
        linkedInResponse = ClientConnector.isMemberAdmin(linkedInConnector, companyId, "xml");
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Get IsMemberAdmin in JSON format");
        linkedInResponse = ClientConnector.isMemberAdmin(linkedInConnector, companyId, "json");
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else if (args[0]=="profileShare") {
        linkedInConnector = create ClientConnector(args[1]);

    	system:println(" ");
        system:println("Share Short Profile Post in XML format");
        linkedInResponse = ClientConnector.profileShare(linkedInConnector, shortXmlPayload);
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Short Profile Post in JSON format");
        linkedInResponse = ClientConnector.profileShare(linkedInConnector, shortJsonPayload);
        printJsonResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Full Profile Post in XML format");
        linkedInResponse = ClientConnector.profileShare(linkedInConnector, fullXmlPayload);
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Full Profile Post in JSON format");
        linkedInResponse = ClientConnector.profileShare(linkedInConnector, fullJsonPayload);
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else if (args[0]=="companyShare") {
        linkedInConnector = create ClientConnector(args[1]);
        companyId = args[2];

        system:println(" ");
        system:println("Share Short Company Post in XML format");
        linkedInResponse = ClientConnector.companyShare(linkedInConnector, companyId, shortXmlPayload);
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Short Company Post in JSON format");
        linkedInResponse = ClientConnector.companyShare(linkedInConnector, companyId, shortJsonPayload);
        printJsonResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Full Company Post in XML format");
        linkedInResponse = ClientConnector.companyShare(linkedInConnector, companyId, fullXmlPayload);
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Full Company Post in JSON format");
        linkedInResponse = ClientConnector.companyShare(linkedInConnector, companyId, fullJsonPayload);
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else {
        linkedInConnector = create ClientConnector(args[0]);
        companyId = args[1];
        runGETSamples(linkedInConnector, companyId);
        runPOSTSamples(linkedInConnector, companyId);
    }

}
