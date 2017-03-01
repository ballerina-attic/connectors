package org.wso2.ballerina.connectors.etcd;

import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.net.http;
import ballerina.utils;

@doc:Description("etcd client connector")
@doc:Param("etcdURL : etcd Server URL")
@doc:Param("username : etcd user")
@doc:Param("password : etcd user's password")
@doc:Param("apiVersion : etcd API version")
connector ClientConnector (string etcdURL, string username, string password, string apiVersion) {

    http:ClientConnector etcdEP = create http:ClientConnector(etcdURL);

    @doc:Description("Get the value for given key")
	@doc:Param("t: The etcd Connector instance")
    @doc:Param("key: key to get the value")
    @doc:Return("response object")
    action getValue(ClientConnector t, string key) (message) {

	string encodedBasicAuthHeaderValue;
	string path;
    	message request= {};
    	message response;

    	if ((strings:length(username) > 0) && (strings:length(password) > 0) ){
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
    	}
        path = "/" + apiVersion + "/keys/" + key;
        response = http:ClientConnector.get(etcdEP, path, request);
        return response;
    }

    @doc:Description("Set/Store key/value pair")
    @doc:Param("t: The etcd Connector instance")
    @doc:Param("key: key to set the value")
    @doc:Param("value: value for the key")
    @doc:Return("response object")
    action setKeyValue(ClientConnector t, string key, string value) (message) {

    	string encodedBasicAuthHeaderValue;
    	string path;
    	message request= {};
    	message response;

    	if ((strings:length(username) > 0) && (strings:length(password) > 0) ){
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
    	}
    	messages:setStringPayload(request, "value=" + value);
    	messages:setHeader(request, "Content-Type", "application/x-www-form-urlencoded");
    	path = "/" + apiVersion + "/keys/" + key;
    	response = http:ClientConnector.put(etcdEP, path, request);
    	return response;
    }

    @doc:Description("Update the value for given key")
    @doc:Param("t: The etcd Connector instance")
    @doc:Param("key: key to update the value")
    @doc:Param("value: value for the key")
    @doc:Return("response object")
    action updateValue(ClientConnector t, string key, string value) (message) {

    	string encodedBasicAuthHeaderValue;
    	string path;
    	message request= {};
    	message response;

    	if ((strings:length(username) > 0) && (strings:length(password) > 0) ){
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
    	}
    	messages:setStringPayload(request, "value=" + value);
    	messages:setHeader(request, "Content-Type", "application/x-www-form-urlencoded");
    	path = "/" + apiVersion + "/keys/" + key;
    	response = http:ClientConnector.put(etcdEP, path, request);
    	return response;
    }

    @doc:Description("Delete the key")
    @doc:Param("t: The etcd Connector instance")
    @doc:Param("key: key to delete")
    @doc:Return("response object")
    action deleteKey(ClientConnector t, string key) (message) {

    	string encodedBasicAuthHeaderValue;
    	string path;
    	message request= {};
    	message response;

    	if ((strings:length(username) > 0) && (strings:length(password) > 0) ){
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
    	}
    	path = "/" + apiVersion + "/keys/" + key;
    	response = http:ClientConnector.delete(etcdEP, path, request);
    	return response;
     }

    @doc:Description("Create a directory")
    @doc:Param("t: The etcd Connector instance")
    @doc:Param("dir: name of the directory")
    @doc:Return("response object")
    action createDir(ClientConnector t, string dir) (message) {

    	string encodedBasicAuthHeaderValue;
    	string path;
    	message request= {};
    	message response;

    	if ((strings:length(username) > 0) && (strings:length(password) > 0) ){
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
    	}
    	path = "/" + apiVersion + "/keys/" + dir;
    	response = http:ClientConnector.put(etcdEP, path, request);
    	return response;
    }

    @doc:Description("List directory")
    @doc:Param("t: The etcd Connector instance")
    @doc:Param("dir: name of the directory")
    @doc:Param("recursive: recursive=true OR recursive=false")
    @doc:Return("response object")
    action listDir(ClientConnector t, string dir, string recursive) (message) {

    	string encodedBasicAuthHeaderValue;
    	string path;
    	message request= {};
    	message response;

    	if ((strings:length(username) > 0) && (strings:length(password) > 0) ){
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
    	}
	path = "/" + apiVersion + "/keys" + dir + "?" + recursive;
        response = http:ClientConnector.get(etcdEP, path, request);
    	return response;
    }

    @doc:Description("Delete directory")
    @doc:Param("t: The etcd Connector instance")
    @doc:Param("dir: name of the directory")
    @doc:Param("recursive: recursive=true OR recursive=false")
    @doc:Return("response object")
    action deleteDir(ClientConnector t, string dir, string recursive) (message) {

    	string encodedBasicAuthHeaderValue;
    	string path;
    	message request= {};
    	message response;

    	if ((strings:length(username) > 0) && (strings:length(password) > 0) ){
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
    	}
    	path = "/" + apiVersion + "/keys" + dir + "?" + recursive;
        response = http:ClientConnector.delete(etcdEP, path, request);
    	return response;
    }
}
