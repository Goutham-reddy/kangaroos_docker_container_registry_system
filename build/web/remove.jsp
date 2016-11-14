<%-- 
    Document   : remove
    Created on : Nov 13, 2016, 3:14:34 AM
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
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileReader"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.http.client.methods.HttpDelete"%>
<%@page import="org.apache.http.impl.client.DefaultHttpClient"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.entity.ByteArrayEntity"%>
<%@page import="org.apache.http.client.methods.HttpPut"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    //finding the clicked button
    String username = session.getAttribute("username").toString();
    String url = "https://api.mlab.com/api/1/databases/hackathon/collections/containers?apiKey=KxwkFRBr321eGOMLVtTOHpmMRZJMj0u6&q={%27username%27:%27" + username + "%27}";
    URL query = new URL(url);
    BufferedReader br = new BufferedReader(new InputStreamReader(query.openStream()));
    String inputLine;
    String res = "";
    while ((inputLine = br.readLine()) != null) {
        res += inputLine;
    }
    JSONArray UserContainers = new JSONArray(res);
    String DeleteId = "";
    String DeleteURL = "";
    JSONObject deleteJSON=null;
    int index = 0;
    for (int i = 0; i < UserContainers.length(); i++) {
        JSONObject temp = UserContainers.getJSONObject(i);
        String Id = temp.getString("Id");
        if (request.getParameter(Id) != null) {
            DeleteId = Id;
            index = i;
            DeleteURL = temp.getString("URL");
            deleteJSON=UserContainers.getJSONObject(i);
            break;
        }
    }

    
     //update memory
    String path="C:\\Users\\kaushik\\Documents\\NetBeansProjects\\ContainerRegisterService\\";
    String UserURL=deleteJSON.getString("URL");
    String NodeIp=UserURL.substring(UserURL.indexOf(":")+1,UserURL.lastIndexOf(":"));
    Long FreeMemory=Long.parseLong(deleteJSON.getString("memory"));
    int FreeCpu=Integer.parseInt(deleteJSON.getString("cpu"));
    System.out.println("Got the free variables");
    BufferedReader nodeBr=new BufferedReader(new FileReader(path+NodeIp+".txt"));
    String nodeStats[]=nodeBr.readLine().split(" ");
    System.out.println("got stats");
    nodeBr.close();
    Long AvailableMemory=Long.parseLong(nodeStats[0]);
    int AvailableCPU=Integer.parseInt(nodeStats[1]);
    System.out.println("got available resources");
    BufferedWriter nodeWr=new BufferedWriter(new FileWriter(path+NodeIp+".txt"));
    nodeWr.write((AvailableMemory+FreeMemory)+" "+(AvailableCPU+FreeCpu));
    nodeWr.close();
    System.out.println("wrote the resources ");
    
    //remove entry from database
    HttpClient client = new DefaultHttpClient();
    String encoded=URLEncoder.encode("{'Id':'" + DeleteId + "'}", "UTF-8");
    
    String RemoveURL = "https://api.mlab.com/api/1/databases/hackathon/collections/containers?apiKey=KxwkFRBr321eGOMLVtTOHpmMRZJMj0u6&q="+encoded;
    System.out.println(RemoveURL);
    HttpPut request1 = new HttpPut(RemoveURL);
    JSONObject Jsend=new JSONObject();
    Jsend.put("$set",new JSONObject().put("Id","x"));
    request1.setEntity(new ByteArrayEntity(Jsend.toString().getBytes("UTF-8")));
    request1.setHeader("Content-Type", "application/json");
    HttpResponse response1 = client.execute(request1);
    
   
    
    //rest call to stop the container
     HttpClient client1 = new DefaultHttpClient();
     String IPdelte = DeleteURL.substring(0, DeleteURL.lastIndexOf(":")) + ":" + "4243/containers/" + DeleteId;
     HttpPost request2 = new HttpPost(RemoveURL+"/stop");
     request2.setEntity(new ByteArrayEntity(new JSONObject().toString().getBytes("UTF-8")));
    request2.setHeader("Content-Type", "application/json");
    HttpResponse response2 = client1.execute(request1);
    System.out.println("Stoping container:"+response2.getStatusLine().toString());
    
    //rest call to remove the container
    HttpClient client2=new DefaultHttpClient();
     System.out.println(IPdelte);
    HttpDelete deleteRequest = new HttpDelete(IPdelte+"?force=1");
    deleteRequest.setHeader("Content-Type", "application/json");
    response1 = client2.execute(deleteRequest);
    System.out.println("Deleting the container:"+response1.getStatusLine().toString());
    
    
    //redirect to removecontainer.jsp to select other delete items
    response.sendRedirect("RemoveContainer.jsp");
%>
