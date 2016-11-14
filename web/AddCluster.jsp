<%-- 
    Document   : AddCluster
    Created on : Nov 13, 2016, 3:00:01 PM
    Author     : kaushik
--%>
<style>

body {
	background-color : #6aa0f7;
	margin: 0;
	padding: 0;
}
h1 {
	color : #000000;
	text-align : center;
	font-family: "SIMPSON";
	font-size:100%;
}
h2 {
	 
	text-align : center;
	 
}

form {
	width: 300px;
	margin: 0 auto;
	
}

</style>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.entity.ByteArrayEntity"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.impl.client.DefaultHttpClient"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
//build the json
    JSONObject CreateService = new JSONObject();
    CreateService.put("TaskTemplate", new JSONObject().put("ContainerSpec", new JSONObject().put("Image", "nginx")));

    JSONObject Reservations = new JSONObject();
    Reservations.put("NanoCPUs", Integer.parseInt(request.getParameter("cpu").trim()));
    Reservations.put("MemoryBytes", Integer.parseInt(request.getParameter("memory").trim()));
    CreateService.put("Resources", new JSONObject().put("Reservations", Reservations));

    int replicas = Integer.parseInt(request.getParameter("replicas"));
    CreateService.put("Mode", new JSONObject().put("Replicated", new JSONObject().put("Replicas", replicas)));

    JSONObject mapping = new JSONObject();
    mapping.put("Protocol", "tcp");
    mapping.put("PublishedPort", Integer.parseInt(request.getParameter("port")));
    mapping.put("TargetPort", 80);
    JSONArray portsArray = new JSONArray();
    portsArray.put(mapping);

    CreateService.put("EndpointSpec", new JSONObject().put("Ports", portsArray));

    //out.println(CreateService.toString());

//REST call to create service
    String IP = "http://104.198.31.108:4243";
    HttpClient client = new DefaultHttpClient();
    String url = IP + "/services/create";
    HttpPost request1 = new HttpPost(url);
    request1.setEntity(new ByteArrayEntity(CreateService.toString().getBytes("UTF-8")));
    request1.setHeader("Content-Type", "application/json");
    HttpResponse response1 = client.execute(request1);
    BufferedReader rd = new BufferedReader(
            new InputStreamReader(response1.getEntity().getContent()));

    String result = "";
    String line = "";
    while ((line = rd.readLine()) != null) {
        result += line;
    }
    System.out.println(result);

    //store cluster ID
    JSONObject StoreId = new JSONObject();
    StoreId.put("username", session.getAttribute("username").toString());
    StoreId.put("port", Integer.parseInt(request.getParameter("port")));
    StoreId.put("memory",request.getParameter("memory"));
    StoreId.put("cpu",request.getParameter("cpu"));
    StoreId.put("Id",new JSONObject(result).getString("ID"));
    StoreId.put("replicas", replicas);
    StoreId.put("time",System.currentTimeMillis());
    
    String StoreURL = "https://api.mlab.com/api/1/databases/hackathon/collections/clusters?apiKey=KxwkFRBr321eGOMLVtTOHpmMRZJMj0u6";
    request1 = new HttpPost(StoreURL);
    request1.setHeader("Content-Type", "application/json");
    request1.setEntity(new ByteArrayEntity(StoreId.toString().getBytes("UTF-8")));
    client.execute(request1);
    
    out.println("you container was successfully created on port "+request.getParameter("port"));
%>

<br>
<br>
you can access it by using the following IPs:<br>
104.198.31.108<br> 104.197.32.181 <br>104.197.197.157<br>104.197.123.27
