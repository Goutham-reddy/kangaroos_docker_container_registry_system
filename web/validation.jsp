<%@page import="java.net.URL"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>

<%

    //verify user 
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String url = "https://api.mlab.com/api/1/databases/hackathon/collections/UserLogin?apiKey=KxwkFRBr321eGOMLVtTOHpmMRZJMj0u6&q={%27username%27:%27" + username + "%27,%27password%27:%27" + password + "%27}}";
    URL query = new URL(url);
    BufferedReader br = new BufferedReader(new InputStreamReader(query.openStream()));
    String inputLine;
    String res = "";
    while ((inputLine = br.readLine()) != null) {
        res += inputLine;
    }
    if (res.length() > 10) {
        session.setAttribute("username", username);
        response.sendRedirect("HomePage.jsp");
    } else {
        response.sendRedirect("index.html");
    }
%>