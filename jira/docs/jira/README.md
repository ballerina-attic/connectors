# Jira Client Connector

The Jira connector allows you to access the Jira REST API through ballerina. And the actions are being invoked
with a ballerina main function or a service. The following section provide you the details on connector actions.

## getIssueInfo
  The Jira action allows to obtain issue information of the provided issue id.
  
##### Parameters:
  issueIdOrKey: A String containing the issue id
  expand: The parameters to expand
  fields: The list of fields to return for the issue
  
###### Related Jira API documentation
   [getIssueInfo](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e1160)

## searchJira  
  The Jira action allows to Search jira using JQL.
  
##### Parameters:
  payload: The actual payload that is accepted by back end. Jira query formatted json.

###### Related Jira API documentation
   [searchJira](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e4071)
   
## postComment
   The Jira action allows to post comment on existing jira issue.
   
##### Parameters:
  issueIdOrKey: A String containing the issue id
  expand: The parameters to expand
  payload: The actual payload that is accepted by back end. It contains the fields of the issue
  
###### Related Jira API documentation
   [postComment](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e953)
   
## assignIssueToUser
   The Jira action allows to assign an issue to an existing user.

##### Parameters:
   issueIdOrKey: A String containing the issue id
   payload: The actual payload that is accepted by back end. It contains the name of the assignee

###### Related Jira API documentation
   [assignIssueToUser](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e924)
   
## createBulkIssue
   The Jira action allows to create many issues in one bulk operation.

##### Parameters:
  payload: The actual payload that is accepted by back end. It contains the array of objects containing the issue details
  
###### Related Jira API documentation
   [createBulkIssue](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e1294)

   
# How to run the sample

To test a connector action written in Ballerina language use the run command as follows.

###### Invoke the actions

Copy the `<Connector>`/samples/`<Connector>`/samples.bal into `<ballerina_home>`/bin folder 
and run the command like in below,

###### NOTE

If the template parameter is indicate as optional you must pass null as default value to run this
action.

1. getIssueInfo  
    `bin$ ./ballerina run samples.bal getIssueInfo <apiInstance:-Required> <username:-Required> 
    <password:-Required> <issueIdOrKey:-Required> <expand:-Optional> <fields:-Optional>`
    
2. searchJira
    `bin$ ./ballerina run samples.bal searchJira <apiInstance:-Required> <username:-Required> 
    <password:-Required> <payload:-Optional>`
    
3. postComment  
    `bin$ ./ballerina run samples.bal postComment <apiInstance:-Required> <username:-Required> 
    <password:-Required> <issueIdOrKey:-Required> <expand:-Optional> <payload:-Required>`
    
4. assignIssueToUser
    `bin$ ./ballerina run samples.bal assignIssueToUser <apiInstance:-Required> <username:-Required> 
    <password:-Required> <issueIdOrKey:-Required> <payload:-Optional>`
    
5. createBulkIssue
    `bin$ ./ballerina run samples.bal createBulkIssue <apiInstance:-Required> <username:-Required> 
    <password:-Required> <payload:-Optional>`