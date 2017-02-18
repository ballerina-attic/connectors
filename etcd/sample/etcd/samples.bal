import org.wso2.ballerina.connectors.etcd;
import ballerina.lang.array;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {
    string etcdURL = "http://127.0.0.1:2379";
    string username = "root";
    string password = "test123";
    string apiVersion = "v2";
    ClientConnector etcdConnector = create etcd:ClientConnector(etcdURL, username, password, apiVersion);
    messages etcdResponse;

    // add key/value to the etcd
    if (args[0] == "setKeyValue"){
	if (array:length(args) > 2){
    	    etcdResponse = etcd:ClientConnector.setKeyValue(etcdConnector,args[1],args[2]);
    	    system:println(messages:getStringPayload(etcdResponse));
	}else{
	    system:println("Usage: setKeyValue <key> <value>");
	}
    }
 
    // get value from the etcd for given key
    if (args[0] == "getValue"){
   	if (array:length(args) > 1){ 
    	    etcdResponse = etcd:ClientConnector.getValue(etcdConnector,args[1]);
    	    system:println(messages:getStringPayload(etcdResponse));
	}else{
	    system:println("Usage: getValue <key>");
	}
    }
    
    // update a value for given key
    if (args[0] == "updateValue"){
   	if (array:length(args) > 2){ 
    	    etcdResponse = etcd:ClientConnector.updateValue(etcdConnector,args[1],args[2]);
    	    system:println(messages:getStringPayload(etcdResponse));
	}else{
	    system:println("Usage: updateValue <key> <value>");
	}
    }

    // delete a key from etcd
    if (args[0] == "deleteKey"){
   	if (array:length(args) > 1){ 
    	    etcdResponse = etcd:ClientConnector.deleteKey(etcdConnector,args[1]);
    	    system:println(messages:getStringPayload(etcdResponse));
	}else{
	    system:println("Usage: deleteKey <key>");
	}
    }

    // create directory
    if (args[0] == "createDir"){
	if (array:length(args) > 1){
    	    etcdResponse = etcd:ClientConnector.createDir(etcdConnector,args[1]);
    	    system:println(messages:getStringPayload(etcdResponse));
	}else{
	    system:println("Usage: createDir <dir>");
	}
    }
    
    // list directory
    if (args[0] == "listDir"){
	if (array:length(args) > 1){
	    if (array:length(args) < 3 ){
    	        etcdResponse = etcd:ClientConnector.listDir(etcdConnector,args[1],"recursive=false");
	    }else{
    	        etcdResponse = etcd:ClientConnector.listDir(etcdConnector,args[1],args[2]);
	    }
    	    system:println(messages:getStringPayload(etcdResponse));
	}else{
	    system:println("Usage: listDir <dir> [recuresive=true]");
	}
    }
    
    // delete directory
    if (args[0] == "deleteDir"){
 	if (array:length(args) > 1){
	    if (array:length(args) < 3 ){
		etcdResponse = etcd:ClientConnector.deleteDir(etcdConnector,args[1],"recursive=false");
	    }else{
		etcdResponse = etcd:ClientConnector.deleteDir(etcdConnector,args[1],args[2]);
	    }
    	    system:println(messages:getStringPayload(etcdResponse));
	}else{
	    system:println("Usage: deleteDir <dir> [recuresive=true]");
	}
    }
}
