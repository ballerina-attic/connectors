import ballerina.lang.system;
import ballerina.lang.messages;
import ballerina.net.http;
import ballerina.lang.jsons;
import org.wso2.ballerina.connectors.twitter;
import ballerina.test;

string tweetId;

function init () (twitter:ClientConnector) {
    string consumerKey = system:getEnv("CONSUMER_KEY");
    string consumerSecret = system:getEnv("CONSUMER_SECRET");
    string accessToken = system:getEnv("ACCESS_TOKEN");
    string accessTokenSecret = system:getEnv("ACCESS_TOKEN_SECRET");
    twitter:ClientConnector twitterConnector = create twitter:ClientConnector(consumerKey, consumerSecret, accessToken, accessTokenSecret);
    return twitterConnector;

}


function testTweet () {
    twitter:ClientConnector twitterConnector = init();
    message response = twitter:ClientConnector.tweet (twitterConnector, "#ballerina");
    json jsonResponse = messages:getJsonPayload(response);
    int status = http:getStatusCode(response);
    string value = jsons:getString(jsonResponse, "text");
    tweetId = jsons:getString(jsonResponse, "id_str");
    system:println("TweetID------- - " + tweetId);
    test:assertEquals(status, 200);
    test:assertEquals(value, "#ballerina");
    system:println("===testTweet completed===");

}


function testSearch () {
    twitter:ClientConnector twitterConnector = init();
    message response = twitter:ClientConnector.search (twitterConnector, "#ballerina");
    int status = http:getStatusCode(response);
    test:assertEquals(status, 200);
    system:println("===testSearch completed===");
}


function testRetweet () {
    twitter:ClientConnector twitterConnector = init();
    message response = twitter:ClientConnector.retweet (twitterConnector, "XXXXXX");
    int status = http:getStatusCode(response);
    test:assertEquals(status, 200);
    system:println("===testRetweet completed===");
}


function testUnretweet () {
    twitter:ClientConnector twitterConnector = init();
    message response = twitter:ClientConnector.unretweet (twitterConnector, "XXXXXX");
    json jsonResponse = messages:getJsonPayload(response);
    int status = http:getStatusCode(response);
    string value = jsons:getString(jsonResponse, "text");
    test:assertEquals(status, 200);
    test:assertEquals(value, "#ballerina");
    system:println("===testUnRetweet completed===");
}


function testShowStatus () {
    twitter:ClientConnector twitterConnector = init();
    message response = twitter:ClientConnector.showStatus (twitterConnector, "XXXXX");
    json jsonResponse = messages:getJsonPayload(response);
    int status = http:getStatusCode(response);
    string value = jsons:getString(jsonResponse, "text");
    test:assertEquals(status, 200);
    test:assertEquals(value, "#ballerina");
    system:println("===testShowStatus completed===");
}


function testDestroyStatus () {
    twitter:ClientConnector twitterConnector = init();
    message response = twitter:ClientConnector.destroyStatus (twitterConnector, "XXXXX");
    json jsonResponse = messages:getJsonPayload(response);
    int status = http:getStatusCode(response);
    string value = jsons:getString(jsonResponse, "text");
    test:assertEquals(status, 200);
    test:assertEquals(value, "#ballerina");
    system:println("===testDestroyStatus completed===");
}


