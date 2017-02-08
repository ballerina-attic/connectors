package org.wso2.ballerina.connectors;

import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.string;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.net.uri;
import ballerina.util;

connector Gmail (string userId, string accessToken) {

    http:HTTPConnector gmailEP = new http:HTTPConnector("https://www.googleapis.com/gmail");

    action getUserProfile(Gmail g) (message) {

        string getProfilePath;
        message request;
        message response;

        getProfilePath = "/v1/users/" + userId + "/profile";

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.get(gmailEP, getProfilePath, request);

        return response;
    }

    action createDraft(Gmail g, string to, string subject, string from, string messageBody, string cc , string bcc, string id, string threadId) (message) {

        string createDraftPath;
        message request;
        message response;
        string concatRequest;
        string encodedRequest;
        json createDraftRequest;

        concatRequest = "";

        if(to != "null") {
            concatRequest = concatRequest + "to:" + to + "\n";
        }

        if(subject != "null") {
            concatRequest = concatRequest + "subject:" + subject + "\n";
        }

        if(from != "null") {
            concatRequest = concatRequest + "from:" + from + "\n";
        }

        if(cc != "null") {
            concatRequest = concatRequest + "cc:" + cc + "\n";
        }

        if(bcc != "null") {
            concatRequest = concatRequest + "bcc:" + bcc + "\n";
        }

        if(id != "null") {
            concatRequest = concatRequest + "id:" + id + "\n";
        }

        if(threadId != "null") {
            concatRequest = concatRequest + "threadId:" + threadId + "\n";
        }

        if(messageBody != "null") {
            concatRequest = concatRequest + "\n" + messageBody + "\n";
        }

        encodedRequest = util:base64encode(concatRequest);
        createDraftRequest = `{"message":{"raw": "${encodedRequest}"}}`;

        createDraftPath = "/v1/users/" + userId + "/drafts";

        message:setJsonPayload(request, createDraftRequest);

        message:setHeader(request, "Content-Type", "Application/json");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.post(gmailEP, createDraftPath, request);

        return response;
    }

    action updateDraft(Gmail g, string draftId, string to, string subject, string from, string messageBody, string cc , string bcc, string id, string threadId) (message) {

        string updateDraftPath;
        message request;
        message response;
        string concatRequest;
        string encodedRequest;
        json updateDraftRequest;

        concatRequest = "";

        if(to != "null") {
            concatRequest = concatRequest + "to:" + to + "\n";
        }

        if(subject != "null") {
            concatRequest = concatRequest + "subject:" + subject + "\n";
        }

        if(from != "null") {
            concatRequest = concatRequest + "from:" + from + "\n";
        }

        if(cc != "null") {
            concatRequest = concatRequest + "cc:" + cc + "\n";
        }

        if(bcc != "null") {
            concatRequest = concatRequest + "bcc:" + bcc + "\n";
        }

        if(id != "null") {
            concatRequest = concatRequest + "id:" + id + "\n";
        }

        if(threadId != "null") {
            concatRequest = concatRequest + "threadId:" + threadId + "\n";
        }

        if(messageBody != "null") {
            concatRequest = concatRequest + "\n" + messageBody + "\n";
        }

        encodedRequest = util:base64encode(concatRequest);
        updateDraftRequest = `{"message":{"raw": "${encodedRequest}"}}`;

        updateDraftPath = "/v1/users/" + userId + "/drafts/" +draftId;

        message:setJsonPayload(request, updateDraftRequest);

        message:setHeader(request, "Content-Type", "Application/json");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.put(gmailEP, updateDraftPath, request);

        return response;
    }

    action readDraft(Gmail g, string draftId, string format) (message) {

        string readDraftPath;
        message request;
        message response;

        readDraftPath = "/v1/users/" + userId + "/drafts/" + draftId;

        if(format != "null") {
            readDraftPath = readDraftPath + "?format=" + format;
        }

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.get(gmailEP, readDraftPath, request);

        return response;
    }

    action listDrafts(Gmail g, string includeSpamTrash, string maxResults, string pageToken, string q) (message) {

        string listDraftPath;
        message request;
        message response;

        listDraftPath = "/v1/users/" + userId + "/drafts?includeSpamTrash=" + includeSpamTrash + "&maxResults=" + maxResults + "&pageToken=" + pageToken + "&q=" + q;

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.get(gmailEP, listDraftPath, request);

        return response;
    }

    action deleteDraft(Gmail g, string draftId) (message) {

        string deleteDraftPath;
        message request;
        message response;

        deleteDraftPath = "/v1/users/" + userId + "/drafts/" + draftId;

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.delete(gmailEP, deleteDraftPath, request);

        return response;
    }

    action listHistory(Gmail g, string labelId, string maxResults, string pageToken, string startHistoryId) (message){

        string listHistoryPath;
        message request;
        message response;

        listHistoryPath = "/v1/users/" + userId + "/history?startHistoryId=" + startHistoryId;

        if(labelId != "null") {
            listHistoryPath = listHistoryPath + "&labelId=" + labelId;
        }

        if(maxResults != "null") {
            listHistoryPath = listHistoryPath + "&maxResults=" + maxResults;
        }

        if(pageToken != "null") {
             listHistoryPath = listHistoryPath + "&pageToken=" + pageToken;
        }

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.get(gmailEP, listHistoryPath, request);

        return response;
    }

    action createLabel(Gmail g, string labelName, string messageListVisibility, string labelListVisibility, string types, string messagesTotal, string messagesUnread, string threadsTotal, string threadsUnread) (message) {

        string createLabelPath;
        message request;
        message response;
        json createLabelRequest;

        createLabelRequest = `{"name": "${labelName}", "messageListVisibility": "${messageListVisibility}", "labelListVisibility": "${labelListVisibility}", "type": "${types}","messagesTotal": "${messagesTotal}", "messagesUnread": "${messagesUnread}", "threadsTotal": "${threadsTotal}", "threadsUnread": "${threadsUnread}"}`;

        if (types == "null") {
            json:remove(createLabelRequest, "$.type");
        }

        if (messagesTotal == "null") {
            json:remove(createLabelRequest, "$.messagesTotal");
        }

        if (messagesUnread == "null") {
            json:remove(createLabelRequest, "$.messagesUnread");
        }

        if (threadsTotal == "null") {
            json:remove(createLabelRequest, "$.threadsTotal");
        }

        if (threadsUnread == "null") {
            json:remove(createLabelRequest, "$.threadsUnread");
        }

        createLabelPath = "/v1/users/" + userId + "/labels";

        message:setHeader(request, "Content-Type", "Application/json");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        message:setJsonPayload(request, createLabelRequest);

        response = http:HTTPConnector.post(gmailEP, createLabelPath, request);

        return response;
    }

    action deleteLabel(Gmail g, string labelId) (message) {

        string deleteLabelPath;
        message request;
        message response;

        deleteLabelPath = "/v1/users/" + userId + "/labels/" + labelId;

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.delete(gmailEP, deleteLabelPath, request);

        return response;
    }

    action listLabels(Gmail g) (message) {

        string listLabelPath;
        message request;
        message response;

        listLabelPath = "/v1/users/" + userId + "/labels/";

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.get(gmailEP, listLabelPath, request);

        return response;
    }

    action updateLabel(Gmail g, string labelId, string labelName, string messageListVisibility, string labelListVisibility, string types, string messagesTotal, string messagesUnread, string threadsTotal, string threadsUnread) (message) {

        string updateLabelPath;
        message request;
        message response;
        json updateLabelRequest;

        updateLabelRequest = `{"id": "${labelId}", "name": "${labelName}", "messageListVisibility": "${messageListVisibility}", "labelListVisibility": "${labelListVisibility}", "type": "${types}","messagesTotal": "${messagesTotal}", "messagesUnread": "${messagesUnread}", "threadsTotal": "${threadsTotal}", "threadsUnread": "${threadsUnread}"}`;

        if (types == "null") {
            json:remove(updateLabelRequest, "$.type");
        }

        if (messagesTotal == "null") {
            json:remove(updateLabelRequest, "$.messagesTotal");
        }

        if (messagesUnread == "null") {
            json:remove(updateLabelRequest, "$.messagesUnread");
        }

        if (threadsTotal == "null") {
            json:remove(updateLabelRequest, "$.threadsTotal");
        }

        if (threadsUnread == "null") {
            json:remove(updateLabelRequest, "$.threadsUnread");
        }

        updateLabelPath = "/v1/users/" + userId + "/labels/" + labelId;

        message:setHeader(request, "Content-Type", "Application/json");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        message:setJsonPayload(request, updateLabelRequest);

        response = http:HTTPConnector.put(gmailEP, updateLabelPath, request);

        return response;
    }

    action readLabel(Gmail g, string labelId) (message) {

        string readLabelPath;
        message request;
        message response;

        readLabelPath = "/v1/users/" + userId + "/labels/" + labelId;

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.get(gmailEP, readLabelPath, request);

        return response;
    }

    action readThread(Gmail g, string threadId, string format, string metaDataHeaders) (message) {

        string readThreadPath;
        message request;
        message response;
        string encodedHeaders;

        encodedHeaders = uri:encode(metaDataHeaders);

        if(metaDataHeaders == "null") {
            readThreadPath = "/v1/users/" + userId + "/threads/" + threadId + "?format=" + format;
        }

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.get(gmailEP, readThreadPath, request);

        return response;
    }

    action listThreads(Gmail g, string includeSpamTrash, string labelIds, string maxResults, string pageToken, string q) (message) {

        string listThreadPath;
        message request;
        message response;
        string queryParams;

        listThreadPath = "/v1/users/" + userId + "/threads?includeSpamTrash=" + includeSpamTrash + "&labelIds=" + labelIds + "&maxResults=" + maxResults + "&pageToken=" + pageToken + "&q=" + q;

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.get(gmailEP, listThreadPath, request);

        return response;
    }

    action deleteThread(Gmail g, string threadId) (message) {

        string deleteThreadPath;
        message request;
        message response;

        deleteThreadPath = "/v1/users/" + userId + "/threads/" + threadId;

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.delete(gmailEP, deleteThreadPath, request);

        return response;
    }

    action trashThread(Gmail g, string threadId) (message) {

        string trashThreadPath;
        message request;
        message response;

        trashThreadPath = "/v1/users/" + userId + "/threads/" + threadId + "/trash";

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        http:setContentLength(request, 0);
        response = http:HTTPConnector.post(gmailEP, trashThreadPath, request);

        return response;
    }

    action unTrashThread(Gmail g, string threadId) (message) {

        string unTrashThreadPath;
        message request;
        message response;

        unTrashThreadPath = "/v1/users/" + userId + "/threads/" + threadId + "/untrash";

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        http:setContentLength(request, 0);
        response = http:HTTPConnector.post(gmailEP, unTrashThreadPath, request);

        return response;
    }

    action listMails(Gmail g, string includeSpamTrash, string labelIds, string maxResults, string pageToken, string q) (message) {

        string listMailPath;
        message request;
        message response;

        listMailPath = "/v1/users/" + userId + "/messages?includeSpamTrash=" + includeSpamTrash + "&labelIds=" + labelIds +"&maxResults=" + maxResults + "&pageToken=" + pageToken + "&q=" + q;

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.get(gmailEP, listMailPath, request);

        return response;
    }

    action sendMail(Gmail g, string to, string subject, string from, string messageBody, string cc , string bcc, string id, string threadId) (message) {

        string sendMailPath;
        message request;
        message response;
        string concatRequest;
        string encodedRequest;
        json sendMailRequest;

        concatRequest = "";

        if(to != "null") {
            concatRequest = concatRequest + "to:" + to + "\n";
        }

        if(subject != "null") {
            concatRequest = concatRequest + "subject:" + subject + "\n";
        }

        if(from != "null") {
            concatRequest = concatRequest + "from:" + from + "\n";
        }

        if(cc != "null") {
            concatRequest = concatRequest + "cc:" + cc + "\n";
        }

        if(bcc != "null") {
            concatRequest = concatRequest + "bcc:" + bcc + "\n";
        }

        if(id != "null") {
            concatRequest = concatRequest + "id:" + id + "\n";
        }

        if(threadId != "null") {
            concatRequest = concatRequest + "threadId:" + threadId + "\n";
        }

        if(messageBody != "null") {
            concatRequest = concatRequest + "\n" + messageBody + "\n";
        }

        encodedRequest = util:base64encode(concatRequest);
        sendMailRequest = `{"raw": "${encodedRequest}"}`;

        sendMailPath = "/v1/users/" + userId + "/messages/send";

        message:setJsonPayload(request, sendMailRequest);

        message:setHeader(request, "Content-Type", "Application/json");
        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.post(gmailEP, sendMailPath, request);

        return response;
    }

    action modifyExistingMessage(Gmail g, string messageId, string addLabelIds, string removeLabelIds) (message) {

        string modifyExistingMessagePath;
        message request;
        message response;
        json modifyExistingMessageRequest;

        modifyExistingMessageRequest = `{"addLabelIds":["${addLabelIds}"],"removeLabelIds":["${removeLabelIds}"]}`;

        if(addLabelIds == "null") {
            json:remove(modifyExistingMessageRequest, "$.addLabelIds");
        }

        if(removeLabelIds == "null") {
            json:remove(modifyExistingMessageRequest, "$.removeLabelIds");
        }

        modifyExistingMessagePath = "/v1/users/" + userId + "/messages/" + messageId + "/modify";

        message:setJsonPayload(request, modifyExistingMessageRequest);
        message:setHeader(request, "Content-Type", "Application/json");

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.post(gmailEP, modifyExistingMessagePath, request);

        return response;
    }

    action readMail(Gmail g, string messageId, string format, string metaDataHeaders) (message) {

        string readMailPath;
        message request;
        message response;
        string encodedHeaders;

        encodedHeaders = uri:encode(metaDataHeaders);

        if(metaDataHeaders == "null") {
        readMailPath = "/v1/users/" + userId + "/messages/" + messageId + "?format=" + format;
        }

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.get(gmailEP, readMailPath, request);

        return response;
    }

    action deleteMail(Gmail g, string messageId) (message) {

        string deleteMailPath;
        message request;
        message response;

        deleteMailPath = "/v1/users/" + userId + "/messages/" + messageId;

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        response = http:HTTPConnector.delete(gmailEP, deleteMailPath, request);

        return response;
    }

    action trashMail(Gmail g, string messageId) (message) {

        string trashMailPath;
        message request;
        message response;

        trashMailPath = "/v1/users/" + userId + "/messages/" + messageId + "/trash";

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        http:setContentLength(request, 0);
        response = http:HTTPConnector.post(gmailEP, trashMailPath, request);

        return response;
    }

    action unTrashMail(Gmail g, string messageId) (message) {

        string unTrashMailPath;
        message request;
        message response;

        unTrashMailPath = "/v1/users/" + userId + "/messages/" + messageId + "/untrash";

        message:setHeader(request, "Authorization", "Bearer " + accessToken);

        http:setContentLength(request, 0);
        response = http:HTTPConnector.post(gmailEP, unTrashMailPath, request);

        return response;
    }
}

function main (string[] args) {

    connectors:Gmail gmailConnector = new connectors:Gmail(args[1], args[2]);

    message gmailResponse;
    json gmailJSONResponse;
    string deleteResponse;

    if( args[0] == "getUserProfile") {

    gmailResponse = connectors:Gmail.getUserProfile(gmailConnector);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "createDraft") {

    gmailResponse = connectors:Gmail.createDraft(gmailConnector, args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "updateDraft") {

    gmailResponse = connectors:Gmail.updateDraft(gmailConnector, args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "readDraft") {

    gmailResponse = connectors:Gmail.readDraft(gmailConnector, args[3], args[4]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "listDrafts") {

    gmailResponse = connectors:Gmail.listDrafts(gmailConnector, args[3], args[4], args[5], args[6]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "deleteDraft") {

    gmailResponse = connectors:Gmail.deleteDraft(gmailConnector, args[3]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    deleteResponse = json:toString(gmailJSONResponse);

    if(deleteResponse == "null"){
    system:println("Draft with id: " + args[3] + " deleted successfully.");
    }
    }

    if( args[0] == "listHistory") {

    gmailResponse = connectors:Gmail.listHistory(gmailConnector, args[3], args[4], args[5], args[6]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "createLabel") {

    gmailResponse = connectors:Gmail.createLabel(gmailConnector, args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "deleteLabel") {

    gmailResponse = connectors:Gmail.deleteLabel(gmailConnector, args[3]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    deleteResponse = json:toString(gmailJSONResponse);

    if(deleteResponse == "null"){
     system:println("Label with id: " + args[3] + " deleted successfully.");
    }
    }

    if( args[0] == "listLabels") {

    gmailResponse = connectors:Gmail.listLabels(gmailConnector);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "updateLabel") {

    gmailResponse = connectors:Gmail.updateLabel(gmailConnector, args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "readLabel") {

    gmailResponse = connectors:Gmail.readLabel(gmailConnector, args[3]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "readThread") {

    gmailResponse = connectors:Gmail.readThread(gmailConnector, args[3], args[4], args[5]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "listThreads") {

    gmailResponse = connectors:Gmail.listThreads(gmailConnector, args[3], args[4], args[5], args[6], args[7]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "deleteThread") {

    gmailResponse = connectors:Gmail.deleteThread(gmailConnector, args[3]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    deleteResponse = json:toString(gmailJSONResponse);

        if(deleteResponse == "null"){
        system:println("Thread with id: " + args[3] + " deleted successfully.");
        }
    }

    if( args[0] == "trashThread") {

    gmailResponse = connectors:Gmail.trashThread(gmailConnector, args[3]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "unTrashThread") {

    gmailResponse = connectors:Gmail.unTrashThread(gmailConnector, args[3]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "listMails") {

    gmailResponse = connectors:Gmail.listMails(gmailConnector, args[3], args[4], args[5], args[6], args[7]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "sendMail") {

    gmailResponse = connectors:Gmail.sendMail(gmailConnector, args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "readMail") {

    gmailResponse = connectors:Gmail.readMail(gmailConnector, args[3], args[4], args[5]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "deleteMail") {

    gmailResponse = connectors:Gmail.deleteMail(gmailConnector, args[3]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    deleteResponse = json:toString(gmailJSONResponse);

        if(deleteResponse == "null"){
            system:println("Mail with id: " + args[3] + " deleted successfully.");
        }
    }

    if( args[0] == "trashMail") {

    gmailResponse = connectors:Gmail.trashMail(gmailConnector, args[3]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "unTrashMail") {

    gmailResponse = connectors:Gmail.unTrashMail(gmailConnector, args[3]);

    gmailJSONResponse = message:getJsonPayload(gmailResponse);
    system:println(json:toString(gmailJSONResponse));
    }
}