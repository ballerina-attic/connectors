package org.wso2.ballerina.connectors.salesforcesoap;

import org.wso2.ballerina.connectors.soap;
import ballerina.doc;
import ballerina.lang.xmls;
import ballerina.lang.strings;
import ballerina.lang.maps;

@doc:Description{ value : "Salesforcesoap client connector"}
@doc:Param{ value : "username: Salesforce Username"}
@doc:Param{ value : "password: Salesforce Password + Security Token"}
@doc:Param{ value : "loginUrl: Login Url of Salesforce"}
@doc:Param{ value : "soapVersion: Soap version"}
connector ClientConnector (string username, string password, string loginUrl, string soapVersion) {

    soap:ClientConnector soapConnector = create soap:ClientConnector("");
    string sessionId;
    xml session;
    string serverUrl;

    @doc:Description{ value : "Lists the available objects and their metadata for your organization’s data"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Return{ value : "response message"}
    action describeGlobal (xml[] headers) (xml) {

        int headerCount = headers.length;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:describeGlobal xmlns:urn=\"urn:partner.soap.sforce.com\">
        	           </urn:describeGlobal>");
        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }
        return soapResponse;
    }

    @doc:Description{ value : "Retrieves metadata (field list and object properties) for the specified object type"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Param{ value : "sObjectType: Name of SObject"}
    @doc:Return{ value : "response message"}
    action describeSObject (xml[] headers, string sObjectType) (xml) {

        int headerCount = headers.length;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:describeSObject xmlns:urn=\"urn:partner.soap.sforce.com\">
                           <urn:sObjectType>" + sObjectType + "</urn:sObjectType>
                       </urn:describeSObject>");
        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description{ value : "An array-based version of describeSObject"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Param{ value : "sObjectType: Name of SObject"}
    @doc:Return{ value : "response message"}
    action describeSObjects (xml[] headers, string sObjectType) (xml) {

        int headerCount = headers.length;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:describeSObjects xmlns:urn=\"urn:partner.soap.sforce.com\">
                           <urn:sObjectType>" + sObjectType + "</urn:sObjectType>
                       </urn:describeSObjects>");
        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description{ value : "Adds one or more new records to your organization’s data"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Param{ value : "fields: Map of fields of records"}
    @doc:Return{ value : "response message"}
    action createRecord (xml[] headers, map fields) (xml) {

        int headerCount = headers.length;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:create xmlns:urn=\"urn:partner.soap.sforce.com\" xmlns:urn1=\"urn:sobject.partner.soap.sforce.com\">
                           <urn:sObjects>
                           </urn:sObjects>
                       </urn:create>");

        addFields(payload, fields, "/urn:create/urn:sObjects");

        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description{ value : "Updates one or more existing records in your organization’s data"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Param{ value : "fields: Map of fields of records"}
    @doc:Return{ value : "response message"}
    action updateRecord (xml[] headers, map fields) (xml) {

        int headerCount = headers.length;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:update xmlns:urn=\"urn:partner.soap.sforce.com\" xmlns:urn1=\"urn:sobject.partner.soap.sforce.com\">
                           <urn:sObjects>
                           </urn:sObjects>
                       </urn:update>");

        addFields(payload, fields, "/urn:update/urn:sObjects");

        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description{ value : "Creates new records and updates existing records"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Param{ value : "externalId: External Id"}
    @doc:Param{ value : "fields: Map of fields of records"}
    @doc:Return{ value : "response message"}
    action upsertRecord (xml[] headers, string externalId, map fields) (xml) {

        int headerCount = headers.length;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:upsert xmlns:urn=\"urn:partner.soap.sforce.com\" xmlns:urn1=\"urn:sobject.partner.soap.sforce.com\">
                            <urn:externalIDFieldName>" + externalId + "</urn:externalIDFieldName>
                            <urn:sObjects>
                            </urn:sObjects>
                       </urn:upsert>");

        addFields(payload, fields, "/urn:upsert/urn:sObjects");

        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description{ value : "Executes a query against the specified object and returns data that matches the specified criteria"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Param{ value : "query: Query String"}
    @doc:Return{ value : "response message"}
    action query (xml[] headers, string query) (xml) {

        int headerCount = headers.length;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:query xmlns:urn=\"urn:partner.soap.sforce.com\">
                           <urn:queryString>" + query + "</urn:queryString>
                       </urn:query>");
        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description{ value : "Retrieves data from specified objects, whether or not they have been deleted"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Param{ value : "query: Query String"}
    @doc:Return{ value : "response message"}
    action queryAll (xml[] headers, string query) (xml) {

        int headerCount = headers.length;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:queryAll xmlns:urn=\"urn:partner.soap.sforce.com\">
                           <urn:queryString>" + query + "</urn:queryString>
                       </urn:queryAll>");
        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description{ value : "Retrieves the next batch of objects from a query"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Param{ value : "queryLocator: Url to retrieve the balance query results"}
    @doc:Return{ value : "response message"}
    action queryMore (xml[] headers, string queryLocator) (xml) {

        int headerCount = headers.length;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:queryMore xmlns:urn=\"urn:partner.soap.sforce.com\">
                           <urn:queryLocator>" + queryLocator + "</urn:queryLocator>
                       </urn:queryMore>");
        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }

        return soapResponse;
    }
    @doc:Description{ value : "Deletes one or more records from your organization’s data"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Param{ value : "recordId: Id of Record to be deleted"}
    @doc:Return{ value : "response message"}
    action deleteRecord (xml[] headers, string recordId) (xml) {

        int headerCount = headers.length;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:delete xmlns:urn=\"urn:partner.soap.sforce.com\">
                           <urn:ids>" + recordId + "</urn:ids>
                       </urn:delete>");
        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description{ value : "Retrieves one or more records based on the specified IDs"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Param{ value : "fieldList: List of fields that needs to be retrieved"}
    @doc:Param{ value : "sObjectType: Name of SObject"}
    @doc:Param{ value : "recordId: Id of Record"}
    @doc:Return{ value : "response message"}
    action retrieve (xml[] headers, string fieldList, string sObjectType, string recordId) (xml) {

        int headerCount = headers.length;
        xml queryOptions = xmls:parse("<urn:QueryOptions xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>");
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:retrieve xmlns:urn=\"urn:partner.soap.sforce.com\">
                           <urn:fieldList>" + fieldList + "</urn:fieldList>
                           <urn:sObjectType>" + sObjectType + "</urn:sObjectType>
                           <urn:ids>" + recordId + "</urn:ids>
                       </urn:retrieve>");

        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description{ value : "Executes a text search in your organization’s data"}
    @doc:Param{ value : "headers: Soap header values"}
    @doc:Param{ value : "query: Search String"}
    @doc:Return{ value : "response message"}
    action search (xml[] headers, string query) (xml) {

        int headerCount = headers.length;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = xmls:parse("<urn:search xmlns:urn=\"urn:partner.soap.sforce.com\">
                           <urn:searchString>" + query + "</urn:searchString>
                       </urn:search>");
        xml soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = xmls:parse("<urn:SessionHeader xmlns:urn=\"urn:partner.soap.sforce.com\"><urn:sessionId>" + sessionId + "</urn:sessionId></urn:SessionHeader>");
            serverUrl = xmls:getStringWithNamespace(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soapConnector.send(headers, payload, "''", serverUrl, soapVersion);
        }

        return soapResponse;
    }
}

function login (string username, string password, string loginUrl, string soapVersion) (xml) {

    xml[] headers = [];
    soap:ClientConnector soapConnector = create soap:ClientConnector("");
    xml payload = xmls:parse("<urn:login xmlns:urn=\"urn:partner.soap.sforce.com\">
        	               <urn:username>" + username + "</urn:username>
        	               <urn:password>" + password + "</urn:password>
        	           </urn:login>");
    xml soapResponse = soapConnector.send(headers, payload, "''", loginUrl, soapVersion);
    return soapResponse;
}

function isSessionExpired (xml soapResponse) (boolean) {

    string response = xmls:toString(soapResponse);
    boolean isValid = strings:contains(response, "INVALID_SESSION_ID");
    return isValid;
}

function addFields (xml payload, map fields, string xpath) {

    string[] fieldKeys = maps:keys(fields);
    int fieldKeyCount = fieldKeys.length;
    if (fieldKeyCount != 0) {
        int i = 0;
        string key;
        string stringValue;
        xml xmlValue;
        map n = {"urn":"urn:partner.soap.sforce.com", "urn1" : "urn1:sobject.partner.soap.sforce.com"};
        while (i < fieldKeyCount){
            key = fieldKeys[i];
            stringValue, _ = (string) fields[key];
            xmlValue = xmls:parse("<urn1:" + key + " xmlns:urn=\"urn:partner.soap.sforce.com\" xmlns:urn1=\"urn:sobject.partner.soap.sforce.com\">" + stringValue + "</urn1:" + key + ">");
            xmls:addElementWithNamespace(payload, xpath, xmlValue, n);
            i = i+1;
        }
    }
}
