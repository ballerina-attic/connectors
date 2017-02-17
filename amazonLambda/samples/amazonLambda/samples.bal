import org.wso2.ballerina.connectors.amazonLambda;

import ballerina.lang.jsonutils;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    amazonLambda:ClientConnector amzLamConnector = create amazonLambda:ClientConnector(args[1], args[2], args[3]);
    message lambdaResponse;
    json lambdaJSONResponse;

    if (args[0] == "invokeFunction"){
        lambdaResponse = amazonLambda:ClientConnector.invokeFunction(amzLamConnector, args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsonutils:toString(lambdaJSONResponse));
    }
    if (args[0] == "deleteFunction"){
        lambdaResponse = amazonLambda:ClientConnector.deleteFunction(amzLamConnector, args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsonutils:toString(lambdaJSONResponse));
    }
    if (args[0] == "listFunctions"){
        lambdaResponse = amazonLambda:ClientConnector.listFunctions(amzLamConnector);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsonutils:toString(lambdaJSONResponse));
    }
    if (args[0] == "listFunctionVersions"){
        lambdaResponse = amazonLambda:ClientConnector.getFunctionVersions(amzLamConnector, args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsonutils:toString(lambdaJSONResponse));
    }
    if (args[0] == "getFunction"){
        lambdaResponse = amazonLambda:ClientConnector.getFunction(amzLamConnector, args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsonutils:toString(lambdaJSONResponse));
    }
    if (args[0] == "getAccountDetails"){
        lambdaResponse = amazonLambda:ClientConnector.getAccountDetails(amzLamConnector);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsonutils:toString(lambdaJSONResponse));
    }
}