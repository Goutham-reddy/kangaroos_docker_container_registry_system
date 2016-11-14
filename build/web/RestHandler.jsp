<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%!
    public String GET(String url) {
        try {
            URL query = new URL(url);
            BufferedReader br = new BufferedReader(new InputStreamReader(query.openStream()));
            String inputLine;
            String res = "";
            while ((inputLine = br.readLine()) != null) {
                res += inputLine;
            }
            return res;
        } catch (Exception e) {
            return "Error in getting";
        }

%>
