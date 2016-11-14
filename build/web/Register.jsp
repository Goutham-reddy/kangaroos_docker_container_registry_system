<%@page import="java.io.IOException"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="org.apache.http.HttpStatus"%>
<%@page import="org.apache.http.StatusLine"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.entity.ByteArrayEntity"%>
<%@page import="org.apache.http.impl.client.DefaultHttpClient"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.json.JSONObject"%>

<%
    //preparing JSONobject
    JSONObject Jsend = new JSONObject();
    Jsend.put("username", request.getParameter("username"));
    Jsend.put("password", request.getParameter("password"));

    //posting the JSON string
    HttpClient client = new DefaultHttpClient();
    String url = "https://api.mlab.com/api/1/databases/hackathon/collections/UserLogin?apiKey=KxwkFRBr321eGOMLVtTOHpmMRZJMj0u6";
    HttpPost request1 = new HttpPost(url);
    request1.setEntity(new ByteArrayEntity(Jsend.toString().getBytes("UTF-8")));
    request1.setHeader("Content-Type", "application/json");
    HttpResponse response1 = client.execute(request1);

    //success prompt
    out.println("You have successfully registered! <a href='index.html'>login</a>");

    
%>