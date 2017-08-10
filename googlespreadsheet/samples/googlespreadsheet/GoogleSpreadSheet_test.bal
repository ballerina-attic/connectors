import ballerina.test;
import ballerina.lang.messages;
import ballerina.lang.system;
import org.wso2.ballerina.connectors.googlespreadsheet;
import ballerina.net.http;

json payload;

function initBalConnector () (googlespreadsheet:ClientConnector googlespreadsheetConnector){
    string ACCESS_TOKEN = system:getEnv("ACCESS_TOKEN");
    string REFRESH_TOKEN = system:getEnv("REFRESH_TOKEN");
    string CLIENT_ID = system:getEnv("CLIENT_ID");
    string CLIENT_SECRET = system:getEnv("CLIENT_SECRET");
    googlespreadsheetConnector = create googlespreadsheet:ClientConnector(ACCESS_TOKEN, REFRESH_TOKEN, CLIENT_ID
                                                                          , CLIENT_SECRET);
    return;
}

function testCreateSpreadSheet () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    json payload = {
                   "spreadsheetId":"p4PJALKcIXLr75rJWXlHhVjOt7z0Nby7AvcKXJGhMN2s",
                   "properties":{
                                "title":"TestBal_1"
                                },
                   "sheets":[
                            {
                            "properties":{
                                         "title":"mySheet",
                                         "sheetId":600
                                         }
                            }
                            ],
                   "namedRanges":[
                                 {
                                 "name":"Title",
                                 "range":{
                                         "sheetId":600,
                                         "endColumnIndex":1,
                                         "endRowIndex":6,
                                         "startColumnIndex":0,
                                         "startRowIndex":0
                                         }
                                 }
                                 ]
                   };
    string fields = "spreadsheetId";
    message directResponse = {};
    message googlespreadsheetResponse = {};
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;


    googlespreadsheetResponse = connectorInstance.createSpreadsheet (payload, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing createSpreadsheet.............................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testGetSheetMetaData () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    string includeGridInfo = "true";
    string range = "Name";
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.getSheetMetaData (spreadSheetId, includeGridInfo, fields, range);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing getSheetMetaData..............................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testCopyTo () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string sourceSpreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    string sourceSheetId = "789";
    json payloadToSend = {"destinationSpreadsheetId":"1DS0OuYBzmYgMid47RlESl0gwA6mCQpvVDhLHvYoO4ng"};
    string fields;
    string returnedTitleOfCopy;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.copyTo (sourceSpreadSheetId, sourceSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedTitleOfCopy = (string)payload.title;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedTitleOfCopy != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing copyTo........................................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "Sheet ID" + ":" + returnedTitleOfCopy
                                         + "Status Code" + ":" + statusCode);
}

function testGetCellData () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    string range = "Name";
    string dateTimeRenderOption = "SERIAL_NUMBER";
    string valueRenderOption = "FORMATTED_VALUE";
    string majorDimension = "ROWS";
    string fields = "range";
    message googlespreadsheetResponse = {};
    string returnedRange;
    boolean assertValue = false;
    int statusCode;

    googlespreadsheetResponse = connectorInstance.getCellData (spreadSheetId, range, dateTimeRenderOption,
                                                               valueRenderOption, fields, majorDimension);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedRange = (string)payload.range;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedRange != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing getCellData...................................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "Range" + ":" + returnedRange
                                         + "Status Code" + ":" + statusCode);
}

function testGetMultipleCellData () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    string range = "Name";
    string dateTimeRenderOption = "SERIAL_NUMBER";
    string valueRenderOption = "FORMATTED_VALUE";
    string majorDimension = "ROWS";
    string fields = "spreadsheetId";
    message googlespreadsheetResponse = {};
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;

    googlespreadsheetResponse = connectorInstance.getMultipleCellData (spreadSheetId, range, dateTimeRenderOption,
                                                                       valueRenderOption, fields, majorDimension);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing getMultipleCellData...........................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testEditCell () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    string range = "Name";
    string valueInputOption = "RAW";
    json payloadToSend = {"majorDimension":"ROWS"};
    string fields = "spreadsheetId";
    message googlespreadsheetResponse = {};
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;

    googlespreadsheetResponse = connectorInstance.editCell (spreadSheetId, range, valueInputOption, payloadToSend,
                                                            fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing editCell......................................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testEditMultipleCells () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "responseValueRenderOption":"FORMATTED_VALUE",
                         "responseDateTimeRenderOption":"SERIAL_NUMBER",
                         "includeValuesInResponse":true,
                         "valueInputOption":"RAW",
                         "data":[
                                {
                                "range":"A1:B2",
                                "majorDimension":"ROWS",
                                "values":[
                                         [
                                         1
                                         ],
                                         [
                                         2
                                         ]
                                         ]
                                }
                                ]
                         };
    string fields = "spreadsheetId";
    message googlespreadsheetResponse = {};
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;

    googlespreadsheetResponse = connectorInstance.editMultipleCell (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing editMultipleCell..............................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testAddSheets () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "addSheet":{
                                               "properties":{
                                                            "title":"Withdrawls_1",
                                                            "gridProperties":{
                                                                             "rowCount":20,
                                                                             "columnCount":12
                                                                             },
                                                            "tabColor":{
                                                                       "red":1.0,
                                                                       "green":0.3,
                                                                       "blue":0.4
                                                                       }
                                                            }
                                               }
                                    }
                                    ]
                         };
    message googlespreadsheetResponse = {};
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;

    googlespreadsheetResponse = connectorInstance.addSheetBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing addSheetBatchRequest..........................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}


function testDeleteSheets () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};
    json payloadToSend = {
                         "requests":[
                                    {
                                    "deleteSheet":{
                                                  "sheetId":1782472643
                                                  }
                                    }
                                    ]
                         };

    googlespreadsheetResponse = connectorInstance.deleteSheetBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing deleteSheetBatchRequest.......................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testUpdateSheetBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[{
                                     "updateSpreadsheetProperties":{
                                                                   "properties":{"title":"My New Title"},
                                                                   "fields":"title"
                                                                   }
                                     }]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.updateSheetPropertiesBatchRequest (spreadSheetId, payloadToSend
                                                                                     , fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing updateSheetPropertiesBatchRequest.............................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testDeleteDimensionBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "deleteDimension":{
                                                      "range":{
                                                              "sheetId":1596758874,
                                                              "dimension":"ROWS",
                                                              "startIndex":9,
                                                              "endIndex":11
                                                              }
                                                      }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.deleteDimensionBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing deleteDimensionBatchRequest...................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testUpdateCellsBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "updateCells":{
                                                  "range":{
                                                          "sheetId":1596758874
                                                          },
                                                  "fields":"*"
                                                  }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.updateCellsBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing updateCellsBatchRequest.......................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testAppendCellsBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "appendDimension":{

                                                      "sheetId":1596758874,
                                                      "dimension":"ROWS",
                                                      "length":3

                                                      }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.appendDimensionBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing appendDimensionBatchRequest...................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testUpdateBorderBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "updateBorders":{
                                                    "range":{
                                                            "sheetId":1596758874,
                                                            "startRowIndex":2,
                                                            "endRowIndex":10,
                                                            "startColumnIndex":2,
                                                            "endColumnIndex":4
                                                            }
                                                    }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.updateBordersBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing updateBordersBatchRequest.....................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testRepeatCellsBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "repeatCell":{
                                                 "range":{
                                                         "sheetId":1596758874,
                                                         "startRowIndex":0,
                                                         "endRowIndex":1
                                                         },
                                                 "cell":{
                                                        "userEnteredFormat":{
                                                                            "backgroundColor":{
                                                                                              "red":0.0,
                                                                                              "green":0.0,
                                                                                              "blue":0.0
                                                                                              },
                                                                            "horizontalAlignment":"CENTER",
                                                                            "textFormat":{
                                                                                         "foregroundColor":{
                                                                                                           "red":1.0,
                                                                                                           "green":1.0,
                                                                                                           "blue":1.0
                                                                                                           },
                                                                                         "fontSize":12,
                                                                                         "bold":true
                                                                                         }
                                                                            }
                                                        },
                                                 "fields":"userEnteredFormat(backgroundColor,textFormat,horizontalAlignment)"
                                                 }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.repeatCellsBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing repeatCellsBatchRequest.......................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testMergeCellsBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "mergeCells":{
                                                 "range":{
                                                         "sheetId":1596758874,
                                                         "startRowIndex":0,
                                                         "endRowIndex":1,
                                                         "startColumnIndex":0,
                                                         "endColumnIndex":1
                                                         },
                                                 "mergeType":"MERGE_ALL"
                                                 }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.mergeCellsBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing mergeCellsBatchRequest........................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);

}

function testSetDataValidationBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {"requests":[
                                     {
                                     "setDataValidation":{
                                                         "range":{
                                                                 "sheetId":1596758874,
                                                                 "startRowIndex":0,
                                                                 "endRowIndex":10,
                                                                 "startColumnIndex":0,
                                                                 "endColumnIndex":6
                                                                 },
                                                         "rule":{
                                                                "condition":{
                                                                            "type":"NUMBER_GREATER",
                                                                            "values":[
                                                                                     {
                                                                                     "userEnteredValue":"5"
                                                                                     }
                                                                                     ]
                                                                            },
                                                                "inputMessage":"Value must be > 5",
                                                                "strict":true
                                                                }
                                                         }
                                     }
                                     ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.setDataValidationBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing setDataValidationBatchRequest.................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testCopyPasteBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "copyPaste":{
                                                "source":{
                                                         "sheetId":789,
                                                         "startRowIndex":0,
                                                         "endRowIndex":10,
                                                         "startColumnIndex":0,
                                                         "endColumnIndex":4
                                                         },
                                                "destination":{
                                                              "sheetId":1596758874,
                                                              "startRowIndex":0,
                                                              "endRowIndex":10,
                                                              "startColumnIndex":5,
                                                              "endColumnIndex":9
                                                              },
                                                "pasteType":"PASTE_FORMAT",
                                                "pasteOrientation":"NORMAL"
                                                }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.copyPasteBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing copyPasteBatchRequest.........................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testCutPasteBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "cutPaste":{
                                               "source":{
                                                        "sheetId":789,
                                                        "startRowIndex":0,
                                                        "endRowIndex":10,
                                                        "startColumnIndex":0,
                                                        "endColumnIndex":4
                                                        },
                                               "destination":{
                                                             "sheetId":1596758874,
                                                             "rowIndex":0,
                                                             "columnIndex":5
                                                             },
                                               "pasteType":"PASTE_NORMAL"
                                               }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.cutPasteBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing cutPasteBatchRequest..........................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testAddConditionalFormatRuleBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "addConditionalFormatRule":{
                                                               "rule":{
                                                                      "ranges":[
                                                                               {
                                                                               "sheetId":1596758874,
                                                                               "startRowIndex":9,
                                                                               "endRowIndex":10
                                                                               }
                                                                               ],
                                                                      "gradientRule":{
                                                                                     "minpoint":{
                                                                                                "color":{
                                                                                                        "green":0.2,
                                                                                                        "red":0.8
                                                                                                        },
                                                                                                "type":"MIN"
                                                                                                },
                                                                                     "maxpoint":{
                                                                                                "color":{
                                                                                                        "green":0.9
                                                                                                        },
                                                                                                "type":"MAX"
                                                                                                }
                                                                                     }
                                                                      },
                                                               "index":0
                                                               }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.addConditionalFormatRuleBatchRequest (spreadSheetId, payloadToSend
                                                                                        , fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing addConditionalFormatRuleBatchRequest..........................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testUpdateConidtionalFormatRuleBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "updateConditionalFormatRule":{
                                                                  "sheetId":521331261,
                                                                  "index":1,
                                                                  "rule":{
                                                                         "ranges":[
                                                                                  {
                                                                                  "sheetId":1596758874,
                                                                                  "startRowIndex":0,
                                                                                  "endRowIndex":5,
                                                                                  "startColumnIndex":0,
                                                                                  "endColumnIndex":4
                                                                                  }
                                                                                  ],
                                                                         "booleanRule":{
                                                                                       "condition":{
                                                                                                   "type":"TEXT_EQ",
                                                                                                   "values":[
                                                                                                            {
                                                                                                            "userEnteredValue":"Total Cost"
                                                                                                            }
                                                                                                            ]
                                                                                                   },
                                                                                       "format":{
                                                                                                "textFormat":{
                                                                                                             "bold":true
                                                                                                             }
                                                                                                }
                                                                                       }
                                                                         }
                                                                  }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.updateConditionalFormatRuleBatchRequest (spreadSheetId, payloadToSend
                                                                                           , fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing updateConditionalFormatRuleBatchRequest........................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}


function testDeleteConditionalFormatRuleBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {"requests":[
                                     {
                                     "deleteConditionalFormatRule":{
                                                                   "sheetId":1596758874,
                                                                   "index":0
                                                                   }
                                     }
                                     ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.deleteConditionalFormatRuleBatchRequest (spreadSheetId, payloadToSend
                                                                                           , fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing deleteConditionalFormatRuleBatchRequest.......................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testUpdateDimensionPropertiesBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "updateDimensionProperties":{
                                                                "range":{
                                                                        "sheetId":1596758874,
                                                                        "dimension":"COLUMNS",
                                                                        "startIndex":0,
                                                                        "endIndex":1
                                                                        },
                                                                "properties":{
                                                                             "pixelSize":160
                                                                             },
                                                                "fields":"pixelSize"
                                                                }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.updateDimensionPropertiesBatchRequest (spreadSheetId, payloadToSend
                                                                                         , fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing updateDimensionPropertiesBatchRequest.........................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testAutoResizeBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "autoResizeDimensions":{
                                                           "dimensions":{
                                                                        "sheetId":1596758874,
                                                                        "dimension":"COLUMNS",
                                                                        "startIndex":0,
                                                                        "endIndex":3
                                                                        }
                                                           }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.autoResizeDimensionsBatchRequest (spreadSheetId, payloadToSend
                                                                                    , fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing autoResizeDimensionsBatchRequest..............................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testInsertDimensionBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "insertDimension":{
                                                      "range":{
                                                              "sheetId":1596758874,
                                                              "dimension":"COLUMNS",
                                                              "startIndex":2,
                                                              "endIndex":4
                                                              },
                                                      "inheritFromBefore":true
                                                      }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.insertDimensionBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing insertDimensionBatchRequest...................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testMoveDimensionBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "moveDimension":{
                                                    "source":{
                                                             "sheetId":1596758874,
                                                             "dimension":"COLUMNS",
                                                             "startIndex":0,
                                                             "endIndex":1
                                                             },
                                                    "destinationIndex":3
                                                    }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.moveDimensionBatchRequest (spreadSheetId, payloadToSend
                                                                             , fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing moveDimensionBatchRequest.....................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}

function testSortRangeBatchRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    json payloadToSend = {
                         "requests":[
                                    {
                                    "sortRange":{
                                                "range":{
                                                        "sheetId":1596758874,
                                                        "startRowIndex":0,
                                                        "endRowIndex":10,
                                                        "startColumnIndex":0,
                                                        "endColumnIndex":6
                                                        },
                                                "sortSpecs":[
                                                            {
                                                            "dimensionIndex":1,
                                                            "sortOrder":"ASCENDING"
                                                            },
                                                            {
                                                            "dimensionIndex":3,
                                                            "sortOrder":"DESCENDING"
                                                            },
                                                            {
                                                            "dimensionIndex":4,
                                                            "sortOrder":"DESCENDING"
                                                            }
                                                            ]
                                                }
                                    }
                                    ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.sortRangeBatchRequest (spreadSheetId, payloadToSend, fields);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing sortRangeBatchRequest.........................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}


function testAddRowsColumnsDataRequest () {
    googlespreadsheet:ClientConnector connectorInstance = initBalConnector();
    string spreadSheetId = "1kjhXdkEQfLy4p1SIOMx5JRwev8ZrrmK0Ch_NxuV6zKY";
    string range = "Withdrawls!A1:B2";
    string insertDataOption = "INSERT_ROWS";
    string valueInputOption = "RAW";
    json payloadToSend = {
                         "values":[
                                  [
                                  "20",
                                  "21"
                                  ],
                                  [
                                  "22",
                                  "23"
                                  ]
                                  ]
                         };
    string fields = "spreadsheetId";
    string returnedSpreadSheetId;
    boolean assertValue = false;
    int statusCode;
    message googlespreadsheetResponse = {};

    googlespreadsheetResponse = connectorInstance.addRowsColumnsData (spreadSheetId, range, insertDataOption,
                                                                      valueInputOption, fields, payloadToSend);
    payload = messages:getJsonPayload(googlespreadsheetResponse);
    returnedSpreadSheetId = (string)payload.spreadsheetId;
    statusCode = http:getStatusCode(googlespreadsheetResponse);
    if (returnedSpreadSheetId != "" && statusCode == 200) {
        assertValue = true;
    }
    system:println(".........................Executing addRowsColumnsData............................................");
    test:assertEquals(assertValue, true, "Test Failed.Assertion is failing" + "SpreadsheetID" + ":"
                                         + returnedSpreadSheetId + "Status Code" + ":" + statusCode);
}






