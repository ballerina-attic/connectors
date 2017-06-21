import org.wso2.ballerina.connectors.facebook;
import ballerina.lang.messages;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.test;

message response;
json facebookJSONResponse;
string postID = "XXXX";

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
    test:assertIntEquals(status, 200, "CreatePost Failed");
    system:println("===testCreatePost completed===\n");
}

function testRetrievePost () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.retrievePost (facebookConnector, postID, "message");
    facebookJSONResponse = messages:getJsonPayload(response);
    string msg = (string)facebookJSONResponse["message"];
    int status = http:getStatusCode(response);
    test:assertIntEquals(status, 200, "RetrievePost Failed");
    test:assertStringEquals(msg, "Test Message", "Invalid post");
    system:println("===testRetrievePost completed===\n");
}

function testUpdatePost () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.updatePost (facebookConnector, postID, "Updated Test Message", "", "");
    int status = http:getStatusCode(response);
    test:assertIntEquals(status, 200, "UpdatePost Failed");
    system:println("===testUpdatePost completed===\n");
}

function testAddLikes () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.addLikes (facebookConnector, postID);
    int status = http:getStatusCode(response);
    test:assertIntEquals(status, 200, "AddLikes Failed");
    system:println("===testAddLikes completed===\n");
}

function testGetLikes () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.getLikesDetails (facebookConnector, postID, "");
    int status = http:getStatusCode(response);
    test:assertIntEquals(status, 200, "GetLikes Failed");
    system:println("===testGetLikes completed===\n");
}

function testDeleteLikes () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.deleteLikes (facebookConnector, postID);
    int status = http:getStatusCode(response);
    test:assertIntEquals(status, 200, "DeleteLikes Failed");
    system:println("===testDeleteLikes completed===\n");
}

function testAddComments () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.addComments (facebookConnector, postID, "Comment123", "", "");
    int status = http:getStatusCode(response);
    test:assertIntEquals(status, 200, "AddComments Failed");
    system:println("===testAddComments completed===\n");
}

function testGetComments () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.getComments (facebookConnector, postID, "");
    int status = http:getStatusCode(response);
    test:assertIntEquals(status, 200, "GetComments Failed");
    system:println("===testGetComments completed===\n");
}

function testDeletePost () {
    facebook:ClientConnector facebookConnector = init();
    response = facebook:ClientConnector.deletePost (facebookConnector, postID);
    int status = http:getStatusCode(response);
    test:assertIntEquals(status, 200, "DeletePost Failed");
    system:println("===testDeletePost completed===\n");
}


