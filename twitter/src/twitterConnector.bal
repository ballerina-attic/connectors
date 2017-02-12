package org.wso2.ballerina.connectors.twitter;

import ballerina.lang.array;
import ballerina.lang.json;
import ballerina.lang.map;
import ballerina.lang.message;
import ballerina.lang.string;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.net.uri;
import ballerina.util;

connector Twitter (string consumerKey, string consumerSecret, string accessToken, string accessTokenSecret) {

    http:ClientConnector tweeterEP = create http:ClientConnector("https://api.twitter.com");

    action tweet(Twitter t, string status) (message) {
        message request = {};
        map parameters = {};
        string urlParams;
        string tweetPath = "/1.1/statuses/update.json";
        status = uri:encode(status);
        parameters["status"] = status;
        urlParams = "status=" + status;

        constructRequestHeaders(request, "POST", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);
        tweetPath = tweetPath + "?" + urlParams;

        message response = http:ClientConnector.post(tweeterEP, tweetPath, request);

        return response;
    }

    action reTweet(Twitter t, string tweetId) (message) {
        message request = {};
        map parameters = {};

        string tweetPath = "/1.1/statuses/retweet/" + tweetId + ".json";
        constructRequestHeaders(request, "POST", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);

        message response = http:ClientConnector.post(tweeterEP, tweetPath, request);

        return response;
    }

    action unReTweet(Twitter t, string tweetId) (message) {
        message request = {};
        map parameters = {};

        string tweetPath = "/1.1/statuses/unretweet/" + tweetId + ".json";
        constructRequestHeaders(request, "POST", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);

        message response = http:ClientConnector.post(tweeterEP, tweetPath, request);

        return response;
    }

    action search(Twitter t, string query) (message) {
        message request = {};
        map parameters = {};
        string urlParams;
        string tweetPath = "/1.1/search/tweets.json";
        query = uri:encode(query);
        parameters["q"] = query;
        urlParams = "q=" + query;
        constructRequestHeaders(request, "GET", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);
        tweetPath = tweetPath + "?" + urlParams;

        message response = http:ClientConnector.get(tweeterEP, tweetPath, request);

        return response;
    }

    action showStatus(Twitter t, string tweetId) (message) {
        string urlParams;
        message request = {};
        map parameters = {};

        string tweetPath = "/1.1/statuses/show.json";
        parameters["id"] = tweetId;
        urlParams = "id=" + tweetId;
        constructRequestHeaders(request, "GET", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);
        tweetPath = tweetPath + "?" + urlParams;

        message response = http:ClientConnector.get(tweeterEP, tweetPath, request);

        return response;
    }

    action destroyStatus(Twitter t, string tweetId) (message) {
        message request = {};
        map parameters = {};

        string tweetPath = "/1.1/statuses/destroy/" + tweetId + ".json";
        constructRequestHeaders(request, "POST", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);

        message response = http:ClientConnector.post(tweeterEP, tweetPath, request);

        return response;
    }

    action getClosestTrendLocations(Twitter t, string lat, string long) (message) {
        string urlParams;
        message request = {};
        map parameters = {};

        string tweetPath = "/1.1/trends/closest.json";
        parameters["lat"] = lat;
        urlParams = urlParams + "&lat=" + lat;
        parameters["long"] = long;
        urlParams = urlParams + "&long=" + long;
        constructRequestHeaders(request, "GET", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);
        tweetPath = tweetPath + "?" + string:subString(urlParams, 1, string:length(urlParams));

        message response = http:ClientConnector.get(tweeterEP, tweetPath, request);

        return response;
    }

    action getTopTrendsByPlace(Twitter t, string locationId) (message) {
        string urlParams;
        message request = {};
        map parameters = {};

        string tweetPath = "/1.1/trends/place.json";
        parameters["id"] = locationId;
        urlParams = "id=" + locationId;
        constructRequestHeaders(request, "GET", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);
        tweetPath = tweetPath + "?" + urlParams;

        message response = http:ClientConnector.get(tweeterEP, tweetPath, request);

        return response;
    }
}

function constructRequestHeaders(message request, string httpMethod, string serviceEP, string consumerKey,
                            string consumerSecret, string accessToken, string accessTokenSecret, map parameters) {
    int index;
    string paramStr;
    string key;
    string value;

    string timeStamp = string:valueOf(system:epochTime());
    string nonceString = util:getRandomString();
    serviceEP = "https://api.twitter.com" + serviceEP;

    parameters["oauth_consumer_key"] = consumerKey;
    parameters["oauth_nonce"] = nonceString;
    parameters["oauth_signature_method"] = "HMAC-SHA1";
    parameters["oauth_timestamp"] = timeStamp;
    parameters["oauth_token"] = accessToken;
    parameters["oauth_version"] = "1.0";

    string[] parameterKeys = map:keys(parameters);
    string[] sortedParameters = array:sort(parameterKeys);
    while (index < array:length(sortedParameters)){
        key =  sortedParameters[index];
        value = parameters[key];
        paramStr = paramStr + key + "=" + value + "&";
        index = index + 1;
    }
    paramStr = string:subString(paramStr, 0, string:length(paramStr)-1);
    string baseString = httpMethod + "&" + uri:encode(serviceEP) + "&" + uri:encode(paramStr);
    string keyStr = uri:encode(consumerSecret) + "&" + uri:encode(accessTokenSecret);
    string signature = util:getHmac(baseString, keyStr, "SHA1");
    string oauthHeaderString = "OAuth oauth_consumer_key=\"" + consumerKey +
                "\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"" + timeStamp +
                "\",oauth_nonce=\"" + nonceString + "\",oauth_version=\"1.0\",oauth_signature=\"" +
                uri:encode(signature) + "\",oauth_token=\"" + uri:encode(accessToken) + "\"";

    message:setHeader(request, "Authorization", string:unescape(oauthHeaderString));
}

function main (string[] args) {

    Twitter twitterConnector = create Twitter(args[1], args[2], args[3], args[4]);
    message tweetResponse;
    json tweetJSONResponse;

    if (args[0] == "tweet"){
        tweetResponse = Twitter.tweet(twitterConnector, args[5]);

        tweetJSONResponse = message:getJsonPayload(tweetResponse);
        system:println(json:toString(tweetJSONResponse));
    }

    if (args[0] == "search"){
        tweetResponse = Twitter.search(twitterConnector, args[5]);

        tweetJSONResponse = message:getJsonPayload(tweetResponse);
        system:println(json:toString(tweetJSONResponse));
    }

    if (args[0] == "reTweet"){
        tweetResponse = Twitter.reTweet(twitterConnector, args[5]);

        tweetJSONResponse = message:getJsonPayload(tweetResponse);
        system:println(json:toString(tweetJSONResponse));
    }

    if (args[0] == "unReTweet"){
        tweetResponse = Twitter.unReTweet(twitterConnector, args[5]);

        tweetJSONResponse = message:getJsonPayload(tweetResponse);
        system:println(json:toString(tweetJSONResponse));
    }

    if (args[0] == "showStatus"){
        tweetResponse = Twitter.showStatus(twitterConnector, args[5]);

        tweetJSONResponse = message:getJsonPayload(tweetResponse);
        system:println(json:toString(tweetJSONResponse));
    }

    if (args[0] == "destroyStatus"){
        tweetResponse = Twitter.destroyStatus(twitterConnector, args[5]);

        tweetJSONResponse = message:getJsonPayload(tweetResponse);
        system:println(json:toString(tweetJSONResponse));
    }

    if (args[0] == "getClosestTrendLocations"){
        tweetResponse = Twitter.getClosestTrendLocations(twitterConnector, args[5], args[6]);

        tweetJSONResponse = message:getJsonPayload(tweetResponse);
        system:println(json:toString(tweetJSONResponse));
    }

    if (args[0] == "getTopTrendsByPlace"){
        tweetResponse = Twitter.getTopTrendsByPlace(twitterConnector, args[5]);

        tweetJSONResponse = message:getJsonPayload(tweetResponse);
        system:println(json:toString(tweetJSONResponse));
    }
}