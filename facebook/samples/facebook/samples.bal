package samples.facebook;

import org.ballerinalang.connectors.facebook;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    facebook:ClientConnector facebookConnector = create facebook:ClientConnector(args[1]);
    
    message facebookResponse = {};
    json facebookJSONResponse;
    if (args[0] == "createPost"){
        facebookResponse = facebook:ClientConnector.createPost(facebookConnector, args[2], args[3], args[4], args[5]);
    
        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "retrievePost"){
        facebookResponse = facebook:ClientConnector.retrievePost(facebookConnector, args[2], args[3]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "deletePost"){
        facebookResponse = facebook:ClientConnector.deletePost(facebookConnector, args[2]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "updatePost"){
        facebookResponse = facebook:ClientConnector.updatePost(facebookConnector, args[2], args[3], args[4], args[5]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "addLikes"){
        facebookResponse = facebook:ClientConnector.addLikes(facebookConnector, args[2]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "getLikesDetails"){
        facebookResponse = facebook:ClientConnector.getLikesDetails(facebookConnector, args[2], args[3]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "deleteLikes"){
        facebookResponse = facebook:ClientConnector.deleteLikes(facebookConnector, args[2]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "addComments"){
        facebookResponse = facebook:ClientConnector.addComments(facebookConnector, args[2], args[3], args[4], args[5]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    } else if (args[0] == "getComments"){
        facebookResponse = facebook:ClientConnector.getComments(facebookConnector, args[2], args[3]);

        facebookJSONResponse = messages:getJsonPayload(facebookResponse);
        system:println(jsons:toString(facebookJSONResponse));
    }
}