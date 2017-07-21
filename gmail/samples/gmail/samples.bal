import org.wso2.ballerina.connectors.gmail;

import ballerina.lang.system;

function main (string[] args) {

    gmail:ClientConnector gmailConnector = create gmail:ClientConnector(args[1], args[2], args[3], args[4], args[5]);

    gmail:Error errorResponse = {};

    if (args[0] == "getUserProfile") {
        gmail:UserProfile gmailResponse;
        gmailResponse, errorResponse = gmail:ClientConnector.getUserProfile (gmailConnector);

        if (gmailResponse.emailAddress != "") {
            system:println(gmailResponse.emailAddress);
            system:println(gmailResponse.messagesTotal);
            system:println(gmailResponse.threadsTotal);
            system:println(gmailResponse.historyId);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "createDraft") {
        gmail:Draft gmailResponse;
        gmail:Message createDraft = {to:"birunthagnanes@gmail.com", subject:"This is subject",
                                    from:"birunthagnanes@gmail.com"};
        gmailResponse, errorResponse = gmail:ClientConnector.createDraft (gmailConnector, createDraft);

        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.mailMessage.id);
            system:println(gmailResponse.mailMessage.threadId);
            system:println(gmailResponse.mailMessage.labelIds);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "updateDraft") {
        gmail:Draft gmailResponse;
        string draftId = args[6];
        gmail:Message updateDraft = {to:"birunthagnanes@gmail.com", subject:"This is subject",
                                    from:"birunthagnanes@gmail.com"};
        gmailResponse, errorResponse = gmail:ClientConnector.updateDraft (gmailConnector, draftId, updateDraft);

        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.mailMessage.id);
            system:println(gmailResponse.mailMessage.threadId);
            system:println(gmailResponse.mailMessage.labelIds);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "readDraft") {
        gmail:Draft gmailResponse;
        string draftId = args[6];
        gmail:DraftFilter readDraft = {format:"full"};
        gmailResponse, errorResponse = gmail:ClientConnector.readDraft (gmailConnector, draftId, readDraft);

        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.mailMessage.id);
            system:println(gmailResponse.mailMessage.threadId);
            system:println(gmailResponse.mailMessage.labelIds);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "listDrafts") {
        gmail:Drafts gmailResponse;
        gmail:DraftsListFilter listDrafts = {includeSpamTrash:"false", pageToken:"2"};
        gmailResponse, errorResponse = gmail:ClientConnector.listDrafts (gmailConnector, listDrafts);

        if (gmailResponse.drafts != null) {
            system:println(gmailResponse.drafts);
            system:println(gmailResponse.nextPageToken);
            system:println(gmailResponse.resultSizeEstimate);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "deleteDraft") {
        gmail:StatusCode gmailResponse;
        string draftId = args[6];
        gmailResponse, errorResponse = gmail:ClientConnector.deleteDraft (gmailConnector, draftId);
        if (gmailResponse.statusCode == 204) {
            system:println(gmailResponse.statusCode);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "listHistory") {
        gmail:HistoryList gmailResponse;
        string startHistoryId = args[6];
        gmail:HistoryFilter listHistory = {maxResults:"3"};
        gmailResponse, errorResponse = gmail:ClientConnector.listHistory (gmailConnector, startHistoryId, listHistory);

        if (gmailResponse.historyId != "") {
            system:println(gmailResponse.history);
            system:println(gmailResponse.nextPageToken);
            system:println(gmailResponse.historyId);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "createLabel") {
        gmail:Label gmailResponse;
        string labelName = args[6];
        string messageListVisibility = args[7];
        string labelListVisibility = args[8];
        gmail:EmailLabel createLabel = {types:"user"};
        gmailResponse, errorResponse = gmail:ClientConnector.createLabel (gmailConnector, labelName, messageListVisibility,
                                                                          labelListVisibility, createLabel);
        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.name);
            system:println(gmailResponse.messageListVisibility);
            system:println(gmailResponse.labelListVisibility);
            system:println(gmailResponse.type);
            system:println(gmailResponse.messagesTotal);
            system:println(gmailResponse.messagesUnread);
            system:println(gmailResponse.threadsTotal);
            system:println(gmailResponse.threadsUnread);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "deleteLabel") {
        gmail:StatusCode gmailResponse;
        string labelId = args[6];
        gmailResponse, errorResponse = gmail:ClientConnector.deleteLabel (gmailConnector, labelId);

        if (gmailResponse.statusCode == 204) {
            system:println(gmailResponse.statusCode);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "listLabels") {
        gmail:Labels gmailResponse;
        gmailResponse, errorResponse = gmail:ClientConnector.listLabels (gmailConnector);

        if (gmailResponse.labels != null) {
            system:println(gmailResponse.labels);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "updateLabel") {
        gmail:Label gmailResponse;
        string labelId = args[6];
        string labelName = args[7];
        string messageListVisibility = args[8];
        string labelListVisibility = args[9];
        gmail:EmailLabel updateLabel = {types:"user"};
        gmailResponse, errorResponse = gmail:ClientConnector.updateLabel (gmailConnector, labelId, labelName, messageListVisibility,
                                                                          labelListVisibility, updateLabel);
        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.name);
            system:println(gmailResponse.messageListVisibility);
            system:println(gmailResponse.labelListVisibility);
            system:println(gmailResponse.type);
            system:println(gmailResponse.messagesTotal);
            system:println(gmailResponse.messagesUnread);
            system:println(gmailResponse.threadsTotal);
            system:println(gmailResponse.threadsUnread);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "readLabel") {
        gmail:Label gmailResponse;
        string labelId = args[6];
        gmailResponse, errorResponse = gmail:ClientConnector.readLabel (gmailConnector, labelId);

        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.name);
            system:println(gmailResponse.messageListVisibility);
            system:println(gmailResponse.labelListVisibility);
            system:println(gmailResponse.type);
            system:println(gmailResponse.messagesTotal);
            system:println(gmailResponse.messagesUnread);
            system:println(gmailResponse.threadsTotal);
            system:println(gmailResponse.threadsUnread);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "listThreads") {
        gmail:Threads gmailResponse;
        gmail:ThreadListFilter listThreads = {includeSpamTrash:"false"};
        gmailResponse, errorResponse = gmail:ClientConnector.listThreads (gmailConnector, listThreads);

        if (gmailResponse.threads != null) {
            system:println(gmailResponse.threads);
            system:println(gmailResponse.nextPageToken);
            system:println(gmailResponse.resultSizeEstimate);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "deleteThread") {
        gmail:StatusCode gmailResponse;
        string threadId = args[6];
        gmailResponse, errorResponse = gmail:ClientConnector.deleteThread (gmailConnector, threadId);

        if (gmailResponse.statusCode == 204) {
            system:println(gmailResponse.statusCode);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "readThread") {
        gmail:Thread gmailResponse;
        string threadId = args[6];
        gmail:ThreadFilter readThread = {format:"full"};
        gmailResponse, errorResponse = gmail:ClientConnector.readThread (gmailConnector, threadId, readThread);

        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.snippet);
            system:println(gmailResponse.historyId);
            system:println(gmailResponse.messages);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "trashThread") {
        gmail:Thread gmailResponse;
        string threadId = args[6];
        gmailResponse, errorResponse = gmail:ClientConnector.trashThread (gmailConnector, threadId);

        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.snippet);
            system:println(gmailResponse.historyId);
            system:println(gmailResponse.messages);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "unTrashThread") {
        gmail:Thread gmailResponse;
        string threadId = args[6];
        gmailResponse, errorResponse = gmail:ClientConnector.unTrashThread (gmailConnector, threadId);

        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.snippet);
            system:println(gmailResponse.historyId);
            system:println(gmailResponse.messages);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "listMails") {
        gmail:Emails gmailResponse;
        gmail:ThreadListFilter listMails = {includeSpamTrash:"false"};
        gmailResponse, errorResponse = gmail:ClientConnector.listMails (gmailConnector, listMails);

        if (gmailResponse.nextPageToken != "") {
            system:println(gmailResponse.nextPageToken);
            system:println(gmailResponse.resultSizeEstimate);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "readMail") {
        gmail:EmailMessage gmailResponse;
        string messageId = args[6];
        gmail:ThreadFilter readMail = {format:"full"};
        gmailResponse, errorResponse = gmail:ClientConnector.readMail (gmailConnector, messageId, readMail);

        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.threadId);
            system:println(gmailResponse.labelIds);
            system:println(gmailResponse.snippet);
            system:println(gmailResponse.historyId);
            system:println(gmailResponse.internalDate);
            system:println(gmailResponse.payload.headers);
            system:println(gmailResponse.payload.parts);
            system:println(gmailResponse.sizeEstimate);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "sendMail") {
        gmail:EmailMessage gmailResponse;
        gmail:Message sendMail = {to:"birunthagnanes@gmail.com", subject:"This is subject",
                                 from:"birunthagnanes@gmail.com"};
        gmailResponse, errorResponse = gmail:ClientConnector.sendMail (gmailConnector, sendMail);
        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.threadId);
            system:println(gmailResponse.labelIds);
            system:println(gmailResponse.snippet);
            system:println(gmailResponse.historyId);
            system:println(gmailResponse.internalDate);
            system:println(gmailResponse.payload.headers);
            system:println(gmailResponse.payload.parts);
            system:println(gmailResponse.sizeEstimate);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "modifyExistingMessage") {
        gmail:EmailMessage gmailResponse;
        string messageId = args[6];
        string addLabelIds = args[7];
        string removeLabelIds = args[8];
        gmailResponse, errorResponse = gmail:ClientConnector.modifyExistingMessage (gmailConnector, messageId, addLabelIds,
                                                                                    removeLabelIds);
        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.threadId);
            system:println(gmailResponse.labelIds);
            system:println(gmailResponse.snippet);
            system:println(gmailResponse.historyId);
            system:println(gmailResponse.internalDate);
            system:println(gmailResponse.payload.headers);
            system:println(gmailResponse.payload.parts);
            system:println(gmailResponse.sizeEstimate);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "deleteMail") {
        gmail:StatusCode gmailResponse;
        string messageId = args[6];
        gmailResponse, errorResponse = gmail:ClientConnector.deleteMail (gmailConnector, messageId);

        if (gmailResponse.statusCode == 204) {
            system:println(gmailResponse.statusCode);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "trashMail") {
        gmail:EmailMessage gmailResponse;
        string messageId = args[6];
        gmailResponse, errorResponse = gmail:ClientConnector.trashMail (gmailConnector, messageId);
        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.threadId);
            system:println(gmailResponse.labelIds);
            system:println(gmailResponse.snippet);
            system:println(gmailResponse.historyId);
            system:println(gmailResponse.internalDate);
            system:println(gmailResponse.payload.headers);
            system:println(gmailResponse.payload.parts);
            system:println(gmailResponse.sizeEstimate);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }

    if (args[0] == "unTrashMail") {
        gmail:EmailMessage gmailResponse;
        string messageId = args[6];
        gmailResponse, errorResponse = gmail:ClientConnector.unTrashMail (gmailConnector, messageId);
        if (gmailResponse.id != "") {
            system:println(gmailResponse.id);
            system:println(gmailResponse.threadId);
            system:println(gmailResponse.labelIds);
            system:println(gmailResponse.snippet);
            system:println(gmailResponse.historyId);
            system:println(gmailResponse.internalDate);
            system:println(gmailResponse.payload.headers);
            system:println(gmailResponse.payload.parts);
            system:println(gmailResponse.sizeEstimate);
        } else {
            system:println(errorResponse.errors);
            system:println(errorResponse.errorMessage);
        }
    }
}