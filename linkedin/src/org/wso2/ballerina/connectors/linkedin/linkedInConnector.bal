package org.wso2.ballerina.connectors.linkedin;

import org.wso2.ballerina.connectors.oauth2;
import ballerina.doc;
import ballerina.lang.messages;

@doc:Description{ value : "LinkedIn client connector"}
@doc:Param{ value : "accessToken: The access token of the LinkedIn Application"}
connector ClientConnector (string accessToken) {

    string baseURL = "https://api.linkedin.com";
    oauth2:ClientConnector linkedInEP = create oauth2:ClientConnector(baseURL, accessToken, "null", "null",
            "null", "null");

    @doc:Description{ value : "Get Profile Information"}
    @doc:Param{ value : "format: Format of the response expected (json/xml)"}
    @doc:Return{ value : "response object"}
    action getProfileInfo(string format) (message) {

        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/people/~?format=" + format;
        response = linkedInEP.get (getProfileInfoPath, request);

        return response;
    }

    @doc:Description{ value : "Get Company Page Information"}
    @doc:Param{ value : "companyId: ID of the relevant company"}
    @doc:Param{ value : "format: Format of the response expected (json/xml"}
    @doc:Return{ value : "response object"}
    action getCompanyInfo(string companyId, string format) (message) {

        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/companies/" + companyId + "?format=" + format;
        response = linkedInEP.get (getProfileInfoPath, request);

        return response;
    }

    @doc:Description{ value : "Check if Sharing is enabled for a company page"}
    @doc:Param{ value : "companyId: ID of the relevant company"}
    @doc:Param{ value : "format: Format of the response expected (json/xml)"}
    @doc:Return{ value : "response object"}
    action isCompanyShareEnabled(string companyId, string format) (message) {

        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/companies/" + companyId + "/is-company-share-enabled?format=" + format;
        response = linkedInEP.get (getProfileInfoPath, request);

        return response;
    }

    @doc:Description{ value : "Check if the user is an admin of Company Page"}
    @doc:Param{ value : "companyId: ID of the relevant company"}
    @doc:Param{ value : "format: Format of the response expected (json/xml)"}
    @doc:Return{ value : "response object"}
    action isMemberAdmin(string companyId, string format) (message) {

        string getProfileInfoPath;
        message request = {};
        message response;

        format = validateFormat(format);
        getProfileInfoPath = "/v1/companies/" + companyId + "/relation-to-viewer/is-company-share-enabled?format=" + format;
        response = linkedInEP.get (getProfileInfoPath, request);

        return response;
    }

    @doc:Description{ value : "Post on the profile of the authenticated user"}
    @doc:Param{ value : "payload: json payload containing the post that needed to be shared"}
    @doc:Return{ value : "response object"}
    action profileShareJson(json payload) (message) {

        string profileSharePath;
        message request = {};
        message response;

        profileSharePath = "/v1/people/~/shares?format=json";
        messages:setHeader(request, "Content-Type", "application/json");
        messages:setHeader(request, "x-li-format", "json");
        messages:setJsonPayload(request, payload);
        response = linkedInEP.post (profileSharePath, request);

        return response;
    }

    @doc:Description{ value : "Post on the profile of the authenticated user"}
    @doc:Param{ value : "payload: xml payload containing the post that needed to be shared"}
    @doc:Return{ value : "response object"}
    action profileShareXml(xml payload) (message) {

        string profileSharePath;
        message request = {};
        message response;

        profileSharePath = "/v1/people/~/shares?format=xml";
        messages:setHeader(request, "Content-Type", "application/xml");
        messages:setHeader(request, "x-li-format", "xml");
        messages:setXmlPayload(request, payload);
        response = linkedInEP.post (profileSharePath, request);

        return response;
    }

    @doc:Description{ value : "Post on a Company Page"}
    @doc:Param{ value : "companyId: ID of the relevant company"}
    @doc:Param{ value : "payload: json payload containing the post that needed to be shared"}
    @doc:Return{ value : "response object"}
    action companyShareJson(string companyId, json payload) (message) {

        string companySharePath;
        message request = {};
        message response;

        companySharePath = "/v1/companies/" + companyId + "/shares?format=json";
        messages:setHeader(request, "Content-Type", "application/json");
        messages:setHeader(request, "x-li-format", "json");
        messages:setJsonPayload(request, payload);
        response = linkedInEP.post (companySharePath, request);

        return response;
    }

    @doc:Description{ value : "Post on a Company Page"}
    @doc:Param{ value : "companyId: ID of the relevant company"}
    @doc:Param{ value : "payload: xml payload containing the post that needed to be shared"}
    @doc:Return{ value : "response object"}
    action companyShareXml(string companyId, xml payload) (message) {

        string companySharePath;
        message request = {};
        message response;

        companySharePath = "/v1/companies/" + companyId + "/shares?format=xml";
        messages:setHeader(request, "Content-Type", "application/xml");
        messages:setHeader(request, "x-li-format", "xml");
        messages:setXmlPayload(request, payload);
        response = linkedInEP.post (companySharePath, request);

        return response;
    }

}

function validateFormat (string format) (string) {

    if (format == "xml") {
        return format;
    }
    else {
        return "json";
    }
}
