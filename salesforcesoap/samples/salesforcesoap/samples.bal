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
        soapResponse = sales.describeGlobal(headers);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "describeSObject") {
        soapResponse = sales.describeSObject(headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "createRecord") {
        xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
        xml allowFieldTruncationHeader = `<urn:AllowFieldTruncationHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allowFieldTruncation>0</urn:allowFieldTruncation></urn:AllowFieldTruncationHeader>`;
        headers = [allOrNoneHeader, allowFieldTruncationHeader];
        map fields = {"type" : args[3], "Name" : args[4]};
        soapResponse = sales.createRecord(headers, fields);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "describeSObjects") {
        soapResponse = sales.describeSObjects(headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "search") {
        soapResponse = sales.search(headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "retrieve") {
        soapResponse = sales.retrieve(headers, args[3], args[4], args[5]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "deleteRecord") {
        xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
        headers = [allOrNoneHeader];
        soapResponse = sales.deleteRecord(headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "query") {
        xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
        headers = [queryOptions];
        soapResponse = sales.query(headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "queryAll") {
        xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
        headers = [queryOptions];
        soapResponse = sales.queryAll(headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "queryMore") {
        xml queryOptions = `<urn:QueryOptions xmlns:urn="urn:partner.soap.sforce.com"><urn:batchSize>200</urn:batchSize></urn:QueryOptions>`;
        headers = [queryOptions];
        soapResponse = sales.queryMore(headers, args[3]);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "updateRecord") {
        xml allOrNoneHeader = `<urn:AllOrNoneHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allOrNone>0</urn:allOrNone></urn:AllOrNoneHeader>`;
        xml allowFieldTruncationHeader = `<urn:AllowFieldTruncationHeader xmlns:urn="urn:partner.soap.sforce.com"><urn:allowFieldTruncation>0</urn:allowFieldTruncation></urn:AllowFieldTruncationHeader>`;
        headers = [allOrNoneHeader, allowFieldTruncationHeader];
        map fields = {"type" : args[5], "Name" : args[4], "Id" : args[3]};
        soapResponse = sales.updateRecord(headers, fields);
        system:println(xmls:toString(soapResponse));

    } else if (args[0] == "upsertRecord") {
        map fields = {"type" : args[5], "Name" : args[4]};
        soapResponse = sales.upsertRecord(headers, args[3], fields);
        system:println(xmls:toString(soapResponse));

    } else {
        system:println("Invalid Choice of Action");
    }
}
