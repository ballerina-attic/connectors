import org.wso2.ballerina.connectors.googlespreadsheet;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    googlespreadsheet:ClientConnector googlespreadsheetConnector = create googlespreadsheet:ClientConnector(args[1],
                                                                                                            args[2], args[3], args[4]);

    message googlespreadsheetResponse;
    json googlespreadsheetJSONResponse;

    if (args[0] == "getSheetMetaData") {
        googlespreadsheetResponse = googlespreadsheetConnector.getSheetMetaData (args[5], args[6], args[7], args[8]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "copyTo") {
        json arg7 = jsons:parse(args[7]);
        googlespreadsheetResponse = googlespreadsheetConnector.copyTo (args[5], args[6], arg7, args[8]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "getCellData") {
        googlespreadsheetResponse = googlespreadsheetConnector.getCellData (args[5], args[6], args[7], args[8], args[9],
                                                                            args[10]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "getMultipleCellData") {
        googlespreadsheetResponse = googlespreadsheetConnector.getMultipleCellData (args[5], args[6], args[7], args[8],
                                                                                    args[9], args[10]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "editCell") {
        json arg8 = jsons:parse(args[8]);
        googlespreadsheetResponse = googlespreadsheetConnector.editCell (args[5], args[6], args[7], arg8, args[9]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "editMultipleCell") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.editMultipleCell (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "createSpreadsheet") {
        json arg5 = jsons:parse(args[5]);
        googlespreadsheetResponse = googlespreadsheetConnector.createSpreadsheet (arg5, args[6]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "addSheetBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.addSheetBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "deleteSheetBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.deleteSheetBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "updateSheetPropertiesBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.updateSheetPropertiesBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "deleteDimensionBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.deleteDimensionBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "updateCellsBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.updateCellsBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "appendDimensionBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.appendDimensionBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "updateBordersBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.updateBordersBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "repeatCellsBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.repeatCellsBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "mergeCellsBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.mergeCellsBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "setDataValidationBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.setDataValidationBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "copyPasteBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.copyPasteBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "cutPasteBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.cutPasteBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "updateConditionalFormatRuleBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.updateConditionalFormatRuleBatchRequest (args[5], arg6,
                                                                                                        args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "addConditionalFormatRuleBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.addConditionalFormatRuleBatchRequest (args[5], arg6,
                                                                                                     args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "deleteConditionalFormatRuleBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.deleteConditionalFormatRuleBatchRequest (args[5], arg6,
                                                                                                        args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "updateDimensionPropertiesBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.updateDimensionPropertiesBatchRequest (args[5], arg6,
                                                                                                      args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "autoResizeDimensionsBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.autoResizeDimensionsBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "insertDimensionBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.insertDimensionBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "moveDimensionBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.moveDimensionBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "sortRangeBatchRequest") {
        json arg6 = jsons:parse(args[6]);
        googlespreadsheetResponse = googlespreadsheetConnector.sortRangeBatchRequest (args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if (args[0] == "addRowsColumnsData") {
        json arg10 = jsons:parse(args[10]);
        googlespreadsheetResponse = googlespreadsheetConnector.addRowsColumnsData (args[5], args[6], args[7], args[8],
                                                                                   args[9], arg10);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }
}