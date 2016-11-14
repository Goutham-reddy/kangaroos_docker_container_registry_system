<%-- 
    Document   : removeclusterhelper
    Created on : Nov 13, 2016, 3:29:08 PM
    Author     : kaushik
--%>

<%@page import="org.apache.http.client.methods.HttpDelete"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.entity.ByteArrayEntity"%>
<%@page import="org.apache.http.client.methods.HttpPut"%>
<%@page import="org.apache.http.impl.client.DefaultHttpClient"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String IP = "http://104.198.31.108:4243";
    String username = session.getAttribute("username").toString();
    String url = "https://api.mlab.com/api/1/databases/hackathon/collections/clusters?apiKey=KxwkFRBr321eGOMLVtTOHpmMRZJMj0u6&q={%27username%27:%27" + username + "%27}";
    URL query = new URL(url);
    BufferedReader br = new BufferedReader(new InputStreamReader(query.openStream()));
    String inputLine;
    String res = "";
    while ((inputLine = br.readLine()) != null) {
        res += inputLine;
    }
    System.out.println("Got the results");
    JSONArray UserClusters = new JSONArray(res);
    String DeleteId = "";

    int index = 0;
    for (int i = 0; i < UserClusters.length(); i++) {
        JSONObject temp = UserClusters.getJSONObject(i);
        String Id = temp.getString("Id");
        if (request.getParameter(Id) != null) {
            DeleteId = Id;
            index = i;
            break;
        }
    }

    //remove entry from database
    HttpClient client = new DefaultHttpClient();
    String encoded = URLEncoder.encode("{'Id':'" + DeleteId + "'}", "UTF-8");

    String RemoveURL = "https://api.mlab.com/api/1/databases/hackathon/collections/clusters?apiKey=KxwkFRBr321eGOMLVtTOHpmMRZJMj0u6&q=" + encoded;
    System.out.println(RemoveURL);
    HttpPut request1 = new HttpPut(RemoveURL);
    JSONObject Jsend = new JSONObject();
    Jsend.put("$set", new JSONObject().put("Id", "x"));
    request1.setEntity(new ByteArrayEntity(Jsend.toString().getBytes("UTF-8")));
    request1.setHeader("Content-Type", "application/json");
    HttpResponse response1 = client.execute(request1);

    //remove the service
    //rest call to remove the container
    HttpClient client2 = new DefaultHttpClient();
    HttpDelete deleteRequest = new HttpDelete(IP + "/services/" + DeleteId);
    deleteRequest.setHeader("Content-Type", "application/json");
    response1 = client2.execute(deleteRequest);
    System.out.println("Deleting the container:" + response1.getStatusLine().toString());

    response.sendRedirect("RemoveCluster.jsp");
%>