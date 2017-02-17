package org.wso2.ballerina.connectors.twitter;

import ballerina.lang.jsonutils;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {
    ClientConnector twitterConnector = create ClientConnector(args[1], args[2], args[3], args[4]);
    message tweetResponse;
    json tweetJSONResponse;
    if (args[0] == "tweet"){
        tweetResponse = ClientConnector.tweet(twitterConnector, args[5]);

        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "search"){
        tweetResponse = ClientConnector.search(twitterConnector, args[5]);

        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "retweet"){
        tweetResponse = ClientConnector.retweet(twitterConnector, args[5]);

        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "unretweet"){
        tweetResponse = ClientConnector.unretweet(twitterConnector, args[5]);

        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "showStatus"){
        tweetResponse = ClientConnector.showStatus(twitterConnector, args[5]);

        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "destroyStatus"){
        tweetResponse = ClientConnector.destroyStatus(twitterConnector, args[5]);

        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "getClosestTrendLocations"){
        tweetResponse = ClientConnector.getClosestTrendLocations(twitterConnector, args[5], args[6]);

        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "getTopTrendsByPlace"){
        tweetResponse = ClientConnector.getTopTrendsByPlace(twitterConnector, args[5]);

        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else{
        system:println("====== Update Status =====");
        tweetResponse = ClientConnector.tweet(twitterConnector, "Tweet messages");
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        string tweetId = jsonutils:getString(tweetJSONResponse, "$.id_str");
        system:println(jsonutils:toString(tweetJSONResponse));

        system:println("====== search =====");
        tweetResponse = ClientConnector.search(twitterConnector, "Tweet messages");
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));

        system:println("====== Retweet a tweet =====");
        tweetResponse = ClientConnector.retweet(twitterConnector, tweetId);
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));

        system:println("====== Untweet a retweeted status =====");
        tweetResponse = ClientConnector.unretweet(twitterConnector, tweetId);
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));

        system:println("====== Retrive a single status =====");
        tweetResponse = ClientConnector.showStatus(twitterConnector, tweetId);
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));

        system:println("====== Distroy a status =====");
        tweetResponse = ClientConnector.destroyStatus(twitterConnector, tweetId);
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));

        system:println("====== Retrive closest trend locations =====");
        tweetResponse = ClientConnector.getClosestTrendLocations(twitterConnector, "37.781157", "-122.400612831116");
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));

        system:println("====== Retrieve top trends by place =====");
        tweetResponse = ClientConnector.getTopTrendsByPlace(twitterConnector, "1");
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    }

}