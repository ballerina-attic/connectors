# Google Spreadsheet Connector

   The Google Spreadsheet connector allows you to access the Google Spreadsheet API Version v4 through Ballerina. 
   Google Sheets is an online spreadsheet that lets users create and format spreadsheets and simultaneously work with other people.
   The following section provide you the details on connector operations.
   
## createSpreadsheet
   The createSpreadsheet action allows you to creates a new spreadsheet.

###### Properties
   * payload :- The payload containing the information of the post that should be send.
   * fields :- Specifying which fields to include in a partial response.
      
###### Related Google Spreadsheet documentation
   [createSpreadsheet](https://developers.google.com/sheets/reference/rest/v4/spreadsheets#Spreadsheet)

## addSheetBatchRequest
   This action allow you to add new sheet/sheets to an existing spreadsheet.

###### Properties
   * spreadsheetId :- Unique value of the spreadsheet.
   * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
     To add multiple sheets within the spread sheet, need to repeat "addSheetBatchRequest" property within the requests attribute.
   * fields :- Specifying which fields to include in a partial response.
  
###### Related Google Spreadsheet documentation
   [addSheetBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#AddSheetRequest)

## deleteSheetBatchRequest
   This action allows you to remove sheets from a given spreadsheet using "sheetId".

###### Properties
   * spreadsheetId :- Unique value of the spreadsheet.
   * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
     To delete multiple sheets within the spread sheet, need to repeat "deleteSheetBatchRequest" property within the requests attribute.
   * fields :- Specifying which fields to include in a partial response.
  
###### Related Google Spreadsheet documentation
   [deleteSheetBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#deletesheetrequest)

## getSheetMetaData
   This action can be used to acquire sheet properties and other metadata.

###### Properties
   * spreadsheetId :- Unique value of the spreadsheet.
   * includeGridData :- True if grid data should be returned. This parameter is ignored if a field mask was set in the request.
   * fields :- Specifying which fields to include in a partial response.
   * ranges :- The ranges to retrieve from the spreadsheet.
    
###### Related Google Spreadsheet documentation
   [getSheetMetaData](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/get)
   
## updateSheetPropertiesBatchRequest
  This action allows you to update the size, title, and other sheet properties.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To update multiple sheets within the spread sheet, need to repeat "updateSheetPropertiesBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [updateSheetPropertiesBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#UpdateSheetPropertiesRequest)
  
## copyTo
  This action allows you to Copy a single sheet from a spreadsheet to another spreadsheet. Returns the properties of the newly created sheet.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * sheetId :- The ID of the sheet to copy.
  * payload :- It contains the ID of the spreadsheet to copy the sheet to.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [copyTo](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.sheets/copyTo)
  
## addRowsColumnsData
  This action allows to append row/rows/column/columns of data.
 
###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * range :- The A1 notation of the values to retrieve.
  * insertDataOption :- How the input data should be inserted.
  * valueInputOption :- How the input data should be interpreted.
  * payload :- It contains the major dimension that results should use and the data that was to be written(values).
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [addRowsColumnsData](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.values/append)
  
## deleteDimensionBatchRequest
  This action allows you to delete rows or columns by specifying the dimension property.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To do multiple delete dimension within the spread sheet, need to repeat "deleteDimensionBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [deleteDimensionBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#DeleteDimensionRequest)
  
## getCellData
  This action allow you to retrieve any set of cell data from a sheet. 
  It return cell contents not only as input values (as would be entered by a user at a keyboard) but also it grants 
  full access to values, formulas, formatting, hyperlinks, data validation, and other properties.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * range :- The A1 notation of the values to retrieve.   
  * dateTimeRenderOption :- How dates, times, and durations should be represented in the output.
  * majorDimension :- The major dimension that results should use.
  * valueRenderOption :- How values should be represented in the output.
  * fields :- Specifying which fields to include in a partial response.
  
###### Related Google Spreadsheet documentation
  [getCellData](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.values/get)
  
## getMultipleCellData
  This action allow you to retrieve any multiple set of cell data from a sheet (including multiple ranges). It return cell contents not only 
  as input values (as would be entered by a user at a keyboard) but also it grants full access to values, formulas, formatting, hyperlinks, data validation, and other properties.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * ranges :- The ranges of the values to retrieve from the spreadsheet. 
  * dateTimeRenderOption :- How dates, times, and durations should be represented in the output.
  * majorDimension :- The major dimension that results should use.
  * valueRenderOption :- How values should be represented in the output.
  * fields :- Specifying which fields to include in a partial response.
  
###### Related Google Spreadsheet documentation
  [getMultipleCellData](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.values/batchGet)
  
## editCell
  This action allow to edit the content of the cell with new values.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * range :- The A1 notation of the values to retrieve.
  * valueInputOption :- How the input data should be interpreted.
  * payload :- It contains data about major dimension that results should use and about the values (the data that was to be written).
  * fields :- Specifying which fields to include in a partial response.
  
###### Related Google Spreadsheet documentation
  [editCell](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.values/update)
  
## editMultipleCell
  This action allow to edit the content of multiple cell with new values.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data about the new values(data) to apply to the spreadsheet and How the input data should be interpreted(valueInputOption).
  * fields :- Specifying which fields to include in a partial response.
  
###### Related Google Spreadsheet documentation
  [editMultipleCell](https://developers.google.com/sheets/reference/rest/v4/spreadsheets.values/batchUpdate)
  
## updateCellsBatchRequest
  This action allow to updates all cells in a range with new data that can be cell value, formatting.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To update multiple cells within the spread sheet, need to repeat "updateCellsBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [updateCellsBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#updatecellsrequest)
  
## appendDimensionBatchRequest
  This action allows you to appends empty rows and columns to the end of the sheet.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To append multiple dimension within the spread sheet, need to repeat "appendDimensionBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [appendDimensionBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#appenddimensionrequest)
  
## updateBordersBatchRequest
  This action allow you to edit cell borders.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To update multiple borders within the spread sheet, need to repeat "updateBordersBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [updateBordersBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#updatebordersrequest)
  
## repeatCellsBatchRequest
  This action allow you to updates all cells in the range to the values in the given Cell object.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple operation within the spread sheet, need to repeat "repeatCellsBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [repeatCellsBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#repeatcellrequest)
  
## mergeCellsBatchRequest
  This action allow you to merges all cells in the range. 

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple merge operation within the spread sheet, need to repeat "mergeCellsBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [mergeCellsBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#mergecellsrequest)
  
## setDataValidationBatchRequest
  This action allow to sets a data validation rule to every cell in the range. 
  To clear validation in a range, call this with no rule specified. 

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple setDataValidation operation within the spread sheet, need to repeat "setDataValidationBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [setDataValidationBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#setdatavalidationrequest)
  
## copyPasteBatchRequest
  This action allow to copy cell formatting in one range and paste it into another range on the same sheet.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple copyPaste operation within the spread sheet, need to repeat "copyPasteBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [copyPasteBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#copypasterequest)
  
## cutPasteBatchRequest
  This action allow to cuts the one range and pastes its data, formats, formulas, and merges to the another range on the same sheet.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple cutPaste operation within the spread sheet, need to repeat "cutPasteBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [cutPasteBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#cutpasterequest)
  
## updateConditionalFormatRuleBatchRequest
  This action allow to updates a conditional format rule at the given index, or moves a conditional format rule to another index.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple updateConditionalFormat operation within the spread sheet, need to repeat "updateConditionalFormatRuleBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [updateConditionalFormatRuleBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#updateconditionalformatrulerequest)

## addConditionalFormatRuleBatchRequest
  This action allow to adds a new conditional format rule at the given index.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple addConditionalFormat operation within the spread sheet, need to repeat "addConditionalFormatRuleBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [addConditionalFormatRuleBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#addconditionalformatrulerequest)

## deleteConditionalFormatRuleBatchRequest
  This action allow to deletes a conditional format rule at the given index.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple deleteConditionalFormat operation within the spread sheet, need to repeat "deleteConditionalFormatRuleBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [deleteConditionalFormatRuleBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#DeleteConditionalFormatRuleRequest)
  
## updateDimensionPropertiesBatchRequest
  This action allow to updates properties of dimensions within the specified range.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple updateDimensionProperties operation within the spread sheet, need to repeat "updateDimensionPropertiesBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [updateDimensionPropertiesBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#updatedimensionpropertiesrequest)
  
## autoResizeDimensionsBatchRequest
  This action allow to automatically resizes one or more dimensions based on the contents of the cells in that dimension.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple autoResizeDimensions operation within the spread sheet, need to repeat "autoResizeDimensionsBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [autoResizeDimensionsBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#autoresizedimensionsrequest)
  
## insertDimensionBatchRequest
  This action allow to inserts rows or columns in a sheet at a particular index.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple insertDimension operation within the spread sheet, need to repeat "insertDimensionBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [insertDimensionBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#insertdimensionrequest)

## moveDimensionBatchRequest
  This action allow to moves one or more rows or columns.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple moveDimension operation within the spread sheet, need to repeat "moveDimensionBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [moveDimensionBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#movedimensionrequest)
  
## sortRangeBatchRequest
  This action allow to sorts data in rows based on a sort order per column.

###### Properties
  * spreadsheetId :- Unique value of the spreadsheet.
  * payload :- It contains data that is a kind of update to apply to a spreadsheet. 
    To perform multiple sortRange operation within the spread sheet, need to repeat "sortRangeBatchRequest" property within the requests attribute.
  * fields :- Specifying which fields to include in a partial response.
 
###### Related Google Spreadsheet documentation
  [sortRangeBatchRequest](https://developers.google.com/sheets/reference/rest/v4/spreadsheets/request#sortrangerequest)
  
  
## How to use

###### Prerequisites

1. Create a project and create an app for this project by visiting [Google Spreadsheet](https://console.developers.google.com/)
2. Obtain the following parameters
   * Client Id
   * Client Secret
   * Redirect URI
   * Access Token
   * Refresh Token
   
    **IMPORTANT** This access token and refresh token can be used to make API requests on your own
account's behalf. Do not share your access token, client  secret with anyone.


###### Invoke the actions

- copy googlespreadsheet/sample/googlespreadsheet/samples.bal into `<ballerina_home>`/bin$ folder
- To run the actions of the Google Spreadsheet connector run the below command for relevant actions.

###### NOTE

If the template parameter is indicate as optional you must pass null as default value to run this
action.

1. getSheetMetaData  
    `bin$ ./ballerina run main samples.bal getSheetMetaData <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <includeGridData:-Optional> 
    <fields:-Optional> <ranges:-Optional>`

2. copyTo  
    `bin$ ./ballerina run main samples.bal copyTo <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <sheetId:-Required> 
    <payload:-Required> <fields:-Optional>`
    
3. getCellData  
    `bin$ ./ballerina run main samples.bal getCellData <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <range:-Required> 
    <dateTimeRenderOption:-Optional> <valueRenderOption:-Optional> <fields:-Optional> <majorDimension:-Optional>`
    
4. getMultipleCellData  
    `bin$ ./ballerina run main samples.bal getMultipleCellData <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <ranges:-Optional> 
    <dateTimeRenderOption:-Optional> <valueRenderOption:-Optional> <fields:-Optional> <majorDimension:-Optional>`
    
5. editCell  
    `bin$ ./ballerina run main samples.bal editCell <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <range:-Required> 
    <valueInputOption:-Required> <payload:-Required> <fields:-Optional>`
    
6. editMultipleCell  
    `bin$ ./ballerina run main samples.bal editMultipleCell <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
7. createSpreadsheet  
    `bin$ ./ballerina run main samples.bal createSpreadsheet <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
8. addSheetBatchRequest  
    `bin$ ./ballerina run main samples.bal addSheetBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
9. deleteSheetBatchRequest  
    `bin$ ./ballerina run main samples.bal deleteSheetBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
10. updateSheetPropertiesBatchRequest  
    `bin$ ./ballerina run main samples.bal updateSheetPropertiesBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
11. deleteDimensionBatchRequest  
    `bin$ ./ballerina run main samples.bal deleteDimensionBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
12. updateCellsBatchRequest  
    `bin$ ./ballerina run main samples.bal updateCellsBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`

13. appendDimensionBatchRequest  
    `bin$ ./ballerina run main samples.bal appendDimensionBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
 
14. updateBordersBatchRequest  
    `bin$ ./ballerina run main samples.bal updateBordersBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
15. repeatCellsBatchRequest  
    `bin$ ./ballerina run main samples.bal repeatCellsBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
16. mergeCellsBatchRequest  
    `bin$ ./ballerina run main samples.bal mergeCellsBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
17. setDataValidationBatchRequest  
    `bin$ ./ballerina run main samples.bal setDataValidationBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
18. copyPasteBatchRequest  
    `bin$ ./ballerina run main samples.bal copyPasteBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
19. cutPasteBatchRequest  
    `bin$ ./ballerina run main samples.bal cutPasteBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
20. updateConditionalFormatRuleBatchRequest  
    `bin$ ./ballerina run main samples.bal updateConditionalFormatRuleBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
21. addConditionalFormatRuleBatchRequest  
    `bin$ ./ballerina run main samples.bal addConditionalFormatRuleBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
22. deleteConditionalFormatRuleBatchRequest  
    `bin$ ./ballerina run main samples.bal deleteConditionalFormatRuleBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
23. updateDimensionPropertiesBatchRequest  
    `bin$ ./ballerina run main samples.bal updateDimensionPropertiesBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
24. autoResizeDimensionsBatchRequest  
    `bin$ ./ballerina run main samples.bal autoResizeDimensionsBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
25. insertDimensionBatchRequest  
    `bin$ ./ballerina run main samples.bal insertDimensionBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
26. moveDimensionBatchRequest  
    `bin$ ./ballerina run main samples.bal moveDimensionBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
27. sortRangeBatchRequest  
    `bin$ ./ballerina run main samples.bal sortRangeBatchRequest <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`
    
28. addRowsColumnsData  
    `bin$ ./ballerina run main samples.bal addRowsColumnsData <accessToken:-Required> <refreshToken:-Optional> 
    <clientId:-Optional> <clientSecret:-Optional> <spreadsheetId:-Required> <payload:-Required> <fields:-Optional>`