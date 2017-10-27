package org.wso2.ballerina.connectors.salesforcerest;

import ballerina.net.uri;
import org.wso2.ballerina.connectors.oauth2;
import ballerina.net.http;

@Description { value:"Salesforcerest client connector"}
@Param { value:"accessToken: The accessToken of the salesforce connected app to access the salesforce REST API"}
@Param { value:"clientId: The clientId of the salesforce connected app to access the salesforce REST API"}
@Param { value:"clientSecret: The clientSecret of the salesforce connected app to access the salesforce REST API"}
@Param { value:"refreshToken: The refreshToken of the salesforce connected app to access the salesforce REST API"}
@Param { value:"apiInstance: The api instance of the organization"}
public connector ClientConnector (string accessToken, string clientId, string clientSecret, string refreshToken,
                           string apiInstance, string refreshEndpoint) {

    oauth2:ClientConnector oauth2Connector = create oauth2:ClientConnector(buildBaseUrl(apiInstance), accessToken, clientId,
                                                                           clientSecret, refreshToken, refreshEndpoint);

    @Description { value:"Lists the available objects and their metadata for your organization’s data"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Return { value:"response message"}
    action describeGlobal (string apiVersion) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects";
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Completely describes the individual metadata at all levels for the specified object"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Return { value:"response message"}
    action sObjectDescribe (string sobjectName, string apiVersion) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/describe/";
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Lists summary information about each REST API version currently available"}
    @Return { value:"response message"}
    action listAvailableApiVersion () (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data";
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Lists limits information for your organization"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Return { value:"response message"}
    action listOrganizationLimits (string apiVersion) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/limits";
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Lists the resources available for the specified API version"}
    @Param { value:"requestingApiVersion: The api version to get resources"}
    @Return { value:"response message"}
    action listResourcesByApiVersion (string requestingApiVersion) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + requestingApiVersion;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Describes the individual metadata for the specified object"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Return { value:"response message"}
    action sObjectBasicInfo (string sobjectName, string apiVersion) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Retrieves the list of individual records that have been deleted within the given timespan
     for the specified object"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Param { value:"startTime: The start time of the time span"}
    @Param { value:"endTime: The end time of the time span"}
    @Return { value:"response message"}
    action sObjectGetDeleted (string apiVersion, string sobjectName, string startTime, string endTime) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/deleted/?start=" + uri:encode(startTime)
                            + "&end=" + uri:encode(endTime);
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Retrieves the list of individual records that have been updated (added or changed)
     within the given timespan for the specified object"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Param { value:"startTime: The start time of the time span"}
    @Param { value:"endTime: The end time of the time span"}
    @Return { value:"response message"}
    action sObjectGetUpdated (string apiVersion, string sobjectName, string startTime, string endTime) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/updated/?start=" + uri:encode(startTime)
                            + "&end=" + uri:encode(endTime);
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Query for actions displayed in the UI, given a user, a context, device format, and a record ID"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Return { value:"response message"}
    action sObjectPlatformAction (string apiVersion) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/PlatformAction";
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Accesses records based on the specified object ID"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Return { value:"response message"}
    action sObjectRows (string apiVersion, string sobjectName, string rowId) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + rowId;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Creates new records or updates existing records (upserts records) based on the value of a
     specified external ID field"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Param { value:"fieldId: The external field id"}
    @Param { value:"fieldValue: The external field value"}
    @Return { value:"response message"}
    action sObjectRowsByExternalId (string apiVersion, string sobjectName, string fieldId, string fieldValue) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + fieldId + "/" + fieldValue;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Get feedback on how Salesforce will execute your list view"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"listViewId: The id of the listview to get the feedback from"}
    @Return { value:"response message"}
    action listviewQueryPerformanceFeedback (string apiVersion, string listViewId) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/query/?explain=" + listViewId;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Executes the specified SOQL query"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"queryString: The request SOQL query"}
    @Return { value:"response message"}
    action query (string apiVersion, string queryString) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/query/?q=" + queryString;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"QueryAll will return records that have been deleted because of a merge or delete, archived Task
     and Event records"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"queryString: The request SOQL query"}
    @Return { value:"response message"}
    action queryAll (string apiVersion, string queryString) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/queryAll/?q=" + queryString;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }
    @Description { value:"If the queryAll results are too large, retrieve the next batch of results"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"nextRecordsUrl: The url sent with first batch of queryAll results to get the next batch"}
    @Return { value:"response message"}
    action queryAllMore (string apiVersion, string nextRecordsUrl) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/queryAll/" + nextRecordsUrl;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"If the query results are too large, retrieve the next batch of results"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"nextRecordsUrl: The url sent with first batch of query results to get the next batch"}
    @Return { value:"response message"}
    action queryMore (string apiVersion, string nextRecordsUrl) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/query/" + nextRecordsUrl;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Get feedback on how Salesforce will execute your query"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"queryString: The request SOQL query"}
    @Return { value:"response message"}
    action queryPerformanceFeedback (string apiVersion, string queryString) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/query/?explain=" + queryString;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Creates new records"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Param { value:"payload: json payload containing record data"}
    @Return { value:"response message"}
    action createRecord (string apiVersion, string sobjectName, json payload) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName;
        requestMsg.setJsonPayload(payload);
        response = oauth2Connector.post (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Create multiple records"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Param { value:"payload: json payload containing record data"}
    @Return { value:"response message"}
    action createMultipleRecords (string apiVersion, string sobjectName, json payload) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/composite/tree/" + sobjectName;
        requestMsg.setJsonPayload(payload);
        response = oauth2Connector.post (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Deletes existing record"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Return { value:"response message"}
    action delete (string apiVersion, string sobjectName, string deleteId) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + deleteId;
        response = oauth2Connector.delete (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Retrieve field values from a record"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Param { value:"rowId: The row ID of the required record"}
    @Param { value:"fields: The comma separated set of required fields"}
    @Return { value:"response message"}
    action retrieveFieldValues (string apiVersion, string sobjectName, string rowId, string fields) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + rowId + "?fields=" + fields;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Retrieve field values from an external record"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Param { value:"rowId: The row ID of the required record"}
    @Param { value:"fields: The comma separated set of required fields"}
    @Return { value:"response message"}
    action retrieveFieldValuesFromExternalObject (string apiVersion, string sobjectName, string rowId, string fields)
    (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + rowId + "?fields=" + fields;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Retrieve field values from an external record with external ID"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Param { value:"externalId: The row ID of the required external record"}
    @Param { value:"fields: The comma separated set of required fields"}
    @Return { value:"response message"}
    action retrieveStandardFieldValuesFromExternalObjectWithExternalId (string apiVersion, string sobjectName,
                                                                        string externalId, string fields) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + externalId + "?fields=" + fields;
        response = oauth2Connector.get (requestURI, requestMsg);
        return response;
    }

    @Description { value:"Updates an existing record"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Param { value:"payload: json payload containing record data"}
    @Return { value:"response message"}
    action update (string apiVersion, string sobjectName, string recordId, json payload) (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + recordId;
        requestMsg.setJsonPayload(payload);
        response = oauth2Connector.patch (requestURI, requestMsg);
        return response;
    }

    @Description { value:"If record exists, update it else inserts it"}
    @Param { value:"apiVersion: The api version to send request to"}
    @Param { value:"sobjectName: The relevant sobject name"}
    @Param { value:"externalField: The external field id"}
    @Param { value:"fieldValueId: The external field value"}
    @Param { value:"payload: json payload containing record data"}
    @Return { value:"response message"}
    action upsert (string apiVersion, string sobject, string externalField, string fieldValueId, json payload)
    (http:Response) {
        http:Request requestMsg = {};
        http:Response response = {};

        string requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobject + "/" + externalField + "/" + fieldValueId;
        requestMsg.setJsonPayload(payload);
        response = oauth2Connector.patch (requestURI, requestMsg);
        return response;
    }
}

function buildBaseUrl(string apiInstance) (string) {
    string baseEndpoint = "https://" + apiInstance + ".salesforce.com";
    return baseEndpoint;
}