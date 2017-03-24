package org.wso2.ballerina.connectors.facebook;

import ballerina.doc;
import ballerina.lang.strings;
import ballerina.net.uri;

import org.wso2.ballerina.connectors.oauth2;

@doc:Description{ value : "Facebook client connector."}
@doc:Param{ value : "accessToken: Value of the valid access_token."}
connector ClientConnector (string accessToken) {

    string baseURL = "https://graph.facebook.com";

    oauth2:ClientConnector facebookEP = create oauth2:ClientConnector(baseURL, accessToken, "null", "null",
                                        "null", "null");
    @doc:Description{ value : "Create a post for user, page, event or group. "}
    @doc:Param{ value : "f: The facebook Connector instance"}
    @doc:Param{ value : "id: The identifier."}
    @doc:Param{ value : "msg: The main body of the post."}
    @doc:Param{ value : "link: The URL of a link to attach to the post."}
    @doc:Param{ value : "place: Page ID of a location associated with this post."}
    @doc:Return{ value : "Response object."}
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
        facebookPath = facebookPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
                                                                                                  
        message response = oauth2:ClientConnector.post(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description{ value : "Retrieve a post."}
    @doc:Param{ value : "f: The facebook Connector instance"}
    @doc:Param{ value : "postId: The post ID."}
    @doc:Param{ value : "fields: The fields to retrieve which belongs to an object."}
    @doc:Return{ value : "Response object."}
    action retrievePost(ClientConnector f, string postId, string fields) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + postId;

        if(fields != "null"){
            facebookPath = facebookPath + "?fields=" + fields;
        }

        message response = oauth2:ClientConnector.get(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description{ value : "Delete a post."}
    @doc:Param{ value : "f: The facebook Connector instance"}
    @doc:Param{ value : "postId: The post ID."}
    @doc:Return{ value : "Response object."}
    action deletePost(ClientConnector f, string postId) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + postId;

        message response = oauth2:ClientConnector.delete(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description{ value : "Update a post."}
    @doc:Param{ value : "f: The facebook Connector instance"}
    @doc:Param{ value : "postId: The post ID."}
    @doc:Param{ value : "msg: The main body of the post."}
    @doc:Param{ value : "tags: Comma-separated list of user IDs of people tagged in this post."}
    @doc:Param{ value : "privacy: Privacy settings of the post."}
    @doc:Return{ value : "Response object"}
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
        facebookPath = facebookPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));

        message response = oauth2:ClientConnector.post(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description{ value : "Add likes."}
    @doc:Param{ value : "f: The facebook Connector instance"}
    @doc:Param{ value : "objectId: The object ID to add like."}
    @doc:Return{ value : "Response object"}
    action addLikes(ClientConnector f, string objectId) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + objectId + "/likes";

        message response = oauth2:ClientConnector.post(facebookEP, facebookPath, request);

        return response;

    }

    @doc:Description{ value : "Get like details."}
    @doc:Param{ value : "f: The facebook Connector instance"}
    @doc:Param{ value : "objectId: The object ID to get the like details."}
    @doc:Param{ value : "fields: The fields to retrieve."}
    @doc:Return{ value : "Response object."}
    action getLikesDetails(ClientConnector f, string objectId, string fields) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + objectId + "/likes";

        if(fields != "null"){
            facebookPath = facebookPath + "?fields=" + fields;
        }

        message response = oauth2:ClientConnector.get(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description{ value : "Delete likes."}
    @doc:Param{ value : "f: The facebook Connector instance"}
    @doc:Param{ value : "objectId: The object ID to remove the likes."}
    @doc:Return{ value : "Response object."}
    action deleteLikes(ClientConnector f, string objectId) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + objectId + "/likes";

        message response = oauth2:ClientConnector.delete(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description{ value : "Add comments"}
    @doc:Param{ value : "f: The facebook Connector instance"}
    @doc:Param{ value : "objectId: The ID of the object such as a page, video, etc."}
    @doc:Param{ value : "msg: The comment text."}
    @doc:Param{ value : "attachmentId: An ID of an unpublished photo."}
    @doc:Param{ value : "attachmentUrl: The URL of an image to include as a photo comment."}
    @doc:Return{ value : "Response object."}
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
        facebookPath = facebookPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));

        message response = oauth2:ClientConnector.post(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description{ value : "Get comments."}
    @doc:Param{ value : "f: The facebook Connector instance"}
    @doc:Param{ value : "objectId: The ID of the object such as a page, video, etc."}
    @doc:Param{ value : "fields: The fields to retrieve."}
    @doc:Return{ value : "Response object."}
    action getComments(ClientConnector f, string objectId, string fields) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + objectId + "/comments";

        if(fields != "null"){
            facebookPath = facebookPath + "?fields=" + fields;
        }

        message response = oauth2:ClientConnector.get(facebookEP, facebookPath, request);

        return response;
    }

}
