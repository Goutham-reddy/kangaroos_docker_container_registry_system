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
<%
        String username = session.getAttribute("username").toString();
        
        String url = "https://api.mlab.com/api/1/databases/hackathon/collections/clusters?apiKey=KxwkFRBr321eGOMLVtTOHpmMRZJMj0u6&q={%27username%27:%27" + username + "%27}";
        URL query = new URL(url);
        BufferedReader br = new BufferedReader(new InputStreamReader(query.openStream()));
        String inputLine;
        String res = "";
        while ((inputLine = br.readLine()) != null) {
            res += inputLine;
        }
        JSONArray UserContainers = new JSONArray(res);
        out.println("<h1> <u> User Billing Information $ per port </h1> </u>  <br>");
        Double total = 0.0;
        for (int i = 0; i < UserContainers.length(); i++) {
            JSONObject temp = UserContainers.getJSONObject(i);
            if (temp.getString("Id").length()>3) {
                Long time=Long.parseLong(temp.getString("time"));
                Long Uptime=(System.currentTimeMillis()-time)/1000;
                int replicas=Integer.parseInt(temp.getString("replicas"));
                double price=replicas*Uptime*(0.001*((Integer.parseInt(temp.getString("cpu"))/10000000)+0.0001*((Integer.parseInt(temp.getString("memory"))/100000000))));
                String result = String.format("%.2f", price);
                total+= price;
                out.println("<h1>"+temp.getString("port")+"(Port)  -   "+result+"$" + "<br> </h1>");
            }
         
        }
        out.println("<h1> Total Usage Bill:  $" + String.format("%.2f", total) + "</h1>");
        
%>
<br><br>
<h3>
Note: Calculated based on Uptime and No of replica containers in which the service is hosted<br>
100 MB RAM/sec = 0.0001$<br>
10000000 CPU Nano/sec = 0.001$<br>
<br>

<a href="ManageSwarm.jsp">Back</a>
</h3>