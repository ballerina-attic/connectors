import org.wso2.ballerina.connectors.oauth2;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    message request = {};
    message userProfileResponse;
    json userProfileJSONResponse;

    oauth2:ClientConnector clientConnector = create oauth2:ClientConnector(args[1], args[2], args[3], args[4], args[5], args[6]);

    if (args[0] == "get"){
        userProfileResponse = oauth2:ClientConnector.get(clientConnector, args[7], request);
        userProfileJSONResponse = messages:getJsonPayload(userProfileResponse);
        system:println(jsons:toString(userProfileJSONResponse));
    }
}
