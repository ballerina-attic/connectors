import org.wso2.ballerina.connectors.googlespreadsheet;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    googlespreadsheet:ClientConnector googlespreadsheetConnector = create googlespreadsheet:ClientConnector(args[1],
                                                                          args[2], args[3], args[4]);

    message googlespreadsheetResponse;
    json googlespreadsheetJSONResponse;

    if( args[0] == "getSheetMetaData") {
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.getSheetMetaData(googlespreadsheetConnector,
                                    args[5], args[6], args[7], args[8]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "copyTo") {
        json arg7 = (json) args[7];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.copyTo(googlespreadsheetConnector,
                                    args[5], args[6], arg7, args[8]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "getCellData") {
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.getCellData(
                                    googlespreadsheetConnector, args[5], args[6], args[7], args[8], args[9], args[10]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "getMultipleCellData") {
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.getMultipleCellData(googlespreadsheetConnector,
                                    args[5], args[6], args[7], args[8], args[9], args[10]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "editCell") {
        json arg8 = (json) args[8];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.editCell(googlespreadsheetConnector,
                                    args[5], args[6], args[7], arg8, args[9]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "editMultipleCell") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.editMultipleCell(googlespreadsheetConnector,
                                    args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "createSpreadsheet") {
        json arg5 = (json) args[5];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.createSpreadsheet(googlespreadsheetConnector,
                                                                                        arg5, args[6]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "addSheetBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.addSheetBatchRequest(googlespreadsheetConnector,
                                    args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "deleteSheetBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.deleteSheetBatchRequest(googlespreadsheetConnector,
                                    args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "updateSheetPropertiesBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.updateSheetPropertiesBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "deleteDimensionBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.deleteDimensionBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "updateCellsBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.updateCellsBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "appendDimensionBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.appendDimensionBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "updateBordersBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.updateBordersBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "repeatCellsBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.repeatCellsBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "mergeCellsBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.mergeCellsBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "setDataValidationBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.setDataValidationBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "copyPasteBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.copyPasteBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "cutPasteBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.cutPasteBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "updateConditionalFormatRuleBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.updateConditionalFormatRuleBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "addConditionalFormatRuleBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.addConditionalFormatRuleBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "deleteConditionalFormatRuleBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.deleteConditionalFormatRuleBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "updateDimensionPropertiesBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.updateDimensionPropertiesBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "autoResizeDimensionsBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.autoResizeDimensionsBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "insertDimensionBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.insertDimensionBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "moveDimensionBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.moveDimensionBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "sortRangeBatchRequest") {
        json arg6 = (json) args[6];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.sortRangeBatchRequest(
                                    googlespreadsheetConnector, args[5], arg6, args[7]);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }

    if( args[0] == "addRowsColumnsData") {
        json arg10 = (json) args[10];
        googlespreadsheetResponse = googlespreadsheet:ClientConnector.addRowsColumnsData(googlespreadsheetConnector,
                                    args[5], args[6], args[7], args[8], args[9], arg10);
        googlespreadsheetJSONResponse = messages:getJsonPayload(googlespreadsheetResponse);
        system:println(jsons:toString(googlespreadsheetJSONResponse));
    }
}