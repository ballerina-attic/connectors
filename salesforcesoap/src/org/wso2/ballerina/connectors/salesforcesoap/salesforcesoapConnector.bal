package org.wso2.ballerina.connectors.salesforcesoap;

import org.ballerinalang.connectors.soap;
import ballerina.lang.xmls;
import ballerina.lang.strings;
import ballerina.lang.system;

@doc:Description("Salesforcesoap client connector")
@doc:Param("username: Salesforce Username")
@doc:Param("password: Salesforce Password + Security Token")
@doc:Param("soapVersion: Soap version")
@doc:Param("loginUrl: Login Url of Salesforce")
connector ClientConnector (string username, string password, string loginUrl, string soapVersion) {

    soap:ClientConnector soapConnector = create soap:ClientConnector("");
    string sessionId;
    xml session;
    string serverUrl;

    @doc:Description("Lists the available objects and their metadata for your organization’s data")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Return("response message")
    action describeGlobal (ClientConnector s) (xml) {

        xml[] headers;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session];
        }
        headers = [session];
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
            headers = [session];
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                         serverUrl, soapVersion);
        }
        return soapResponse;
    }

    @doc:Description("Retrieves metadata (field list and object properties) for the specified object type")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("type: Type of SObject")
    @doc:Return("response message")
    action describeSObject (ClientConnector s, string type) (xml) {

        xml[] headers;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session];
        }
        headers = [session];
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
            headers = [session];
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description("An array-based version of describeSObject")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("type: Type of SObject")
    @doc:Return("response message")
    action describeSObjects (ClientConnector s, string type) (xml) {

        xml[] headers;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session];
        }
        headers = [session];
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
            headers = [session];
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description("Adds one or more new records to your organization’s data")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("type: Type of SObject")
    @doc:Param("name: Name of SObject")
    @doc:Return("response message")
    action createSObject (ClientConnector s, string type, string name) (xml) {

        xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
        xml allowFieldTruncationHeader = `<urn:AllowFieldTruncationHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allowFieldTruncation>0</urn:allowFieldTruncation></urn:AllowFieldTruncationHeader>`;
        xml[] headers;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session];
        }
        headers = [session, allOrNoneHeader, allowFieldTruncationHeader];
        xml payload = `<urn:create xmlns:urn="urn:partner.soap.sforce.com" xmlns:urn1="urn:sobject.partner.soap.sforce.com">
                           <urn:sObjects>
                               <urn1:type>${type}</urn1:type>
                               <urn1:Name>${name}</urn1:Name>
                           </urn:sObjects>
                       </urn:create>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
         serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers =  [session, allOrNoneHeader, allowFieldTruncationHeader];
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description("Updates one or more existing records in your organization’s data")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("id: Id of SObject")
    @doc:Param("newName: New name of SObject")
    @doc:Param("type: Type of SObject")
    @doc:Return("response message")
    action updateSObject (ClientConnector s, string objectId, string newName, string type) (xml) {

        xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
        xml allowFieldTruncationHeader = `<urn:AllowFieldTruncationHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allowFieldTruncation>0</urn:allowFieldTruncation></urn:AllowFieldTruncationHeader>`;
        xml[] headers;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session];
        }
        headers = [session, allOrNoneHeader, allowFieldTruncationHeader];
        xml payload = `<urn:update xmlns:urn="urn:partner.soap.sforce.com" xmlns:urn1="urn:sobject.partner.soap.sforce.com">
                           <urn:sObjects>
                               <urn1:Id>${objectId}</urn1:Id>
                               <urn1:type>${type}</urn1:type>
                                   <urn1:Name>${newName}</urn1:Name>
                                </urn:sObjects>
                             </urn:update>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
         serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session, allOrNoneHeader, allowFieldTruncationHeader];
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description("Creates new records and updates existing records")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("id: External Id")
    @doc:Param("newName: New name of SObject")
    @doc:Param("type: Type of SObject")
    @doc:Return("response message")
    action upsertSObject (ClientConnector s, string objectId, string newName, string type) (xml) {

        xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
        xml allowFieldTruncationHeader = `<urn:AllowFieldTruncationHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allowFieldTruncation>0</urn:allowFieldTruncation></urn:AllowFieldTruncationHeader>`;
        xml[] headers;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session];
        }
        headers = [session, allOrNoneHeader, allowFieldTruncationHeader];
        xml payload = `<urn:upsert xmlns:urn="urn:partner.soap.sforce.com" xmlns:urn1="urn:sobject.partner.soap.sforce.com">
                            <urn:externalIDFieldName>${objectId}</urn:externalIDFieldName>
                                <urn:sObjects>
                                   <urn1:type>${type}</urn1:type>
                                   <urn1:Name>${newName}</urn1:Name>
                                </urn:sObjects>
                             </urn:upsert>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
         serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session, allOrNoneHeader, allowFieldTruncationHeader];
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

         return soapResponse;
    }

    @doc:Description("Executes a query against the specified object and returns data that matches the specified criteria")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("query: Query String")
    @doc:Return("response message")
    action query (ClientConnector s, string query) (xml) {

        xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
        xml[] headers;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session];
        }
        headers = [session, queryOptions];
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
            headers = [session, queryOptions];
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description("Retrieves data from specified objects, whether or not they have been deleted")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("query: Query String")
    @doc:Return("response message")
    action queryAll (ClientConnector s, string query) (xml) {

        xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
        xml[] headers;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session];
        }
        headers = [session, queryOptions];
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
            headers = [session, queryOptions];
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description("Deletes one or more records from your organization’s data")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("id: Id of SObject to be deleted")
    @doc:Return("response message")
    action deleteSObject (ClientConnector s, string objectId) (xml) {
        xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
        xml[] headers;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session];
        }
        headers = [session, allOrNoneHeader];
        xml payload = `<urn:delete xmlns:urn="urn:partner.soap.sforce.com">
                           <urn:ids>${objectId}</urn:ids>
                       </urn:delete>`;
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
            serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session, allOrNoneHeader];
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description("Retrieves one or more records based on the specified IDs")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("fieldList: List of fields that needs to be retrieved")
    @doc:Param("type: Type of SObject")
    @doc:Param("id: Id of SObject")
    @doc:Return("response message")
    action retrieve (ClientConnector s, string fieldList, string type, string objectId) (xml) {

        xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
        xml[] headers;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session];
        }
        headers = [session, queryOptions];
        xml payload = `<urn:retrieve xmlns:urn="urn:partner.soap.sforce.com">
                           <urn:fieldList>${fieldList}</urn:fieldList>
                           <urn:sObjectType>${type}</urn:sObjectType>
                           <urn:ids>${objectId}</urn:ids>
                       </urn:retrieve>`;
        system:println(xmls:toString(payload));
        xml soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
            serverUrl, soapVersion);
        if (isSessionExpired(soapResponse)) {
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session, queryOptions];
            soapResponse = soap:ClientConnector.send(soapConnector, headers, payload, "''",
                                                     serverUrl, soapVersion);
        }

        return soapResponse;
    }

    @doc:Description("Executes a text search in your organization’s data")
    @doc:Param("s: The salesforcesoap connector instance")
    @doc:Param("query: Search String")
    @doc:Return("response message")
    action search (ClientConnector s, string query) (xml) {

        xml[] headers;
        if (serverUrl == ""){
            xml loginResponse = login(username, password, loginUrl, soapVersion);

            map n = {"ns":"urn:partner.soap.sforce.com"};
            sessionId = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:sessionId/text()", n);
            session = `<urn:SessionHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:sessionId>${sessionId}</urn:sessionId></urn:SessionHeader>`;
            serverUrl = xmls:getString(loginResponse, "/ns:loginResponse/ns:result/ns:serverUrl/text()", n);
            headers = [session];
        }
        headers = [session];
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
            headers = [session];
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

function isSessionExpired ( xml soapResponse) (boolean) {
    map n = {"ns":"http://schemas.xmlsoap.org/soap/envelope/"};
    string response = xmls:toString(soapResponse);
    boolean isValid = strings:contains(response, "INVALID_SESSION_ID");
    return isValid;
}

