package org.ballerinalang.connectors.jira;

import ballerina.doc;
import ballerina.lang.log;
import ballerina.lang.jsonutils;
import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.net.uri;

@doc:Description{ value : "Jira client connector"}
@doc:Param{ value : "encodedBasicAuthValue: base64encoded username:password value"}
@doc:Param{ value : "jiraAPI: Jira API url"}
connector JiraClient(string encodedBasicAuthValue, string jiraAPI){

    http:ClientConnector jiraEP = create http:ClientClient(jiraAPI);

    @doc:Description{ value : "Get Issue Information"}
    @doc:Param{ value : "issueID: issue ID"}
    @doc:Return{ value : "response object"}
    action getIssueInfo(JiraClient jcl, string issueID) (message) {

            message request = {};
            message requestH = {};
            message response = {};
            string jiraPath = "/issue/"+ issueID;
            requestH = authHeader(request, encodedBasicAuthValue);
            response = http:ClientConnector.get(jiraEP, jiraPath, requestH);
            return response;
     }

    @doc:Description{ value : "Get issues"}
    @doc:Param{ value : "projectName: Name of the project"}
    @doc:Param{ value : "maxResults: number of issues to retrieve"}
    @doc:Return{ value : "response object"}
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

    @doc:Description{ value : "Get issues"}
    @doc:Param{ value : "query: jira query formatted json"}
    @doc:Return{ value : "response object"}
    action getIssues(JiraClient jcl, json query) (message){

        message request = {};
        json data = query;
        string jiraPath = "/search";
        messages:setJsonPayload(request,data);
        message requestH = authHeader(request, encodedBasicAuthValue);
        message response = http:ClientConnector.post(jiraEP, jiraPath, requestH);
        return response;
     }

    @doc:Description{ value : "Comment on Issue"}
    @doc:Param{ value : "issueID: Issue ID"}
    @doc:Param{ value : "comment: comment as a json >`{'body': 'This is a comment regarding the quality of the response.'}`"}
    @doc:Return{ value : "response object"}
    action comment(JiraClient jcl, string issueID, json comment) (message){

        message request = {};
        string jiraPath = "/issue/"+issueID+"/comment";
        messages:setJsonPayload(request,comment);
        message requestH = authHeader(request, encodedBasicAuthValue);
        message response = http:ClientConnector.post(jiraEP, jiraPath, requestH);
        return response;
     }

    @doc:Description{ value : "Assign an issue"}
    @doc:Param{ value : "issueID: Issue ID"}
    @doc:Param{ value : "user: Name of the user whom be assigned to"}
    @doc:Return{ value : "response object"}
    action assign(JiraClient jcl, string issueID, string user) (message){

        message request = {};
        string jiraPath = "/issue/"+issueID;
        json data = `{"fields": {"assignee":{"name":"${user}"}}}`;
        messages:setJsonPayload(request,data);
        message requestH = authHeader(request, encodedBasicAuthValue);
        message response = http:ClientConnector.post(jiraEP, jiraPath, requestH);
        return response;
     }

    @doc:Description{ value : "create a jira issue"}
    @doc:Param{ value : "projectKey: key of the project where user creates the issue"}
    @doc:Param{ value : "summary: issue summary"}
    @doc:Param{ value : "description: issue description"}
    @doc:Param{ value : "issueType: issue type"}
    @doc:Return{ value : "response object"}
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



