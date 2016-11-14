<%-- 
    Document   : HomePage
    Created on : Nov 11, 2016, 11:41:46 PM
    Author     : kaushik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String username=session.getAttribute("username").toString();
    out.println("Welcome "+username);
    
    
%>
<html>
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

form {
	width: 300px;
	margin: 0 auto;
	
}

</style>
    <form action="AddContainer.jsp" method="post" name="AddContainer">
        <br>
        Mem: <input type="text" name="memory"><br>
        <font size="2">Enter the memory in Bytes that you want to reserve for you container.</font>
        <br><br>
        CPU: <input type="text" name="cpu"><br>
        <font size="2">Enter the CpuQuota for 1 vCPU with CpuPeriod 100000.</font>
        <br><br>
        Port: <input type="text" name="port"><br>
        <br><br>
        Select the image to deploy in docker.
        <br>
        <input type="radio" name="image" value="nginx">nginx<br/>
        <input type="radio" name="image" value="MongoDB">MongoDB<br/>
        <br>
        <input type="submit" value="Add Container">
    </form>
    <br><br>
    <h3>
    <a href="RemoveContainer.jsp">Remove a Container</a><br>
    <a href="CheckStats.jsp">Check Container Statistics</a><br>
    <a href="ManageSwarm.jsp">Manage Swarm Cluster</a>
    </h3>
</html>