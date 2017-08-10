import org.wso2.ballerina.connectors.facebook;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    facebook:ClientConnector facebookConnector = create facebook:ClientConnector(args[1]);

    message facebookResponse = {};
    json facebookJSONResponse;
    if (args[0] == "createPost") {
        facebookResponse = facebookConnector.createPost (args[2], args[3], args[4], args[5]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "retrievePost") {
        facebookResponse = facebookConnector.retrievePost (args[2], args[3]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "deletePost") {
        facebookResponse = facebookConnector.deletePost (args[2]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "updatePost") {
        facebookResponse = facebookConnector.updatePost (args[2], args[3], args[4], args[5]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "addLikes") {
        facebookResponse = facebookConnector.addLikes (args[2]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "getLikesDetails") {
        facebookResponse = facebookConnector.getLikesDetails (args[2], args[3]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "deleteLikes") {
        facebookResponse = facebookConnector.deleteLikes (args[2]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "addComments") {
        facebookResponse = facebookConnector.addComments (args[2], args[3], args[4], args[5]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "getComments") {
        facebookResponse = facebookConnector.getComments (args[2], args[3]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    }
}
