import org.wso2.ballerina.connectors.soap;

import ballerina.lang.xmls;
import ballerina.lang.system;

function main (string[] args) {

    soap:ClientConnector soapConnector = create soap:ClientConnector("");
    xml[] headers = [];
    string username = args[0];
    string password = args[1];
    xml payload = `<urn:login xmlns:urn="urn:partner.soap.sforce.com">
	<urn:username>${username}</urn:username>
	<urn:password>${password}</urn:password>
	</urn:login>`;

    xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
    "https://login.salesforce.com/services/Soap/u/27.0", "1.1");

    map n = {"ns":"urn:partner.soap.sforce.com"};
    string sessionId = xmls:getString(soapResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
    system:println("================The Soap Body is===============");
    system:println(xmls:toString(soapResponse));
    system:println("================The Session Id is===============");
    system:println(sessionId);
}