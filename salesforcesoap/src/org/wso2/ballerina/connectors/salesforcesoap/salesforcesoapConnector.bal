package org.wso2.ballerina.connectors.salesforcesoap;

import org.wso2.ballerina.connectors.soap;
import ballerina.lang.xmls;
import ballerina.lang.strings;
import ballerina.lang.maps;
import ballerina.lang.arrays;

@doc:Description("Salesforcesoap client connector")
@doc:Param("username: Salesforce Username")
@doc:Param("password: Salesforce Password + Security Token")
@doc:Param("loginUrl: Login Url of Salesforce")
@doc:Param("soapVersion: Soap version")
connector ClientConnector (string username, string password, string loginUrl, string soapVersion) {

    soap:ClientConnector soapConnector = create soap:ClientConnector("");
    string sessionId;
    xml session;
    string serverUrl;

    @doc:Description("Lists the available objects and their metadata for your organization’s data")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Return("response message")
    action describeGlobal (ClientConnector s, xml[] headers) (xml) {

        int headerCount = arrays:length(headers);
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:describeGlobal xmlns:urn="urn:partner.soap.sforce.com">
        	           </urn:describeGlobal>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
         serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                         serverUrl, soapVersion);
        }
        return soapResponse;
    }

    @doc:Description("Retrieves metadata (field list and object properties) for the specified object type")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Param("type: Name of SObject")
    @doc:Return("response message")
    action describeSObject (ClientConnector s, xml[] headers, string type) (xml) {

        int headerCount = arrays:length(headers);
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:describeSObject xmlns:urn="urn:partner.soap.sforce.com">
                           <urn:sObjectType>${type}</urn:sObjectType>
                       </urn:describeSObject>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
        serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description("An array-based version of describeSObject")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Param("type: Name of SObject")
    @doc:Return("response message")
    action describeSObjects (ClientConnector s, xml[] headers, string type) (xml) {

        int headerCount = arrays:length(headers);
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:describeSObjects xmlns:urn="urn:partner.soap.sforce.com">
                           <urn:sObjectType>${type}</urn:sObjectType>
                       </urn:describeSObjects>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
        serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description("Adds one or more new records to your organization’s data")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Param("fields: Map of fields of records")
    @doc:Return("response message")
    action createRecord (ClientConnector s, xml[] headers, map fields) (xml) {

        int headerCount = arrays:length(headers);
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:create xmlns:urn="urn:partner.soap.sforce.com" xmlns:urn1="urn:sobject.partner.soap.sforce.com">
                           <urn:sObjects>
                           </urn:sObjects>
                       </urn:create>`;

        addFields(payload, fields, "/urn:create/urn:sObjects");

        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
         serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description("Updates one or more existing records in your organization’s data")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Param("fields: Map of fields of records")
    @doc:Return("response message")
    action updateRecord (ClientConnector s, xml[] headers, map fields) (xml) {

        int headerCount = arrays:length(headers);
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:update xmlns:urn="urn:partner.soap.sforce.com" xmlns:urn1="urn:sobject.partner.soap.sforce.com">
                           <urn:sObjects>
                           </urn:sObjects>
                       </urn:update>`;

        addFields(payload, fields, "/urn:update/urn:sObjects");

        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
         serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description("Creates new records and updates existing records")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Param("externalId: External Id")
    @doc:Param("fields: Map of fields of records")
    @doc:Return("response message")
    action upsertRecord (ClientConnector s, xml[] headers, string externalId, map fields) (xml) {

        int headerCount = arrays:length(headers);
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:upsert xmlns:urn="urn:partner.soap.sforce.com" xmlns:urn1="urn:sobject.partner.soap.sforce.com">
                            <urn:externalIDFieldName>${externalId}</urn:externalIDFieldName>
                            <urn:sObjects>
                            </urn:sObjects>
                       </urn:upsert>`;

        addFields(payload, fields, "/urn:upsert/urn:sObjects");

        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
         serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description("Executes a query against the specified object and returns data that matches the specified criteria")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Param("query: Query String")
    @doc:Return("response message")
    action query (ClientConnector s, xml[] headers, string query) (xml) {

        int headerCount = arrays:length(headers);
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:query xmlns:urn="urn:partner.soap.sforce.com">
                           <urn:queryString>${query}</urn:queryString>
                       </urn:query>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
             serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description("Retrieves data from specified objects, whether or not they have been deleted")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Param("query: Query String")
    @doc:Return("response message")
    action queryAll (ClientConnector s, xml[] headers, string query) (xml) {

        int headerCount = arrays:length(headers);
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:queryAll xmlns:urn="urn:partner.soap.sforce.com">
                           <urn:queryString>${query}</urn:queryString>
                       </urn:queryAll>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
            serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description("Retrieves the next batch of objects from a query")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Param("queryLocator: Url to retrieve the balance query results")
    @doc:Return("response message")
    action queryMore (ClientConnector s, xml[] headers, string queryLocator) (xml) {

        int headerCount = arrays:length(headers);
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:queryMore>
                           <urn:queryLocator>${queryLocator}</urn:queryLocator>
                       </urn:queryMore>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }
    @doc:Description("Deletes one or more records from your organization’s data")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Param("recordId: Id of Record to be deleted")
    @doc:Return("response message")
    action deleteRecord (ClientConnector s, xml[] headers, string recordId) (xml) {

        int headerCount = arrays:length(headers);
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:delete xmlns:urn="urn:partner.soap.sforce.com">
                           <urn:ids>${recordId}</urn:ids>
                       </urn:delete>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
            serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description("Retrieves one or more records based on the specified IDs")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Param("fieldList: List of fields that needs to be retrieved")
    @doc:Param("type: Name of SObject")
    @doc:Param("recordId: Id of Record")
    @doc:Return("response message")
    action retrieve (ClientConnector s, xml[] headers, string fieldList, string type, string recordId) (xml) {

        int headerCount = arrays:length(headers);
        xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:retrieve xmlns:urn="urn:partner.soap.sforce.com">
                           <urn:fieldList>${fieldList}</urn:fieldList>
                           <urn:sObjectType>${type}</urn:sObjectType>
                           <urn:ids>${recordId}</urn:ids>
                       </urn:retrieve>`;

        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
            serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description("Executes a text search in your organization’s data")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("headers: Soap header values")
    @doc:Param("query: Search String")
    @doc:Return("response message")
    action search (ClientConnector s, xml[] headers, string query) (xml) {

        int headerCount = arrays:length(headers);
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
        }
        headers[headerCount] = session;
        xml payload = `<urn:search xmlns:urn="urn:partner.soap.sforce.com">
                           <urn:searchString>${query}</urn:searchString>
                       </urn:search>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
            serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers[headerCount] = session;
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }
}

function login (string username, string password, string loginUrl, string soapVersion) (xml) {

    xml[] headers = [];
    soap:ClientConnector soapConnector = create soap:ClientConnector("");
    xml payload = `<urn:login xmlns:urn="urn:partner.soap.sforce.com">
        	               <urn:username>${username}</urn:username>
        	               <urn:password>${password}</urn:password>
        	           </urn:login>`;
    xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''", loginUrl, soapVersion);
    return soapResponse;
}

function isSessionExpired (xml soapResponse) (boolean) {

    string response = xmls:toString(soapResponse);
    boolean isValid = strings:contains(response, "INVALID_SESSION_ID");
    return isValid;
}

function addFields (xml payload, map fields, string xpath) (boolean) {

    string[] fieldKeys = maps:keys(fields);
    int fieldKeyCount = arrays:length(fieldKeys);
    if (fieldKeyCount != 0) {
        int i = 0;
        string key;
        string stringValue;
        xml xmlValue;
        map n = {"urn":"urn:partner.soap.sforce.com", "urn1" : "urn1:sobject.partner.soap.sforce.com"};
        while (i < fieldKeyCount){
            key = fieldKeys[i];
            stringValue = fields[key];
            xmlValue = `<urn1:${key} xmlns:urn="urn:partner.soap.sforce.com" xmlns:urn1="urn:sobject.partner.soap.sforce.com">${stringValue}</urn1:${key}>`;
            xmls:addElement(payload, xpath, xmlValue, n);
            i = i+1;
        }
    }
}