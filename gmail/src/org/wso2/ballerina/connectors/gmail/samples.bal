import org.wso2.ballerina.connectors.gmail;

import ballerina.lang.json;
import ballerina.lang.message;
import ballerina.lang.system;

function main (string[] args) {

    gmail:ClientConnector gmailConnector = create gmail:ClientConnector(args[1], args[2], args[3], args[4], args[5], args[6]);

    message gmailResponse;
    json gmailJSONResponse;
    string deleteResponse;

    if( args[0] == "getUserProfile") {
        gmailResponse = gmail:ClientConnector.getUserProfile(gmailConnector);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "createDraft") {
        gmailResponse = gmail:ClientConnector.createDraft(gmailConnector,args[7], args[8],
        args[9], args[10], args[11], args[12], args[13] , args[14]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "updateDraft") {
        gmailResponse = gmail:ClientConnector.updateDraft(gmailConnector, args[7], args[8], args[9],
        args[10], args[11], args[12], args[13], args[14], args[15]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "readDraft") {
        gmailResponse = gmail:ClientConnector.readDraft(gmailConnector, args[7], args[8]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "listDrafts") {
        gmailResponse = gmail:ClientConnector.listDrafts(gmailConnector, args[7], args[8], args[9], args[10]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "deleteDraft") {
        gmailResponse = gmail:ClientConnector.deleteDraft(gmailConnector, args[7]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        deleteResponse = json:toString(gmailJSONResponse);
        if(deleteResponse == "null"){
            system:println("Draft with id: " + args[3] + " deleted successfully.");
        }
    }

    if( args[0] == "listHistory") {
        gmailResponse = gmail:ClientConnector.listHistory(gmailConnector, args[7], args[8], args[9], args[10]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "createLabel") {
        gmailResponse = gmail:ClientConnector.createLabel(gmailConnector, args[7], args[8],
        args[9], args[10], args[11], args[12], args[13], args[14]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "deleteLabel") {
        gmailResponse = gmail:ClientConnector.deleteLabel(gmailConnector, args[7]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        deleteResponse = json:toString(gmailJSONResponse);
        if(deleteResponse == "null"){
            system:println("Label with id: " + args[3] + " deleted successfully.");
        }
    }

    if( args[0] == "listLabels") {
        gmailResponse = gmail:ClientConnector.listLabels(gmailConnector);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "updateLabel") {
        gmailResponse = gmail:ClientConnector.updateLabel(gmailConnector, args[7], args[8], args[9],
        args[10], args[11], args[12], args[13], args[14], args[15]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "readLabel") {
        gmailResponse = gmail:ClientConnector.readLabel(gmailConnector, args[7]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "readThread") {
        gmailResponse = gmail:ClientConnector.readThread(gmailConnector, args[7], args[8], args[9]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "listThreads") {
        gmailResponse = gmail:ClientConnector.listThreads(gmailConnector, args[7], args[8], args[9], args[10],  args[11]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "deleteThread") {
        gmailResponse = gmail:ClientConnector.deleteThread(gmailConnector, args[7]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        deleteResponse = json:toString(gmailJSONResponse);
        if(deleteResponse == "null"){
            system:println("Thread with id: " + args[3] + " deleted successfully.");
        }
    }

    if( args[0] == "trashThread") {
        gmailResponse = gmail:ClientConnector.trashThread(gmailConnector, args[7]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "unTrashThread") {
        gmailResponse = gmail:ClientConnector.unTrashThread(gmailConnector, args[7]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "listMails") {
        gmailResponse = gmail:ClientConnector.listMails(gmailConnector, args[7], args[8], args[9], args[10], args[11]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "sendMail") {
        gmailResponse = gmail:ClientConnector.sendMail(gmailConnector, args[7], args[8], args[9], args[10], args[11],
        args[12], args[13], args[14]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "modifyExistingMessage") {
        gmailResponse = gmail:ClientConnector.modifyExistingMessage(gmailConnector, args[7], args[8], args[9]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "readMail") {
        gmailResponse = gmail:ClientConnector.readMail(gmailConnector, args[7], args[8], args[9]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "deleteMail") {
        gmailResponse = gmail:ClientConnector.deleteMail(gmailConnector, args[7]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        deleteResponse = json:toString(gmailJSONResponse);
        if(deleteResponse == "null"){
            system:println("Mail with id: " + args[3] + " deleted successfully.");
        }
    }

    if( args[0] == "trashMail") {
        gmailResponse = gmail:ClientConnector.trashMail(gmailConnector, args[7]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }

    if( args[0] == "unTrashMail") {
        gmailResponse = gmail:ClientConnector.unTrashMail(gmailConnector, args[7]);
        gmailJSONResponse = message:getJsonPayload(gmailResponse);
        system:println(json:toString(gmailJSONResponse));
    }
}