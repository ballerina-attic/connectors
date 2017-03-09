import org.wso2.ballerina.connectors.salesforcesoap;
import ballerina.lang.system;
import ballerina.lang.xmls;

function main (string[] args) {

    xml soapResponse;
    xml[] headers = [];
    string username = args[1];
    string password = args[2];
    salesforcesoap:ClientConnector sales = create salesforcesoap:ClientConnector(username, password, "https://login.salesforce.com/services/Soap/u/39.0", "1.1");

    if (args[0] == "describeGlobal"){
        soapResponse = salesforcesoap:ClientConnector.describeGlobal(sales, headers);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "describeSObject") {
        soapResponse = salesforcesoap:ClientConnector.describeSObject(sales, headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "createRecord") {
        xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
        xml allowFieldTruncationHeader = `<urn:AllowFieldTruncationHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allowFieldTruncation>0</urn:allowFieldTruncation></urn:AllowFieldTruncationHeader>`;
        headers = [allOrNoneHeader, allowFieldTruncationHeader];
        soapResponse = salesforcesoap:ClientConnector.createRecord(sales, headers, args[3], args[4]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "describeSObjects") {
        soapResponse = salesforcesoap:ClientConnector.describeSObjects(sales, headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "search") {
        soapResponse = salesforcesoap:ClientConnector.search(sales, headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "retrieve") {
        soapResponse = salesforcesoap:ClientConnector.retrieve(sales, headers, args[3], args[4], args[5]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "deleteRecord") {
        xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
        headers = [allOrNoneHeader];
        soapResponse = salesforcesoap:ClientConnector.deleteRecord(sales, headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "query") {
        xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
        headers = [queryOptions];
        soapResponse = salesforcesoap:ClientConnector.query(sales, headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "queryAll") {
        xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
        headers = [queryOptions];
        soapResponse = salesforcesoap:ClientConnector.queryAll(sales, headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "queryMore") {
        xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
        headers = [queryOptions];
        soapResponse = salesforcesoap:ClientConnector.queryMore(sales, headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "updateRecord") {
        xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
        xml allowFieldTruncationHeader = `<urn:AllowFieldTruncationHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allowFieldTruncation>0</urn:allowFieldTruncation></urn:AllowFieldTruncationHeader>`;
        headers = [allOrNoneHeader, allowFieldTruncationHeader];
        soapResponse = salesforcesoap:ClientConnector.updateRecord(sales, headers, args[3], args[4], args[5]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "upsertRecord") {
        soapResponse = salesforcesoap:ClientConnector.upsertRecord(sales, headers, args[3], args[4], args[5]);
        system:println(xmls:toString(soapResponse));

    } else {
        system:println("Invalid Choice of Action");
    }
}
