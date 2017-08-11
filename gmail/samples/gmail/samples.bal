import org.wso2.ballerina.connectors.gmail;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;
import ballerina.net.http;

function main (string[] args) {

    gmail:ClientConnector gmailConnector = create gmail:ClientConnector(args[1], args[2], args[3], args[4], args[5]);

    message gmailResponse;
    json gmailJSONResponse;
    string deleteResponse;

    if (args[0] == "getUserProfile") {
        gmailResponse = gmailConnector.getUserProfile ();
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "createDraft") {
        gmailResponse = gmailConnector.createDraft (args[6], args[7], args[8],
                                                    args[9], args[10], args[11], args[12], args[13]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "updateDraft") {
        gmailResponse = gmailConnector.updateDraft (args[6], args[7], args[8], args[9],
                                                    args[10], args[11], args[12], args[13], args[14]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "readDraft") {
        gmailResponse = gmailConnector.readDraft (args[6], args[7]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "listDrafts") {
        gmailResponse = gmailConnector.listDrafts (args[6], args[7], args[8], args[9]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "deleteDraft") {
        gmailResponse = gmailConnector.deleteDraft (args[6]);
        system:println("Status code : " + http:getStatusCode(gmailResponse));
    }

    if (args[0] == "listHistory") {
        gmailResponse = gmailConnector.listHistory (args[6], args[7], args[8], args[9]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "createLabel") {
        gmailResponse = gmailConnector.createLabel (args[6], args[7], args[8],
                                                    args[9], args[10], args[11], args[12], args[13]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "deleteLabel") {
        gmailResponse = gmailConnector.deleteLabel (args[6]);
        system:println("Status code : " + http:getStatusCode(gmailResponse));
    }

    if (args[0] == "listLabels") {
        gmailResponse = gmailConnector.listLabels ();
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "updateLabel") {
        gmailResponse = gmailConnector.updateLabel (args[6], args[7], args[8], args[9],
                                                    args[10], args[11], args[12], args[13], args[14]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "readLabel") {
        gmailResponse = gmailConnector.readLabel (args[6]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "readThread") {
        gmailResponse = gmailConnector.readThread (args[6], args[7], args[8]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "listThreads") {
        gmailResponse = gmailConnector.listThreads (args[6], args[7], args[8], args[9], args[10]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "deleteThread") {
        gmailResponse = gmailConnector.deleteThread (args[6]);
        system:println("Status code : " + http:getStatusCode(gmailResponse));
    }

    if (args[0] == "trashThread") {
        gmailResponse = gmailConnector.trashThread (args[6]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "unTrashThread") {
        gmailResponse = gmailConnector.unTrashThread (args[6]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "listMails") {
        gmailResponse = gmailConnector.listMails (args[6], args[7], args[8], args[9], args[10]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "sendMail") {
        gmailResponse = gmailConnector.sendMail (args[6], args[7], args[8], args[9], args[10], args[11],
                                                 args[12], args[13]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "modifyExistingMessage") {
        gmailResponse = gmailConnector.modifyExistingMessage (args[6], args[7], args[8]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "readMail") {
        gmailResponse = gmailConnector.readMail (args[6], args[7], args[8]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "deleteMail") {
        gmailResponse = gmailConnector.deleteMail (args[6]);
        system:println("Status code : " + http:getStatusCode(gmailResponse));
    }

    if (args[0] == "trashMail") {
        gmailResponse = gmailConnector.trashMail (args[6]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }

    if (args[0] == "unTrashMail") {
        gmailResponse = gmailConnector.unTrashMail (args[6]);
        gmailJSONResponse = messages:getJsonPayload(gmailResponse);
        system:println(jsons:toString(gmailJSONResponse));
    }
}