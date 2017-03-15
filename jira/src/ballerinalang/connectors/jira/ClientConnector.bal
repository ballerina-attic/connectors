package org.ballerinalang.connectors.jira;

import ballerina.lang.log;
import ballerina.lang.jsonutils;
import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.net.uri;

@doc:Description("Jira client connector")
@doc:Param("encodedBasicAuthValue: base64encoded username:password value")
@doc:Param("jiraAPI: Jira API url")
connector JiraClient(string encodedBasicAuthValue, string jiraAPI){

    http:ClientConnector jiraEP = create http:ClientClient(jiraAPI);

    @doc:Description("Get Issue Information")
    @doc:Param("issueID: issue ID")
    @doc:Return("response object")
    action getIssueInfo(JiraClient jcl, string issueID) (message) {

            message request = {};
            message requestH = {};
            message response = {};
            string jiraPath = "/issue/"+ issueID;
            requestH = authHeader(request, encodedBasicAuthValue);
            response = http:ClientConnector.get(jiraEP, jiraPath, requestH);
            return response;
     }

    @doc:Description("Get issues")
    @doc:Param("projectName: Name of the project")
    @doc:Param("maxResults: number of issues to retrieve")
    @doc:Return("response object")
    action getIssues(JiraClient jcl, string projectName, int maxResults) (message){

            message request = {};

            json data = {};

            if(projectName=="null"){
                data = `{"startAt":3,"maxResults":${maxResults},"fields":["id","key"]}`;
             }
            else{
                data = `{"jql":"project = '${projectName}'","startAt":3,"maxResults":${maxResults},"fields":["id","key"]}`;
            }
            string jiraPath = "/search";
            messages:setJsonPayload(request,data);
            message requestH = authHeader(request, encodedBasicAuthValue);
            message response = http:ClientConnector.post(jiraEP, jiraPath, requestH);
            return response;
     }

    @doc:Description("Get issues")
    @doc:Param("query: jira query formatted json")
    @doc:Return("response object")
    action getIssues(JiraClient jcl, json query) (message){

        message request = {};
        json data = query;
        string jiraPath = "/search";
        messages:setJsonPayload(request,data);
        message requestH = authHeader(request, encodedBasicAuthValue);
        message response = http:ClientConnector.post(jiraEP, jiraPath, requestH);
        return response;
     }

    @doc:Description("Comment on Issue")
    @doc:Param("issueID: Issue ID")
    @doc:Param("comment: comment as a json >`{'body': 'This is a comment regarding the quality of the response.'}`")
    @doc:Return("response object")
    action comment(JiraClient jcl, string issueID, json comment) (message){

        message request = {};
        string jiraPath = "/issue/"+issueID+"/comment";
        messages:setJsonPayload(request,comment);
        message requestH = authHeader(request, encodedBasicAuthValue);
        message response = http:ClientConnector.post(jiraEP, jiraPath, requestH);
        return response;
     }

    @doc:Description("Assign an issue")
    @doc:Param("issueID: Issue ID")
    @doc:Param("user: Name of the user whom be assigned to")
    @doc:Return("response object")
    action assign(JiraClient jcl, string issueID, string user) (message){

        message request = {};
        string jiraPath = "/issue/"+issueID;
        json data = `{"fields": {"assignee":{"name":"${user}"}}}`;
        messages:setJsonPayload(request,data);
        message requestH = authHeader(request, encodedBasicAuthValue);
        message response = http:ClientConnector.post(jiraEP, jiraPath, requestH);
        return response;
     }

    @doc:Description("create a jira issue")
    @doc:Param("projectKey: key of the project where user creates the issue")
    @doc:Param("summary: issue summary")
    @doc:Param("description: issue description")
    @doc:Param("issueType: issue type")
    @doc:Return("response object")
    action createIssue(JiraClient jcl, string projectKey, string summary, string description, string issueType) (message){

        message request = {};
        string jiraPath = "/issue";
        json data = `{"fields":
                            {"project":
                                {"key": ${projectKey}},
                                "summary": ${summary},"description": ${description},"issuetype":
                                {"name": ${issueType}}
                            }
                        }`;
        message requestH = authHeader(request, encodedBasicAuthValue);
        messages:setJsonPayload(requestH,data);
        message response = http:ClientConnector.post(jiraEP, jiraPath, requestH);
        return response;
    }	

}

    function authHeader(message req, string base64EncodedCredentials)(message){
        messages:setHeader(req, "Authentication", "Basic "+base64EncodedCredentials+"");
        messages:setHeader(req, "Content-Type", "application/json");
        return req;
    }



