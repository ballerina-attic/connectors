package org.wso2.ballerina.connectors.gmail;

import org.wso2.ballerina.connectors.oauth2;
import ballerina.doc;
import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.net.http;
import ballerina.utils;
import ballerina.lang.jsons;

struct Message {
    string to;
    string subject;
    string from;
    string messageBody;
    string cc;
    string bcc;
    string id;
    string threadId;
}

struct ThreadFilter {
    string format;
    string metaDataHeaders;
}

struct DraftFilter {
    string format;
}

struct ThreadListFilter {
    string includeSpamTrash;
    string labelIds;
    string maxResults;
    string pageToken;
    string q;
}

struct DraftsListFilter {
    string includeSpamTrash;
    string maxResults;
    string pageToken;
    string q;
}

struct HistoryFilter {
    string labelId;
    string maxResults;
    string pageToken;
}

struct EmailLabel {
    string types;
    string messagesTotal;
    string messagesUnread;
    string threadsTotal;
    string threadsUnread;
}

struct UserProfile {
    string emailAddress;
    int messagesTotal;
    int threadsTotal;
    string historyId;
}

struct Email {
    string id;
    string threadId;
    string[] labelIds;
}

struct Draft {
    string id;
    EmailMessage mailMessage;
}

struct Drafts {
    Draft[] drafts;
    int resultSizeEstimate;
    string nextPageToken;
}

struct HistoryList {
    History[] history;
    string nextPageToken;
    string historyId;
}

struct History {
    string id;
    EmailMessage[] messages;
    Messages[] messagesAdded;
    Messages[] messagesDeleted;
    Messages[] labelsAdded;
    Messages[] labelsRemoved;
}

struct Messages {
    Email emailMessage;
}

struct Label {
    string id;
    string name;
    string messageListVisibility;
    string labelListVisibility;
    string type;
    int messagesTotal;
    int messagesUnread;
    int threadsTotal;
    int threadsUnread;
}

struct Labels {
    Label[] labels;
}

struct Threads {
    Thread[] threads;
    string nextPageToken;
    int resultSizeEstimate;
}

struct Thread {
    string id;
    string snippet;
    string historyId;
    EmailMessage[] messages;
}

struct Emails {
    EmailMessage[] messages;
    string nextPageToken;
    int resultSizeEstimate;
}

struct EmailMessage {
    string id;
    string threadId;
    string[] labelIds;
    string snippet;
    string historyId;
    string internalDate;
    MessagePayload payload;
    int sizeEstimate;
}

struct MessagePayload {
    string partId;
    string mimeType;
    string filename;
    Header[] headers;
    Body body;
    Parts[] parts;
}

struct Parts {
    string partId;
    string mimeType;
    string filename;
    Header[] headers;
    Body body;
}

struct Header {
    string name;
    string value;
}

struct Body {
    string attachmentId;
    int size;
    string data;
}

struct Error {
    json errors;
    string errorMessage;
}

struct StatusCode {
    int statusCode;
}

@doc:Description { value:"Gmail client connector"}
@doc:Param { value:"userId: The userId of the Gmail account which means the email id"}
@doc:Param { value:"accessToken: The accessToken of the Gmail account to access the gmail REST API"}
@doc:Param { value:"refreshToken: The refreshToken of the Gmail App to access the gmail REST API"}
@doc:Param { value:"clientId: The clientId of the App to access the gmail REST API"}
@doc:Param { value:"clientSecret: The clientSecret of the App to access the gmail REST API"}
connector ClientConnector (string userId, string accessToken, string refreshToken, string clientId,
                           string clientSecret) {

    string refreshTokenEP = "https://www.googleapis.com/oauth2/v3/token";
    string baseURL = "https://www.googleapis.com/gmail";
    message request = {};
    Error errorResponse = {};

    oauth2:ClientConnector gmailEP = create oauth2:ClientConnector(baseURL, accessToken, clientId, clientSecret,
                                                                   refreshToken, refreshTokenEP);

    @doc:Description { value:"Retrieve the user profile information"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Return { value:"response structs"}
    action getUserProfile (ClientConnector g) (UserProfile, Error) {
        UserProfile response = {};
        string getProfilePath = "/v1/users/" + userId + "/profile";
        message responseMessage = oauth2:ClientConnector.get (gmailEP, getProfilePath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        if (statusCode == 200) {
            if (jsonResponse.emailAddress != null) {
                response.emailAddress, _ = (string)jsonResponse.emailAddress;
            }
            if (jsonResponse.messagesTotal != null) {
                response.messagesTotal, _ = (int)jsonResponse.messagesTotal;
            }
            if (jsonResponse.threadsTotal != null) {
                response.threadsTotal, _ = (int)jsonResponse.threadsTotal;
            }
            if (jsonResponse.historyId != null) {
                response.historyId, _ = (string)jsonResponse.historyId;
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Create a draft"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"createDraft: It is a struct. Which contains all optional parameters (to,subject,from,messageBody
    ,cc,bcc,id,threadId) to create draft message"}
    @doc:Return { value:"response structs"}
    action createDraft (ClientConnector g, Message createDraft) (Draft, Error) {
        Draft response = {};
        string concatRequest;

        if (createDraft != null) {
            string to = createDraft.to;
            string subject = createDraft.subject;
            string from = createDraft.from;
            string messageBody = createDraft.messageBody;
            string cc = createDraft.cc;
            string bcc = createDraft.bcc;
            string id = createDraft.id;
            string threadId = createDraft.threadId;

            if (to != "") {
                concatRequest = concatRequest + "to:" + to + "\n";
            }
            if (subject != "") {
                concatRequest = concatRequest + "subject:" + subject + "\n";
            }
            if (from != "") {
                concatRequest = concatRequest + "from:" + from + "\n";
            }
            if (cc != "") {
                concatRequest = concatRequest + "cc:" + cc + "\n";
            }
            if (bcc != "") {
                concatRequest = concatRequest + "bcc:" + bcc + "\n";
            }
            if (id != "") {
                concatRequest = concatRequest + "id:" + id + "\n";
            }
            if (threadId != "") {
                concatRequest = concatRequest + "threadId:" + threadId + "\n";
            }
            if (messageBody != "") {
                concatRequest = concatRequest + "\n" + messageBody + "\n";
            }
        }
        string encodedRequest = utils:base64encode(concatRequest);
        json createDraftRequest = {"message":{"raw":encodedRequest}};
        string createDraftPath = "/v1/users/" + userId + "/drafts";
        messages:setJsonPayload(request, createDraftRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message responseMessage = oauth2:ClientConnector.post (gmailEP, createDraftPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];
        EmailMessage mailMessage = {};
        mailMessage.labelIds = [];

        if (statusCode == 200) {
            if (jsonResponse["message"].payload != null) {
                if (jsonResponse["message"].payload.headers != null) {
                    int lengthOfHeader = jsons:getInt(jsonResponse["message"].payload.headers, "$.length()");
                    int j = 0;
                    while (j < lengthOfHeader) {
                        Header header = {};
                        if (jsonResponse["message"].payload.headers[j].name != null) {
                            header.name, _ = (string)jsonResponse["message"].payload.headers[j].name;
                        }
                        if (jsonResponse["message"].payload.headers[j].value != null) {
                            header.value, _ = (string)jsonResponse["message"].payload.headers[j].value;
                        }
                        messagePayload.headers[j] = header;
                        j = j + 1;
                    }
                }
                if (jsonResponse["message"].payload.parts != null) {
                    int lengthOfParts = jsons:getInt(jsonResponse["message"].payload.parts, "$.length()");
                    int k = 0;
                    while (k < lengthOfParts) {
                        Parts parts = {};
                        Body body = {};
                        parts.headers = [];
                        if (jsonResponse["message"].payload.parts[k].partId != null) {
                            parts.partId, _ = (string)jsonResponse["message"].payload.parts[k].partId;
                        }
                        if (jsonResponse["message"].payload.parts[k].mimeType != null) {
                            parts.mimeType, _ = (string)jsonResponse["message"].payload.parts[k].mimeType;
                        }
                        if (jsonResponse["message"].payload.parts[k].filename != null) {
                            parts.filename, _ = (string)jsonResponse["message"].payload.parts[k].filename;
                        }
                        if (jsonResponse["message"].payload.parts[k].body.size != null) {
                            body.size, _ = (int)jsonResponse["message"].payload.parts[k].body.size;
                        }
                        if (jsonResponse["message"].payload.parts[k].body.data != null) {
                            body.data, _ = (string)jsonResponse["message"].payload.parts[k].body.data;
                        }
                        if (jsonResponse["message"].payload.parts[k].body.attachmentId != null) {
                            body.attachmentId, _ = (string)jsonResponse["message"].payload.parts[k].body.attachmentId;
                        }
                        parts.body = body;
                        int lengthOfPartHeader = jsons:getInt(jsonResponse["message"].payload.parts[k].headers,
                                                              "$.length()");
                        int l = 0;
                        while (l < lengthOfPartHeader) {
                            Header header_2 = {};
                            if (jsonResponse["message"].payload.parts[k].headers[l].name != null) {
                                header_2.name, _ = (string)jsonResponse["message"].payload.parts[k].headers[l].name;
                            }
                            if (jsonResponse["message"].payload.parts[k].headers[l].value != null) {
                                header_2.value, _ = (string)jsonResponse["message"].payload.parts[k].headers[l].value;
                            }
                            parts.headers[k] = header_2;
                            l = l + 1;
                        }
                        messagePayload.parts[k] = parts;
                        k = k + 1;
                    }
                }
                Body body_2 = {};
                if (jsonResponse["message"].payload.body.size != null) {
                    body_2.size, _ = (int)jsonResponse["message"].payload.body.size;
                }
                if (jsonResponse["message"].payload.body.data != null) {
                    body_2.data, _ = (string)jsonResponse["message"].payload.body.data;
                }
                if (jsonResponse["message"].payload.body.attachmentId != null) {
                    body_2.attachmentId, _ = (string)jsonResponse["message"].payload.body.attachmentId;
                }
                messagePayload.body = body_2;
                if (jsonResponse["message"].payload.filename != null) {
                    messagePayload.filename, _ = (string)jsonResponse["message"].payload.filename;
                }
                if (jsonResponse["message"].payload.mimeType != null) {
                    messagePayload.mimeType, _ = (string)jsonResponse["message"].payload.mimeType;
                }
                if (jsonResponse["message"].payload.partId != null) {
                    messagePayload.partId, _ = (string)jsonResponse["message"].payload.partId;
                }
                mailMessage.payload = messagePayload;
            }
            if (jsonResponse["message"].id != null) {
                mailMessage.id, _ = (string)jsonResponse["message"].id;
            }
            if (jsonResponse["message"].threadId != null) {
                mailMessage.threadId, _ = (string)jsonResponse["message"].threadId;
            }
            if (jsonResponse["message"].snippet != null) {
                mailMessage.snippet, _ = (string)jsonResponse["message"].snippet;
            }
            if (jsonResponse["message"].historyId != null) {
                mailMessage.historyId, _ = (string)jsonResponse["message"].historyId;
            }
            if (jsonResponse["message"].internalDate != null) {
                mailMessage.internalDate, _ = (string)jsonResponse["message"].internalDate;
            }
            if (jsonResponse["message"].sizeEstimate != null) {
                mailMessage.sizeEstimate, _ = (int)jsonResponse["message"].sizeEstimate;
            }
            if (jsonResponse["message"].labelIds != null) {
                int lengthOfLabel = jsons:getInt(jsonResponse["message"].labelIds, "$.length()");
                int i = 0;
                while (i < lengthOfLabel) {
                    mailMessage.labelIds[i], _ = (string)jsonResponse["message"].labelIds[i];
                    i = i + 1;
                }
            }
            response.mailMessage = mailMessage;
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Update a draft"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"draftId: Id of the draft to update"}
    @doc:Param { value:"updateDraft: It is a struct. Which contains all optional parameters (to,subject,from,messageBody
    ,cc,bcc,id,threadId) to update draft"}
    @doc:Return { value:"response structs"}
    action updateDraft (ClientConnector g, string draftId, Message updateDraft) (Draft, Error) {
        Draft response = {};
        string concatRequest;

        if (updateDraft != null) {
            string to = updateDraft.to;
            string subject = updateDraft.subject;
            string from = updateDraft.from;
            string messageBody = updateDraft.messageBody;
            string cc = updateDraft.cc;
            string bcc = updateDraft.bcc;
            string id = updateDraft.id;
            string threadId = updateDraft.threadId;

            if (to != "") {
                concatRequest = concatRequest + "to:" + to + "\n";
            }
            if (subject != "") {
                concatRequest = concatRequest + "subject:" + subject + "\n";
            }
            if (from != "") {
                concatRequest = concatRequest + "from:" + from + "\n";
            }
            if (cc != "") {
                concatRequest = concatRequest + "cc:" + cc + "\n";
            }
            if (bcc != "") {
                concatRequest = concatRequest + "bcc:" + bcc + "\n";
            }
            if (id != "") {
                concatRequest = concatRequest + "id:" + id + "\n";
            }
            if (threadId != "") {
                concatRequest = concatRequest + "threadId:" + threadId + "\n";
            }
            if (messageBody != "") {
                concatRequest = concatRequest + "\n" + messageBody + "\n";
            }
        }
        string encodedRequest = utils:base64encode(concatRequest);
        json updateDraftRequest = {"message":{"raw":encodedRequest}};
        string updateDraftPath = "/v1/users/" + userId + "/drafts/" + draftId;
        messages:setJsonPayload(request, updateDraftRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message responseMessage = oauth2:ClientConnector.put (gmailEP, updateDraftPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];
        EmailMessage mailMessage = {};
        mailMessage.labelIds = [];

        if (statusCode == 200) {
            if (jsonResponse["message"].payload != null) {
                if (jsonResponse["message"].payload.headers != null) {
                    int lengthOfHeader = jsons:getInt(jsonResponse["message"].payload.headers, "$.length()");
                    int j = 0;
                    while (j < lengthOfHeader) {
                        Header header = {};
                        if (jsonResponse["message"].payload.headers[j].name != null) {
                            header.name, _ = (string)jsonResponse["message"].payload.headers[j].name;
                        }
                        if (jsonResponse["message"].payload.headers[j].value != null) {
                            header.value, _ = (string)jsonResponse["message"].payload.headers[j].value;
                        }
                        messagePayload.headers[j] = header;
                        j = j + 1;
                    }
                }
                if (jsonResponse["message"].payload.parts != null) {
                    int lengthOfParts = jsons:getInt(jsonResponse["message"].payload.parts, "$.length()");
                    int k = 0;
                    while (k < lengthOfParts) {
                        Parts parts = {};
                        Body body = {};
                        parts.headers = [];
                        if (jsonResponse["message"].payload.parts[k].partId != null) {
                            parts.partId, _ = (string)jsonResponse["message"].payload.parts[k].partId;
                        }
                        if (jsonResponse["message"].payload.parts[k].mimeType != null) {
                            parts.mimeType, _ = (string)jsonResponse["message"].payload.parts[k].mimeType;
                        }
                        if (jsonResponse["message"].payload.parts[k].filename != null) {
                            parts.filename, _ = (string)jsonResponse["message"].payload.parts[k].filename;
                        }
                        if (jsonResponse["message"].payload.parts[k].body.size != null) {
                            body.size, _ = (int)jsonResponse["message"].payload.parts[k].body.size;
                        }
                        if (jsonResponse["message"].payload.parts[k].body.data != null) {
                            body.data, _ = (string)jsonResponse["message"].payload.parts[k].body.data;
                        }
                        if (jsonResponse["message"].payload.parts[k].body.attachmentId != null) {
                            body.attachmentId, _ = (string)jsonResponse["message"].payload.parts[k].body.attachmentId;
                        }
                        parts.body = body;
                        int lengthOfPartHeader = jsons:getInt(jsonResponse["message"].payload.parts[k].headers,
                                                              "$.length()");
                        int l = 0;
                        while (l < lengthOfPartHeader) {
                            Header header_2 = {};
                            if (jsonResponse["message"].payload.parts[k].headers[l].name != null) {
                                header_2.name, _ = (string)jsonResponse["message"].payload.parts[k].headers[l].name;
                            }
                            if (jsonResponse["message"].payload.parts[k].headers[l].value != null) {
                                header_2.value, _ = (string)jsonResponse["message"].payload.parts[k].headers[l].value;
                            }
                            parts.headers[k] = header_2;
                            l = l + 1;
                        }
                        messagePayload.parts[k] = parts;
                        k = k + 1;
                    }
                }
                Body body_2 = {};
                if (jsonResponse["message"].payload.body.size != null) {
                    body_2.size, _ = (int)jsonResponse["message"].payload.body.size;
                }
                if (jsonResponse["message"].payload.body.data != null) {
                    body_2.data, _ = (string)jsonResponse["message"].payload.body.data;
                }
                if (jsonResponse["message"].payload.body.attachmentId != null) {
                    body_2.attachmentId, _ = (string)jsonResponse["message"].payload.body.attachmentId;
                }
                messagePayload.body = body_2;
                if (jsonResponse["message"].payload.filename != null) {
                    messagePayload.filename, _ = (string)jsonResponse["message"].payload.filename;
                }
                if (jsonResponse["message"].payload.mimeType != null) {
                    messagePayload.mimeType, _ = (string)jsonResponse["message"].payload.mimeType;
                }
                if (jsonResponse["message"].payload.partId != null) {
                    messagePayload.partId, _ = (string)jsonResponse["message"].payload.partId;
                }
                mailMessage.payload = messagePayload;
            }
            if (jsonResponse["message"].id != null) {
                mailMessage.id, _ = (string)jsonResponse["message"].id;
            }
            if (jsonResponse["message"].threadId != null) {
                mailMessage.threadId, _ = (string)jsonResponse["message"].threadId;
            }
            if (jsonResponse["message"].snippet != null) {
                mailMessage.snippet, _ = (string)jsonResponse["message"].snippet;
            }
            if (jsonResponse["message"].historyId != null) {
                mailMessage.historyId, _ = (string)jsonResponse["message"].historyId;
            }
            if (jsonResponse["message"].internalDate != null) {
                mailMessage.internalDate, _ = (string)jsonResponse["message"].internalDate;
            }
            if (jsonResponse["message"].sizeEstimate != null) {
                mailMessage.sizeEstimate, _ = (int)jsonResponse["message"].sizeEstimate;
            }
            if (jsonResponse["message"].labelIds != null) {
                int lengthOfLabel = jsons:getInt(jsonResponse["message"].labelIds, "$.length()");
                int i = 0;
                while (i < lengthOfLabel) {
                    mailMessage.labelIds[i], _ = (string)jsonResponse["message"].labelIds[i];
                    i = i + 1;
                }
            }
            response.mailMessage = mailMessage;
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Retrieve a particular draft"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"draftId: Id of the draft to retrieve"}
    @doc:Param { value:"readDraft: It is a struct. Which contains all optional parameters (format) to read draft"}
    @doc:Return { value:"response structs"}
    action readDraft (ClientConnector g, string draftId, DraftFilter readDraft) (Draft, Error) {
        Draft response = {};
        string readDraftPath = "/v1/users/" + userId + "/drafts/" + draftId;

        if (readDraft != null) {
            string format = readDraft.format;

            if (format != "") {
                readDraftPath = readDraftPath + "?format=" + format;
            }
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, readDraftPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];
        EmailMessage mailMessage = {};
        mailMessage.labelIds = [];

        if (statusCode == 200) {
            if (jsonResponse["message"].payload != null) {
                if (jsonResponse["message"].payload.headers != null) {
                    int lengthOfHeader = jsons:getInt(jsonResponse["message"].payload.headers, "$.length()");
                    int j = 0;
                    while (j < lengthOfHeader) {
                        Header header = {};
                        if (jsonResponse["message"].payload.headers[j].name != null) {
                            header.name, _ = (string)jsonResponse["message"].payload.headers[j].name;
                        }
                        if (jsonResponse["message"].payload.headers[j].value != null) {
                            header.value, _ = (string)jsonResponse["message"].payload.headers[j].value;
                        }
                        messagePayload.headers[j] = header;
                        j = j + 1;
                    }
                }
                if (jsonResponse["message"].payload.parts != null) {
                    int lengthOfParts = jsons:getInt(jsonResponse["message"].payload.parts, "$.length()");
                    int k = 0;
                    while (k < lengthOfParts) {
                        Parts parts = {};
                        Body body = {};
                        parts.headers = [];
                        if (jsonResponse["message"].payload.parts[k].partId != null) {
                            parts.partId, _ = (string)jsonResponse["message"].payload.parts[k].partId;
                        }
                        if (jsonResponse["message"].payload.parts[k].mimeType != null) {
                            parts.mimeType, _ = (string)jsonResponse["message"].payload.parts[k].mimeType;
                        }
                        if (jsonResponse["message"].payload.parts[k].filename != null) {

                        }
                        if (jsonResponse["message"].payload.parts[k].filename != null) {
                            parts.filename, _ = (string)jsonResponse["message"].payload.parts[k].filename;
                        }
                        if (jsonResponse["message"].payload.parts[k].body.size != null) {
                            body.size, _ = (int)jsonResponse["message"].payload.parts[k].body.size;
                        }
                        if (jsonResponse["message"].payload.parts[k].body.data != null) {
                            body.data, _ = (string)jsonResponse["message"].payload.parts[k].body.data;
                        }
                        if (jsonResponse["message"].payload.parts[k].body.attachmentId != null) {
                            body.attachmentId, _ = (string)jsonResponse["message"].payload.parts[k].body.attachmentId;
                        }
                        parts.body = body;
                        int lengthOfPartHeader = jsons:getInt(jsonResponse["message"].payload.parts[k].headers,
                                                              "$.length()");
                        int l = 0;
                        while (l < lengthOfPartHeader) {
                            Header header_2 = {};
                            if (jsonResponse["message"].payload.parts[k].headers[l].name != null) {
                                header_2.name, _ = (string)jsonResponse["message"].payload.parts[k].headers[l].name;
                            }
                            if (jsonResponse["message"].payload.parts[k].headers[l].value != null) {
                                header_2.value, _ = (string)jsonResponse["message"].payload.parts[k].headers[l].value;
                            }
                            parts.headers[k] = header_2;
                            l = l + 1;
                        }
                        messagePayload.parts[k] = parts;
                        k = k + 1;
                    }
                }
                Body body_2 = {};
                if (jsonResponse["message"].payload.body.size != null) {
                    body_2.size, _ = (int)jsonResponse["message"].payload.body.size;
                }
                if (jsonResponse["message"].payload.body.data != null) {
                    body_2.data, _ = (string)jsonResponse["message"].payload.body.data;
                }
                if (jsonResponse["message"].payload.body.attachmentId != null) {
                    body_2.attachmentId, _ = (string)jsonResponse["message"].payload.body.attachmentId;
                }
                messagePayload.body = body_2;
                if (jsonResponse["message"].payload.filename != null) {
                    messagePayload.filename, _ = (string)jsonResponse["message"].payload.filename;
                }
                if (jsonResponse["message"].payload.mimeType != null) {

                }
                if (jsonResponse["message"].payload.mimeType != null) {
                    messagePayload.mimeType, _ = (string)jsonResponse["message"].payload.mimeType;
                }
                if (jsonResponse["message"].payload.partId != null) {
                    messagePayload.partId, _ = (string)jsonResponse["message"].payload.partId;
                }
                mailMessage.payload = messagePayload;
            }
            if (jsonResponse["message"].id != null) {
                mailMessage.id, _ = (string)jsonResponse["message"].id;
            }
            if (jsonResponse["message"].threadId != null) {
                mailMessage.threadId, _ = (string)jsonResponse["message"].threadId;
            }
            if (jsonResponse["message"].snippet != null) {
                mailMessage.snippet, _ = (string)jsonResponse["message"].snippet;
            }
            if (jsonResponse["message"].historyId != null) {
                mailMessage.historyId, _ = (string)jsonResponse["message"].historyId;
            }
            if (jsonResponse["message"].internalDate != null) {
                mailMessage.internalDate, _ = (string)jsonResponse["message"].internalDate;
            }
            if (jsonResponse["message"].sizeEstimate != null) {
                mailMessage.sizeEstimate, _ = (int)jsonResponse["message"].sizeEstimate;
            }
            if (jsonResponse["message"].labelIds != null) {
                int lengthOfLabel = jsons:getInt(jsonResponse["message"].labelIds, "$.length()");
                int i = 0;
                while (i < lengthOfLabel) {
                    mailMessage.labelIds[i], _ = (string)jsonResponse["message"].labelIds[i];
                    i = i + 1;
                }
            }
            response.mailMessage = mailMessage;
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Lists the drafts in the user's mailbox"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"listDrafts: It is a struct. Which contains all optional parameters (includeSpamTrash,maxResults,
    pageToken,q) to list drafts"}
    @doc:Return { value:"response structs"}
    action listDrafts (ClientConnector g, DraftsListFilter listDrafts) (Drafts, Error) {
        Drafts response = {};
        string uriParams;
        string listDraftPath = "/v1/users/" + userId + "/drafts";

        if (listDrafts != null) {
            string includeSpamTrash = listDrafts.includeSpamTrash;
            string maxResults = listDrafts.maxResults;
            string pageToken = listDrafts.pageToken;
            string q = listDrafts.q;

            if (includeSpamTrash != "") {
                uriParams = uriParams + "&includeSpamTrash=" + includeSpamTrash;
            }

            if (maxResults != "") {
                uriParams = uriParams + "&maxResults=" + maxResults;
            }

            if (pageToken != "") {
                uriParams = uriParams + "&pageToken=" + pageToken;
            }

            if (q != "") {
                uriParams = uriParams + "&q=" + q;
            }
        }
        if (uriParams != "") {
            listDraftPath = listDraftPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, listDraftPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];
        response.drafts = [];

        if (statusCode == 200) {
            if (jsonResponse.resultSizeEstimate != null) {
                response.resultSizeEstimate, _ = (int)jsonResponse.resultSizeEstimate;
            }
            if (jsonResponse.nextPageToken != null) {
                response.nextPageToken, _ = (string)jsonResponse.nextPageToken;
            }
            if (jsonResponse.drafts != null) {
                int lengthOfDrafts = jsons:getInt(jsonResponse.drafts, "$.length()");
                int a = 0;
                while (a < lengthOfDrafts) {
                    Draft draft = {};
                    EmailMessage mailMessage = {};
                    mailMessage.labelIds = [];
                    if (jsonResponse.drafts[a]["message"].payload != null) {
                        if (jsonResponse.drafts[a]["message"].payload.headers != null) {
                            int lengthOfHeader = jsons:getInt(jsonResponse.drafts[a]["message"].payload.headers,
                                                              "$.length()");
                            int j = 0;
                            while (j < lengthOfHeader) {
                                Header header = {};
                                if (jsonResponse.drafts[a]["message"].payload.headers[j].name != null) {
                                    header.name, _ = (string)jsonResponse.drafts[a]["message"].payload.headers[j].name;
                                }
                                if (jsonResponse.drafts[a]["message"].payload.headers[j].value != null) {
                                    header.value, _ = (string)jsonResponse.drafts[a]["message"].payload.headers[j].value;
                                }
                                messagePayload.headers[j] = header;
                                j = j + 1;
                            }
                        }
                        if (jsonResponse.drafts[a]["message"].payload.parts != null) {
                            int lengthOfParts = jsons:getInt(jsonResponse.drafts[a]["message"].payload.parts,
                                                             "$.length()");
                            int k = 0;
                            while (k < lengthOfParts) {
                                Parts parts = {};
                                Body body = {};
                                parts.headers = [];
                                if (jsonResponse.drafts[a]["message"].payload.parts[k].partId != null) {
                                    parts.partId, _ = (string)jsonResponse.drafts[a]["message"].payload.parts[k].partId;
                                }
                                if (jsonResponse.drafts[a]["message"].payload.parts[k].mimeType != null) {
                                    parts.mimeType, _ = (string)jsonResponse.drafts[a]["message"].
                                                                             payload.parts[k].mimeType;
                                }
                                if (jsonResponse.drafts[a]["message"].payload.parts[k].filename != null) {
                                    parts.filename, _ = (string)jsonResponse.drafts[a]["message"].payload.parts[k].
                                                                                                          filename;
                                }
                                if (jsonResponse.drafts[a]["message"].payload.parts[k].body.size != null) {
                                    body.size, _ = (int)jsonResponse.drafts[a]["message"].payload.parts[k].body.size;
                                }
                                if (jsonResponse.drafts[a]["message"].payload.parts[k].body.data != null) {
                                    body.data, _ = (string)jsonResponse.drafts[a]["message"].payload.parts[k].body.data;
                                }
                                if (jsonResponse.drafts[a]["message"].payload.parts[k].body.attachmentId != null) {
                                    body.attachmentId, _ = (string)jsonResponse.drafts[a]["message"]
                                                                                .payload.parts[k].body.attachmentId;
                                }
                                parts.body = body;
                                int lengthOfPartHeader = jsons:getInt(jsonResponse
                                                                      .drafts[a]["message"].payload.parts[k].headers,
                                                                      "$.length()");

                                int l = 0;
                                while (l < lengthOfPartHeader) {
                                    Header header_2 = {};
                                    if (jsonResponse.drafts[a]["message"].payload.parts[k].headers[l].name != null) {
                                        header_2.name, _ = (string)jsonResponse.drafts[a]["message"]
                                                                                .payload.parts[k].headers[l].name;
                                    }
                                    if (jsonResponse.drafts[a]["message"].payload.parts[k].headers[l].value != null) {
                                        header_2.value, _ = (string)jsonResponse.drafts[a]["message"]
                                                                                 .payload.parts[k].headers[l].value;
                                    }
                                    parts.headers[k] = header_2;
                                    l = l + 1;
                                }
                                messagePayload.parts[k] = parts;
                                k = k + 1;
                            }
                        }
                        Body body_2 = {};
                        if (jsonResponse.drafts[a]["message"].payload.body.size != null) {
                            body_2.size, _ = (int)jsonResponse.drafts[a]["message"].payload.body.size;
                        }
                        if (jsonResponse.drafts[a]["message"].payload.body.data != null) {
                            body_2.data, _ = (string)jsonResponse.drafts[a]["message"].payload.body.data;
                        }
                        if (jsonResponse.drafts[a]["message"].payload.body.attachmentId != null) {
                            body_2.attachmentId, _ = (string)jsonResponse.drafts[a]["message"].payload.body.attachmentId;
                        }
                        messagePayload.body = body_2;
                        if (jsonResponse.drafts[a]["message"].payload.filename != null) {
                            messagePayload.filename, _ = (string)jsonResponse.drafts[a]["message"].payload.filename;
                        }
                        if (jsonResponse.drafts[a]["message"].payload.mimeType != null) {
                            messagePayload.mimeType, _ = (string)jsonResponse.drafts[a]["message"].payload.mimeType;
                        }
                        if (jsonResponse.drafts[a]["message"].payload.partId != null) {
                            messagePayload.partId, _ = (string)jsonResponse.drafts[a]["message"].payload.partId;
                        }
                        mailMessage.payload = messagePayload;
                    }
                    if (jsonResponse.drafts[a]["message"].id != null) {
                        mailMessage.id, _ = (string)jsonResponse.drafts[a]["message"].id;
                    }
                    if (jsonResponse.drafts[a]["message"].threadId != null) {
                        mailMessage.threadId, _ = (string)jsonResponse.drafts[a]["message"].threadId;
                    }
                    if (jsonResponse.drafts[a]["message"].snippet != null) {
                        mailMessage.snippet, _ = (string)jsonResponse.drafts[a]["message"].snippet;
                    }
                    if (jsonResponse.drafts[a]["message"].historyId != null) {
                        mailMessage.historyId, _ = (string)jsonResponse.drafts[a]["message"].historyId;
                    }
                    if (jsonResponse.drafts[a]["message"].internalDate != null) {
                        mailMessage.internalDate, _ = (string)jsonResponse.drafts[a]["message"].internalDate;
                    }
                    if (jsonResponse.drafts[a]["message"].sizeEstimate != null) {
                        mailMessage.sizeEstimate, _ = (int)jsonResponse.drafts[a]["message"].sizeEstimate;
                    }
                    if (jsonResponse.drafts[a]["message"].labelIds != null) {
                        int lengthOfLabel = jsons:getInt(jsonResponse.drafts[a]["message"].labelIds, "$.length()");
                        int i = 0;
                        while (i < lengthOfLabel) {
                            mailMessage.labelIds[i], _ = (string)jsonResponse.drafts[a]["message"].labelIds[i];
                            i = i + 1;
                        }
                    }
                    draft.mailMessage = mailMessage;
                    if (jsonResponse.drafts[a].id != null) {
                        draft.id, _ = (string)jsonResponse.drafts[a].id;
                    }
                    response.drafts[a] = draft;
                    a = a + 1;
                }
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Delete a particular draft"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"draftId: Id of the draft to delete"}
    @doc:Return { value:"response structs"}
    action deleteDraft (ClientConnector g, string draftId) (StatusCode, Error) {
        StatusCode response = {};

        string deleteDraftPath = "/v1/users/" + userId + "/drafts/" + draftId;
        message responseMessage = oauth2:ClientConnector.delete (gmailEP, deleteDraftPath, request);
        int statusCode = http:getStatusCode(responseMessage);

        if (statusCode == 204) {
            response.statusCode = statusCode;
        } else {
            json jsonResponse = messages:getJsonPayload(responseMessage);
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Lists the history to of all changes to the given mailbox"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"startHistoryId: Returns history records after the specified startHistoryId"}
    @doc:Param { value:"listHistory: It is a struct. Which contains all optional parameters (labelId,
    maxResults,pageToken)"}
    @doc:Return { value:"response structs"}
    action listHistory (ClientConnector g, string startHistoryId, HistoryFilter listHistory) (HistoryList,
                                                                                              Error) {
        HistoryList response = {};
        string listHistoryPath = "/v1/users/" + userId + "/history?startHistoryId=" + startHistoryId;

        if (listHistory != null) {
            string labelId = listHistory.labelId;
            string maxResults = listHistory.maxResults;
            string pageToken = listHistory.pageToken;

            if (labelId != "") {
                listHistoryPath = listHistoryPath + "&labelId=" + labelId;
            }
            if (maxResults != "") {
                listHistoryPath = listHistoryPath + "&maxResults=" + maxResults;
            }
            if (pageToken != "") {
                listHistoryPath = listHistoryPath + "&pageToken=" + pageToken;
            }
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, listHistoryPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];
        response.history = [];

        if (statusCode == 200) {
            if (jsonResponse.nextPageToken != null) {
                response.nextPageToken, _ = (string)jsonResponse.nextPageToken;
            }
            if (jsonResponse.historyId != null) {
                response.historyId, _ = (string)jsonResponse.historyId;
            }
            if (jsonResponse.history != null) {
                int i = 0;
                int length = jsons:getInt(jsonResponse.history, "$.length()");
                while (i < length) {
                    History history = {};
                    history.messages = [];
                    history.messagesAdded = [];
                    history.messagesDeleted = [];
                    history.labelsAdded = [];
                    history.labelsRemoved = [];
                    if (jsonResponse.history[i].id != null) {
                        history.id, _ = (string)jsonResponse.history[i].id;
                    }

                    if (jsonResponse.history[i].messages != null) {
                        int lengthOfMessages = jsons:getInt(jsonResponse.history[i].messages, "$.length()");
                        int a = 0;
                        while (a < lengthOfMessages) {
                            EmailMessage mailMessage = {};
                            mailMessage.labelIds = [];
                            if (jsonResponse.history[i].messages[a].payload != null) {
                                if (jsonResponse.history[i].messages[a].payload.headers != null) {
                                    int lengthOfHeader = jsons:getInt(jsonResponse.
                                                                      history[i].messages[a].payload.headers,
                                                                      "$.length()");
                                    int j = 0;
                                    while (j < lengthOfHeader) {
                                        Header header = {};
                                        if (jsonResponse.history[i].messages[a].payload.headers[j].name != null) {
                                            header.name, _ = (string)jsonResponse.history[i].
                                                                                  messages[a].payload.headers[j].name;
                                        }
                                        if (jsonResponse.history[i].messages[a].payload.headers[j].value != null) {
                                            header.value, _ = (string)jsonResponse.history[i].
                                                                                   messages[a].payload.headers[j].value;
                                        }
                                        messagePayload.headers[j] = header;
                                        j = j + 1;
                                    }
                                }
                                if (jsonResponse.history[i].messages[a].payload.parts != null) {
                                    int lengthOfParts = jsons:getInt(jsonResponse.history[i].messages[a].payload.parts,
                                                                     "$.length()");
                                    int k = 0;
                                    while (k < lengthOfParts) {
                                        Parts parts = {};
                                        Body body = {};
                                        parts.headers = [];
                                        if (jsonResponse.history[i].messages[a].payload.parts[k].partId != null) {
                                            parts.partId, _ = (string)jsonResponse.history[i].
                                                                                   messages[a].payload.parts[k].partId;
                                        }
                                        if (jsonResponse.history[i].messages[a].payload.parts[k].
                                                                                        mimeType != null) {
                                            parts.mimeType, _ = (string)
                                                                jsonResponse.history[i].
                                                                             messages[a].payload.parts[k].mimeType;
                                        }
                                        if (jsonResponse.history[i].messages[a].payload.parts[k].filename != null) {
                                            parts.filename, _ = (string)jsonResponse.
                                                                        history[i].messages[a].payload.parts[k].filename;
                                        }
                                        if (jsonResponse.history[i].messages[a].payload.parts[k].body.size != null) {
                                            body.size, _ = (int)jsonResponse.history[i].
                                                                             messages[a].payload.parts[k].body.size;
                                        }
                                        if (jsonResponse.history[i].messages[a].payload.parts[k].body.data != null) {
                                            body.data, _ = (string)jsonResponse.history[i].
                                                                                messages[a].payload.parts[k].body.data;
                                        }
                                        if (jsonResponse.history[i].messages[a].
                                                                    payload.parts[k].body.attachmentId != null) {
                                            body.attachmentId, _ = (string)jsonResponse.
                                                                           history[i].messages[a].
                                                                                      payload.parts[k].body.attachmentId;
                                        }
                                        parts.body = body;
                                        int lengthOfPartHeader =
                                        jsons:getInt(jsonResponse.history[i].messages[a].payload.parts[k].headers,
                                                     "$.length()");

                                        int l = 0;
                                        while (l < lengthOfPartHeader) {
                                            Header header_2 = {};
                                            if (jsonResponse.history[i].messages[a].
                                                                        payload.parts[k].headers[l].name != null) {
                                                header_2.name, _ =
                                                (string)jsonResponse.history[i].
                                                                     messages[a].payload.parts[k].headers[l].name;
                                            }
                                            if (jsonResponse.history[i].messages[a].
                                                                        payload.parts[k].headers[l].value != null) {
                                                header_2.value, _ =
                                                (string)jsonResponse.history[i].messages[a].
                                                                                payload.parts[k].headers[l].value;
                                            }
                                            parts.headers[k] = header_2;
                                            l = l + 1;
                                        }
                                        messagePayload.parts[k] = parts;
                                        k = k + 1;
                                    }
                                }
                                Body body_2 = {};
                                if (jsonResponse.history[i].messages[a].payload.body.size != null) {
                                    body_2.size, _ = (int)jsonResponse.history[i].messages[a].payload.body.size;
                                }
                                if (jsonResponse.history[i].messages[a].payload.body.data != null) {
                                    body_2.data, _ = (string)jsonResponse.history[i].messages[a].payload.body.data;
                                }
                                if (jsonResponse.history[i].messages[a].payload.body.attachmentId != null) {
                                    body_2.attachmentId, _ = (string)jsonResponse.history[i].
                                                                                  messages[a].payload.body.attachmentId;
                                }
                                messagePayload.body = body_2;
                                if (jsonResponse.history[i].messages[a].payload.filename != null) {
                                    messagePayload.filename, _ = (string)jsonResponse.
                                                                         history[i].messages[a].payload.filename;
                                }
                                if (jsonResponse.history[i].messages[a].payload.mimeType != null) {
                                    messagePayload.mimeType, _ = (string)jsonResponse.
                                                                         history[i].messages[a].payload.mimeType;
                                }
                                if (jsonResponse.history[i].messages[a].payload.partId != null) {
                                    messagePayload.partId, _ = (string)jsonResponse.
                                                                       history[i].messages[a].payload.partId;
                                }
                                mailMessage.payload = messagePayload;
                            }
                            if (jsonResponse.history[i].messages[a].id != null) {
                                mailMessage.id, _ = (string)jsonResponse.history[i].messages[a].id;
                            }
                            if (jsonResponse.history[i].messages[a].threadId != null) {
                                mailMessage.threadId, _ = (string)jsonResponse.history[i].messages[a].threadId;
                            }
                            if (jsonResponse.history[i].messages[a].snippet != null) {
                                mailMessage.snippet, _ = (string)jsonResponse.history[i].messages[a].snippet;
                            }
                            if (jsonResponse.history[i].messages[a].historyId != null) {
                                mailMessage.historyId, _ = (string)jsonResponse.history[i].messages[a].historyId;
                            }
                            if (jsonResponse.history[i].messages[a].internalDate != null) {
                                mailMessage.internalDate, _ = (string)jsonResponse.history[i].messages[a].internalDate;
                            }
                            if (jsonResponse.history[i].messages[a].sizeEstimate != null) {
                                mailMessage.sizeEstimate, _ = (int)jsonResponse.history[i].messages[a].sizeEstimate;
                            }
                            if (jsonResponse.history[i].messages[a].labelIds != null) {
                                int lengthOfLabel = jsons:getInt(jsonResponse.history[i].messages[a].labelIds,
                                                                 "$.length()");
                                int l = 0;
                                while (l < lengthOfLabel) {
                                    mailMessage.labelIds[l], _ = (string)jsonResponse.history[i].messages[a].labelIds[l];
                                    l = l + 1;
                                }
                            }
                            history.messages[a] = mailMessage;
                            a = a + 1;
                        }
                    }

                    if (jsonResponse.history[i].messagesAdded != null) {
                        int lengthOfMessagesAdded = jsons:getInt(jsonResponse.history[i].messagesAdded, "$.length()");
                        int k = 0;
                        while (k < lengthOfMessagesAdded) {
                            int l = 0;
                            int lengthOfLabels = jsons:getInt(jsonResponse.history[i].messagesAdded[k]["message"].
                                                                                      labelIds, "$.length()");
                            Messages messagesAdded = {};
                            Email email = {};
                            email.labelIds = [];
                            if (jsonResponse.history[i].messagesAdded[k]["message"].id != null) {
                                email.id, _ = (string)jsonResponse.history[i].messagesAdded[k]["message"].id;
                            }
                            if (jsonResponse.history[i].messagesAdded[k]["message"].threadId != null) {
                                email.threadId, _ = (string)jsonResponse.history[i].messagesAdded[k]["message"].threadId;
                            }

                            while (l < lengthOfLabels) {
                                email.labelIds[l], _ = (string)jsonResponse.history[i].messagesAdded[k]["message"].
                                                                                       labelIds[l];
                                l = l + 1;
                            }
                            messagesAdded.emailMessage = email;
                            history.messagesAdded[k] = messagesAdded;
                            k = k + 1;
                        }
                    }
                    if (jsonResponse.history[i].messagesDeleted != null) {
                        int m = 0;
                        int lengthOfMessagesDeleted = jsons:getInt(jsonResponse.history[i].messagesDeleted, "$.length()");
                        while (m < lengthOfMessagesDeleted) {
                            int l = 0;
                            int lengthOfLabels = jsons:getInt(jsonResponse.history[i].messagesDeleted[m]["message"].
                                                                                      labelIds, "$.length()");
                            Messages messagesDeleted = {};
                            Email email = {};
                            email.labelIds = [];
                            if (jsonResponse.history[i].messagesDeleted[m]["message"].id != null) {
                                email.id, _ = (string)jsonResponse.history[i].messagesDeleted[m]["message"].id;
                            }
                            if (jsonResponse.history[i].messagesDeleted[m]["message"].threadId != null) {
                                email.threadId, _ = (string)jsonResponse.history[i].messagesDeleted[m]["message"].
                                                                                    threadId;
                            }

                            while (l < lengthOfLabels) {
                                email.labelIds[l], _ = (string)jsonResponse.history[i].messagesDeleted[m]["message"].
                                                                                       labelIds[l];
                                l = l + 1;
                            }
                            messagesDeleted.emailMessage = email;
                            history.messagesDeleted[m] = messagesDeleted;
                            m = m + 1;
                        }
                    }
                    if (jsonResponse.history[i].labelsAdded != null) {
                        int p = 0;
                        int lengthOfLabelsAdded = jsons:getInt(jsonResponse.history[i].labelsAdded, "$.length()");
                        while (p < lengthOfLabelsAdded) {
                            int l = 0;
                            int lengthOfLabels = jsons:getInt(jsonResponse.history[i].labelsAdded[p]["message"].
                                                                                      labelIds, "$.length()");
                            Messages labelsAdded = {};
                            Email email = {};
                            email.labelIds = [];
                            if (jsonResponse.history[i].labelsAdded[p]["message"].id != null) {
                                email.id, _ = (string)jsonResponse.history[i].labelsAdded[p]["message"].id;
                            }
                            if (jsonResponse.history[i].labelsAdded[p]["message"].threadId != null) {
                                email.threadId, _ = (string)jsonResponse.history[i].labelsAdded[p]["message"].threadId;
                            }

                            while (l < lengthOfLabels) {
                                email.labelIds[l], _ = (string)jsonResponse.history[i].labelsAdded[p]["message"].
                                                                                       labelIds[l];
                                l = l + 1;
                            }
                            labelsAdded.emailMessage = email;
                            history.labelsAdded[p] = labelsAdded;
                            p = p + 1;
                        }
                    }
                    if (jsonResponse.history[i].labelsRemoved != null) {
                        int q = 0;
                        int lengthOfLabelsRemoved = jsons:getInt(jsonResponse.history[i].labelsRemoved, "$.length()");
                        while (q < lengthOfLabelsRemoved) {
                            int l = 0;
                            int lengthOfLabels = jsons:getInt(jsonResponse.history[i].labelsAdded[q]["message"].labelIds,
                                                              "$.length()");
                            Messages labelsRemoved = {};
                            Email email = {};
                            email.labelIds = [];
                            if (jsonResponse.history[i].labelsRemoved[q]["message"].id != null) {
                                email.id, _ = (string)jsonResponse.history[i].labelsRemoved[q]["message"].id;
                            }
                            if (jsonResponse.history[i].labelsRemoved[q]["message"].threadId != null) {
                                email.threadId, _ = (string)jsonResponse.history[i].labelsRemoved[q]["message"].threadId;
                            }

                            while (l < lengthOfLabels) {
                                email.labelIds[l], _ = (string)jsonResponse.history[i].labelsRemoved[q]["message"].
                                                                                       labelIds[l];
                                l = l + 1;
                            }
                            labelsRemoved.emailMessage = email;
                            history.labelsRemoved[q] = labelsRemoved;
                            q = q + 1;
                        }
                    }
                    response.history[i] = history;
                    i = i + 1;
                }
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }
    @doc:Description { value:"Create a new label"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"labelName: The display name of the label"}
    @doc:Param { value:"messageListVisibility: The visibility of messages with this label in the message list in the
                                        Gmail web interface"}
    @doc:Param { value:"labelListVisibility: The visibility of the label in the label list in the Gmail web interface"}
    @doc:Param { value:"createLabel: It is a struct. Which contains all optional parameters (types,messagesTotal,
    messagesUnread,threadsTotal,threadsUnread)"}
    @doc:Return { value:"response structs"}
    action createLabel (ClientConnector g, string labelName, string messageListVisibility, string labelListVisibility,
                        EmailLabel createLabel) (Label, Error) {
        Label response = {};
        string createLabelPath = "/v1/users/" + userId + "/labels";
        json createLabelRequest = {"name":labelName, "messageListVisibility":messageListVisibility,
                                  "labelListVisibility":labelListVisibility};
        if (createLabel != null) {
            string types = createLabel.types;
            string messagesTotal = createLabel.messagesTotal;
            string messagesUnread = createLabel.messagesUnread;
            string threadsTotal = createLabel.threadsTotal;
            string threadsUnread = createLabel.threadsUnread;

            if (types != "") {
                createLabelRequest.type = types;
            }

            if (messagesTotal != "") {
                createLabelRequest.messagesTotal = messagesTotal;
            }

            if (messagesUnread != "") {
                createLabelRequest.messagesUnread = messagesUnread;
            }

            if (threadsTotal != "") {
                createLabelRequest.threadsTotal = threadsTotal;
            }

            if (threadsUnread != "") {
                createLabelRequest.threadsUnread = threadsUnread;
            }
        }
        messages:setHeader(request, "Content-Type", "Application/json");
        messages:setJsonPayload(request, createLabelRequest);
        message responseMessage = oauth2:ClientConnector.post (gmailEP, createLabelPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        if (statusCode == 200) {
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
            if (jsonResponse.name != null) {
                response.name, _ = (string)jsonResponse.name;
            }
            if (jsonResponse.messageListVisibility != null) {
                response.messageListVisibility, _ = (string)jsonResponse.messageListVisibility;
            }
            if (jsonResponse.labelListVisibility != null) {
                response.labelListVisibility, _ = (string)jsonResponse.labelListVisibility;
            }
            if (jsonResponse.type != null) {
                response.type, _ = (string)jsonResponse.type;
            }
            if (jsonResponse.messagesTotal != null) {
                response.messagesTotal, _ = (int)jsonResponse.messagesTotal;
            }
            if (jsonResponse.messagesUnread != null) {
                response.messagesUnread, _ = (int)jsonResponse.messagesUnread;
            }
            if (jsonResponse.threadsTotal != null) {
                response.threadsTotal, _ = (int)jsonResponse.threadsTotal;
            }
            if (jsonResponse.threadsUnread != null) {
                response.threadsUnread, _ = (int)jsonResponse.threadsUnread;
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Delete a particular label"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"labelId: Id of the label to delete"}
    @doc:Return { value:"response struct"}
    action deleteLabel (ClientConnector g, string labelId) (StatusCode, Error) {
        StatusCode response = {};

        string deleteLabelPath = "/v1/users/" + userId + "/labels/" + labelId;
        message responseMessage = oauth2:ClientConnector.delete (gmailEP, deleteLabelPath, request);
        int statusCode = http:getStatusCode(responseMessage);

        if (statusCode == 204) {
            response.statusCode = statusCode;
        } else {
            json jsonResponse = messages:getJsonPayload(responseMessage);
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Lists all labels in the user's mailbox"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Return { value:"response struct"}
    action listLabels (ClientConnector g) (Labels, Error) {
        Labels response = {};

        string listLabelPath = "/v1/users/" + userId + "/labels/";
        message responseMessage = oauth2:ClientConnector.get (gmailEP, listLabelPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);
        response.labels = [];

        if (statusCode == 200) {
            int length = jsons:getInt(jsonResponse.labels, "$.length()");
            int i = 0;
            while (i < length) {
                Label label = {};
                if (jsonResponse.labels[i].id != null) {
                    label.id, _ = (string)jsonResponse.labels[i].id;
                }
                if (jsonResponse.labels[i].name != null) {
                    label.name, _ = (string)jsonResponse.labels[i].name;
                }
                if (jsonResponse.labels[i].messageListVisibility != null) {
                    label.messageListVisibility, _ = (string)jsonResponse.labels[i].messageListVisibility;
                }
                if (jsonResponse.labels[i].labelListVisibility != null) {
                    label.labelListVisibility, _ = (string)jsonResponse.labels[i].labelListVisibility;
                }
                if (jsonResponse.labels[i].type != null) {
                    label.type, _ = (string)jsonResponse.labels[i].type;
                }
                if (jsonResponse.labels[i].messagesTotal != null) {
                    label.messagesTotal, _ = (int)jsonResponse.labels[i].messagesTotal;
                }
                if (jsonResponse.labels[i].messagesUnread != null) {
                    label.messagesUnread, _ = (int)jsonResponse.labels[i].messagesUnread;
                }
                if (jsonResponse.labels[i].threadsTotal != null) {
                    label.threadsTotal, _ = (int)jsonResponse.labels[i].threadsTotal;
                }
                if (jsonResponse.labels[i].threadsUnread != null) {
                    label.threadsUnread, _ = (int)jsonResponse.labels[i].threadsUnread;
                }
                response.labels[i] = label;
                i = i + 1;
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Update a particular label"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"labelId: The Id of the label to update"}
    @doc:Param { value:"labelName: The display name of the label"}
    @doc:Param { value:"messageListVisibility: The visibility of messages with this label in the message list in the
                                        Gmail web interface"}
    @doc:Param { value:"labelListVisibility: The visibility of the label in the label list in the Gmail web interface"}
    @doc:Param { value:"updateLabel: It is a struct. Which contains all optional parameters (types,messagesTotal
                                        ,messagesUnread,threadsUnread)"}
    @doc:Return { value:"response struct"}
    action updateLabel (ClientConnector g, string labelId, string labelName, string messageListVisibility,
                        string labelListVisibility, EmailLabel updateLabel) (Label, Error) {
        Label response = {};
        string updateLabelPath = "/v1/users/" + userId + "/labels/" + labelId;
        json updateLabelRequest = {"id":labelId, "name":labelName, "messageListVisibility":messageListVisibility,
                                  "labelListVisibility":labelListVisibility};

        if (updateLabel != null) {
            string types = updateLabel.types;
            string messagesTotal = updateLabel.messagesTotal;
            string messagesUnread = updateLabel.messagesUnread;
            string threadsTotal = updateLabel.threadsTotal;
            string threadsUnread = updateLabel.threadsUnread;

            if (types != "") {
                updateLabelRequest.type = types;
            }

            if (messagesTotal != "") {
                updateLabelRequest.messagesTotal = messagesTotal;
            }

            if (messagesUnread != "") {
                updateLabelRequest.messagesUnread = messagesUnread;
            }

            if (threadsTotal != "") {
                updateLabelRequest.threadsTotal = threadsTotal;
            }

            if (threadsUnread != "") {
                updateLabelRequest.threadsUnread = threadsUnread;
            }
        }
        messages:setHeader(request, "Content-Type", "Application/json");
        messages:setJsonPayload(request, updateLabelRequest);
        message responseMessage = oauth2:ClientConnector.put (gmailEP, updateLabelPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        if (statusCode == 200) {
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
            if (jsonResponse.name != null) {
                response.name, _ = (string)jsonResponse.name;
            }
            if (jsonResponse.messageListVisibility != null) {
                response.messageListVisibility, _ = (string)jsonResponse.messageListVisibility;
            }
            if (jsonResponse.labelListVisibility != null) {
                response.labelListVisibility, _ = (string)jsonResponse.labelListVisibility;
            }
            if (jsonResponse.type != null) {
                response.type, _ = (string)jsonResponse.type;
            }
            if (jsonResponse.messagesTotal != null) {
                response.messagesTotal, _ = (int)jsonResponse.messagesTotal;
            }
            if (jsonResponse.messagesUnread != null) {
                response.messagesUnread, _ = (int)jsonResponse.messagesUnread;
            }
            if (jsonResponse.threadsTotal != null) {
                response.threadsTotal, _ = (int)jsonResponse.threadsTotal;
            }
            if (jsonResponse.threadsUnread != null) {
                response.threadsUnread, _ = (int)jsonResponse.threadsUnread;
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Retrieve a particular label"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"labelId: Id of the label to retrieve"}
    @doc:Return { value:"response struct"}
    action readLabel (ClientConnector g, string labelId) (Label, Error) {
        Label response = {};

        string readLabelPath = "/v1/users/" + userId + "/labels/" + labelId;
        message responseMessage = oauth2:ClientConnector.get (gmailEP, readLabelPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        if (statusCode == 200) {
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
            if (jsonResponse.name != null) {
                response.name, _ = (string)jsonResponse.name;
            }
            if (jsonResponse.messageListVisibility != null) {
                response.messageListVisibility, _ = (string)jsonResponse.messageListVisibility;
            }
            if (jsonResponse.labelListVisibility != null) {
                response.labelListVisibility, _ = (string)jsonResponse.labelListVisibility;
            }
            if (jsonResponse.type != null) {
                response.type, _ = (string)jsonResponse.type;
            }
            if (jsonResponse.messagesTotal != null) {
                response.messagesTotal, _ = (int)jsonResponse.messagesTotal;
            }
            if (jsonResponse.messagesUnread != null) {
                response.messagesUnread, _ = (int)jsonResponse.messagesUnread;
            }
            if (jsonResponse.threadsTotal != null) {
                response.threadsTotal, _ = (int)jsonResponse.threadsTotal;
            }
            if (jsonResponse.threadsUnread != null) {
                response.threadsUnread, _ = (int)jsonResponse.threadsUnread;
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Retrieve a particular Thread"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"threadId: Id of the thread to retrieve"}
    @doc:Param { value:"readThread: It is a struct. Which contains all optional parameters (format,metaDataHeaders)"}
    @doc:Return { value:"response struct"}
    action readThread (ClientConnector g, string threadId, ThreadFilter readThread) (Thread, Error) {
        Thread response = {};
        string uriParams;

        string readThreadPath = "/v1/users/" + userId + "/threads/" + threadId;

        if (readThread != null) {
            string format = readThread.format;
            string metaDataHeaders = readThread.metaDataHeaders;

            if (format != "") {
                uriParams = uriParams + "&format=" + format;
            }

            if (metaDataHeaders != "") {
                uriParams = uriParams + "&metaDataHeaders=" + metaDataHeaders;
            }
        }

        if (uriParams != "") {
            readThreadPath = readThreadPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, readThreadPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];
        response.messages = [];

        if (statusCode == 200) {
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
            if (jsonResponse.snippet != null) {
                response.snippet, _ = (string)jsonResponse.snippet;
            }
            if (jsonResponse.historyId != null) {
                response.historyId, _ = (string)jsonResponse.historyId;
            }

            if (jsonResponse.messages != null) {
                int lengthOfMessages = jsons:getInt(jsonResponse.messages, "$.length()");
                int a = 0;
                while (a < lengthOfMessages) {
                    EmailMessage mailMessage = {};
                    mailMessage.labelIds = [];
                    if (jsonResponse.messages[a].payload != null) {
                        if (jsonResponse.messages[a].payload.headers != null) {
                            int lengthOfHeader = jsons:getInt(jsonResponse.messages[a].payload.headers, "$.length()");
                            int j = 0;
                            while (j < lengthOfHeader) {
                                Header header = {};
                                if (jsonResponse.messages[a].payload.headers[j].name != null) {
                                    header.name, _ = (string)jsonResponse.messages[a].payload.headers[j].name;
                                }
                                if (jsonResponse.messages[a].payload.headers[j].value != null) {
                                    header.value, _ = (string)jsonResponse.messages[a].payload.headers[j].value;
                                }
                                messagePayload.headers[j] = header;
                                j = j + 1;
                            }
                        }
                        if (jsonResponse.messages[a].payload.parts != null) {
                            int lengthOfParts = jsons:getInt(jsonResponse.messages[a].payload.parts, "$.length()");
                            int k = 0;
                            while (k < lengthOfParts) {
                                Parts parts = {};
                                Body body = {};
                                parts.headers = [];
                                if (jsonResponse.messages[a].payload.parts[k].partId != null) {
                                    parts.partId, _ = (string)jsonResponse.messages[a].payload.parts[k].partId;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].mimeType != null) {
                                    parts.mimeType, _ = (string)jsonResponse.messages[a].payload.parts[k].mimeType;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].filename != null) {
                                    parts.filename, _ = (string)jsonResponse.messages[a].payload.parts[k].filename;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.size != null) {
                                    body.size, _ = (int)jsonResponse.messages[a].payload.parts[k].body.size;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.data != null) {
                                    body.data, _ = (string)jsonResponse.messages[a].payload.parts[k].body.data;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.attachmentId != null) {
                                    body.attachmentId, _ = (string)jsonResponse.
                                                                   messages[a].payload.parts[k].body.attachmentId;
                                }
                                parts.body = body;
                                int lengthOfPartHeader = jsons:getInt(jsonResponse.messages[a].payload.parts[k].headers,
                                                                      "$.length()");

                                int l = 0;
                                while (l < lengthOfPartHeader) {
                                    Header header_2 = {};
                                    if (jsonResponse.messages[a].payload.parts[k].headers[l].name != null) {
                                        header_2.name, _ = (string)jsonResponse.
                                                                   messages[a].payload.parts[k].headers[l].name;
                                    }
                                    if (jsonResponse.messages[a].payload.parts[k].headers[l].value != null) {
                                        header_2.value, _ = (string)jsonResponse.
                                                                    messages[a].payload.parts[k].headers[l].value;
                                    }
                                    parts.headers[k] = header_2;
                                    l = l + 1;
                                }
                                messagePayload.parts[k] = parts;
                                k = k + 1;
                            }
                        }
                        Body body_2 = {};
                        if (jsonResponse.messages[a].payload.body.size != null) {
                            body_2.size, _ = (int)jsonResponse.messages[a].payload.body.size;
                        }
                        if (jsonResponse.messages[a].payload.body.data != null) {
                            body_2.data, _ = (string)jsonResponse.messages[a].payload.body.data;
                        }
                        if (jsonResponse.messages[a].payload.body.attachmentId != null) {
                            body_2.attachmentId, _ = (string)jsonResponse.messages[a].payload.body.attachmentId;
                        }
                        messagePayload.body = body_2;
                        if (jsonResponse.messages[a].payload.filename != null) {
                            messagePayload.filename, _ = (string)jsonResponse.messages[a].payload.filename;
                        }
                        if (jsonResponse.messages[a].payload.mimeType != null) {
                            messagePayload.mimeType, _ = (string)jsonResponse.messages[a].payload.mimeType;
                        }
                        if (jsonResponse.messages[a].payload.partId != null) {
                            messagePayload.partId, _ = (string)jsonResponse.messages[a].payload.partId;
                        }
                        mailMessage.payload = messagePayload;
                    }
                    if (jsonResponse.messages[a].id != null) {
                        mailMessage.id, _ = (string)jsonResponse.messages[a].id;
                    }
                    if (jsonResponse.messages[a].threadId != null) {
                        mailMessage.threadId, _ = (string)jsonResponse.messages[a].threadId;
                    }
                    if (jsonResponse.messages[a].snippet != null) {
                        mailMessage.snippet, _ = (string)jsonResponse.messages[a].snippet;
                    }
                    if (jsonResponse.messages[a].historyId != null) {
                        mailMessage.historyId, _ = (string)jsonResponse.messages[a].historyId;
                    }
                    if (jsonResponse.messages[a].internalDate != null) {
                        mailMessage.internalDate, _ = (string)jsonResponse.messages[a].internalDate;
                    }
                    if (jsonResponse.messages[a].sizeEstimate != null) {
                        mailMessage.sizeEstimate, _ = (int)jsonResponse.messages[a].sizeEstimate;
                    }
                    if (jsonResponse.messages[a].labelIds != null) {
                        int lengthOfLabel = jsons:getInt(jsonResponse.messages[a].labelIds, "$.length()");
                        int i = 0;
                        while (i < lengthOfLabel) {
                            mailMessage.labelIds[i], _ = (string)jsonResponse.messages[a].labelIds[i];
                            i = i + 1;
                        }
                    }
                    response.messages[a] = mailMessage;
                    a = a + 1;
                }
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Lists the threads in the user's mailbox"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"listThreads: It is a struct. Which contains all optional parameters (includeSpamTrash,labelIds
    ,maxResults,pageToken,q)"}
    @doc:Return { value:"response struct"}
    action listThreads (ClientConnector g, ThreadListFilter listThreads) (Threads, Error) {
        Threads response = {};
        string uriParams;
        string listThreadPath = "/v1/users/" + userId + "/threads";

        if (listThreads != null) {
            string includeSpamTrash = listThreads.includeSpamTrash;
            string labelIds = listThreads.labelIds;
            string maxResults = listThreads.maxResults;
            string pageToken = listThreads.pageToken;
            string q = listThreads.q;

            if (includeSpamTrash != "") {
                uriParams = uriParams + "&includeSpamTrash=" + includeSpamTrash;
            }

            if (labelIds != "") {
                uriParams = uriParams + "&labelIds=" + labelIds;
            }

            if (maxResults != "") {
                uriParams = uriParams + "&maxResults=" + maxResults;
            }

            if (pageToken != "") {
                uriParams = uriParams + "&pageToken=" + pageToken;
            }

            if (q != "") {
                uriParams = uriParams + "&q=" + q;
            }
        }

        if (uriParams != "") {
            listThreadPath = listThreadPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, listThreadPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];
        response.threads = [];

        if (statusCode == 200) {
            if (jsonResponse.resultSizeEstimate != null) {
                response.resultSizeEstimate, _ = (int)jsonResponse.resultSizeEstimate;
            }
            if (jsonResponse.nextPageToken != null) {
                response.nextPageToken, _ = (string)jsonResponse.nextPageToken;
            }
            if (jsonResponse.threads != null) {
                int lengthOfThreads = jsons:getInt(jsonResponse.threads, "$.length()");
                int a = 0;
                int m = 0;
                while (a < lengthOfThreads) {
                    Thread thread = {};
                    thread.messages = [];
                    EmailMessage mailMessage = {};
                    mailMessage.labelIds = [];
                    if (jsonResponse.threads[a].messages != null) {
                        int lengthOfMessages = jsons:getInt(jsonResponse.threads[a].messages, "$.length()");
                        while (m < lengthOfMessages) {
                            if (jsonResponse.threads[a].messages[m].payload != null) {
                                if (jsonResponse.threads[a].messages[m].payload.headers != null) {
                                    int lengthOfHeader = jsons:getInt(jsonResponse.threads[a].messages[m].payload.headers,
                                                                      "$.length()");
                                    int j = 0;
                                    while (j < lengthOfHeader) {
                                        Header header = {};
                                        if (jsonResponse.threads[a].messages[m].payload.headers[j].name != null) {
                                            header.name, _ = (string)jsonResponse.threads[a].
                                                                                  messages[m].payload.headers[j].name;
                                        }
                                        if (jsonResponse.threads[a].messages[m].payload.headers[j].value != null) {
                                            header.value, _ = (string)jsonResponse.threads[a].
                                                                                   messages[m].payload.headers[j].value;
                                        }
                                        messagePayload.headers[j] = header;
                                        j = j + 1;
                                    }
                                }
                                if (jsonResponse.threads[a].messages[m].payload.parts != null) {
                                    int lengthOfParts = jsons:getInt(jsonResponse.threads[a].messages[m].payload.parts,
                                                                     "$.length()");
                                    int k = 0;
                                    while (k < lengthOfParts) {
                                        Parts parts = {};
                                        Body body = {};
                                        parts.headers = [];
                                        if (jsonResponse.threads[a].messages[m].payload.parts[k].partId != null) {
                                            parts.partId, _ = (string)jsonResponse.threads[a].
                                                                                   messages[m].payload.parts[k].partId;
                                        }
                                        if (jsonResponse.threads[a].messages[m].payload.parts[k].mimeType != null) {
                                            parts.mimeType, _ = (string)jsonResponse.
                                                                        threads[a].messages[m].payload.parts[k].mimeType;
                                        }
                                        if (jsonResponse.threads[a].messages[m].payload.parts[k].filename != null) {
                                            parts.filename, _ = (string)jsonResponse.
                                                                        threads[a].messages[m].payload.parts[k].filename;
                                        }
                                        if (jsonResponse.threads[a].messages[m].payload.parts[k].body.size != null) {
                                            body.size, _ = (int)jsonResponse.
                                                                threads[a].messages[m].payload.parts[k].body.size;
                                        }
                                        if (jsonResponse.threads[a].messages[m].payload.parts[k].body.data != null) {
                                            body.data, _ = (string)jsonResponse[m].
                                                                   threads[a].messages.payload.parts[k].body.data;
                                        }
                                        if (jsonResponse.threads[a].messages[m].payload.
                                                                                parts[k].body.attachmentId != null) {
                                            body.attachmentId, _ =
                                            (string)jsonResponse.threads[a].messages[m].payload.parts[k].body.attachmentId;
                                        }
                                        parts.body = body;
                                        int lengthOfPartHeader =
                                        jsons:getInt(jsonResponse.threads[a].messages[m].payload.parts[k].headers,
                                                     "$.length()");

                                        int l = 0;
                                        while (l < lengthOfPartHeader) {
                                            Header header_2 = {};
                                            if (jsonResponse.threads[a].messages[m].
                                                                        payload.parts[k].headers[l].name != null) {
                                                header_2.name, _ =
                                                (string)jsonResponse.threads[a].messages[m].payload.parts[k].
                                                                                                    headers[l].name;
                                            }
                                            if (jsonResponse.threads[a].
                                                             messages[m].payload.parts[k].headers[l].value != null) {
                                                header_2.value, _ =
                                                (string)jsonResponse.threads[a].messages[m].payload.
                                                                                            parts[k].headers[l].value;
                                            }
                                            parts.headers[k] = header_2;
                                            l = l + 1;
                                        }
                                        messagePayload.parts[k] = parts;
                                        k = k + 1;
                                    }
                                }
                                Body body_2 = {};
                                if (jsonResponse.threads[a].messages[m].payload.body.size != null) {
                                    body_2.size, _ = (int)jsonResponse.threads[a].messages[m].payload.body.size;
                                }
                                if (jsonResponse.threads[a].messages[m].payload.body.data != null) {
                                    body_2.data, _ = (string)jsonResponse.threads[a].messages[m].payload.body.data;
                                }
                                if (jsonResponse.threads[a].messages[m].payload.body.attachmentId != null) {
                                    body_2.attachmentId, _ = (string)jsonResponse.threads[a].
                                                                                  messages[m].payload.body.attachmentId;
                                }
                                messagePayload.body = body_2;
                                if (jsonResponse.threads[a].messages[m].payload.filename != null) {
                                    messagePayload.filename, _ = (string)jsonResponse.threads[a].
                                                                                      messages[m].payload.filename;
                                }
                                if (jsonResponse.threads[a].messages[m].payload.mimeType != null) {
                                    messagePayload.mimeType, _ = (string)jsonResponse.threads[a].
                                                                                      messages[m].payload.mimeType;
                                }
                                if (jsonResponse.threads[a].messages[m].payload.partId != null) {
                                    messagePayload.partId, _ = (string)jsonResponse.threads[a].
                                                                                    messages[m].payload.partId;
                                }
                                mailMessage.payload = messagePayload;
                            }
                            if (jsonResponse.threads[a].messages[m].id != null) {
                                mailMessage.id, _ = (string)jsonResponse.threads[a].messages[m].id;
                            }
                            if (jsonResponse.threads[a].messages[m].threadId != null) {
                                mailMessage.threadId, _ = (string)jsonResponse.threads[a].messages[m].threadId;
                            }
                            if (jsonResponse.threads[a].messages[m].snippet != null) {
                                mailMessage.snippet, _ = (string)jsonResponse.threads[a].messages[m].snippet;
                            }
                            if (jsonResponse.threads[a].messages[m].historyId != null) {
                                mailMessage.historyId, _ = (string)jsonResponse.threads[a].messages[m].historyId;
                            }
                            if (jsonResponse.threads[a].messages[m].internalDate != null) {
                                mailMessage.internalDate, _ = (string)jsonResponse.threads[a].messages[m].internalDate;
                            }

                            if (jsonResponse.threads[a].messages[m].sizeEstimate != null) {
                                mailMessage.sizeEstimate, _ = (int)jsonResponse.threads[a].messages[m].sizeEstimate;
                            }
                            if (jsonResponse.threads[a].messages[m].labelIds != null) {
                                int lengthOfLabel = jsons:getInt(jsonResponse.threads[a].messages[m].labelIds,
                                                                 "$.length()");
                                int i = 0;
                                while (i < lengthOfLabel) {
                                    mailMessage.labelIds[i], _ = (string)jsonResponse.threads[a].messages[m].labelIds[i];
                                    i = i + 1;
                                }
                            }
                            thread.messages[m] = mailMessage;
                        }
                    }
                    if (jsonResponse.threads[a].id != null) {
                        thread.id, _ = (string)jsonResponse.threads[a].id;
                    }
                    if (jsonResponse.threads[a].snippet != null) {
                        thread.snippet, _ = (string)jsonResponse.threads[a].snippet;
                    }
                    if (jsonResponse.threads[a].historyId != null) {
                        thread.historyId, _ = (string)jsonResponse.threads[a].historyId;
                    }
                    response.threads[a] = thread;
                    a = a + 1;
                }
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Delete a particular thread"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"threadId: Id of the thread to delete"}
    @doc:Return { value:"response struct"}
    action deleteThread (ClientConnector g, string threadId) (StatusCode, Error) {
        StatusCode response = {};

        string deleteThreadPath = "/v1/users/" + userId + "/threads/" + threadId;
        message responseMessage = oauth2:ClientConnector.delete (gmailEP, deleteThreadPath, request);
        int statusCode = http:getStatusCode(responseMessage);

        if (statusCode == 204) {
            response.statusCode = statusCode;
        } else {
            json jsonResponse = messages:getJsonPayload(responseMessage);
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Trash a particular thread"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"threadId: Id of the thread to Trash"}
    @doc:Return { value:"response struct"}
    action trashThread (ClientConnector g, string threadId) (Thread, Error) {
        Thread response = {};

        string trashThreadPath = "/v1/users/" + userId + "/threads/" + threadId + "/trash";
        http:setContentLength(request, 0);
        message responseMessage = oauth2:ClientConnector.post (gmailEP, trashThreadPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];
        response.messages = [];

        if (statusCode == 200) {
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
            if (jsonResponse.snippet != null) {
                response.snippet, _ = (string)jsonResponse.snippet;
            }
            if (jsonResponse.historyId != null) {
                response.historyId, _ = (string)jsonResponse.historyId;
            }

            if (jsonResponse.messages != null) {
                int lengthOfMessages = jsons:getInt(jsonResponse.messages, "$.length()");
                int a = 0;
                while (a < lengthOfMessages) {
                    EmailMessage mailMessage = {};
                    mailMessage.labelIds = [];
                    if (jsonResponse.messages[a].payload != null) {
                        if (jsonResponse.messages[a].payload.headers != null) {
                            int lengthOfHeader = jsons:getInt(jsonResponse.messages[a].payload.headers, "$.length()");
                            int j = 0;
                            while (j < lengthOfHeader) {
                                Header header = {};
                                if (jsonResponse.messages[a].payload.headers[j].name != null) {
                                    header.name, _ = (string)jsonResponse.messages[a].payload.headers[j].name;
                                }
                                if (jsonResponse.messages[a].payload.headers[j].value != null) {
                                    header.value, _ = (string)jsonResponse.messages[a].payload.headers[j].value;
                                }
                                messagePayload.headers[j] = header;
                                j = j + 1;
                            }
                        }
                        if (jsonResponse.messages[a].payload.parts != null) {
                            int lengthOfParts = jsons:getInt(jsonResponse.messages[a].payload.parts, "$.length()");
                            int k = 0;
                            while (k < lengthOfParts) {
                                Parts parts = {};
                                Body body = {};
                                parts.headers = [];
                                if (jsonResponse.messages[a].payload.parts[k].partId != null) {
                                    parts.partId, _ = (string)jsonResponse.messages[a].payload.parts[k].partId;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].mimeType != null) {
                                    parts.mimeType, _ = (string)jsonResponse.messages[a].payload.parts[k].mimeType;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].filename != null) {
                                    parts.filename, _ = (string)jsonResponse.messages[a].payload.parts[k].filename;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.size != null) {
                                    body.size, _ = (int)jsonResponse.messages[a].payload.parts[k].body.size;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.data != null) {
                                    body.data, _ = (string)jsonResponse.messages[a].payload.parts[k].body.data;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.attachmentId != null) {
                                    body.attachmentId, _ = (string)jsonResponse.
                                                                   messages[a].payload.parts[k].body.attachmentId;
                                }
                                parts.body = body;
                                int lengthOfPartHeader = jsons:getInt(jsonResponse.messages[a].payload.parts[k].headers,
                                                                      "$.length()");

                                int l = 0;
                                while (l < lengthOfPartHeader) {
                                    Header header_2 = {};
                                    if (jsonResponse.messages[a].payload.parts[k].headers[l].name != null) {
                                        header_2.name, _ = (string)jsonResponse.messages[a].payload.
                                                                                            parts[k].headers[l].name;
                                    }
                                    if (jsonResponse.messages[a].payload.parts[k].headers[l].value != null) {
                                        header_2.value, _ = (string)jsonResponse.messages[a].
                                                                                 payload.parts[k].headers[l].value;
                                    }
                                    parts.headers[k] = header_2;
                                    l = l + 1;
                                }
                                messagePayload.parts[k] = parts;
                                k = k + 1;
                            }
                        }
                        Body body_2 = {};
                        if (jsonResponse.messages[a].payload.body.size != null) {
                            body_2.size, _ = (int)jsonResponse.messages[a].payload.body.size;
                        }
                        if (jsonResponse.messages[a].payload.body.data != null) {
                            body_2.data, _ = (string)jsonResponse.messages[a].payload.body.data;
                        }
                        if (jsonResponse.messages[a].payload.body.attachmentId != null) {
                            body_2.attachmentId, _ = (string)jsonResponse.messages[a].payload.body.attachmentId;
                        }
                        messagePayload.body = body_2;
                        if (jsonResponse.messages[a].payload.filename != null) {
                            messagePayload.filename, _ = (string)jsonResponse.messages[a].payload.filename;
                        }
                        if (jsonResponse.messages[a].payload.mimeType != null) {
                            messagePayload.mimeType, _ = (string)jsonResponse.messages[a].payload.mimeType;
                        }
                        if (jsonResponse.messages[a].payload.partId != null) {
                            messagePayload.partId, _ = (string)jsonResponse.messages[a].payload.partId;
                        }
                        mailMessage.payload = messagePayload;
                    }
                    if (jsonResponse.messages[a].id != null) {
                        mailMessage.id, _ = (string)jsonResponse.messages[a].id;
                    }
                    if (jsonResponse.messages[a].threadId != null) {
                        mailMessage.threadId, _ = (string)jsonResponse.messages[a].threadId;
                    }
                    if (jsonResponse.messages[a].snippet != null) {
                        mailMessage.snippet, _ = (string)jsonResponse.messages[a].snippet;
                    }
                    if (jsonResponse.messages[a].historyId != null) {
                        mailMessage.historyId, _ = (string)jsonResponse.messages[a].historyId;
                    }
                    if (jsonResponse.messages[a].internalDate != null) {
                        mailMessage.internalDate, _ = (string)jsonResponse.messages[a].internalDate;
                    }
                    if (jsonResponse.messages[a].sizeEstimate != null) {
                        mailMessage.sizeEstimate, _ = (int)jsonResponse.messages[a].sizeEstimate;
                    }
                    if (jsonResponse.messages[a].labelIds != null) {
                        int lengthOfLabel = jsons:getInt(jsonResponse.messages[a].labelIds, "$.length()");
                        int i = 0;
                        while (i < lengthOfLabel) {
                            mailMessage.labelIds[i], _ = (string)jsonResponse.messages[a].labelIds[i];
                            i = i + 1;
                        }
                    }
                    response.messages[a] = mailMessage;
                    a = a + 1;
                }
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"UnTrash a particular thread"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"threadId: Id of the thread to unTrash"}
    @doc:Return { value:"response struct"}
    action unTrashThread (ClientConnector g, string threadId) (Thread, Error) {
        Thread response = {};

        string unTrashThreadPath = "/v1/users/" + userId + "/threads/" + threadId + "/untrash";
        http:setContentLength(request, 0);
        message responseMessage = oauth2:ClientConnector.post (gmailEP, unTrashThreadPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];
        response.messages = [];

        if (statusCode == 200) {
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
            if (jsonResponse.snippet != null) {
                response.snippet, _ = (string)jsonResponse.snippet;
            }
            if (jsonResponse.historyId != null) {
                response.historyId, _ = (string)jsonResponse.historyId;
            }
            if (jsonResponse.messages != null) {
                int lengthOfMessages = jsons:getInt(jsonResponse.messages, "$.length()");
                int a = 0;
                while (a < lengthOfMessages) {
                    EmailMessage mailMessage = {};
                    mailMessage.labelIds = [];
                    if (jsonResponse.messages[a].payload != null) {
                        if (jsonResponse.messages[a].payload.headers != null) {
                            int lengthOfHeader = jsons:getInt(jsonResponse.messages[a].payload.headers, "$.length()");
                            int j = 0;
                            while (j < lengthOfHeader) {
                                Header header = {};
                                if (jsonResponse.messages[a].payload.headers[j].name != null) {
                                    header.name, _ = (string)jsonResponse.messages[a].payload.headers[j].name;
                                }
                                if (jsonResponse.messages[a].payload.headers[j].value != null) {
                                    header.value, _ = (string)jsonResponse.messages[a].payload.headers[j].value;
                                }
                                messagePayload.headers[j] = header;
                                j = j + 1;
                            }
                        }
                        if (jsonResponse.messages[a].payload.parts != null) {
                            int lengthOfParts = jsons:getInt(jsonResponse.messages[a].payload.parts, "$.length()");
                            int k = 0;
                            while (k < lengthOfParts) {
                                Parts parts = {};
                                Body body = {};
                                parts.headers = [];
                                if (jsonResponse.messages[a].payload.parts[k].partId != null) {
                                    parts.partId, _ = (string)jsonResponse.messages[a].payload.parts[k].partId;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].mimeType != null) {
                                    parts.mimeType, _ = (string)jsonResponse.messages[a].payload.parts[k].mimeType;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].filename != null) {
                                    parts.filename, _ = (string)jsonResponse.messages[a].payload.parts[k].filename;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.size != null) {
                                    body.size, _ = (int)jsonResponse.messages[a].payload.parts[k].body.size;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.data != null) {
                                    body.data, _ = (string)jsonResponse.messages[a].payload.parts[k].body.data;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.attachmentId != null) {
                                    body.attachmentId, _ = (string)jsonResponse.messages[a].payload.
                                                                                            parts[k].body.attachmentId;
                                }
                                parts.body = body;
                                int lengthOfPartHeader = jsons:getInt(jsonResponse.messages[a].payload.parts[k].headers,
                                                                      "$.length()");

                                int l = 0;
                                while (l < lengthOfPartHeader) {
                                    Header header_2 = {};
                                    if (jsonResponse.messages[a].payload.parts[k].headers[l].name != null) {
                                        header_2.name, _ = (string)jsonResponse.messages[a].payload.parts[k].
                                                                                                    headers[l].name;
                                    }
                                    if (jsonResponse.messages[a].payload.parts[k].headers[l].value != null) {
                                        header_2.value, _ = (string)jsonResponse.messages[a].payload.parts[k].
                                                                                                     headers[l].value;
                                    }
                                    parts.headers[k] = header_2;
                                    l = l + 1;
                                }
                                messagePayload.parts[k] = parts;
                                k = k + 1;
                            }
                        }
                        Body body_2 = {};
                        if (jsonResponse.messages[a].payload.body.size != null) {
                            body_2.size, _ = (int)jsonResponse.messages[a].payload.body.size;
                        }
                        if (jsonResponse.messages[a].payload.body.data != null) {
                            body_2.data, _ = (string)jsonResponse.messages[a].payload.body.data;
                        }
                        if (jsonResponse.messages[a].payload.body.attachmentId != null) {
                            body_2.attachmentId, _ = (string)jsonResponse.messages[a].payload.body.attachmentId;
                        }
                        messagePayload.body = body_2;
                        if (jsonResponse.messages[a].payload.filename != null) {
                            messagePayload.filename, _ = (string)jsonResponse.messages[a].payload.filename;
                        }
                        if (jsonResponse.messages[a].payload.mimeType != null) {
                            messagePayload.mimeType, _ = (string)jsonResponse.messages[a].payload.mimeType;
                        }
                        if (jsonResponse.messages[a].payload.partId != null) {
                            messagePayload.partId, _ = (string)jsonResponse.messages[a].payload.partId;
                        }
                        mailMessage.payload = messagePayload;
                    }
                    if (jsonResponse.messages[a].id != null) {
                        mailMessage.id, _ = (string)jsonResponse.messages[a].id;
                    }
                    if (jsonResponse.messages[a].threadId != null) {
                        mailMessage.threadId, _ = (string)jsonResponse.messages[a].threadId;
                    }
                    if (jsonResponse.messages[a].snippet != null) {
                        mailMessage.snippet, _ = (string)jsonResponse.messages[a].snippet;
                    }
                    if (jsonResponse.messages[a].historyId != null) {
                        mailMessage.historyId, _ = (string)jsonResponse.messages[a].historyId;

                    }
                    if (jsonResponse.messages[a].internalDate != null) {
                        mailMessage.internalDate, _ = (string)jsonResponse.messages[a].internalDate;
                    }
                    if (jsonResponse.messages[a].sizeEstimate != null) {
                        mailMessage.sizeEstimate, _ = (int)jsonResponse.messages[a].sizeEstimate;
                    }
                    if (jsonResponse.messages[a].labelIds != null) {
                        int lengthOfLabel = jsons:getInt(jsonResponse.messages[a].labelIds, "$.length()");
                        int i = 0;
                        while (i < lengthOfLabel) {
                            mailMessage.labelIds[i], _ = (string)jsonResponse.messages[a].labelIds[i];
                            i = i + 1;
                        }
                    }
                    response.messages[a] = mailMessage;
                    a = a + 1;
                }
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Lists the messages in the user's mailbox"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"listMails: It is a struct. Which contains all optional parameters (includeSpamTrash,labelIds,
    maxResults,pageToken,q)"}
    @doc:Return { value:"response struct"}
    action listMails (ClientConnector g, ThreadListFilter listMails) (Emails, Error) {
        Emails response = {};
        string uriParams;
        string listMailPath = "/v1/users/" + userId + "/messages";

        if (listMails != null) {
            string includeSpamTrash = listMails.includeSpamTrash;
            string labelIds = listMails.labelIds;
            string maxResults = listMails.maxResults;
            string pageToken = listMails.pageToken;
            string q = listMails.q;

            if (includeSpamTrash != "") {
                uriParams = uriParams + "&includeSpamTrash=" + includeSpamTrash;
            }
            if (labelIds != "") {
                uriParams = uriParams + "&labelIds=" + labelIds;
            }
            if (maxResults != "") {
                uriParams = uriParams + "&maxResults=" + maxResults;
            }
            if (pageToken != "") {
                uriParams = uriParams + "&pageToken=" + pageToken;
            }
            if (q != "") {
                uriParams = uriParams + "&q=" + q;
            }
        }

        if (uriParams != "") {
            listMailPath = listMailPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, listMailPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];
        response.messages = [];

        if (statusCode == 200) {
            if (jsonResponse.nextPageToken != null) {
                response.nextPageToken, _ = (string)jsonResponse.nextPageToken;
            }
            if (jsonResponse.resultSizeEstimate != null) {
                response.resultSizeEstimate, _ = (int)jsonResponse.resultSizeEstimate;
            }

            if (jsonResponse.messages != null) {
                int lengthOfMessages = jsons:getInt(jsonResponse.messages, "$.length()");
                int a = 0;
                while (a < lengthOfMessages) {
                    EmailMessage mailMessage = {};
                    mailMessage.labelIds = [];
                    if (jsonResponse.messages[a].payload != null) {
                        if (jsonResponse.messages[a].payload.headers != null) {
                            int lengthOfHeader = jsons:getInt(jsonResponse.messages[a].payload.headers, "$.length()");
                            int j = 0;
                            while (j < lengthOfHeader) {
                                Header header = {};
                                if (jsonResponse.messages[a].payload.headers[j].name != null) {
                                    header.name, _ = (string)jsonResponse.messages[a].payload.headers[j].name;
                                }
                                if (jsonResponse.messages[a].payload.headers[j].value != null) {
                                    header.value, _ = (string)jsonResponse.messages[a].payload.headers[j].value;
                                }
                                messagePayload.headers[j] = header;
                                j = j + 1;
                            }
                        }
                        if (jsonResponse.messages[a].payload.parts != null) {
                            int lengthOfParts = jsons:getInt(jsonResponse.messages[a].payload.parts, "$.length()");
                            int k = 0;
                            while (k < lengthOfParts) {
                                Parts parts = {};
                                Body body = {};
                                parts.headers = [];
                                if (jsonResponse.messages[a].payload.parts[k].partId != null) {
                                    parts.partId, _ = (string)jsonResponse.messages[a].payload.parts[k].partId;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].mimeType != null) {
                                    parts.mimeType, _ = (string)jsonResponse.messages[a].payload.parts[k].mimeType;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].filename != null) {
                                    parts.filename, _ = (string)jsonResponse.messages[a].payload.parts[k].filename;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.size != null) {
                                    body.size, _ = (int)jsonResponse.messages[a].payload.parts[k].body.size;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.data != null) {
                                    body.data, _ = (string)jsonResponse.messages[a].payload.parts[k].body.data;
                                }
                                if (jsonResponse.messages[a].payload.parts[k].body.attachmentId != null) {
                                    body.attachmentId, _ = (string)jsonResponse.messages[a].payload.parts[k].
                                                                                                    body.attachmentId;
                                }
                                parts.body = body;
                                int lengthOfPartHeader = jsons:getInt(jsonResponse.messages[a].payload.parts[k].headers,
                                                                      "$.length()");
                                int l = 0;
                                while (l < lengthOfPartHeader) {
                                    Header header_2 = {};
                                    if (jsonResponse.messages[a].payload.parts[k].headers[l].name != null) {
                                        header_2.name, _ = (string)jsonResponse.messages[a].payload.parts[k].
                                                                                                    headers[l].name;
                                    }
                                    if (jsonResponse.messages[a].payload.parts[k].headers[l].value != null) {
                                        header_2.value, _ = (string)jsonResponse.messages[a].payload.parts[k].
                                                                                                     headers[l].value;
                                    }
                                    parts.headers[k] = header_2;
                                    l = l + 1;
                                }
                                messagePayload.parts[k] = parts;
                                k = k + 1;
                            }
                        }
                        Body body_2 = {};
                        if (jsonResponse.messages[a].payload.body.size != null) {
                            body_2.size, _ = (int)jsonResponse.messages[a].payload.body.size;
                        }
                        if (jsonResponse.messages[a].payload.body.data != null) {
                            body_2.data, _ = (string)jsonResponse.messages[a].payload.body.data;
                        }
                        if (jsonResponse.messages[a].payload.body.attachmentId != null) {
                            body_2.attachmentId, _ = (string)jsonResponse.messages[a].payload.body.attachmentId;
                        }
                        messagePayload.body = body_2;
                        if (jsonResponse.messages[a].payload.filename != null) {
                            messagePayload.filename, _ = (string)jsonResponse.messages[a].payload.filename;
                        }
                        if (jsonResponse.messages[a].payload.mimeType != null) {
                            messagePayload.mimeType, _ = (string)jsonResponse.messages[a].payload.mimeType;
                        }
                        if (jsonResponse.messages[a].payload.partId != null) {
                            messagePayload.partId, _ = (string)jsonResponse.messages[a].payload.partId;
                        }
                        mailMessage.payload = messagePayload;
                    }
                    if (jsonResponse.messages[a].id != null) {
                        mailMessage.id, _ = (string)jsonResponse.messages[a].id;
                    }
                    if (jsonResponse.messages[a].threadId != null) {
                        mailMessage.threadId, _ = (string)jsonResponse.messages[a].threadId;
                    }
                    if (jsonResponse.messages[a].snippet != null) {
                        mailMessage.snippet, _ = (string)jsonResponse.messages[a].snippet;
                    }
                    if (jsonResponse.messages[a].historyId != null) {
                        mailMessage.historyId, _ = (string)jsonResponse.messages[a].historyId;
                    }
                    if (jsonResponse.messages[a].internalDate != null) {
                        mailMessage.internalDate, _ = (string)jsonResponse.messages[a].internalDate;
                    }
                    if (jsonResponse.messages[a].sizeEstimate != null) {
                        mailMessage.sizeEstimate, _ = (int)jsonResponse.messages[a].sizeEstimate;
                    }
                    if (jsonResponse.messages[a].labelIds != null) {
                        int lengthOfLabel = jsons:getInt(jsonResponse.messages[a].labelIds, "$.length()");
                        int i = 0;
                        while (i < lengthOfLabel) {
                            mailMessage.labelIds[i], _ = (string)jsonResponse.messages[a].labelIds[i];
                            i = i + 1;
                        }
                    }
                    response.messages[a] = mailMessage;
                    a = a + 1;
                }
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Retrieve a particular Message"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"messageId: Id of the message to retrieve"}
    @doc:Param { value:"readMail: It is a struct. Which contains all optional parameters (format,metaDataHeaders)"}
    @doc:Return { value:"response struct"}
    action readMail (ClientConnector g, string messageId, ThreadFilter readMail) (EmailMessage, Error) {
        EmailMessage response = {};
        string uriParams;

        string readMailPath = "/v1/users/" + userId + "/messages/" + messageId;

        if (readMail != null) {
            string format = readMail.format;
            string metaDataHeaders = readMail.metaDataHeaders;

            if (format != "") {
                uriParams = uriParams + "&format=" + format;
            }
            if (metaDataHeaders != "") {
                uriParams = uriParams + "&metaDataHeaders=" + metaDataHeaders;
            }
        }

        if (uriParams != "") {
            readMailPath = readMailPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, readMailPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        response.labelIds = [];
        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];

        if (statusCode == 200) {
            if (jsonResponse.payload.headers != null) {
                int lengthOfHeader = jsons:getInt(jsonResponse.payload.headers, "$.length()");
                int j = 0;
                while (j < lengthOfHeader) {
                    Header header = {};
                    if (jsonResponse.payload.headers[j].name != null) {
                        header.name, _ = (string)jsonResponse.payload.headers[j].name;
                    }
                    if (jsonResponse.payload.headers[j].value != null) {
                        header.value, _ = (string)jsonResponse.payload.headers[j].value;
                    }
                    messagePayload.headers[j] = header;
                    j = j + 1;
                }
            }
            if (jsonResponse.payload.parts != null) {
                int lengthOfParts = jsons:getInt(jsonResponse.payload.parts, "$.length()");
                int k = 0;
                while (k < lengthOfParts) {
                    Parts parts = {};
                    Body body = {};
                    parts.headers = [];
                    parts.partId, _ = (string)jsonResponse.payload.parts[k].partId;
                    parts.mimeType, _ = (string)jsonResponse.payload.parts[k].mimeType;
                    parts.filename, _ = (string)jsonResponse.payload.parts[k].filename;
                    if (jsonResponse.payload.parts[k].body.size != null) {
                        body.size, _ = (int)jsonResponse.payload.parts[k].body.size;
                    }
                    if (jsonResponse.payload.parts[k].body.data != null) {
                        body.data, _ = (string)jsonResponse.payload.parts[k].body.data;
                    }
                    if (jsonResponse.payload.parts[k].body.attachmentId != null) {
                        body.attachmentId, _ = (string)jsonResponse.payload.parts[k].body.attachmentId;
                    }
                    parts.body = body;
                    int lengthOfPartHeader = jsons:getInt(jsonResponse.payload.parts[k].headers, "$.length()");

                    int l = 0;
                    while (l < lengthOfPartHeader) {
                        Header header_2 = {};
                        if (jsonResponse.payload.parts[k].headers[l].name != null) {
                            header_2.name, _ = (string)jsonResponse.payload.parts[k].headers[l].name;
                        }
                        if (jsonResponse.payload.parts[k].headers[l].value != null) {
                            header_2.value, _ = (string)jsonResponse.payload.parts[k].headers[l].value;
                        }
                        parts.headers[k] = header_2;
                        l = l + 1;
                    }
                    messagePayload.parts[k] = parts;
                    k = k + 1;
                }
            }
            Body body_2 = {};
            if (jsonResponse.payload.body.size != null) {
                body_2.size, _ = (int)jsonResponse.payload.body.size;
            }
            if (jsonResponse.payload.body.data != null) {
                body_2.data, _ = (string)jsonResponse.payload.body.data;
            }
            if (jsonResponse.payload.body.attachmentId != null) {
                body_2.attachmentId, _ = (string)jsonResponse.payload.body.attachmentId;
            }
            messagePayload.body = body_2;
            if (jsonResponse.payload.filename != null) {
                messagePayload.filename, _ = (string)jsonResponse.payload.filename;
            }
            if (jsonResponse.payload.mimeType != null) {
                messagePayload.mimeType, _ = (string)jsonResponse.payload.mimeType;
            }
            if (jsonResponse.payload.partId != null) {
                messagePayload.partId, _ = (string)jsonResponse.payload.partId;
            }
            response.payload = messagePayload;
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
            if (jsonResponse.threadId != null) {
                response.threadId, _ = (string)jsonResponse.threadId;
            }
            if (jsonResponse.snippet != null) {
                response.snippet, _ = (string)jsonResponse.snippet;
            }
            if (jsonResponse.historyId != null) {
                response.historyId, _ = (string)jsonResponse.historyId;
            }
            if (jsonResponse.internalDate != null) {
                response.internalDate, _ = (string)jsonResponse.internalDate;
            }
            if (jsonResponse.sizeEstimate != null) {
                response.sizeEstimate, _ = (int)jsonResponse.sizeEstimate;
            }

            int lengthOfLabel = jsons:getInt(jsonResponse.labelIds, "$.length()");
            int i = 0;
            while (i < lengthOfLabel) {
                response.labelIds[i], _ = (string)jsonResponse.labelIds[i];
                i = i + 1;
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Send a mail"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"sendMail: It is a struct. Which contains all optional parameters (to,subject,from,messageBody,
    cc,bcc,id,threadId)"}
    @doc:Return { value:"response struct"}
    action sendMail (ClientConnector g, Message sendMail) (EmailMessage, Error) {
        EmailMessage response = {};
        string concatRequest;

        if (sendMail != null) {
            string to = sendMail.to;
            string subject = sendMail.subject;
            string from = sendMail.from;
            string messageBody = sendMail.messageBody;
            string cc = sendMail.cc;
            string bcc = sendMail.bcc;
            string id = sendMail.id;
            string threadId = sendMail.threadId;

            if (to != "") {
                concatRequest = concatRequest + "to:" + to + "\n";
            }
            if (subject != "") {
                concatRequest = concatRequest + "subject:" + subject + "\n";
            }
            if (from != "") {
                concatRequest = concatRequest + "from:" + from + "\n";
            }
            if (cc != "") {
                concatRequest = concatRequest + "cc:" + cc + "\n";
            }
            if (bcc != "") {
                concatRequest = concatRequest + "bcc:" + bcc + "\n";
            }
            if (id != "") {
                concatRequest = concatRequest + "id:" + id + "\n";
            }
            if (threadId != "") {
                concatRequest = concatRequest + "threadId:" + threadId + "\n";
            }
            if (messageBody != "") {
                concatRequest = concatRequest + "\n" + messageBody + "\n";
            }
        }

        string encodedRequest = utils:base64encode(concatRequest);
        json sendMailRequest = {"raw":encodedRequest};
        string sendMailPath = "/v1/users/" + userId + "/messages/send";
        messages:setJsonPayload(request, sendMailRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message responseMessage = oauth2:ClientConnector.post (gmailEP, sendMailPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);

        response.labelIds = [];
        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];

        if (statusCode == 200) {
            if (jsonResponse.payload != null) {
                if (jsonResponse.payload.headers != null) {
                    int lengthOfHeader = jsons:getInt(jsonResponse.payload.headers, "$.length()");
                    int j = 0;
                    while (j < lengthOfHeader) {
                        Header header = {};
                        if (jsonResponse.payload.headers[j].name != null) {
                            header.name, _ = (string)jsonResponse.payload.headers[j].name;
                        }
                        if (jsonResponse.payload.headers[j].value != null) {
                            header.value, _ = (string)jsonResponse.payload.headers[j].value;
                        }
                        messagePayload.headers[j] = header;
                        j = j + 1;
                    }
                }
                if (jsonResponse.payload.parts != null) {
                    int lengthOfParts = jsons:getInt(jsonResponse.payload.parts, "$.length()");
                    int k = 0;
                    while (k < lengthOfParts) {
                        Parts parts = {};
                        Body body = {};
                        parts.headers = [];
                        if (jsonResponse.payload.parts[k].partId != null) {
                            parts.partId, _ = (string)jsonResponse.payload.parts[k].partId;
                        }
                        if (jsonResponse.payload.parts[k].mimeType != null) {
                            parts.mimeType, _ = (string)jsonResponse.payload.parts[k].mimeType;
                        }
                        if (jsonResponse.payload.parts[k].filename != null) {
                            parts.filename, _ = (string)jsonResponse.payload.parts[k].filename;
                        }

                        if (jsonResponse.payload.parts[k].body.size != null) {
                            body.size, _ = (int)jsonResponse.payload.parts[k].body.size;
                        }
                        if (jsonResponse.payload.parts[k].body.data != null) {
                            body.data, _ = (string)jsonResponse.payload.parts[k].body.data;
                        }
                        if (jsonResponse.payload.parts[k].body.attachmentId != null) {
                            body.attachmentId, _ = (string)jsonResponse.payload.parts[k].body.attachmentId;
                        }
                        parts.body = body;
                        int lengthOfPartHeader = jsons:getInt(jsonResponse.payload.parts[k].headers, "$.length()");

                        int l = 0;
                        while (l < lengthOfPartHeader) {
                            Header header_2 = {};
                            if (jsonResponse.payload.parts[k].headers[l].name != null) {
                                header_2.name, _ = (string)jsonResponse.payload.parts[k].headers[l].name;
                            }
                            if (jsonResponse.payload.parts[k].headers[l].value != null) {
                                header_2.value, _ = (string)jsonResponse.payload.parts[k].headers[l].value;
                            }
                            parts.headers[k] = header_2;
                            l = l + 1;
                        }
                        messagePayload.parts[k] = parts;
                        k = k + 1;
                    }
                }
                Body body_2 = {};
                if (jsonResponse.payload.body.size != null) {
                    body_2.size, _ = (int)jsonResponse.payload.body.size;
                }
                if (jsonResponse.payload.body.data != null) {
                    body_2.data, _ = (string)jsonResponse.payload.body.data;
                }
                if (jsonResponse.payload.body.attachmentId != null) {
                    body_2.attachmentId, _ = (string)jsonResponse.payload.body.attachmentId;
                }
                messagePayload.body = body_2;
                if (jsonResponse.payload.filename != null) {
                    messagePayload.filename, _ = (string)jsonResponse.payload.filename;
                }
                if (jsonResponse.payload.mimeType != null) {
                    messagePayload.mimeType, _ = (string)jsonResponse.payload.mimeType;
                }
                if (jsonResponse.payload.partId != null) {
                    messagePayload.partId, _ = (string)jsonResponse.payload.partId;
                }
                response.payload = messagePayload;
            }
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
            if (jsonResponse.threadId != null) {
                response.threadId, _ = (string)jsonResponse.threadId;
            }
            if (jsonResponse.snippet != null) {
                response.snippet, _ = (string)jsonResponse.snippet;
            }
            if (jsonResponse.historyId != null) {
                response.historyId, _ = (string)jsonResponse.historyId;
            }
            if (jsonResponse.internalDate != null) {
                response.internalDate, _ = (string)jsonResponse.internalDate;
            }
            if (jsonResponse.sizeEstimate != null) {
                response.sizeEstimate, _ = (int)jsonResponse.sizeEstimate;
            }
            if (jsonResponse.labelIds != null) {
                int lengthOfLabel = jsons:getInt(jsonResponse.labelIds, "$.length()");
                int i = 0;
                while (i < lengthOfLabel) {
                    response.labelIds[i], _ = (string)jsonResponse.labelIds[i];
                    i = i + 1;
                }
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Modifies the labels on the specified message"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"messageId: The ID of the message to modifies the labels"}
    @doc:Param { value:"addLabelIds: A list of IDs of labels to add to this message"}
    @doc:Param { value:"removeLabelIds: A list IDs of labels to remove from this message"}
    @doc:Return { value:"response struct"}
    action modifyExistingMessage (ClientConnector g, string messageId, string addLabelIds,
                                  string removeLabelIds) (EmailMessage, Error) {
        EmailMessage response = {};
        json modifyExistingMessageRequest = {};
        string modifyExistingMessagePath = "/v1/users/" + userId + "/messages/" + messageId + "/modify";

        if (addLabelIds != "null") {
            modifyExistingMessageRequest.addLabelIds = [addLabelIds];
        }
        if (removeLabelIds != "null") {
            modifyExistingMessageRequest.removeLabelIds = [removeLabelIds];
        }
        messages:setJsonPayload(request, modifyExistingMessageRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message responseMessage = oauth2:ClientConnector.post (gmailEP, modifyExistingMessagePath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);
        response.labelIds = [];
        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];

        if (statusCode == 200) {
            if (jsonResponse.payload != null) {
                if (jsonResponse.payload.headers != null) {
                    int lengthOfHeader = jsons:getInt(jsonResponse.payload.headers, "$.length()");
                    int j = 0;
                    while (j < lengthOfHeader) {
                        Header header = {};
                        if (jsonResponse.payload.headers[j].name != null) {
                            header.name, _ = (string)jsonResponse.payload.headers[j].name;
                        }
                        if (jsonResponse.payload.headers[j].value != null) {
                            header.value, _ = (string)jsonResponse.payload.headers[j].value;
                        }
                        messagePayload.headers[j] = header;
                        j = j + 1;
                    }
                }
                if (jsonResponse.payload.parts != null) {
                    int lengthOfParts = jsons:getInt(jsonResponse.payload.parts, "$.length()");
                    int k = 0;
                    while (k < lengthOfParts) {
                        Parts parts = {};
                        Body body = {};
                        parts.headers = [];
                        if (jsonResponse.payload.parts[k].partId != null) {
                            parts.partId, _ = (string)jsonResponse.payload.parts[k].partId;
                        }
                        if (jsonResponse.payload.parts[k].mimeType != null) {
                            parts.mimeType, _ = (string)jsonResponse.payload.parts[k].mimeType;
                        }
                        if (jsonResponse.payload.parts[k].filename != null) {
                            parts.filename, _ = (string)jsonResponse.payload.parts[k].filename;
                        }
                        if (jsonResponse.payload.parts[k].body.size != null) {
                            body.size, _ = (int)jsonResponse.payload.parts[k].body.size;
                        }
                        if (jsonResponse.payload.parts[k].body.data != null) {
                            body.data, _ = (string)jsonResponse.payload.parts[k].body.data;
                        }
                        if (jsonResponse.payload.parts[k].body.attachmentId != null) {
                            body.attachmentId, _ = (string)jsonResponse.payload.parts[k].body.attachmentId;
                        }
                        parts.body = body;
                        int lengthOfPartHeader = jsons:getInt(jsonResponse.payload.parts[k].headers, "$.length()");

                        int l = 0;
                        while (l < lengthOfPartHeader) {
                            Header header_2 = {};
                            if (jsonResponse.payload.parts[k].headers[l].name != null) {
                                header_2.name, _ = (string)jsonResponse.payload.parts[k].headers[l].name;
                            }
                            if (jsonResponse.payload.parts[k].headers[l].value != null) {
                                header_2.value, _ = (string)jsonResponse.payload.parts[k].headers[l].value;
                            }
                            parts.headers[k] = header_2;
                            l = l + 1;
                        }
                        messagePayload.parts[k] = parts;
                        k = k + 1;
                    }
                }
                Body body_2 = {};
                if (jsonResponse.payload.body.size != null) {
                    body_2.size, _ = (int)jsonResponse.payload.body.size;
                }
                if (jsonResponse.payload.body.data != null) {
                    body_2.data, _ = (string)jsonResponse.payload.body.data;
                }
                if (jsonResponse.payload.body.attachmentId != null) {
                    body_2.attachmentId, _ = (string)jsonResponse.payload.body.attachmentId;
                }
                messagePayload.body = body_2;
                if (jsonResponse.payload.filename != null) {
                    messagePayload.filename, _ = (string)jsonResponse.payload.filename;
                }
                if (jsonResponse.payload.mimeType != null) {
                    messagePayload.mimeType, _ = (string)jsonResponse.payload.mimeType;
                }
                if (jsonResponse.payload.partId != null) {
                    messagePayload.partId, _ = (string)jsonResponse.payload.partId;
                }
                response.payload = messagePayload;
            }
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
            if (jsonResponse.threadId != null) {
                response.threadId, _ = (string)jsonResponse.threadId;
            }
            if (jsonResponse.snippet != null) {
                response.snippet, _ = (string)jsonResponse.snippet;
            }
            if (jsonResponse.historyId != null) {
                response.historyId, _ = (string)jsonResponse.historyId;
            }
            if (jsonResponse.internalDate != null) {
                response.internalDate, _ = (string)jsonResponse.internalDate;
            }
            if (jsonResponse.sizeEstimate != null) {
                response.sizeEstimate, _ = (int)jsonResponse.sizeEstimate;
            }
            if (jsonResponse.labelIds != null) {
                int lengthOfLabel = jsons:getInt(jsonResponse.labelIds, "$.length()");
                int i = 0;
                while (i < lengthOfLabel) {
                    response.labelIds[i], _ = (string)jsonResponse.labelIds[i];
                    i = i + 1;
                }
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Delete a particular message"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"messageId: Id of the message to delete"}
    @doc:Return { value:"response struct"}
    action deleteMail (ClientConnector g, string messageId) (StatusCode, Error) {
        StatusCode response = {};

        string deleteMailPath = "/v1/users/" + userId + "/messages/" + messageId;
        message responseMessage = oauth2:ClientConnector.delete (gmailEP, deleteMailPath, request);
        int statusCode = http:getStatusCode(responseMessage);

        if (statusCode == 204) {
            response.statusCode = statusCode;
        } else {
            json jsonResponse = messages:getJsonPayload(responseMessage);
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"Trash a particular message"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"messageId: Id of the message to Trash"}
    @doc:Return { value:"response struct"}
    action trashMail (ClientConnector g, string messageId) (EmailMessage, Error) {
        EmailMessage response = {};

        string trashMailPath = "/v1/users/" + userId + "/messages/" + messageId + "/trash";
        http:setContentLength(request, 0);
        message responseMessage = oauth2:ClientConnector.post (gmailEP, trashMailPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);
        response.labelIds = [];
        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];

        if (statusCode == 200) {
            if (jsonResponse.payload != null) {
                if (jsonResponse.payload.headers != null) {
                    int lengthOfHeader = jsons:getInt(jsonResponse.payload.headers, "$.length()");
                    int j = 0;
                    while (j < lengthOfHeader) {
                        Header header = {};
                        if (jsonResponse.payload.headers[j].name != null) {
                            header.name, _ = (string)jsonResponse.payload.headers[j].name;
                        }
                        if (jsonResponse.payload.headers[j].value != null) {
                            header.value, _ = (string)jsonResponse.payload.headers[j].value;
                        }
                        messagePayload.headers[j] = header;
                        j = j + 1;
                    }
                }
                if (jsonResponse.payload.parts != null) {
                    int lengthOfParts = jsons:getInt(jsonResponse.payload.parts, "$.length()");
                    int k = 0;
                    while (k < lengthOfParts) {
                        Parts parts = {};
                        Body body = {};
                        parts.headers = [];
                        parts.partId, _ = (string)jsonResponse.payload.parts[k].partId;
                        parts.mimeType, _ = (string)jsonResponse.payload.parts[k].mimeType;
                        parts.filename, _ = (string)jsonResponse.payload.parts[k].filename;
                        if (jsonResponse.payload.parts[k].body.size != null) {
                            body.size, _ = (int)jsonResponse.payload.parts[k].body.size;
                        }
                        if (jsonResponse.payload.parts[k].body.data != null) {
                            body.data, _ = (string)jsonResponse.payload.parts[k].body.data;
                        }
                        if (jsonResponse.payload.parts[k].body.attachmentId != null) {
                            body.attachmentId, _ = (string)jsonResponse.payload.parts[k].body.attachmentId;
                        }
                        parts.body = body;
                        int lengthOfPartHeader = jsons:getInt(jsonResponse.payload.parts[k].headers, "$.length()");

                        int l = 0;
                        while (l < lengthOfPartHeader) {
                            Header header_2 = {};
                            header_2.name, _ = (string)jsonResponse.payload.parts[k].headers[l].name;
                            header_2.value, _ = (string)jsonResponse.payload.parts[k].headers[l].value;
                            parts.headers[k] = header_2;
                            l = l + 1;
                        }
                        messagePayload.parts[k] = parts;
                        k = k + 1;
                    }
                }
                Body body_2 = {};
                if (jsonResponse.payload.body.size != null) {
                    body_2.size, _ = (int)jsonResponse.payload.body.size;
                }
                if (jsonResponse.payload.body.data != null) {
                    body_2.data, _ = (string)jsonResponse.payload.body.data;
                }
                if (jsonResponse.payload.body.attachmentId != null) {
                    body_2.attachmentId, _ = (string)jsonResponse.payload.body.attachmentId;
                }
                messagePayload.body = body_2;
                if (jsonResponse.payload.filename != null) {
                    messagePayload.filename, _ = (string)jsonResponse.payload.filename;
                }
                if (jsonResponse.payload.mimeType != null) {
                    messagePayload.mimeType, _ = (string)jsonResponse.payload.mimeType;
                }
                if (jsonResponse.payload.partId != null) {
                    messagePayload.partId, _ = (string)jsonResponse.payload.partId;
                }
                response.payload = messagePayload;
            }
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
            if (jsonResponse.threadId != null) {
                response.threadId, _ = (string)jsonResponse.threadId;
            }
            if (jsonResponse.snippet != null) {
                response.snippet, _ = (string)jsonResponse.snippet;
            }
            if (jsonResponse.historyId != null) {
                response.historyId, _ = (string)jsonResponse.historyId;
            }
            if (jsonResponse.internalDate != null) {
                response.internalDate, _ = (string)jsonResponse.internalDate;
            }
            if (jsonResponse.sizeEstimate != null) {
                response.sizeEstimate, _ = (int)jsonResponse.sizeEstimate;
            }
            if (jsonResponse.labelIds != null) {
                int lengthOfLabel = jsons:getInt(jsonResponse.labelIds, "$.length()");
                int i = 0;
                while (i < lengthOfLabel) {
                    response.labelIds[i], _ = (string)jsonResponse.labelIds[i];
                    i = i + 1;
                }
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }

    @doc:Description { value:"UnTrash a particular message"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"messageId: Id of the message to unTrash"}
    @doc:Return { value:"response struct"}
    action unTrashMail (ClientConnector g, string messageId) (EmailMessage, Error) {
        EmailMessage response = {};
        string unTrashMailPath = "/v1/users/" + userId + "/messages/" + messageId + "/untrash";
        http:setContentLength(request, 0);
        message responseMessage = oauth2:ClientConnector.post (gmailEP, unTrashMailPath, request);
        json jsonResponse = messages:getJsonPayload(responseMessage);
        int statusCode = http:getStatusCode(responseMessage);
        response.labelIds = [];
        MessagePayload messagePayload = {};
        messagePayload.headers = [];
        messagePayload.parts = [];

        if (statusCode == 200) {
            if (jsonResponse.payload != null) {
                if (jsonResponse.payload.headers != null) {
                    int lengthOfHeader = jsons:getInt(jsonResponse.payload.headers, "$.length()");
                    int j = 0;
                    while (j < lengthOfHeader) {
                        Header header = {};
                        if (jsonResponse.payload.headers[j].name != null) {
                            header.name, _ = (string)jsonResponse.payload.headers[j].name;
                        }
                        if (jsonResponse.payload.headers[j].value != null) {
                            header.value, _ = (string)jsonResponse.payload.headers[j].value;
                        }
                        messagePayload.headers[j] = header;
                        j = j + 1;
                    }
                }
                if (jsonResponse.payload.parts != null) {
                    int lengthOfParts = jsons:getInt(jsonResponse.payload.parts, "$.length()");
                    int k = 0;
                    while (k < lengthOfParts) {
                        Parts parts = {};
                        Body body = {};
                        parts.headers = [];
                        if (jsonResponse.payload.parts[k].partId != null) {
                            parts.partId, _ = (string)jsonResponse.payload.parts[k].partId;
                        }
                        if (jsonResponse.payload.parts[k].mimeType != null) {
                            parts.mimeType, _ = (string)jsonResponse.payload.parts[k].mimeType;
                        }
                        if (jsonResponse.payload.parts[k].filename != null) {
                            parts.filename, _ = (string)jsonResponse.payload.parts[k].filename;
                        }
                        if (jsonResponse.payload.parts[k].body.size != null) {
                            body.size, _ = (int)jsonResponse.payload.parts[k].body.size;
                        }
                        if (jsonResponse.payload.parts[k].body.data != null) {
                            body.data, _ = (string)jsonResponse.payload.parts[k].body.data;
                        }
                        if (jsonResponse.payload.parts[k].body.attachmentId != null) {
                            body.attachmentId, _ = (string)jsonResponse.payload.parts[k].body.attachmentId;
                        }
                        parts.body = body;
                        int lengthOfPartHeader = jsons:getInt(jsonResponse.payload.parts[k].headers, "$.length()");

                        int l = 0;
                        while (l < lengthOfPartHeader) {
                            Header header_2 = {};
                            if (jsonResponse.payload.parts[k].headers[l].name != null) {
                                header_2.name, _ = (string)jsonResponse.payload.parts[k].headers[l].name;
                            }
                            if (jsonResponse.payload.parts[k].headers[l].value != null) {
                                header_2.value, _ = (string)jsonResponse.payload.parts[k].headers[l].value;
                            }
                            parts.headers[k] = header_2;
                            l = l + 1;
                        }
                        messagePayload.parts[k] = parts;
                        k = k + 1;
                    }
                }
                Body body_2 = {};
                if (jsonResponse.payload.body.size != null) {
                    body_2.size, _ = (int)jsonResponse.payload.body.size;
                }
                if (jsonResponse.payload.body.data != null) {
                    body_2.data, _ = (string)jsonResponse.payload.body.data;
                }
                if (jsonResponse.payload.body.attachmentId != null) {
                    body_2.attachmentId, _ = (string)jsonResponse.payload.body.attachmentId;
                }
                messagePayload.body = body_2;
                if (jsonResponse.payload.filename != null) {
                    messagePayload.filename, _ = (string)jsonResponse.payload.filename;
                }
                if (jsonResponse.payload.mimeType != null) {
                    messagePayload.mimeType, _ = (string)jsonResponse.payload.mimeType;
                }
                if (jsonResponse.payload.partId != null) {
                    messagePayload.partId, _ = (string)jsonResponse.payload.partId;
                }
                response.payload = messagePayload;
            }
            if (jsonResponse.id != null) {
                response.id, _ = (string)jsonResponse.id;
            }
            if (jsonResponse.threadId != null) {
                response.threadId, _ = (string)jsonResponse.threadId;
            }
            if (jsonResponse.snippet != null) {
                response.snippet, _ = (string)jsonResponse.snippet;
            }
            if (jsonResponse.historyId != null) {
                response.historyId, _ = (string)jsonResponse.historyId;
            }
            if (jsonResponse.internalDate != null) {
                response.internalDate, _ = (string)jsonResponse.internalDate;
            }
            if (jsonResponse.sizeEstimate != null) {
                response.sizeEstimate, _ = (int)jsonResponse.sizeEstimate;
            }
            if (jsonResponse.labelIds != null) {
                int lengthOfLabel = jsons:getInt(jsonResponse.labelIds, "$.length()");
                int i = 0;
                while (i < lengthOfLabel) {
                    response.labelIds[i], _ = (string)jsonResponse.labelIds[i];
                    i = i + 1;
                }
            }
        } else {
            errorResponse.errors = jsonResponse.error.errors;
            errorResponse.errorMessage, _ = (string)jsonResponse.error["message"];
        }

        return response, errorResponse;
    }
}