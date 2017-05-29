import org.wso2.ballerina.connectors.facebook;
import ballerina.lang.messages;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.test;

message response;
json facebookJSONResponse;
string postID = "XXXXX";

function init () (facebook:ClientConnector){
    string accessToken = system:getEnv("FB_ACCESS_TOKEN");
    facebook:ClientConnector facebookConnector = create facebook:ClientConnector(accessToken);
    return facebookConnector;
}

function testCreatePost () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.createPost (facebookConnector, "me", "Test Message", "", "");
    facebookJSONResponse = messages:getJsonPayload(response);
    system:println(facebookJSONResponse);
    int status = http:getStatusCode(response);
    test:assertEquals(status, 200);
    system:println("===testCreatePost completed===\n");
}

function testRetrievePost () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.retrievePost (facebookConnector, postID, "message");
    facebookJSONResponse = messages:getJsonPayload(response);
    string msg = (string)facebookJSONResponse["message"];
    int status = http:getStatusCode(response);
    test:assertEquals(status, 200);
    test:assertEquals(msg, "Test Message");
    system:println("===testRetrievePost completed===\n");
}

function testUpdatePost () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.updatePost (facebookConnector, postID, "Updated Test Message", "", "");
    int status = http:getStatusCode(response);
    test:assertEquals(status, 200);
    system:println("===testUpdatePost completed===\n");
}

function testAddLikes () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.addLikes (facebookConnector, postID);
    int status = http:getStatusCode(response);
    test:assertEquals(status, 200);
    system:println("===testAddLikes completed===\n");
}

function testGetLikes () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.getLikesDetails (facebookConnector, postID, "");
    int status = http:getStatusCode(response);
    test:assertEquals(status, 200);
    system:println("===testGetLikes completed===\n");
}

function testDeleteLikes () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.deleteLikes (facebookConnector, postID);
    int status = http:getStatusCode(response);
    test:assertEquals(status, 200);
    system:println("===testDeleteLikes completed===\n");
}

function testAddComments () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.addComments (facebookConnector, postID, "Comment123", "", "");
    int status = http:getStatusCode(response);
    test:assertEquals(status, 200);
    system:println("===testAddComments completed===\n");
}

function testGetComments () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.getComments (facebookConnector, postID, "");
    int status = http:getStatusCode(response);
    test:assertEquals(status, 200);
    system:println("===testGetComments completed===\n");
}

function testDeletePost () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.deletePost (facebookConnector, postID);
    int status = http:getStatusCode(response);
    test:assertEquals(status, 200);
    system:println("===testDeletePost completed===\n");
}


