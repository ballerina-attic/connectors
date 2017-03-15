package org.wso2.ballerina.connectors.salesforcerest;

import ballerina.lang.messages;
import ballerina.net.uri;
import org.wso2.ballerina.connectors.oauth2;

@doc:Description("Salesforcerest client connector")
@doc:Param("accessToken: The accessToken of the salesforce connected app to access the salesforce REST API")
@doc:Param("clientId: The clientId of the salesforce connected app to access the salesforce REST API")
@doc:Param("clientSecret: The clientSecret of the salesforce connected app to access the salesforce REST API")
@doc:Param("refreshToken: The refreshToken of the salesforce connected app to access the salesforce REST API")
@doc:Param("apiInstance: The api instance of the organization")
connector ClientConnector(string accessToken, string clientId, string clientSecret, string refreshToken, string apiInstance, string refreshEndpoint) {

    string baseEndpoint = "https://" + apiInstance + ".salesforce.com";
    oauth2:ClientConnector oauth2Connector = create oauth2:ClientConnector(baseEndpoint, accessToken, clientId,
     clientSecret, refreshToken, refreshEndpoint);

    @doc:Description("Lists the available objects and their metadata for your organization’s data")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Return("response message")
    action describeGlobal(ClientConnector sf, string apiVersion) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects";
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Completely describes the individual metadata at all levels for the specified object")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Return("response message")
    action sObjectDescribe(ClientConnector sf, string sobjectName, string apiVersion) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Lists summary information about each REST API version currently available")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Return("response message")
    action listAvailableApiVersion(ClientConnector sf) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data";
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Lists limits information for your organization")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Return("response message")
    action listOrganizationLimits(ClientConnector sf, string apiVersion) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/limits";
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Lists the resources available for the specified API version")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("requestingApiVersion: The api version to get resources")
    @doc:Return("response message")
    action listResourcesByApiVersion(ClientConnector sf, string requestingApiVersion) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + requestingApiVersion;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Describes the individual metadata for the specified object")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Return("response message")
    action sObjectBasicInfo(ClientConnector sf, string sobjectName, string apiVersion) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Retrieves the list of individual records that have been deleted within the given timespan
     for the specified object")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Param("startTime: The start time of the time span")
    @doc:Param("endTime: The end time of the time span")
    @doc:Return("response message")
    action sObjectGetDeleted(ClientConnector sf, string apiVersion, string sobjectName, string startTime, string endTime) (message)
     throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/deleted/?start=" + uri:encode(startTime)
        + "&end=" + uri:encode(endTime);
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Retrieves the list of individual records that have been updated (added or changed)
     within the given timespan for the specified object")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Param("startTime: The start time of the time span")
    @doc:Param("endTime: The end time of the time span")
    @doc:Return("response message")
    action sObjectGetUpdated(ClientConnector sf, string apiVersion, string sobjectName, string startTime, string endTime) (message)
     throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/deleted/?start=" + uri:encode(startTime)
        + "&end=" + uri:encode(endTime);
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Query for actions displayed in the UI, given a user, a context, device format, and a record ID")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Return("response message")
    action sObjectPlatformAction(ClientConnector sf, string apiVersion) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/PlatformAction";
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Accesses records based on the specified object ID")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Return("response message")
    action sObjectRows(ClientConnector sf, string apiVersion, string sobjectName, string rowId) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + rowId;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Creates new records or updates existing records (upserts records) based on the value of a
     specified external ID field")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Param("fieldId: The external field id")
    @doc:Param("fieldValue: The external field value")
    @doc:Return("response message")
    action sObjectRowsByExternalId(ClientConnector sf, string apiVersion, string sobjectName, string fieldId, string fieldValue) (message)
     throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + fieldId + "/" + fieldValue;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Get feedback on how Salesforce will execute your list view")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("listViewId: The id of the listview to get the feedback from")
    @doc:Return("response message")
    action listviewQueryPerformanceFeedback(ClientConnector sf, string apiVersion, string listViewId) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/query/?explain=" + listViewId;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Executes the specified SOQL query")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("queryString: The request SOQL query")
    @doc:Return("response message")
    action query(ClientConnector sf, string apiVersion, string queryString) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/query/?q=" + queryString;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("QueryAll will return records that have been deleted because of a merge or delete, archived Task
     and Event records")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("queryString: The request SOQL query")
    @doc:Return("response message")
    action queryAll(ClientConnector sf, string apiVersion, string queryString) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/queryAll/?q=" + queryString;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }
    @doc:Description("If the queryAll results are too large, retrieve the next batch of results")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("nextRecordsUrl: The url sent with first batch of queryAll results to get the next batch")
    @doc:Return("response message")
    action queryAllMore(ClientConnector sf, string apiVersion, string nextRecordsUrl) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/queryAll/" + nextRecordsUrl;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("If the query results are too large, retrieve the next batch of results")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("nextRecordsUrl: The url sent with first batch of query results to get the next batch")
    @doc:Return("response message")
    action queryMore(ClientConnector sf, string apiVersion, string nextRecordsUrl) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/queryMore/" + nextRecordsUrl;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Get feedback on how Salesforce will execute your query")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("queryString: The request SOQL query")
    @doc:Return("response message")
    action queryPerformanceFeedback(ClientConnector sf, string apiVersion, string queryString) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/query/?explain=" + "queryString";
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Creates new records")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Param("payload: json payload containing record data")
    @doc:Return("response message")
    action createRecord(ClientConnector sf, string apiVersion, string sobjectName, json payload) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName;
	    messages:setJsonPayload(requestMsg, payload);
        response = oauth2:ClientConnector.post(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Create multiple records")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Param("payload: json payload containing record data")
    @doc:Return("response message")
    action createMultipleRecords(ClientConnector sf, string apiVersion, string sobjectName, json payload) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/composite/tree/" + sobjectName;
	    messages:setJsonPayload(requestMsg, payload);
        response = oauth2:ClientConnector.post(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Deletes existing record")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Return("response message")
    action delete(ClientConnector sf, string apiVersion, string sobjectName, string deleteId) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + deleteId;
        response = oauth2:ClientConnector.delete(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Retrieve field values from a record")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Param("rowId: The row ID of the required record")
    @doc:Param("fields: The comma separated set of required fields")
    @doc:Return("response message")
    action retrieveFieldValues(ClientConnector sf, string apiVersion, string sobjectName, string rowId, string fields) (message)
     throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + rowId + "?fields=" + fields;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Retrieve field values from an external record")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Param("rowId: The row ID of the required record")
    @doc:Param("fields: The comma separated set of required fields")
    @doc:Return("response message")
    action retrieveFieldValuesFromExternalObject(ClientConnector sf, string apiVersion, string sobjectName, string rowId, string fields)
     (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + rowId + "?fields=" + fields;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Retrieve field values from an external record with external ID")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Param("externalId: The row ID of the required external record")
    @doc:Param("fields: The comma separated set of required fields")
    @doc:Return("response message")
    action retrieveStandardFieldValuesFromExternalObjectWithExternalId(ClientConnector sf, string apiVersion, string sobjectName,
     string externalId, string fields) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + externalId + "?fields=" + fields;
        response = oauth2:ClientConnector.get(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("Updates an existing record")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Param("payload: json payload containing record data")
    @doc:Return("response message")
    action update(ClientConnector sf, string apiVersion, string sobjectName, string recordId, json payload) (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobjectName + "/" + recordId;
	    messages:setJsonPayload(requestMsg, payload);
        response = oauth2:ClientConnector.post(oauth2Connector, requestURI, requestMsg);
        return response;
    }

    @doc:Description("If record exists, update it else inserts it")
    @doc:Param("sf: The salesforcerest connector instance")
    @doc:Param("apiVersion: The api version to send request to")
    @doc:Param("sobjectName: The relevant sobject name")
    @doc:Param("externalField: The external field id")
    @doc:Param("fieldValueId: The external field value")
    @doc:Param("payload: json payload containing record data")
    @doc:Return("response message")
    action upsert(ClientConnector sf, string apiVersion, string sobject, string externalField, string fieldValueId, json payload)
     (message) throws exception {
        string httpMethod;
        string requestURI;
        message requestMsg = {};
        message response = {};
        requestURI = "/services/data/" + apiVersion + "/sobjects/" + sobject + "/" + externalField + "/" + fieldValueId;
	    messages:setJsonPayload(requestMsg, payload);
        response = oauth2:ClientConnector.patch(oauth2Connector, requestURI, requestMsg);
        return response;
    }
}