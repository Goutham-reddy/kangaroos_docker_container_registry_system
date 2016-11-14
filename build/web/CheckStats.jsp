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
        font-weight:normal
	 
}

h3 {
	 
	text-align : center;
        font-size:80%;
        font-weight:normal
	 
}
form {
	width: 300px;
	margin: 0 auto;
	
}

</style>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<h1><u>User Container Resources Statistics & Billing information</u></h1>
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
                Long time=Long.parseLong(temp.getString("time"));
                Long Uptime=(System.currentTimeMillis()-time)/1000;
                double price=Uptime*(0.001*((Integer.parseInt(temp.getString("cpu"))/10000)+0.0001*((Integer.parseInt(temp.getString("memory"))/100000000))));
                String result = String.format("%.2f", price);
                out.println("<br><h2>Resource:  "+temp.getString("URL")+"  -   "+result+"$"+"</h2><br><br>");
            }

        }
        
%>
<h3>
<br><br>
Note: Resource billing is calculated based on Uptime and memory usage<br>
100 MB RAM/sec = 0.0001$<br>
10000 CPU Quota/sec = 0.001$<br>

<a href="HomePage.jsp">Back</a>
</h3>