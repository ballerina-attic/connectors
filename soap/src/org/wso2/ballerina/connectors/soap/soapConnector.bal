package org.wso2.ballerina.connectors.soap;

import ballerina.lang.messages;
import ballerina.net.http;
import ballerina.lang.xmlutils;

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
        messages:setXmlPayload(backendServiceReq, soapPayload);
        messages:setHeader(backendServiceReq, "Content-Type", reqType);

        if (soapAction != "null") {
            messages:setHeader(backendServiceReq, "SOAPAction", soapAction);
        }

        message response = http:ClientConnector.post(httpConnector, url, backendServiceReq);
        xml resp = messages:getXmlPayload(response);
        map m = {"soapenv" : namespaceMap[soapVersion]};
        xml soapBody = xmlutils:getXml(resp, "/soapenv:Envelope/soapenv:Body/*", m);

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