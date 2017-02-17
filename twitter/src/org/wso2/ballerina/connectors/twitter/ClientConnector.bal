package org.wso2.ballerina.connectors.twitter;

import ballerina.lang.arrays;
import ballerina.lang.maps;
import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.lang.system;
import ballerina.net.http as http;
import ballerina.net.uri;
import ballerina.util;

@doc:Description("Twitter client connector.")
@doc:Param("consumerKey: The consumer key of the Twitter account.")
@doc:Param("consumerSecret: The consumer secret of the Twitter account.")
@doc:Param("accessToken: The access token of the Twitter account.")
@doc:Param("accessTokenSecret: The access token secret of the Twitter account.")
connector ClientConnector (string consumerKey, string consumerSecret, string accessToken, string accessTokenSecret) {

    http:ClientConnector tweeterEP = create http:ClientConnector("https://api.twitter.com");

    @doc:Description("Update the authenticated user's current status.")
    @doc:Param("status: The text of status update")
    @doc:Return("Response object.")
    action tweet(ClientConnector t, string status) (message) {
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

    @doc:Description("Retweet a tweet.")
    @doc:Param("id: The numerical ID of the desired status.")
    @doc:Return("Response object.")
    action retweet(ClientConnector t, string id) (message) {
        message request = {};
        map parameters = {};

        string tweetPath = "/1.1/statuses/retweet/" + id + ".json";
        constructRequestHeaders(request, "POST", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);

        message response = http:ClientConnector.post(tweeterEP, tweetPath, request);

        return response;
    }

    @doc:Description("Untweet a retweeted status.")
    @doc:Param("id: The numerical ID of the desired status.")
    @doc:Return("Response object.")
    action unretweet(ClientConnector t, string id) (message) {
        message request = {};
        map parameters = {};

        string tweetPath = "/1.1/statuses/unretweet/" + id + ".json";
        constructRequestHeaders(request, "POST", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);

        message response = http:ClientConnector.post(tweeterEP, tweetPath, request);

        return response;
    }

    @doc:Description("Search for tweets.")
    @doc:Param("query: Query string to retrieve the related tweets.")
    @doc:Return("Response object.")
    action search(ClientConnector t, string query) (message) {
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

    @doc:Description("Retrive a single status.")
    @doc:Param("id: The numerical ID of the desired status.")
    @doc:Return("Response object.")
    action showStatus(ClientConnector t, string id) (message) {
        string urlParams;
        message request = {};
        map parameters = {};

        string tweetPath = "/1.1/statuses/show.json";
        parameters["id"] = id;
        urlParams = "id=" + id;
        constructRequestHeaders(request, "GET", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);
        tweetPath = tweetPath + "?" + urlParams;

        message response = http:ClientConnector.get(tweeterEP, tweetPath, request);

        return response;
    }

    @doc:Description("Distroy a status.")
    @doc:Param("id: The numerical ID of the desired status.")
    @doc:Return("Response object.")
    action destroyStatus(ClientConnector t, string id) (message) {
        message request = {};
        map parameters = {};

        string tweetPath = "/1.1/statuses/destroy/" + id + ".json";
        constructRequestHeaders(request, "POST", tweetPath, consumerKey, consumerSecret, accessToken,
                            accessTokenSecret, parameters);

        message response = http:ClientConnector.post(tweeterEP, tweetPath, request);

        return response;
    }

    @doc:Description("Retrive closest trend locations.")
    @doc:Param("lat: Latitude of the location.")
    @doc:Param("long: Longitude of the location")
    @doc:Return("Response object.")
    action getClosestTrendLocations(ClientConnector t, string lat, string long) (message) {
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
        tweetPath = tweetPath + "?" + strings:subString(urlParams, 1, strings:length(urlParams));

        message response = http:ClientConnector.get(tweeterEP, tweetPath, request);

        return response;
    }

    @doc:Description("Retrive top trends by place.")
    @doc:Param("locationId: The Yahoo! Where On Earth ID of the location to return trending information for.")
    @doc:Return("Response object.")
    action getTopTrendsByPlace(ClientConnector t, string locationId) (message) {
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

    string timeStamp = strings:valueOf(system:epochTime());
    string nonceString = util:getRandomString();
    serviceEP = "https://api.twitter.com" + serviceEP;

    parameters["oauth_consumer_key"] = consumerKey;
    parameters["oauth_nonce"] = nonceString;
    parameters["oauth_signature_method"] = "HMAC-SHA1";
    parameters["oauth_timestamp"] = timeStamp;
    parameters["oauth_token"] = accessToken;
    parameters["oauth_version"] = "1.0";

    string[] parameterKeys = maps:keys(parameters);
    string[] sortedParameters = arrays:sort(parameterKeys);
    while (index < arrays:length(sortedParameters)){
        key =  sortedParameters[index];
        value = parameters[key];
        paramStr = paramStr + key + "=" + value + "&";
        index = index + 1;
    }
    paramStr = strings:subString(paramStr, 0, strings:length(paramStr)-1);
    string baseString = httpMethod + "&" + uri:encode(serviceEP) + "&" + uri:encode(paramStr);
    string keyStr = uri:encode(consumerSecret) + "&" + uri:encode(accessTokenSecret);
    string signature = util:getHmac(baseString, keyStr, "SHA1");
    string oauthHeaderString = "OAuth oauth_consumer_key=\"" + consumerKey +
                "\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"" + timeStamp +
                "\",oauth_nonce=\"" + nonceString + "\",oauth_version=\"1.0\",oauth_signature=\"" +
                uri:encode(signature) + "\",oauth_token=\"" + uri:encode(accessToken) + "\"";

    messages:setHeader(request, "Authorization", strings:unescape(oauthHeaderString));
}
