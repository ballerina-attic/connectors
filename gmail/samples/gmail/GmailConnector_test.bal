import org.wso2.ballerina.connectors.gmail;

import ballerina.lang.messages;
import ballerina.lang.system;
import ballerina.lang.strings;
import ballerina.net.http;
import ballerina.test;


string userId = system:getEnv("USER_ID");
string accessToken = system:getEnv("ACCESS_TOKEN");
string refreshToken = system:getEnv("REFRESH_TOKEN");
string clientId = system:getEnv("CLIENT_ID");
string clientSecret = system:getEnv("CLIENT_SECRET");
string recipientAddress = system:getEnv("RECIPIENT_ADDRESS");
message gmailResponse = {};
json gmailJSONResponse = {};
string deleteResponse = {};


function init () (gmail:ClientConnector gmailConnector) {
    gmailConnector = create gmail:ClientConnector(userId, accessToken, refreshToken, clientId, clientSecret);
    return;
}

function testGetProfile () {
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.getUserProfile (connectorInstance);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string returnedEmailAddress = (string)gmailJSONResponse.emailAddress;
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(returnedEmailAddress, userId) && strings:equalsIgnoreCase(statusCode, "200"));
}

function testCreateDraft () {
    string subject = "Test Subject 1";
    string from = userId;
    string messageBody = "This is test message";
    string cc = userId;
    string bcc = userId;
    string id = "154b8c77e551c510";
    string threadId = "154b8c77e551c510";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.createDraft (connectorInstance, recipientAddress, subject, from, messageBody
                                                       , cc, bcc, id, threadId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string returnedId = (string)gmailJSONResponse.id;
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(!strings:equalsIgnoreCase(returnedId, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testUpdateDraft () {
    string draftId = "r-6158712664976689510";
    string subject = "Test Subject 1 updated";
    string from = userId;
    string messageBody = "This is test message updated";
    string cc = userId;
    string bcc = userId;
    string id = "154b8c77e551c510";
    string threadId = "154b8c77e551c510";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.updateDraft (connectorInstance, draftId, recipientAddress, subject, from
                                                       , messageBody, cc, bcc, id, threadId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string returnedId = (string)gmailJSONResponse.id;
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(!strings:equalsIgnoreCase(returnedId, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testReadDraft () {
    string draftId = "r-6158712664976689510";
    string format = "raw";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.readDraft (connectorInstance, draftId, format);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string returnedId = (string)gmailJSONResponse.id;
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(!strings:equalsIgnoreCase(returnedId, "") && strings:equalsIgnoreCase(statusCode, "200"));
}

function testListDraft () {
    string includeSpamTrash = "false";
    string maxResults = "10";
    string pageToken = "09876536614133772469";
    string q = "";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.listDrafts (connectorInstance, includeSpamTrash, maxResults, pageToken, q);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testDeleteDraft () {
    string draftId = "1489453812801109582";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.deleteDraft (connectorInstance, draftId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testListHistory () {
    string labelId = "";
    string maxResults = "10";
    string pageToken = "";
    string startHistoryId = "1482987";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.listHistory (connectorInstance, labelId, maxResults, pageToken, startHistoryId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testCreateLabel () {
    string labelName = "TestBallerinaLabel1";
    string messageListVisibility = "show";
    string labelListVisibility = "labelShow";
    string types = "user";
    string messagesTotal = "100";
    string messagesUnread = "100";
    string threadsTotal = "100";
    string threadsUnread = "100";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.createLabel (connectorInstance, labelName, messageListVisibility
                                                       , labelListVisibility, types, messagesTotal
                                                       , messagesUnread, threadsTotal, threadsUnread);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testDeleteLabel () {
    string labelId = "Label_5";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.deleteLabel (connectorInstance, labelId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testListLabels () {
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.listLabels (connectorInstance);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testUpdateLabel () {
    string labelId = "Label_7";
    string labelName = "TestBallerinaLabel1_updated";
    string messageListVisibility = "show";
    string labelListVisibility = "labelShow";
    string types = "user";
    string messagesTotal = "100";
    string messagesUnread = "100";
    string threadsTotal = "200";
    string threadsUnread = "100";

    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.updateLabel (connectorInstance, labelId, labelName, messageListVisibility
                                                       , labelListVisibility, types, messagesTotal, messagesUnread
                                                       , threadsTotal, threadsUnread);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testReadLabel () {
    string labelId = "Label_7";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.readLabel (connectorInstance, labelId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testReadThread () {
    string threadId = "15c39eb2dcc84a3d";
    string format = "metadata";
    string metaDataHeaders = "";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.readThread (connectorInstance, threadId, format, metaDataHeaders);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testListThread () {
    string includeSpamTrash = "false";
    string labelIds = "UNREAD";
    string maxResults = "10";
    string pageToken = "";
    string q = "";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.listThreads (connectorInstance, includeSpamTrash, labelIds, maxResults
                                                       , pageToken, q);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testDeleteThread () {
    string threadId = "15c39eb2dcc84a3d";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.deleteThread (connectorInstance, threadId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testTrashThread () {
    string threadId = "15c39eb2dcc84a3d";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.trashThread (connectorInstance, threadId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testUnTrashThread () {
    string threadId = "15c39eb2dcc84a3d";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.unTrashThread (connectorInstance, threadId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testListMails () {
    string includeSpamTrash = "false";
    string labelIds = "UNREAD";
    string maxResults = "10";
    string pageToken = "";
    string q = "";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.listMails (connectorInstance, includeSpamTrash, labelIds
                                                     , maxResults, pageToken, q);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testSendMails () {
    string to = recipientAddress;
    string subject = "Test subject 1";
    string from = userId;
    string messageBody = "Test message 1";
    string cc = userId;
    string bcc = userId;
    string id = "154b8c77e551c511";
    string threadId = "154b8c77e551c512";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.sendMail (connectorInstance, to, subject, from, messageBody
                                                    , cc, bcc, id, threadId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testModifyExistingMessage () {
    string messageId = "15c3a75d7e757965";
    string addLabelIds = "SPAM";
    string removeLabelIds = "UNREAD";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.modifyExistingMessage (connectorInstance, messageId
                                                                 , addLabelIds, removeLabelIds);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testReadMail () {
    string messageId = "15c3a75d7e757965";
    string format = "minimal";
    string metaDataHeaders = "";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.readMail (connectorInstance, messageId, format, metaDataHeaders);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testDeleteMail () {
    string messageId = "15c3a75d7e757965";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.deleteMail (connectorInstance, messageId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testTrashMail () {
    string messageId = "15c3a75d7e757965";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.trashMail (connectorInstance, messageId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}

function testUnTrashMail () {
    string messageId = "15c3a75d7e757965";
    gmail:ClientConnector connectorInstance = init();
    gmailResponse = gmail:ClientConnector.unTrashMail (connectorInstance, messageId);
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = (string)http:getStatusCode(gmailResponse);
    test:assertTrue(strings:equalsIgnoreCase(statusCode, "200"));
}




