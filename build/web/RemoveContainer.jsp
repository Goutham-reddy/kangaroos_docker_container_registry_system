<%-- 
    Document   : RemoveContainer
    Created on : Nov 12, 2016, 5:11:40 PM
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
        font-size:100%;
	 
}

form {
	width: 300px;
	margin: 0 auto;
	
}


</style>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<h1><u>Delete Containers <br><br></u></h1>
<form action="remove.jsp" method="post" >
    <%
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
        for (int i = 0; i < UserContainers.length(); i++) {
            JSONObject temp = UserContainers.getJSONObject(i);
            if (temp.getString("Id").length()>3) {
                out.println("  " + temp.getString("URL") + "        &nbsp;&nbsp;" + "<input type='submit' value='Delete' name=" + temp.getString("Id") + "><br><br>");
            }

        }
    %>
    <h2>
</form><br><br>
<a href="HomePage.jsp">Home</a>
</h2>