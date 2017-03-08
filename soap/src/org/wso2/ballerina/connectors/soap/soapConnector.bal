package org.wso2.ballerina.connectors.soap;

import ballerina.lang.messages;
import ballerina.net.http;
import ballerina.lang.xmls;
import ballerina.lang.arrays;

@doc:Description("The SOAP client connector")
@doc:Param("url: The url")
connector ClientConnector (string url) {

    http:ClientConnector httpConnector = create http:ClientConnector("");
    map namespaceMap = {"1.2":"http://www.w3.org/2003/05/soap-envelope","1.1":"http://schemas.xmlsoap.org/soap/envelope/"};

    @doc:Description("Call a soap endpoint")
    @doc:Param("s: The soap Connector instance")
    @doc:Param("headers: Headers of the SOAP request")
    @doc:Param("payload: The payload to request")
    @doc:Param("soapAction: The soap action")
    @doc:Param("url: The soap endpoint url")
    @doc:Param("soapVersion: The soap version")
    @doc:Return("response xml")
    action send (ClientConnector s, xml[] headers, xml payload, string soapAction, string url, string soapVersion) (xml) {

        message backendServiceReq ={};
        string reqType;

        if (soapVersion == "1.2") {
            reqType = "application/soap+xml";
        } else {
            reqType = "text/xml";
        }
        string soapDefinition = namespaceMap[soapVersion];
        xml soapPayload = constructSoapRequest (payload, soapDefinition, headers);
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

function constructSoapRequest (xml payload, string namespace, xml[] headers) (xml) {

    map n = { "soapenv" : namespace};

    xml soapRequest = `<soapenv:Envelope xmlns:soapenv="${namespace}">
    	               </soapenv:Envelope>`;

    if (arrays:length(headers) != 0) {

        xml value = `<soapenv:Header  xmlns:soapenv="${namespace}">
                     </soapenv:Header>`;
        xmls:addElement(soapRequest, "/soapenv:Envelope", value, n);
        int i = 0;
        int j = arrays:length(headers);
        while (i < j){
            value = headers[i];
            xmls:addElement(soapRequest, "/soapenv:Envelope/soapenv:Header", value, n);
            i = i+1;
        }
    }
    xml body = `<soapenv:Body xmlns:soapenv="${namespace}">
                    ${payload}
                </soapenv:Body>`;
    xmls:addElement(soapRequest, "/soapenv:Envelope", body, n);

    return soapRequest;
}
