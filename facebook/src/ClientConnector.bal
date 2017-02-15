package org.wso2.ballerina.connectors.facebook;

import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.string;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.net.uri;

@doc:Description("Facebook client connector.")
@doc:Param("token: Value of the valid access_token.")
connector ClientConnector (string token) {

    http:ClientConnector facebookEP = create http:ClientConnector("https://graph.facebook.com");

    @doc:Description("Create a post for user, page, event or group. ")
    @doc:Param("id: The identifier.")
    @doc:Param("msg: The main body of the post.")
    @doc:Param("link: The URL of a link to attach to the post.")
    @doc:Param("place: Page ID of a location associated with this post.")
    @doc:Return("Response object.")
    action createPost(ClientConnector f, string id, string msg, string link, string place) (message) {
        string uriParams;
        message request = {};
        string facebookPath = "/v2.8/" + id + "/feed";

        if(msg != "null"){
            uriParams = uriParams + "&message=" + uri:encode(msg);
        }
        if(link != "null"){
            uriParams = uriParams + "&link=" + uri:encode(link);
        }
        if(place != "null"){
            uriParams = uriParams + "&place=" + uri:encode(place);
        }
        facebookPath = facebookPath + "?" + string:subString(uriParams, 1, string:length(uriParams));

        message:setHeader(request, "Authorization", "Bearer " + token);

        message response = http:ClientConnector.post(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description("Retrieve a post.")
    @doc:Param("postId: The post ID.")
    @doc:Param("fields: The fields to retrieve which belongs to an object.")
    @doc:Return("Response object.")
    action retrievePost(ClientConnector f, string postId, string fields) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + postId;

        if(fields != "null"){
            facebookPath = facebookPath + "?fields=" + fields;
        }

        message:setHeader(request, "Authorization", "Bearer " + token);

        message response = http:ClientConnector.get(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description("Delete a post.")
    @doc:Param("postId: The post ID.")
    @doc:Return("Response object.")
    action deletePost(ClientConnector f, string postId) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + postId;

        message:setHeader(request, "Authorization", "Bearer " + token);

        message response = http:ClientConnector.delete(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description("Update a post.")
    @doc:Param("postId: The post ID.")
    @doc:Param("msg: The main body of the post.")
    @doc:Param("tags: Comma-separated list of user IDs of people tagged in this post.")
    @doc:Param("privacy: Privacy settings of the post.")
    @doc:Return("Response object")
    action updatePost(ClientConnector f, string postId, string msg, string tags, string privacy) (message) {
        string uriParams;
        message request = {};
        string facebookPath = "/v2.8/" + postId;

        if(msg != "null"){
            uriParams = uriParams + "&message=" + uri:encode(msg);
        }
        if(tags != "null"){
            uriParams = uriParams + "&tags=" + uri:encode(tags);
        }
        if(privacy != "null"){
            uriParams = uriParams + "&privacy=" + uri:encode(privacy);
        }
        facebookPath = facebookPath + "?" + string:subString(uriParams, 1, string:length(uriParams));

        message:setHeader(request, "Authorization", "Bearer " + token);

        message response = http:ClientConnector.post(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description("Add likes.")
    @doc:Param("objectId: The object ID to add like.")
    @doc:Return("Response object")
    action addLikes(ClientConnector f, string objectId) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + objectId + "/likes";

        message:setHeader(request, "Authorization", "Bearer " + token);

        message response = http:ClientConnector.post(facebookEP, facebookPath, request);

        return response;

    }

    @doc:Description("Get like details.")
    @doc:Param("objectId: The object ID to get the like details.")
    @doc:Param("fields: The fields to retrieve.")
    @doc:Return("Response object.")
    action getLikesDetails(ClientConnector f, string objectId, string fields) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + objectId + "/likes";

        if(fields != "null"){
            facebookPath = facebookPath + "?fields=" + fields;
        }

        message:setHeader(request, "Authorization", "Bearer " + token);

        message response = http:ClientConnector.get(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description("Delete likes.")
    @doc:Param("objectId: The object ID to remove the likes.")
    @doc:Return("Response object.")
    action deleteLikes(ClientConnector f, string objectId) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + objectId + "/likes";

        message:setHeader(request, "Authorization", "Bearer " + token);

        message response = http:ClientConnector.delete(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description("Add comments")
    @doc:Param("objectId: The ID of the object such as a page, video, etc.")
    @doc:Param("msg: The comment text.")
    @doc:Param("attachmentId: An ID of an unpublished photo.")
    @doc:Param("attachmentUrl: The URL of an image to include as a photo comment.")
    @doc:Return("Response object.")
    action addComments(ClientConnector f, string objectId, string msg, string attachmentId, string attachmentUrl) (message) {
        string uriParams;
        message request = {};
        string facebookPath = "/v2.8/" + objectId + "/comments";

        if(msg != "null"){
            uriParams = uriParams + "&message=" + msg;
        }
        if(attachmentId != "null"){
            uriParams = uriParams + "&attachment_id=" + attachmentId;
        }
        if(attachmentUrl != "null"){
            uriParams = uriParams + "&attachment_url=" + attachmentUrl;
        }
        facebookPath = facebookPath + "?" + string:subString(uriParams, 1, string:length(uriParams));
        message:setHeader(request, "Authorization", "Bearer " + token);

        message response = http:ClientConnector.post(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description("Get comments.")
    @doc:Param("objectId: The ID of the object such as a page, video, etc.")
    @doc:Param("fields: The fields to retrieve.")
    @doc:Return("Response object.")
    action getComments(ClientConnector f, string objectId, string fields) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + objectId + "/comments";

        if(fields != "null"){
            facebookPath = facebookPath + "?fields=" + fields;
        }
        message:setHeader(request, "Authorization", "Bearer " + token);

        message response = http:ClientConnector.get(facebookEP, facebookPath, request);

        return response;
    }

}

function main (string[] args) {
    ClientConnector facebookConnector = create ClientConnector(args[1]);
    message facebookResponse = {};
    json facebookJSONResponse;

    if (args[0] == "createPost"){
        facebookResponse = ClientConnector.createPost(facebookConnector, args[2], args[3], args[4], args[5]);

        facebookJSONResponse = message:getJsonPayload(facebookResponse);
        system:println(json:toString(facebookJSONResponse));
    }

    if (args[0] == "retrievePost"){
        facebookResponse = ClientConnector.retrievePost(facebookConnector, args[2], args[3]);

        facebookJSONResponse = message:getJsonPayload(facebookResponse);
        system:println(json:toString(facebookJSONResponse));
    }

    if (args[0] == "deletePost"){
        facebookResponse = ClientConnector.deletePost(facebookConnector, args[2]);

        facebookJSONResponse = message:getJsonPayload(facebookResponse);
        system:println(json:toString(facebookJSONResponse));
    }

    if (args[0] == "updatePost"){
        facebookResponse = ClientConnector.updatePost(facebookConnector, args[2], args[3], args[4], args[5]);

        facebookJSONResponse = message:getJsonPayload(facebookResponse);
        system:println(json:toString(facebookJSONResponse));
    }

    if (args[0] == "addLikes"){
        facebookResponse = ClientConnector.addLikes(facebookConnector, args[2]);

        facebookJSONResponse = message:getJsonPayload(facebookResponse);
        system:println(json:toString(facebookJSONResponse));
    }

    if (args[0] == "getLikesDetails"){
        facebookResponse = ClientConnector.getLikesDetails(facebookConnector, args[2], args[3]);

        facebookJSONResponse = message:getJsonPayload(facebookResponse);
        system:println(json:toString(facebookJSONResponse));
    }

    if (args[0] == "deleteLikes"){
        facebookResponse = ClientConnector.deleteLikes(facebookConnector, args[2]);

        facebookJSONResponse = message:getJsonPayload(facebookResponse);
        system:println(json:toString(facebookJSONResponse));
    }

    if (args[0] == "addComments"){
        facebookResponse = ClientConnector.addComments(facebookConnector, args[2], args[3], args[4], args[5]);

        facebookJSONResponse = message:getJsonPayload(facebookResponse);
        system:println(json:toString(facebookJSONResponse));
    }

    if (args[0] == "getComments"){
        facebookResponse = ClientConnector.getComments(facebookConnector, args[2], args[3]);

        facebookJSONResponse = message:getJsonPayload(facebookResponse);
        system:println(json:toString(facebookJSONResponse));
    }
}
