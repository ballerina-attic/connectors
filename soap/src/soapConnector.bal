package org.wso2.ballerina.connectors.soap;

import ballerina.lang.message;
import ballerina.net.http;
import ballerina.lang.system;
import ballerina.lang.xml;

connector ClientConnector (string url) {

    http:ClientConnector httpConnector = create http:ClientConnector("");
    map namespaceMap = {"1.2":"http://www.w3.org/2003/05/soap-envelope","1.1":"http://schemas.xmlsoap.org/soap/envelope/"};

    action send (ClientConnector s, xml payload, string soapAction, string url, string soapVersion) (xml) {

        message backendServiceReq ={};
        string reqType;

        if (soapVersion == "1.2") {
            reqType = "application/soap+xml";
        } else {
            reqType = "text/xml";
        }

        xml soapPayload = addSoapBody (payload, namespaceMap[soapVersion]);
        message:setXmlPayload(backendServiceReq, soapPayload);
        message:setHeader(backendServiceReq, "Content-Type", reqType);

        if (soapAction != "null") {
            message:setHeader(backendServiceReq, "SOAPAction", soapAction);
        }

        message response = http:ClientConnector.post(httpConnector, url, backendServiceReq);
        xml resp = message:getXmlPayload(response);
        map m = {"soapenv" : namespaceMap[soapVersion]};
        xml soapBody = xml:getXml(resp, "/soapenv:Envelope/soapenv:Body/*", m);

        return soapBody;
    }
}

function addSoapBody (xml payload, map namespace) (xml) {

    xml soapBody = `<soapenv:Envelope xmlns:soapenv="${namespace}">
	<soapenv:Body>
	${payload}
	</soapenv:Body>
	</soapenv:Envelope>`;

    return soapBody;
}

function main (string[] args) {
    ClientConnector soapConnector = create ClientConnector("");

    string username = args[0];
    string password = args[1];
    xml payload = `<urn:login xmlns:urn="urn:partner.soap.sforce.com">
	<urn:username>${username}</urn:username>
	<urn:password>${password}</urn:password>
	</urn:login>`;

    xml soapResponse = ClientConnector.send(soapConnector, payload, "''",
    "https://login.salesforce.com/services/Soap/u/27.0", "1.1");

    map n = {"ns":"urn:partner.soap.sforce.com"};
    string sessionId = xml:getString(soapResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
    system:println("================The Soap Body is===============");
    system:println(xml:toString(soapResponse));
    system:println("================The Session Id is===============");
    system:println(sessionId);
}