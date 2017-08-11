import org.wso2.ballerina.connectors.linkedin;
import ballerina.lang.jsons;
import ballerina.lang.xmls;
import ballerina.lang.messages;
import ballerina.lang.system;

function printJsonResponse(message linkedInResponse) {

    json linkedInJSONResponse;
    linkedInJSONResponse = messages:getJsonPayload(linkedInResponse);
    system:println(jsons:toString(linkedInJSONResponse));
}

function printXmlResponse(message linkedInResponse) {

    xml linkedInXMLResponse;
    linkedInXMLResponse = messages:getXmlPayload(linkedInResponse);
    system:println(xmls:toString(linkedInXMLResponse));
}

function runGETSamples(linkedin:ClientConnector linkedInConnector, string companyId) {

    message linkedInResponse;

    system:println("---------------");
    system:println("  GET actions");
    system:println("---------------");
    system:println(" ");

    system:println(" ");
    system:println("Get Profile Info in XML format");
    linkedInResponse = linkedInConnector.getProfileInfo ("xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get Profile Info in JSON format");
    linkedInResponse = linkedInConnector.getProfileInfo ("json");
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Get Company Info in XML format");
    linkedInResponse = linkedInConnector.getCompanyInfo (companyId, "xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get Company Info in JSON format");
    linkedInResponse = linkedInConnector.getCompanyInfo (companyId, "json");
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsCompanyShareEnabled in XML format");
    linkedInResponse = linkedInConnector.isCompanyShareEnabled (companyId, "xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsCompanyShareEnabled in JSON format");
    linkedInResponse = linkedInConnector.isCompanyShareEnabled (companyId, "json");
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsMemberAdmin in XML format");
    linkedInResponse = linkedInConnector.isMemberAdmin (companyId, "xml");
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Get IsMemberAdmin in JSON format");
    linkedInResponse = linkedInConnector.isMemberAdmin (companyId, "json");
    printJsonResponse(linkedInResponse);
    system:println(" ");
}

function runPOSTSamples(linkedin:ClientConnector linkedInConnector, string companyId) {

    message linkedInResponse;
	xml shortXmlPayload;
	json shortJsonPayload;
	xml fullXmlPayload;
	json fullJsonPayload;

	shortXmlPayload = xml `<share> <visibility> <code>anyone</code> </visibility> <comment>xml test simple payload http://wso2.com</comment> </share>`;
    shortJsonPayload = {"comment": "json test simple payload http://wso2.com","visibility": {"code": "anyone"}};
    fullXmlPayload = xml `<share> <visibility> <code>anyone</code> </visibility> <comment>xml test full payload</comment> <content> <submitted-url>https://www.wso2.com</submitted-url> <title>Test Share with Content</title> <description>content description</description> <submitted-image-url>https://www.example.com/img.jpg</submitted-image-url> </content> </share>`;
    fullJsonPayload = { "visibility": { "code": "anyone" }, "comment": "json test full payload", "content": { "submitted-url": "https://www.wso2.com", "title": "Test Share with Content", "description": "content description", "submitted‐image-­url": "https://www.example.com/img.jpg" } };

	system:println(" ");
	system:println("----------------");
	system:println("  POST actions");
	system:println("----------------");
	system:println(" ");

    system:println("Share Short Profile Post in XML format");

    linkedInResponse = linkedInConnector.profileShareXml (shortXmlPayload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Short Profile Post in JSON format");
    linkedInResponse = linkedInConnector.profileShareJson (shortJsonPayload);
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Profile Post in XML format");
    linkedInResponse = linkedInConnector.profileShareXml (fullXmlPayload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Profile Post in JSON format");
    linkedInResponse = linkedInConnector.profileShareJson (fullJsonPayload);
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Short Company Post in XML format");
    linkedInResponse = linkedInConnector.companyShareXml (companyId, shortXmlPayload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Short Company Post in JSON format");
    linkedInResponse = linkedInConnector.companyShareJson (companyId, shortJsonPayload);
    printJsonResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Company Post in XML format");
    linkedInResponse = linkedInConnector.companyShareXml (companyId, fullXmlPayload);
    printXmlResponse(linkedInResponse);
    system:println(" ");

    system:println("Share Full Company Post in JSON format");
    linkedInResponse = linkedInConnector.companyShareJson (companyId, fullJsonPayload);
    printJsonResponse(linkedInResponse);
    system:println(" ");
}

function main (string[] args) {

    linkedin:ClientConnector linkedInConnector;
    string companyId;
    message linkedInResponse;
	xml shortXmlPayload;
	json shortJsonPayload;
	xml fullXmlPayload;
	json fullJsonPayload;

	shortXmlPayload = xml `<share> <visibility> <code>anyone</code> </visibility> <comment>xml test simple payload http://wso2.com</comment> </share>`;
    shortJsonPayload = {"comment": "json test simple payload http://wso2.com","visibility": {"code": "anyone"}};
    fullXmlPayload = xml `<share> <visibility> <code>anyone</code> </visibility> <comment>xml test full payload</comment> <content> <submitted-url>https://www.wso2.com</submitted-url> <title>Test Share with Content</title> <description>content description</description> <submitted-image-url>https://www.example.com/img.jpg</submitted-image-url> </content> </share>`;
    fullJsonPayload = { "visibility": { "code": "anyone" }, "comment": "json test full payload", "content": { "submitted-url": "https://www.wso2.com", "title": "Test Share with Content", "description": "content description", "submitted‐image-­url": "https://www.example.com/img.jpg" } };


    if (args[0] == "get") {
        linkedInConnector = create linkedin:ClientConnector(args[1]);
        companyId = args[2];
        runGETSamples(linkedInConnector, companyId);

    } else if (args[0] == "post") {
        linkedInConnector = create linkedin:ClientConnector(args[1]);
        companyId = args[2];
        runPOSTSamples(linkedInConnector, companyId);

    } else if (args[0] == "getProfileInfo") {
        linkedInConnector = create linkedin:ClientConnector(args[1]);

        system:println(" ");
        system:println("Get Profile Info in XML format");
        linkedInResponse = linkedInConnector.getProfileInfo ("xml");
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Get Profile Info in JSON format");
        linkedInResponse = linkedInConnector.getProfileInfo ("json");
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else if (args[0] == "getCompanyInfo") {
        linkedInConnector = create linkedin:ClientConnector(args[1]);
        companyId = args[2];

        system:println(" ");
        system:println("Get Company Info in XML format");
        linkedInResponse = linkedInConnector.getCompanyInfo (companyId, "xml");
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Get Company Info in JSON format");
        linkedInResponse = linkedInConnector.getCompanyInfo (companyId, "json");
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else if (args[0] == "isCompanyShareEnabled") {
        linkedInConnector = create linkedin:ClientConnector(args[1]);
        companyId = args[2];

        system:println(" ");
        system:println("Get IsCompanyShareEnabled in XML format");
        linkedInResponse = linkedInConnector.isCompanyShareEnabled (companyId, "xml");
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Get IsCompanyShareEnabled in JSON format");
        linkedInResponse = linkedInConnector.isCompanyShareEnabled (companyId, "json");
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else if (args[0] == "isMemberAdmin") {
        linkedInConnector = create linkedin:ClientConnector(args[1]);
        companyId = args[2];

        system:println(" ");
        system:println("Get IsMemberAdmin in XML format");
        linkedInResponse = linkedInConnector.isMemberAdmin (companyId, "xml");
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Get IsMemberAdmin in JSON format");
        linkedInResponse = linkedInConnector.isMemberAdmin (companyId, "json");
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else if (args[0] == "profileShare") {
        linkedInConnector = create linkedin:ClientConnector(args[1]);

        system:println(" ");
        system:println("Share Short Profile Post in XML format");
        linkedInResponse = linkedInConnector.profileShareXml (shortXmlPayload);
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Short Profile Post in JSON format");
        linkedInResponse = linkedInConnector.profileShareJson (shortJsonPayload);
        printJsonResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Full Profile Post in XML format");
        linkedInResponse = linkedInConnector.profileShareXml (fullXmlPayload);
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Full Profile Post in JSON format");
        linkedInResponse = linkedInConnector.profileShareJson (fullJsonPayload);
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else if (args[0] == "companyShare") {
        linkedInConnector = create linkedin:ClientConnector(args[1]);
        companyId = args[2];

        system:println(" ");
        system:println("Share Short Company Post in XML format");
        linkedInResponse = linkedInConnector.companyShareXml (companyId, shortXmlPayload);
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Short Company Post in JSON format");
        linkedInResponse = linkedInConnector.companyShareJson (companyId, shortJsonPayload);
        printJsonResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Full Company Post in XML format");
        linkedInResponse = linkedInConnector.companyShareXml (companyId, fullXmlPayload);
        printXmlResponse(linkedInResponse);
        system:println(" ");

        system:println("Share Full Company Post in JSON format");
        linkedInResponse = linkedInConnector.companyShareJson (companyId, fullJsonPayload);
        printJsonResponse(linkedInResponse);
        system:println(" ");

    } else {
        linkedInConnector = create linkedin:ClientConnector(args[0]);
        companyId = args[1];
        runGETSamples(linkedInConnector, companyId);
        runPOSTSamples(linkedInConnector, companyId);
    }
}