import org.wso2.ballerina.connectors.basicauth;

import ballerina.lang.jsonutils;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    message request = {};
    message basicAuthResponse;
    json basicJSONResponse;

    json sampleJsonRequest = `{"ticket_field":{ "type": "text", "title": "SampleTicket"}}`;

    basicauth:ClientConnector basicAuthConnector = create basicauth:ClientConnector(args[1], args[2]);

    if (args[0] == "get"){
        basicAuthResponse = basicauth:ClientConnector.get(basicAuthConnector, args[3], request);
        basicJSONResponse = messages:getJsonPayload(basicAuthResponse);
        system:println(jsonutils:toString(basicJSONResponse));
    }

    if (args[0] == "post"){
        messages:setHeader(request, "Content-Type", "application/json");
        messages:setJsonPayload(request, sampleJsonRequest);
        basicAuthResponse = basicauth:ClientConnector.post(basicAuthConnector, args[3], request);
        basicJSONResponse = messages:getJsonPayload(basicAuthResponse);
        system:println(jsonutils:toString(basicJSONResponse));
    }
}
