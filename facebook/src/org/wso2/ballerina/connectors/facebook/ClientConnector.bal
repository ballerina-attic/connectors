package org.wso2.ballerina.connectors.facebook;

import ballerina.lang.strings;
import ballerina.net.uri;

import org.wso2.ballerina.connectors.OAuth2;

@doc:Description("Facebook client connector.")
@doc:Param("accessToken: Value of the valid access_token.")
connector ClientConnector (string accessToken) {

    string baseURL = "https://graph.facebook.com";

    OAuth2:ClientConnector facebookEP = create OAuth2:ClientConnector(baseURL, accessToken, "null", "null",
                                        "null", "null");
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
        facebookPath = facebookPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
                                                                                                  
        message response = OAuth2:ClientConnector.post(facebookEP, facebookPath, request);

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

        message response = OAuth2:ClientConnector.get(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description("Delete a post.")
    @doc:Param("postId: The post ID.")
    @doc:Return("Response object.")
    action deletePost(ClientConnector f, string postId) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + postId;

        message response = OAuth2:ClientConnector.delete(facebookEP, facebookPath, request);

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
        facebookPath = facebookPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));

        message response = OAuth2:ClientConnector.post(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description("Add likes.")
    @doc:Param("objectId: The object ID to add like.")
    @doc:Return("Response object")
    action addLikes(ClientConnector f, string objectId) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + objectId + "/likes";

        message response = OAuth2:ClientConnector.post(facebookEP, facebookPath, request);

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

        message response = OAuth2:ClientConnector.get(facebookEP, facebookPath, request);

        return response;
    }

    @doc:Description("Delete likes.")
    @doc:Param("objectId: The object ID to remove the likes.")
    @doc:Return("Response object.")
    action deleteLikes(ClientConnector f, string objectId) (message) {
        message request = {};
        string facebookPath = "/v2.8/" + objectId + "/likes";

        message response = OAuth2:ClientConnector.delete(facebookEP, facebookPath, request);

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
        facebookPath = facebookPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));

        message response = OAuth2:ClientConnector.post(facebookEP, facebookPath, request);

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

        message response = OAuth2:ClientConnector.get(facebookEP, facebookPath, request);

        return response;
    }

}
