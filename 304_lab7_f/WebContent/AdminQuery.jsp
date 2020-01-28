<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@include file = "navigation.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<head>
<link href = "navigation.css" rel = "stylesheet" type = "text/css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
td,th{
    padding: 8px;   
}

th {
    background-color: #4CAF50;
  
    color: white;
}
#aa{
      vertical-align:middle;
}
#head{
margin-top:40px;
}



</style>
</head>
<body>
<h2>. </h2>
<h1 id="head">Database Tables for Admins</h1>
<div class="d-flex">
<form>
<select size="1" name="query" id="aa">
  <option selected disabled>Display All:</option>
  <option>Orders</option>
  <option>Shipments</option>
  <option>Customers</option>
</select>
<input type="submit" value="Submit" class="btn btn-success btn-sm" id="subbutton">  
</form>
</div>

<%
// Get product name to search for

String selectQ = request.getParameter("query");
String SQL;
PreparedStatement pstmt = null;
ResultSet rst = null;
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
String uid = "salvarez";
String pw = "24165152";
if(selectQ!=null){
try(Connection con = DriverManager.getConnection(url, uid, pw);){

if(selectQ.equals("Orders")){
	Statement stmt = con.createStatement();
	 out.println("<h2>All Order Information:</h2>");
	out.println("<table CELLPADDING='4' CELLSPACING='3'>");
	out.println("<tr>");
	out.println("<th>Order Id</th> <th>Customer Id</th> <th>Customer Name</th> <th>Total Amount</th>");
	out.println("</tr>");
	//Get the order information and loop these into the table
	String SQL1 = "SELECT orderId, Customer.cid, cname, totalPrice FROM Orders JOIN Customer ON Orders.customerId = Customer.cid";
	ResultSet rst1 = stmt.executeQuery(SQL1);
	while(rst1.next()){
		out.println("<tr>");
		out.println("<td>" + rst1.getInt(1) + "</td>" + "<td>" + rst1.getInt(2) + "</td>" + "<td>" + rst1.getString(3) + "</td>" + "<td>" + currFormat.format(rst1.getDouble(4)) + "</td>");
		out.println("</tr>");
		//nested while loop to get the product information for each order 
		out.println("<tr><td colspan='4' align = 'right'>");
		out.println("<table CELLPADDING='4' CELLSPACING='3'>");
		out.println("<tr>");
		out.println("<th> Dinosaur Id </th>" + "<th> Price </th>");
		out.println("</tr>");
		
		//get all the product information for the order 
		String SQL2 = "SELECT did, price FROM OrderedProduct WHERE orderId = ?";
		PreparedStatement pstmt2 = con.prepareStatement(SQL2);
		pstmt2.setInt(1, rst1.getInt(1));
		ResultSet rst2 = pstmt2.executeQuery();
		while(rst2.next()){
			out.println("<tr>");
			out.println("<td>" + rst2.getInt("did") + "</td>");
			out.println("<td>" + currFormat.format(rst2.getDouble("price")) + "</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		out.println("</td></tr>");
		
	}
	//close the table 
	out.println("</table>");
}
	

else if(selectQ.equals("Shipments")){
	 SQL = "SELECT * FROM Shipment";
	 pstmt=con.prepareStatement(SQL);
	 rst=pstmt.executeQuery();
	 
	 out.println("<h2>All Shipment Information:</h2>");
	 out.println("<table border='3'CELLPADDING='4' CELLSPACING='3'><tr><th>Shipment ID</th><th>Dinosaur ID</th><th>Shipment Date</th><th>height</th><th>width</th><th>length</th><th>Shipped</th></tr>");
	 
		while (rst.next()) {		
			out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getInt(2)+"</td><td>"+rst.getDate(3)+"</td><td>"+rst.getInt(4)+"</td><td>"+rst.getInt(5)+"</td><td>" +rst.getInt(6)+"</td><td>"+rst.getBoolean(7)+"</td></tr>");
		}
}
	

else if(selectQ.equals("Customers")){
	 SQL = "SELECT * FROM Customer";
	 pstmt=con.prepareStatement(SQL);
	 rst=pstmt.executeQuery();
	 out.println("<h2>All Customer Information:</h2>");
	 out.println("<table border='3'CELLPADDING='4' CELLSPACING='3'><tr><th>ID</th><th>Name</th><th>password</th><th>address</th><th>city</th><th>province</th><th>country</th><th>postalCode</th><th>phone</th><th>email</th><th>admin</th></tr>");
	 
		while (rst.next()) {		
			out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getString(2)+"</td><td>"+rst.getString(3)+"</td><td>"+rst.getString(4)+"</td><td>"+rst.getString(5)+"</td><td>" +rst.getString(6)+"</td><td>"+rst.getString(7)+"</td><td>"+rst.getString(8)+"</td><td>" +rst.getString(9)+"</td><td>" +rst.getString(10)+"</td><td>" +rst.getBoolean(11)+"</td></tr>");
		}
}
}

catch(SQLException e){
	
}
}
else{
	
}
%>

</body>
</html>