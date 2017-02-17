import org.wso2.ballerina.connectors.twitter;

import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.system;

function main (string[] args) {

    twitter:ClientConnector twitterConnector = create twitter:ClientConnector(args[1], args[2], args[3], args[4]);
    
    message tweetResponse;
    json tweetJSONResponse;
    if (args[0] == "tweet"){
        tweetResponse = twitter:ClientConnectortweet(twitterConnector, args[5]);
        
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "search"){
        tweetResponse = twitter:ClientConnectorsearch(twitterConnector, args[5]);
        
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "retweet"){
        tweetResponse = twitter:ClientConnectorretweet(twitterConnector, args[5]);
        
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "unretweet"){
        tweetResponse = twitter:ClientConnectorunretweet(twitterConnector, args[5]);
        
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "showStatus"){
        tweetResponse = twitter:ClientConnectorshowStatus(twitterConnector, args[5]);
        
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "destroyStatus"){
        tweetResponse = twitter:ClientConnectordestroyStatus(twitterConnector, args[5]);
        
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "getClosestTrendLocations"){
        tweetResponse = twitter:ClientConnectorgetClosestTrendLocations(twitterConnector, args[5], args[6]);
        
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else if (args[0] == "getTopTrendsByPlace"){
        tweetResponse = twitter:ClientConnectorgetTopTrendsByPlace(twitterConnector, args[5]);
        
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    } else{
    system:println("====== Update Status =====");
        tweetResponse = twitter:ClientConnectortweet(twitterConnector, "Tweet messages");
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        string tweetId = jsonutils:getString(tweetJSONResponse, "$.id_str");
        system:println(jsonutils:toString(tweetJSONResponse));
        
        system:println("====== search =====");
        tweetResponse = twitter:ClientConnectorsearch(twitterConnector, "Tweet messages");
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
        
        system:println("====== Retweet a tweet =====");
        tweetResponse = twitter:ClientConnectorretweet(twitterConnector, tweetId);
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
        
        system:println("====== Untweet a retweeted status =====");
        tweetResponse = twitter:ClientConnectorunretweet(twitterConnector, tweetId);
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
        
        system:println("====== Retrive a single status =====");
        tweetResponse = twitter:ClientConnectorshowStatus(twitterConnector, tweetId);
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
        
        system:println("====== Distroy a status =====");
        tweetResponse = twitter:ClientConnectordestroyStatus(twitterConnector, tweetId);
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
        
        system:println("====== Retrive closest trend locations =====");
        tweetResponse = twitter:ClientConnectorgetClosestTrendLocations(twitterConnector, "37.781157", "-122.400612831116");
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
        
        system:println("====== Retrieve top trends by place =====");
        tweetResponse = twitter:ClientConnectorgetTopTrendsByPlace(twitterConnector, "1");
        tweetJSONResponse = messages:getJsonPayload(tweetResponse);
        system:println(jsonutils:toString(tweetJSONResponse));
    }
}