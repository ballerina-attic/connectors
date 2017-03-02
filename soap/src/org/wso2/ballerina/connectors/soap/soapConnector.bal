package org.wso2.ballerina.connectors.soap;

import ballerina.lang.messages;
import ballerina.net.http;
import ballerina.lang.xmls;

@doc:Description("The SOAP client connector")
@doc:Param("url: The url")
connector ClientConnector (string url) {

    http:ClientConnector httpConnector = create http:ClientConnector("");
    map namespaceMap = {"1.2":"http://www.w3.org/2003/05/soap-envelope","1.1":"http://schemas.xmlsoap.org/soap/envelope/"};

    @doc:Description("Call a soap endpoint")
    @doc:Param("s: The soap Connector instance")
    @doc:Param("payload: The payload to request")
    @doc:Param("soapAction: The soap action")
    @doc:Param("url: The soap endpoint url")
    @doc:Param("soapVersion: The soap version")
    @doc:Return("response xml")
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
        xml soapBody = xmls:getXml(resp, "/soapenv:Envelope/soapenv:Body/*", m);

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