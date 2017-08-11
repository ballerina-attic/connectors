import org.wso2.ballerina.connectors.etcd;

import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    string etcdURL = "http://127.0.0.1:2379";
    string username = "root";
    string password = "test123";
    string apiVersion = "v2";
    etcd:ClientConnector etcdConnector = create etcd:ClientConnector(etcdURL, username, password, apiVersion);
    message etcdResponse;

    // add key/value to the etcd
    if (args[0] == "setKeyValue") {
        if (args.length > 2) {
            etcdResponse = etcdConnector.setKeyValue (args[1], args[2]);
            system:println(messages:getStringPayload(etcdResponse));
        } else {
            system:println("Usage: setKeyValue <key> <value>");
        }
    }

    // get value from the etcd for given key
    if (args[0] == "getValue") {
        if (args.length > 1) {
            etcdResponse = etcdConnector.getValue (args[1]);
            system:println(messages:getStringPayload(etcdResponse));
        } else {
            system:println("Usage: getValue <key>");
        }
    }

    // update a value for given key
    if (args[0] == "updateValue") {
        if (args.length > 2) {
            etcdResponse = etcdConnector.updateValue (args[1], args[2]);
            system:println(messages:getStringPayload(etcdResponse));
        } else {
            system:println("Usage: updateValue <key> <value>");
        }
    }

    // delete a key from etcd
    if (args[0] == "deleteKey") {
        if (args.length > 1) {
            etcdResponse = etcdConnector.deleteKey (args[1]);
            system:println(messages:getStringPayload(etcdResponse));
        } else {
            system:println("Usage: deleteKey <key>");
        }
    }

    // create directory
    if (args[0] == "createDir") {
        if (args.length > 1) {
            etcdResponse = etcdConnector.createDir (args[1]);
            system:println(messages:getStringPayload(etcdResponse));
        } else {
            system:println("Usage: createDir <dir>");
        }
    }

    // list directory
    if (args[0] == "listDir") {
        if (args.length > 1) {
            if (args.length < 3) {
                etcdResponse = etcdConnector.listDir (args[1], "recursive=false");
            } else {
                etcdResponse = etcdConnector.listDir (args[1], args[2]);
            }
            system:println(messages:getStringPayload(etcdResponse));
        } else {
            system:println("Usage: listDir <dir> [recuresive=true]");
        }
    }

    // delete directory
    if (args[0] == "deleteDir") {
        if (args.length > 1) {
            if (args.length < 3) {
                etcdResponse = etcdConnector.deleteDir (args[1], "recursive=false");
            } else {
                etcdResponse = etcdConnector.deleteDir (args[1], args[2]);
            }
            system:println(messages:getStringPayload(etcdResponse));
        } else {
            system:println("Usage: deleteDir <dir> [recuresive=true]");
        }
    }
}
