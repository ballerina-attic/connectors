import org.wso2.ballerina.connectors.twitter;

import ballerina.lang.jsons;
import ballerina.lang.system;
import ballerina.net.http;

function main (string[] args) {

    twitter:ClientConnector twitterConnector = create twitter:ClientConnector(args[1], args[2], args[3], args[4]);

    http:Response tweetResponse;
    json tweetJSONResponse;
    if (args[0] == "tweet") {
        tweetResponse = twitterConnector.tweet (args[5]);

        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));
    } else if (args[0] == "search") {
        tweetResponse = twitterConnector.search (args[5]);

        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));
    } else if (args[0] == "retweet") {
        tweetResponse = twitterConnector.retweet (args[5]);

        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));
    } else if (args[0] == "unretweet") {
        tweetResponse = twitterConnector.unretweet (args[5]);

        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));
    } else if (args[0] == "showStatus") {
        tweetResponse = twitterConnector.showStatus (args[5]);

        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));
    } else if (args[0] == "destroyStatus") {
        tweetResponse = twitterConnector.destroyStatus (args[5]);

        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));
    } else if (args[0] == "getClosestTrendLocations") {
        tweetResponse = twitterConnector.getClosestTrendLocations (args[5], args[6]);

        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));
    } else if (args[0] == "getTopTrendsByPlace") {
        tweetResponse = twitterConnector.getTopTrendsByPlace (args[5]);

        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));
    } else {
        system:println("====== Update Status =====");
        tweetResponse = twitterConnector.tweet ("Tweet messages");
        tweetJSONResponse = tweetResponse.getJsonPayload();
        string tweetId;
        tweetId, _ = (string)tweetJSONResponse["$.id_str"];
        system:println(jsons:toString(tweetJSONResponse));

        system:println("====== search =====");
        tweetResponse = twitterConnector.search ("Tweet messages");
        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));

        system:println("====== Retweet a tweet =====");
        tweetResponse = twitterConnector.retweet (tweetId);
        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));

        system:println("====== Untweet a retweeted status =====");
        tweetResponse = twitterConnector.unretweet (tweetId);
        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));

        system:println("====== Retrive a single status =====");
        tweetResponse = twitterConnector.showStatus (tweetId);
        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));

        system:println("====== Distroy a status =====");
        tweetResponse = twitterConnector.destroyStatus (tweetId);
        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));

        system:println("====== Retrive closest trend locations =====");
        tweetResponse = twitterConnector.getClosestTrendLocations ("37.781157", "-122.400612831116");
        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));

        system:println("====== Retrieve top trends by place =====");
        tweetResponse = twitterConnector.getTopTrendsByPlace ("1");
        tweetJSONResponse = tweetResponse.getJsonPayload();
        system:println(jsons:toString(tweetJSONResponse));
    }
}