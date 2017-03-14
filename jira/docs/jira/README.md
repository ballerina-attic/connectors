# Jira Client Connector

The Jira connector allows you to access the Jira REST API through ballerina. And the actions are being invoked
with a ballerina main function or a service. The following section provide you the details on connector actions.

## getIssueInfo
  The Jira action allows to obtain issue information of the provided issue id.
  
##### Parameters:
  issueID: Id of the jira issue
  
## getIssues
  The Jira action allows to list issues by the provided project name.
  
##### Parameters:
  projectName: Name of the project
  maxResults: number of max issues to retrieve
  
## getIssues  
  The Jira action allows to list issues by the provided query
  
##### Parameters:
  query: jira-query formatted json 
  [ex: {"jql":"project = 'WSO2 Identity Server'","startAt":3,"maxResults":2,"fields":["id","key"]}]

## comment
   The Jira action allows to comment on existing jira issue.
   
##### Parameters:
   issueID: Issue ID
   comment: comment as a json > {'body': 'This issue is still reproducing.'}

## assign
   The Jira action allows to assign an issue to an existing user.

##### Parameters:
   issueID: Issue ID
   user: Name of the user who will be the assignee

## createIssue
   The Jira action allows to create a new issue

##### Parameters:
   projectKey: key of the project where user creates the issue
   summary: issue summary
   description: issue description
   issueType: issue type

# How to run the sample

To test a connector action written in Ballerina language use the run 
command as follows.

Copy the `<Connector>`/samples/`<Connector>`/samples.bal into `<ballerina_home>`/bin folder 
and run the command like in below,

$ bin ./ballerina run main samples.bal <JIRA_REST_API_URI> <Base64encoded username:password>

References:
[1] https://github.com/ballerinalang/distribution
[2] https://developer.atlassian.com/jiradev/jira-apis/jira-rest-apis
