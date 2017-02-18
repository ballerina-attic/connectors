package org.wso2.ballerina.connectors.soap;

import ballerina.lang.xmlutils;
import ballerina.lang.system;

function main (string[] args) {

    soap:ClientConnector soapConnector = create soap:ClientConnector("");

    string username = args[0];
    string password = args[1];
    xml payload = `<urn:login xmlns:urn="urn:partner.soap.sforce.com">
	<urn:username>${username}</urn:username>
	<urn:password>${password}</urn:password>
	</urn:login>`;

    xml soapResponse = soap:ClientConnector.send(soapConnector, payload, "''",
    "https://login.salesforce.com/services/Soap/u/27.0", "1.1");

    map n = {"ns":"urn:partner.soap.sforce.com"};
    string sessionId = xmlutils:getString(soapResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
    system:println("================The Soap Body is===============");
    system:println(xmlutils:toString(soapResponse));
    system:println("================The Session Id is===============");
    system:println(sessionId);
}