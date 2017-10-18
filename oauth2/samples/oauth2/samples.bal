import org.wso2.ballerina.connectors.oauth2;

import ballerina.lang.jsons;
import ballerina.lang.system;
import ballerina.net.http;

function main (string[] args) {

    http:Request request = {};
    http:Response userProfileResponse;
    json userProfileJSONResponse;

    oauth2:ClientConnector clientConnector;

    if (args[0] == "get") {
        system:println("-----Calling get action-----");
        clientConnector = create oauth2:ClientConnector(args[1], args[2], args[3], args[4], args[5], args[6]);
        userProfileResponse = clientConnector.get(args[7], request);
        userProfileJSONResponse = userProfileResponse.getJsonPayload();
        system:println(jsons:toString(userProfileJSONResponse));
    }
}