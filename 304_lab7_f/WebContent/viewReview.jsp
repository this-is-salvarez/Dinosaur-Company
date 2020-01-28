<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
  <%@include file = "navigation.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<head>
<link href = "navigation.css" rel = "stylesheet" type = "text/css">

<style>

#subbutton{
margin: 0px 3px;
}
body{
	
	front-size: 15pt;
	
}

.form-control{
width: 50%;

}
td,th{
    padding: 8px;   
}

th {
    background-color: #4CAF50;
    color: white;
}

	
tr:hover {background-color: #CCFFCC;}	


</style>


</head>
<head>

<link href = "navigation.css" rel = "stylesheet" type = "text/css">

<style>

.center {
    display: block;
    margin-left: auto;
    margin-right: auto;
    width: 50%;
}


</style>


</head>
<body>
<h2>. </h2>
<h1 align="center">View All Customer Reviews</h1>


<div class="page-header">
</div>

<h2 align="right"><a href="addReview.jsp">Add a Review</a></h2>
<%
String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
String uid = "salvarez";
String pw = "24165152";

try(Connection con = DriverManager.getConnection(url, uid, pw);){
	
	String SQL = "SELECT province, text FROM Review JOIN Customer USING (cid);";
	PreparedStatement pstmt = con.prepareStatement(SQL);
	ResultSet rst = pstmt.executeQuery();
	
	out.println("<table border='3' CELLPADDING='4' CELLSPACING='3'><tr><th>Customer's Province</th><th>Review</th></tr>");
	while(rst.next()){
		out.println("<tr><td>" + rst.getString(1)+"</td>");
		out.println("<td>" + rst.getString(2)+"</td></tr>");
	}
	out.println("</table></body></html>");	
	
}
	catch(SQLException e){
		out.println(e);
	}
%>
</body>
</html>