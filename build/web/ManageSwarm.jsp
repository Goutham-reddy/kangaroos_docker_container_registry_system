<%-- 
    Document   : ManageSwarm
    Created on : Nov 13, 2016, 2:44:19 PM
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

h3 {
	 
	text-align : center;
	 font-size:100%;
}
h4 {
	 
	text-align : right;
	 font-size:100%;
}

form {
	width: 300px;
	margin: 0 auto;
	
}

</style>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String username=session.getAttribute("username").toString();
    out.println(" <h4>"+username + "</h4>");
    
    
%>
<html>
    
    <form action="AddCluster.jsp" method="post" name="AddContainer">
        <br>
        <h3><u>Cluster Management</u><br><br></h3>
        Mem: &nbsp;&nbsp;&nbsp;&nbsp;  <input type="text" name="memory"><br>
        <font size="2">Enter the memory in Bytes that you want to reserve for you container.</font>
        <br><br>
        CPU:  &nbsp;&nbsp;&nbsp;&nbsp;  <input type="text" name="cpu"><br>
        <font size="2">Enter the NanoCpus for 8vCPUs.</font>
        <br><br>
        Port:&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;  <input type="text" name="port"><br>
        <br><br>
        Replicas: <input type="text" name="replicas"><br>
        <br><br>
        Select the image to deploy in docker.
        <br>
        <input type="radio" name="image" value="nginx">nginx<br/>
        <input type="radio" name="image" value="MongoDB">MongoDB<br/>
        <br>
        <input type="submit" value="Add Cluster">
    </form>
    <br><br>
    <h3>
    <a href="RemoveCluster.jsp">Remove Swarm Service</a><br>
    <a href="ClusterCheckStats.jsp">Check Stats of Swarm Service</a>
    <br><br>
    <a href="HomePage.jsp">Home</a>
    </h3>
</html>
