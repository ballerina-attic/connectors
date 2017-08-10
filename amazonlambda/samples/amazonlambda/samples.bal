import org.wso2.ballerina.connectors.amazonlambda;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    amazonlambda:ClientConnector amzLamConnector = create amazonlambda:ClientConnector(args[1], args[2], args[3]);
    message lambdaResponse;
    json lambdaJSONResponse;

    if (args[0] == "invokeFunction") {
        lambdaResponse = amzLamConnector.invokeFunction (args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "invokeFunctionWithParam") {
        json payload = {"name":"Ballerina"};
        lambdaResponse = amzLamConnector.invokeFunctionWithParam (args[4], payload);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "deleteFunction") {
        lambdaResponse = amzLamConnector.deleteFunction (args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "listFunctions") {
        lambdaResponse = amzLamConnector.listFunctions ();
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "listFunctionVersions") {
        lambdaResponse = amzLamConnector.getFunctionVersions (args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "getFunction") {
        lambdaResponse = amzLamConnector.getFunction (args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "getAccountDetails") {
        lambdaResponse = amzLamConnector.getAccountDetails ();
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
}