package org.wso2.ballerina.connectors.jira;

import ballerina.doc;
import org.wso2.ballerina.connectors.basicauth;
import ballerina.lang.messages;
import ballerina.lang.strings;

@doc:Description {value:"Jira client connector"}
@doc:Param {value:"uri: URI of the JIRA instance"}
@doc:Param {value:"username: Username of the user used to log in to JIRA"}
@doc:Param {value:"password: Password of the user used to log in to JIRA"}
connector ClientConnector (string uri, string username, string password) {

    basicauth:ClientConnector jiraEP = create basicauth:ClientConnector(uri, username, password);

    @doc:Description {value:"Get Issue Information"}
    @doc:Param {value:"issueIdOrKey: A String containing the issue id"}
    @doc:Param {value:"expand: The parameters to expand"}
    @doc:Param {value:"fields: The list of fields to return for the issue"}
    @doc:Return {value:"response object"}
    action getIssueInfo (string issueIdOrKey, string expand, string fields) (message) {
        message request = {};
        string uriParams;
        string jiraPath = "/rest/api/2/issue/" + issueIdOrKey;

        if (expand != "null") {
            uriParams = uriParams + "&expand=" + expand;
        }

        if (fields != "null") {
            uriParams = uriParams + "&fields=" + fields;
        }

        if (uriParams != "") {
            jiraPath = jiraPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }

        message response = jiraEP.get (jiraPath, request);

        return response;
    }

    @doc:Description {value:"Search jira using JQL"}
    @doc:Param {value:"payload: jira query formatted json"}
    @doc:Return {value:"response object"}
    action searchJira (json payload) (message) {
        message request = {};
        string uriParams;
        string jiraPath = "/rest/api/2/search";

        messages:setJsonPayload(request, payload);
        message response = jiraEP.post (jiraPath, request);

        return response;
    }

    @doc:Description {value:"Posting jira issue comment"}
    @doc:Param {value:"issueIdOrKey: A String containing the issue id"}
    @doc:Param {value:"expand: The parameters to expand"}
    @doc:Param {value:"payload: It contains the fields of the issue"}
    @doc:Return {value:"response object"}
    action postComment (string issueIdOrKey, string expand, json payload) (message) {
        message request = {};
        string jiraPath = "/rest/api/2/issue/" + issueIdOrKey + "/comment";

        if (expand != "null") {
            jiraPath = jiraPath + "?" + "expand=" + expand;
        }

        messages:setJsonPayload(request, payload);
        message response = jiraEP.post (jiraPath, request);

        return response;
    }

    @doc:Description {value:"Assigns an issue to a user"}
    @doc:Param {value:"issueIdOrKey: A String containing the issue id"}
    @doc:Param {value:"payload: It contains the name of the assignee"}
    @doc:Return {value:"response object"}
    action assignIssueToUser (string issueIdOrKey, json payload) (message) {
        message request = {};
        string jiraPath = "/rest/api/2/issue/" + issueIdOrKey + "/assignee";

        messages:setJsonPayload(request, payload);
        message response = jiraEP.put (jiraPath, request);

        return response;
    }

    @doc:Description {value:"Creates many issues in one bulk operation"}
    @doc:Param {value:"payload: It contains the array of objects containing the issue details"}
    @doc:Return {value:"response object"}
    action createBulkIssue (json payload) (message) {
        message request = {};
        string jiraPath = "/rest/api/2/issue/bulk";

        messages:setJsonPayload(request, payload);
        message response = jiraEP.post (jiraPath, request);

        return response;
    }
}
