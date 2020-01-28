<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@include file = "navigation.jsp"%>

<!DOCTYPE html>
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
<h1 align="center">Your selected Dino</h1>
<head>
<title>View your Dino</title>
</head>
<body>

<form method="get" action="viewDino.jsp"> 
</form>
<%
int id = Integer.parseInt(request.getParameter("id"));
String name = request.getParameter("name");
String price = request.getParameter("price");
String cid  = String.valueOf(session.getAttribute("customerId_InternalUse"));

String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
String uid = "salvarez";
String pw = "24165152";
out.println("<h2>" + "Name: " +name + "</h2>");
//If user is not logged in, you can't add things to the cart
 if(cid == null || cid.equals("no_user")){
	String redirectURL = "login.jsp";
    response.sendRedirect(redirectURL);
} 
try (Connection con = DriverManager.getConnection(url, uid, pw);)
{
	String SQL = "SELECT * FROM Dinosaur WHERE did = ?";
	PreparedStatement pstmt = con.prepareStatement(SQL);
	pstmt.setInt(1, id);
	ResultSet rst = pstmt.executeQuery();
	out.print("<table><tr><th></th>");
	while(rst.next()){
		out.println("<tr><td>" + "Weight: " + rst.getInt(3) + " kg" + "</td></tr>");
		out.println("<tr><td>" + "Price: $" + rst.getString(4) + "</td></tr>");
		out.println("<tr><td>" + "Age: " + rst.getString(5) + " years"+ "</td></tr>");
		out.println("<tr><td>" + "Gender: " + rst.getString(6) + "</td></tr>");
		out.println("<tr><td>" + "Species: " + rst.getString(9) + "</td></tr>");
		out.println("<tr><td>" + "About Me: " + rst.getString(7) + "</td></tr>");
		out.println("<img style = 'width: 300px; height: 275px' src =" +  rst.getString(8) + ">");

	}
	out.println("<tr><td><h2><a href='addcart.jsp?id="+id+"&name="+name+"&price="+price+"'>Add to cart</a></h2></td></tr></tr>");
}catch(SQLException ex){
	out.println("<h2>" + ex + "</h2>");
}
%>

</body>
</html>

