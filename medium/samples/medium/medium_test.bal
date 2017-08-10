import org.wso2.ballerina.connectors.medium;
import ballerina.lang.system;
import ballerina.test;
import ballerina.net.http;

message mediumResponse;
string publicationId = "XXXXX";
string userId = "XXXXX";


function init () (medium:ClientConnector){

    string accessToken = system:getEnv("MEDIUM_ACCESS_TOKEN");
    string refreshToken = system:getEnv("MEDIUM_REFRESH_TOKEN");
    string clientId = system:getEnv("MEDIUM_CLIENT_ID");
    string clientSecret = system:getEnv("MEDIUM_CLIENT_SECRET");
    medium:ClientConnector mediumConnector = create medium:ClientConnector(accessToken, clientId, clientSecret, refreshToken);
    return mediumConnector;

}

function testGetProfileInfo () {
    medium:ClientConnector mediumConnector = init();
    mediumResponse = mediumConnector.getProfileInfo ();
    int status = http:getStatusCode(mediumResponse);
    test:assertIntEquals(status, 200, "GetProfileInfo Failed");
    system:println("===testGetProfileInfo completed===\n");
}

function testGetContributors () {
    medium:ClientConnector mediumConnector = init();
    mediumResponse = mediumConnector.getContributors (publicationId);
    int status = http:getStatusCode(mediumResponse);
    test:assertIntEquals(status, 200, "GetContributors Failed");
    system:println("===testGetContributors completed===\n");
}

function testGetPublications () {
    medium:ClientConnector mediumConnector = init();
    mediumResponse = mediumConnector.getPublications (userId);
    int status = http:getStatusCode(mediumResponse);
    test:assertIntEquals(status, 200, "GetPublications Failed");
    system:println("===testGetPublications skipped===\n");
}

function testCreateProfilePost () {
    medium:ClientConnector mediumConnector = init();
    json payload = {"title":"Test Payload", "contentFormat":"html", "content":"<h1>Test Payload</h1><p>This is a sample post</p>", "canonicalUrl":"http://wso2.com", "tags":["sample", "test"], "publishStatus":"draft"};
    mediumResponse = mediumConnector.createProfilePost (userId, payload);
    int status = http:getStatusCode(mediumResponse);
    test:assertIntEquals(status, 201, "CreateProfilePost Failed");
    system:println("===testCreateProfilePost completed===\n");
}

function testCreatePublicationPost () {
    medium:ClientConnector mediumConnector = init();
    json payload = {"title":"Test Payload", "contentFormat":"html", "content":"<h1>Test Payload</h1><p>This is a publication post</p>", "canonicalUrl":"http://wso2.com", "tags":["sample", "test"], "publishStatus":"unlisted"};
    mediumResponse = mediumConnector.createPublicationPost (publicationId, payload);
    int status = http:getStatusCode(mediumResponse);
    test:assertIntEquals(status, 201, "CreatePublicationPost Failed");
    system:println("===testCreatePublicationPost completed===\n");
}

