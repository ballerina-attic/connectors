import org.wso2.ballerina.connectors.amazonlambda;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    amazonlambda:ClientConnector amzLamConnector = create amazonlambda:ClientConnector(args[1], args[2], args[3]);
    message lambdaResponse;
    json lambdaJSONResponse;

    if (args[0] == "invokeFunction"){
        lambdaResponse = amazonlambda:ClientConnector.invokeFunction(amzLamConnector, args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "invokeFunctionWithParam"){
        json payload = {"name":"Ballerina"};
        lambdaResponse = amazonlambda:ClientConnector.invokeFunctionWithParam(amzLamConnector, args[4], payload);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "deleteFunction"){
        lambdaResponse = amazonlambda:ClientConnector.deleteFunction(amzLamConnector, args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "listFunctions"){
        lambdaResponse = amazonlambda:ClientConnector.listFunctions(amzLamConnector);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "listFunctionVersions"){
        lambdaResponse = amazonlambda:ClientConnector.getFunctionVersions(amzLamConnector, args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "getFunction"){
        lambdaResponse = amazonlambda:ClientConnector.getFunction(amzLamConnector, args[4]);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
    if (args[0] == "getAccountDetails"){
        lambdaResponse = amazonlambda:ClientConnector.getAccountDetails(amzLamConnector);
        lambdaJSONResponse = messages:getJsonPayload(lambdaResponse);
        system:println(jsons:toString(lambdaJSONResponse));
    }
}