package org.wso2.ballerina.connectors.etcd;

import ballerina.lang.array;
import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.util;

@doc:Description("etcd client connector")
@doc:Param("etcdURL : etcd Server URL")
@doc:Param("username : etcd user")
@doc:Param("password : etcd user's password")
@doc:Param("apiVersion : etcd API version")
connector ClientConnector (string etcdURL, string username, string password, string apiVersion) {

    http:ClientConnector etcdEP = create http:ClientConnector(etcdURL);

    @doc:Description("Get the value for given key")
    @doc:Param("key: key to get the value")
    @doc:Return("response object")
    action getValue(ClientConnector t, string key) (message) {
        
	string encodedBasicAuthHeaderValue;
        string path;
        message request= {};
        message response;
	
	if ((string:length(username) > 0) && (string:length(password) > 0) ){
	    encodedBasicAuthHeaderValue = util:base64encode(username + ":" + password);
	    message:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
	}
	path = "/" + apiVersion + "/keys/" + key;
        response = http:ClientConnector.get(etcdEP, path, request);
        return response;
    }

    @doc:Description("Set/Store key/value pair")
    @doc:Param("key: key to set the value")
    @doc:Param("value: value for the key")
    @doc:Return("response object")
    action setKeyValue(ClientConnector t, string key, string value) (message) {
	
	string encodedBasicAuthHeaderValue;
        string path;
        message request= {};
        message response;
	
	if ((string:length(username) > 0) && (string:length(password) > 0) ){
	    encodedBasicAuthHeaderValue = util:base64encode(username + ":" + password);
	    message:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
	}
	message:setStringPayload(request, "value=" + value);
	message:setHeader(request, "Content-Type", "application/x-www-form-urlencoded");
	path = "/" + apiVersion + "/keys/" + key;
	response = http:ClientConnector.put(etcdEP, path, request);
	return response;
    }

    @doc:Description("Update the value for given key")
    @doc:Param("key: key to update the value")
    @doc:Param("value: value for the key")
    @doc:Return("response object")
    action updateValue(ClientConnector t, string key, string value) (message) {
	
	string encodedBasicAuthHeaderValue;
        string path;
        message request= {};
        message response;
	
	if ((string:length(username) > 0) && (string:length(password) > 0) ){
	    encodedBasicAuthHeaderValue = util:base64encode(username + ":" + password);
	    message:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
	}
	message:setStringPayload(request, "value=" + value);
	message:setHeader(request, "Content-Type", "application/x-www-form-urlencoded");
	path = "/" + apiVersion + "/keys/" + key;
	response = http:ClientConnector.put(etcdEP, path, request);
	return response;
    }

    @doc:Description("Delete the key")
    @doc:Param("key: key to delete")
    @doc:Return("response object")
    action deleteKey(ClientConnector t, string key) (message) {
	
	string encodedBasicAuthHeaderValue;
        string path;
        message request= {};
        message response;
	
	if ((string:length(username) > 0) && (string:length(password) > 0) ){
	    encodedBasicAuthHeaderValue = util:base64encode(username + ":" + password);
	    message:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
	}
	path = "/" + apiVersion + "/keys/" + key;
	response = http:ClientConnector.delete(etcdEP, path, request);
	return response;
     }

    @doc:Description("Create a directory")
    @doc:Param("dir: name of the directory")
    @doc:Return("response object")
    action createDir(ClientConnector t, string dir) (message) {
	
	string encodedBasicAuthHeaderValue;
        string path;
        message request= {};
        message response;
	
	if ((string:length(username) > 0) && (string:length(password) > 0) ){
	    encodedBasicAuthHeaderValue = util:base64encode(username + ":" + password);
	    message:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
	}
	path = "/" + apiVersion + "/keys/" + dir;
	response = http:ClientConnector.put(etcdEP, path, request);
	return response;
    }

    @doc:Description("List directory")
    @doc:Param("dir: name of the directory")
    @doc:Param("recursive: recursive=true OR recursive=false")
    @doc:Return("response object")
    action listDir(ClientConnector t, string dir, string recursive) (message) {
	
	string encodedBasicAuthHeaderValue;
        string path;
        message request= {};
        message response;
	
	if ((string:length(username) > 0) && (string:length(password) > 0) ){
	    encodedBasicAuthHeaderValue = util:base64encode(username + ":" + password);
	    message:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
	}
	path = "/" + apiVersion + "/keys" + dir + "?" + recursive;
        response = http:ClientConnector.get(etcdEP, path, request);
	return response;
    }
    
    @doc:Description("Delete directory")
    @doc:Param("dir: name of the directory")
    @doc:Param("recursive: recursive=true OR recursive=false")
    @doc:Return("response object")
    action deleteDir(ClientConnector t, string dir, string recursive) (message) {
	
	string encodedBasicAuthHeaderValue;
        string path;
        message request= {};
        message response;
	
	if ((string:length(username) > 0) && (string:length(password) > 0) ){
	    encodedBasicAuthHeaderValue = util:base64encode(username + ":" + password);
	    message:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
	}
	path = "/" + apiVersion + "/keys" + dir + "?" + recursive;
        response = http:ClientConnector.delete(etcdEP, path, request);
	return response;
    }
}


