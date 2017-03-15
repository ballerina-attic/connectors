package org.wso2.ballerina.connectors.googlespreadsheet;

import org.wso2.ballerina.connectors.oauth2;
import ballerina.lang.messages;
import ballerina.lang.strings;

@doc:Description("Google Spreadsheet client connector")
@doc:Param("accessToken: The accessToken of the Google Spreadsheet account to access the Google Spreadsheet REST API")
@doc:Param("refreshToken: The refreshToken of the Google Spreadsheet App to access the Google Spreadsheet REST API")
@doc:Param("clientId: The clientId of the App to access the Google Spreadsheet REST API")
@doc:Param("clientSecret: The clientSecret of the App to access the Google Spreadsheet REST API")
connector ClientConnector (string accessToken, string refreshToken, string clientId,
                           string clientSecret) {

    string refreshTokenEP = "https://www.googleapis.com/oauth2/v3/token";
    string baseURL = "https://sheets.googleapis.com";

    oauth2:ClientConnector googlespreadsheetEP = create oauth2:ClientConnector(baseURL, accessToken, clientId,
                                                               clientSecret, refreshToken, refreshTokenEP);

    @doc:Description ("Retrieve Sheet properties and other metadata")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("includeGridData: True if grid data should be returned. This parameter is ignored
                                    if a field mask was set in the request")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Param("ranges: The ranges to retrieve from the spreadsheet")
    @doc:Return ("response object")
    action getSheetMetaData (ClientConnector spreadsheet, string spreadsheetId, string includeGridData, string fields,
                             string ranges) (message) {
        message request = {};
        string uriParams;
        string getSheetMetaDataPath = "/v4/spreadsheets/" + spreadsheetId;

        if (includeGridData != "null") {
            uriParams = uriParams + "&includeGridData=" + includeGridData;
        }

        if (fields != "null") {
            uriParams = uriParams + "&fields=" + fields;
        }

        while(strings:indexOf(ranges, ",") != -1) {
            int index = strings:indexOf(ranges, ",");
            uriParams = uriParams + "&ranges=" + strings:subString(ranges, 0, index);
            ranges = strings:subString(ranges, index+1, strings:length(ranges));
        }

        if(ranges != "null") {
            uriParams = uriParams + "&ranges=" + ranges;
        }

        if(uriParams != "") {
            getSheetMetaDataPath = getSheetMetaDataPath + "?" + strings:subString(
                                                                        uriParams, 1, strings:length(uriParams));
        }

        message response = oauth2:ClientConnector.get(googlespreadsheetEP, getSheetMetaDataPath, request);
        return response;
    }

    @doc:Description("Copies a single sheet from a spreadsheet to another spreadsheet")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("sheetId: The ID of the sheet to copy")
    @doc:Param("payload: It contains the ID of the spreadsheet to copy the sheet to")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action copyTo(ClientConnector spreadsheet, string spreadsheetId, string sheetId,
                  json payload, string fields) (message) {
        message request = {};
        string copyToPath = "/v4/spreadsheets/" + spreadsheetId + "/sheets/" + sheetId + ":copyTo";

        if(fields != "null") {
            copyToPath = copyToPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, copyToPath, request);

        return response;
    }

    @doc:Description("Retrieve any set of cell data from a sheet")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("range: The A1 notation of the values to retrieve")
    @doc:Param("dateTimeRenderOption: How dates, times, and durations should be represented in the output")
    @doc:Param("valueRenderOption: How values should be represented in the output")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Param("majorDimension: The major dimension that results should use")
    @doc:Return("response object")
    action getCellData(ClientConnector spreadsheet, string spreadsheetId, string range, string dateTimeRenderOption,
                       string valueRenderOption, string fields, string majorDimension) (message) {
        message request = {};
        string uriParams;
        string getCellDataPath = "/v4/spreadsheets/" + spreadsheetId + "/values/" + range;

        if(dateTimeRenderOption != "null") {
            uriParams = uriParams + "&dateTimeRenderOption=" + dateTimeRenderOption;
        }

        if(valueRenderOption != "null") {
            uriParams = uriParams + "&valueRenderOption=" + valueRenderOption;
        }

        if(majorDimension != "null") {
            uriParams = uriParams + "&majorDimension=" + majorDimension;
        }

        if(fields != "null") {
            uriParams = uriParams + "&fields=" + fields;
        }

        if(uriParams != "") {
            getCellDataPath = getCellDataPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }

        message response = oauth2:ClientConnector.get(googlespreadsheetEP, getCellDataPath, request);

        return response;
    }

    @doc:Description("Retrieve any set of cell data including multiple ranges from a sheet")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("ranges: The ranges to retrieve from the spreadsheet")
    @doc:Param("dateTimeRenderOption: How dates, times, and durations should be represented in the output")
    @doc:Param("valueRenderOption: How values should be represented in the output")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Param("majorDimension: The major dimension that results should use")
    @doc:Return("response object")
    action getMultipleCellData(ClientConnector spreadsheet, string spreadsheetId, string ranges,
                               string dateTimeRenderOption, string valueRenderOption,
                               string fields, string majorDimension) (message) {
        message request = {};
        string uriParams;
        string getMultipleCellDataPath = "/v4/spreadsheets/" + spreadsheetId + "/values:batchGet";

        while(strings:indexOf(ranges, ",") != -1) {
            int index = strings:indexOf(ranges, ",");
            uriParams = uriParams + "&ranges=" + strings:subString(ranges, 0, index);
            ranges = strings:subString(ranges, index+1, strings:length(ranges));
        }

        if(ranges != "null") {
            uriParams = uriParams + "&ranges=" + ranges;
        }

        if(dateTimeRenderOption != "null") {
            uriParams = uriParams + "&dateTimeRenderOption=" + dateTimeRenderOption;
        }

        if(valueRenderOption != "null") {
            uriParams = uriParams + "&valueRenderOption=" + valueRenderOption;
        }

        if(majorDimension != "null") {
            uriParams = uriParams + "&majorDimension=" + majorDimension;
        }

        if(fields != "null") {
            uriParams = uriParams + "&fields=" + fields;
        }

        if(uriParams != "") {
            getMultipleCellDataPath = getMultipleCellDataPath + "?" + strings:subString(
                                                                             uriParams, 1, strings:length(uriParams));
        }

        message response = oauth2:ClientConnector.get(googlespreadsheetEP, getMultipleCellDataPath, request);

        return response;
    }

    @doc:Description("Edit the content of the cell with new values")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("range: The A1 notation of the values to retrieve")
    @doc:Param("valueInputOption: How the input data should be interpreted")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Param("payload: It contains data about major dimension that results should use and about
                the values (the data that was to be written)")
    @doc:Return("response object")
    action editCell(ClientConnector spreadsheet, string spreadsheetId, string range, string valueInputOption,
                    json payload, string fields) (message) {
        message request = {};
        string editCellPath = "/v4/spreadsheets/" + spreadsheetId + "/values/" + range + "?valueInputOption="
                              + valueInputOption;

        if(fields != "null") {
            editCellPath = editCellPath + "&" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.put(googlespreadsheetEP, editCellPath, request);

        return response;
    }

    @doc:Description("Edit the content of multiple cell with new values")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data about the new values(data) to apply to the spreadsheet and
                How the input data should be interpreted(valueInputOption)")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action editMultipleCell(ClientConnector spreadsheet, string spreadsheetId, json payload, string fields) (message) {
        message request = {};
        string editMultipleCellPath = "/v4/spreadsheets/" + spreadsheetId + "/values:batchUpdate";

        if(fields != "null") {
            editMultipleCellPath = editMultipleCellPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, editMultipleCellPath, request);

        return response;
    }

    @doc:Description("Create a new spreadsheet")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("payload: The payload containing the information of the post that should be send")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action createSpreadsheet(ClientConnector spreadsheet, json payload, string fields) (message) {
        message request = {};
        string createSpreadsheetPath = "/v4/spreadsheets";

        if(fields != "null") {
            createSpreadsheetPath = createSpreadsheetPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, createSpreadsheetPath, request);

        return response;
    }

    @doc:Description("Add a sheet or multiple sheets to a spreadsheet")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action addSheetBatchRequest(ClientConnector spreadsheet, string spreadsheetId,
                                json payload, string fields) (message) {
        message request = {};
        string addSheetBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            addSheetBatchRequestPath = addSheetBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, addSheetBatchRequestPath, request);

        return response;
    }

    @doc:Description("Remove a sheet or multiple sheets from a given spreadsheet")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action deleteSheetBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                   string fields) (message) {
        message request = {};
        string deleteSheetBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            deleteSheetBatchRequestPath = deleteSheetBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, deleteSheetBatchRequestPath, request);

        return response;
    }

    @doc:Description("Update all sheet properties")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action updateSheetPropertiesBatchRequest(ClientConnector spreadsheet, string spreadsheetId,
                                                 json payload, string fields) (message) {
        message request = {};
        string updateSheetPropertiesBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            updateSheetPropertiesBatchRequestPath = updateSheetPropertiesBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, updateSheetPropertiesBatchRequestPath,
                                                       request);

        return response;
    }

    @doc:Description("Removing rows, columns and remove part of a row or column")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action deleteDimensionBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                       string fields) (message) {
        message request = {};
        string deleteDimensionBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            deleteDimensionBatchRequestPath = deleteDimensionBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, deleteDimensionBatchRequestPath, request);

        return response;
    }

    @doc:Description("Updates all cells in a range with new data that can be cell value, formatting")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action updateCellsBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                       string fields) (message) {
        message request = {};
        string updateCellsBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            updateCellsBatchRequestPath = updateCellsBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, updateCellsBatchRequestPath, request);

        return response;
    }

    @doc:Description("Append empty rows or columns at the end of the sheet")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action appendDimensionBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                           string fields) (message) {
        message request = {};
        string appendDimensionBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            appendDimensionBatchRequestPath = appendDimensionBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, appendDimensionBatchRequestPath, request);

        return response;
    }

    @doc:Description("Edit cell borders")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action updateBordersBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                         string fields) (message) {
        message request = {};
        string updateBordersBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            updateBordersBatchRequestPath = updateBordersBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, updateBordersBatchRequestPath, request);

        return response;
    }

    @doc:Description("Repeat formatting of the cell into over a range of cells")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action repeatCellsBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                       string fields) (message) {
        message request = {};
        string repeatCellsBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            repeatCellsBatchRequestPath = repeatCellsBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, repeatCellsBatchRequestPath, request);

        return response;
    }

    @doc:Description("Merge range of cells into a one cell")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action mergeCellsBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                      string fields) (message) {
        message request = {};
        string mergeCellsBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            mergeCellsBatchRequestPath = mergeCellsBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, mergeCellsBatchRequestPath, request);

        return response;
    }

    @doc:Description("Apply data validation rule to a range")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action setDataValidationBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                         string fields) (message) {
        message request = {};
        string setDataValidationBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            setDataValidationBatchRequestPath = setDataValidationBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, setDataValidationBatchRequestPath, request);

        return response;
    }

    @doc:Description("Copy cell formatting in one range and paste it into another range on the same sheet")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action copyPasteBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                     string fields) (message) {
        message request = {};
        string copyPasteBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            copyPasteBatchRequestPath = copyPasteBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, copyPasteBatchRequestPath, request);

        return response;
    }

    @doc:Description("Cuts the one range and pastes its data, formats, formulas, and merges to the another range
                      on the same sheet")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action cutPasteBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                    string fields) (message) {
        message request = {};
        string cutPasteBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            cutPasteBatchRequestPath = cutPasteBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, cutPasteBatchRequestPath, request);

        return response;
    }

    @doc:Description("Update a conditional formatting rule or its priority")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action updateConditionalFormatRuleBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                                   string fields) (message) {
        message request = {};
        string updateConditionalFormatRuleBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            updateConditionalFormatRuleBatchRequestPath = updateConditionalFormatRuleBatchRequestPath + "?" + "fields="
                                                          + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, updateConditionalFormatRuleBatchRequestPath,
                                                       request);

        return response;
    }

    @doc:Description("Establishes a new conditional formatting rule")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action addConditionalFormatRuleBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                                string fields) (message) {
        message request = {};
        string uriParams;
        string addConditionalFormatRuleBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            uriParams = uriParams + "fields=" + fields;
        }

        if(uriParams != "") {
            addConditionalFormatRuleBatchRequestPath = addConditionalFormatRuleBatchRequestPath + "?" + uriParams;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, addConditionalFormatRuleBatchRequestPath
                                                       , request);

        return response;
    }

    @doc:Description("Delete a conditional formatting rule")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action deleteConditionalFormatRuleBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                                   string fields) (message) {
        message request = {};
        string deleteConditionalFormatRuleBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            deleteConditionalFormatRuleBatchRequestPath = deleteConditionalFormatRuleBatchRequestPath + "?" + "fields="
                                                          + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, deleteConditionalFormatRuleBatchRequestPath,
                                                       request);

        return response;
    }

    @doc:Description("Adjust column width or row height")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action updateDimensionPropertiesBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                                 string fields) (message) {
        message request = {};
        string updateDimensionPropertiesBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            updateDimensionPropertiesBatchRequestPath = updateDimensionPropertiesBatchRequestPath + "?" + "fields="
                                                        + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, updateDimensionPropertiesBatchRequestPath,
                                                       request);

        return response;
    }

    @doc:Description("Automatically resize a column")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action autoResizeDimensionsBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                            string fields) (message) {
        message request = {};
        string autoResizeDimensionsBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            autoResizeDimensionsBatchRequestPath = autoResizeDimensionsBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, autoResizeDimensionsBatchRequestPath,
                                                       request);

        return response;
    }

    @doc:Description("Insert an empty row or column at the end or in the middle")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action insertDimensionBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                           string fields) (message) {
        message request = {};
        string insertDimensionBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            insertDimensionBatchRequestPath = insertDimensionBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, insertDimensionBatchRequestPath, request);

        return response;
    }

    @doc:Description("Move a row or column / range of rows or columns")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action moveDimensionBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                         string fields) (message) {
        message request = {};
        string moveDimensionBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            moveDimensionBatchRequestPath = moveDimensionBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, moveDimensionBatchRequestPath, request);

        return response;
    }

    @doc:Description("Sort a range with multiple sorting specifications")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("payload: It contains data that is a kind of update to apply to a spreadsheet")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Return("response object")
    action sortRangeBatchRequest(ClientConnector spreadsheet, string spreadsheetId, json payload,
                                     string fields) (message) {
        message request = {};
        string sortRangeBatchRequestPath = "/v4/spreadsheets/" + spreadsheetId + ":batchUpdate";

        if(fields != "null") {
            sortRangeBatchRequestPath = sortRangeBatchRequestPath + "?" + "fields=" + fields;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, sortRangeBatchRequestPath, request);

        return response;
    }

    @doc:Description("Append row/rows/column/columns of data")
    @doc:Param("spreadsheet: The Google Spreadsheet Connector instance")
    @doc:Param("spreadsheetId: Unique value of the spreadsheet")
    @doc:Param("range: The A1 notation of the values to retrieve")
    @doc:Param("insertDataOption: How the input data should be inserted")
    @doc:Param("valueInputOption: How the input data should be interpreted")
    @doc:Param("fields: Specifying which fields to include in a partial response")
    @doc:Param("payload: It contains the major dimension that results should use and the data that was to be written(values)")
    @doc:Return("response object")
    action addRowsColumnsData(ClientConnector spreadsheet, string spreadsheetId, string range, string insertDataOption,
                              string valueInputOption, string fields, json payload) (message) {
        message request = {};
        string uriParams;
        string addRowsColumnsDataPath = "/v4/spreadsheets/" + spreadsheetId + "/values/" + range
                                        + ":append?valueInputOption=" + valueInputOption;

        if(insertDataOption != "null") {
            uriParams = uriParams + "&insertDataOption=" + insertDataOption;
        }

        if(fields != "null") {
            uriParams = uriParams + "&fields=" + fields;
        }

        if(uriParams != "") {
            addRowsColumnsDataPath = addRowsColumnsDataPath + uriParams;
        }

        messages:setJsonPayload(request, payload);
        message response = oauth2:ClientConnector.post(googlespreadsheetEP, addRowsColumnsDataPath, request);

        return response;
    }
}