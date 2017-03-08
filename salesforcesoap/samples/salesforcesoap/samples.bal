import org.wso2.ballerina.connectors.salesforcesoap;
import ballerina.lang.system;
import ballerina.lang.xmls;

function main (string[] args) {

    xml soapResponse;
    string username = args[1];
    string password = args[2];
    salesforcesoap:ClientConnector sales = create salesforcesoap:ClientConnector(username, password, "https://login.salesforce.com/services/Soap/u/39.0", "1.1");

    if (args[0] == "describeGlobal"){
        soapResponse = salesforcesoap:ClientConnector.describeGlobal(sales);
        system:println(xmls:toString(soapResponse));
    } else if (args[0] == "describeSObject") {
        soapResponse = salesforcesoap:ClientConnector.describeSObject(sales, "Account");
        system:println(xmls:toString(soapResponse));
    } else if (args[0] == "createSObject") {
        soapResponse = salesforcesoap:ClientConnector.createSObject(sales, "Account", "Sample875");
        system:println(xmls:toString(soapResponse));
    } else if (args[0] == "describeSObjects") {
        soapResponse = salesforcesoap:ClientConnector.describeSObjects(sales, "Account");
        system:println(xmls:toString(soapResponse));
    } else if (args[0] == "search") {
        soapResponse = salesforcesoap:ClientConnector.search(sales, "FIND {map*} IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead");
        system:println(xmls:toString(soapResponse));
    } else if (args[0] == "retrieve") {
        soapResponse = salesforcesoap:ClientConnector.retrieve(sales, "id,name", "Account", "0016F00001wy6zcQAA");
        system:println(xmls:toString(soapResponse));
    } else if (args[0] == "deleteSObject") {
        soapResponse = salesforcesoap:ClientConnector.deleteSObject(sales, "0016F00001wy6zcQAA");
        system:println(xmls:toString(soapResponse));
    } else if (args[0] == "query") {
        soapResponse = salesforcesoap:ClientConnector.query(sales, "select id,name from Account");
        system:println(xmls:toString(soapResponse));
    } else if (args[0] == "queryAll") {
        soapResponse = salesforcesoap:ClientConnector.queryAll(sales, "select id,name from Account");
        system:println(xmls:toString(soapResponse));
    } else if (args[0] == "updateSObject") {
        soapResponse = salesforcesoap:ClientConnector.updateSObject(sales, "0016F00001wy6zcQAA", "Test398", "Account");
        system:println(xmls:toString(soapResponse));
    } else if (args[0] == "upsertSObject") {
        soapResponse = salesforcesoap:ClientConnector.upsertSObject(sales, "0016F00001wy6zcQAA", "Test3", "Account");
        system:println(xmls:toString(soapResponse));
    } else {
        system:println("Invalid Choice of Action");
    }
}
