import org.ballerinalang.connectors.jira;
import ballerina.lang.system;
import ballerina.lang.messages;

function main(string[] args){
    //https://example.org/jira/rest/api/2/search
    string auth = arg[0];
    string apiUri = arg[1];
    jira:ClientConnector jiraEP = create  jira:ClientConnector(auth, apiUri);
    message m;
    string stn;
    json query;
    query = `{"jql":"project = 'WSO2 Identity Server'","startAt":3,"maxResults":5,"fields":["id","key"]}`;
    m = jira:JiraClient.getIssuesFQuery(jiraConnector, query);

    stn = messages:getStringPayload(m);
    system:println("response: " + stn);

}