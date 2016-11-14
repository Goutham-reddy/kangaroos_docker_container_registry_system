<%-- 
    Document   : AddContainer
    Created on : Nov 12, 2016, 4:30:02 PM
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
<%@page import="java.io.File"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.entity.ByteArrayEntity"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.impl.client.DefaultHttpClient"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    //prepare JSON for creating the container
    JSONObject ContainerCreator = new JSONObject();
    String image = request.getParameter("image");
    ContainerCreator.put("Image", image);
    JSONObject ContainerConfig = new JSONObject();
    ContainerConfig.put("CpuQuota", Integer.parseInt(request.getParameter("cpu")));
    ContainerConfig.put("MemoryReservation", Integer.parseInt(request.getParameter("memory")));
    JSONObject PortMapping = new JSONObject();
    JSONArray Hosts = new JSONArray().put(new JSONObject().put("HostPort", request.getParameter("port")));
    if (image.equals("nginx")) {
        PortMapping.put("80/tcp", Hosts);
    } else {
        PortMapping.put("27017/tcp", Hosts);
    }
    ContainerConfig.put("PortBindings", PortMapping);
    ContainerCreator.put("HostConfig", ContainerConfig);
    System.out.println(ContainerCreator.toString());

    //logic to select IP of ip address
    //String IP = "http://104.198.31.108:4243"; //update later
    BufferedWriter bw = new BufferedWriter(new FileWriter("trail.txt"));
    bw.write("findme");
    bw.close();
    String IP = "";
    String path = "C:\\Users\\kaushik\\Documents\\NetBeansProjects\\ContainerRegisterService\\";
    BufferedReader br = new BufferedReader(new FileReader(path + "nodes.txt"));
    String nodes[] = br.readLine().split(" ");
    br.close();
    BufferedReader indexBr = new BufferedReader(new FileReader(path + "index.txt"));
    int index = Integer.parseInt(indexBr.readLine().trim());
//    System.out.println("node[0]:" + nodes[0]);
//    System.out.println("index value : " + index);
    indexBr.close();
    int RequestedMemory = Integer.parseInt(request.getParameter("memory").trim());
    int RequestedCPU = Integer.parseInt(request.getParameter("cpu").trim());
    for (int i = 0; i < nodes.length; i++) {
        if (index >= nodes.length) {
            index = nodes.length - index;
        }
        BufferedReader statBr = new BufferedReader(new FileReader(path + nodes[index] + ".txt"));
        String nodeStats[] = statBr.readLine().split(" ");
        statBr.close();
        //System.out.println(nodeStats[0]);
        Long memory = Long.parseLong(nodeStats[0].trim());

        int cpu = Integer.parseInt(nodeStats[1].trim());

        System.out.println("\n\n\n\n" + memory  + "\n" + cpu +"\n");
        if (memory >= RequestedMemory && cpu >= RequestedCPU) {
            System.out.println("Assigning the IP");
            IP = "http://" + nodes[index] + ":4243";
            BufferedWriter indexBw = new BufferedWriter(new FileWriter(path + "index.txt"));
            indexBw.write(index + 1 + " ");
            indexBw.close();
            BufferedWriter nodeBw = new BufferedWriter(new FileWriter(path + nodes[index] + ".txt"));
            nodeBw.write((memory - RequestedMemory) + " " + (cpu - RequestedCPU));
            nodeBw.close();
            break;

        }

    }
    if (IP.equals("")) {
        out.println("No available resources for your criteria");
        return;
    }

    //REST call to create conatiner
    HttpClient client = new DefaultHttpClient();
    String url = IP + "/containers/create";
    HttpPost request1 = new HttpPost(url);
    request1.setEntity(new ByteArrayEntity(ContainerCreator.toString().getBytes("UTF-8")));
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

    //REST Call to start the created container
    JSONObject res = new JSONObject(result);
    System.out.println(res.toString());
    String ContainerId = res.getString("Id");
    String StartURL = IP + "/containers/" + ContainerId + "/start";
    request1 = new HttpPost(StartURL);
    request1.setHeader("Content-Type", "application/json");
    JSONObject temp = new JSONObject();
    request1.setEntity(new ByteArrayEntity(temp.toString().getBytes("UTF-8")));
    client.execute(request1);

    String UserURL = IP.substring(0, IP.lastIndexOf(":")) + ":" + request.getParameter("port");
    out.println("Succesfully created and started container you can access it by " + UserURL);

    //store container ID
    JSONObject StoreId = new JSONObject();
    StoreId.put("username", session.getAttribute("username").toString());
    StoreId.put("Id", ContainerId);
    StoreId.put("URL", UserURL);
    StoreId.put("memory", request.getParameter("memory"));
    StoreId.put("cpu", request.getParameter("cpu"));
    StoreId.put("time", System.currentTimeMillis());

    String StoreURL = "https://api.mlab.com/api/1/databases/hackathon/collections/containers?apiKey=KxwkFRBr321eGOMLVtTOHpmMRZJMj0u6";
    request1 = new HttpPost(StoreURL);
    request1.setHeader("Content-Type", "application/json");
    request1.setEntity(new ByteArrayEntity(StoreId.toString().getBytes("UTF-8")));
    client.execute(request1);

%>
<br>
<br>
<a href="HomePage.jsp">Home</a>