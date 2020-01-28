<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
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
<head>
<link href = "navigation.css" rel = "stylesheet" type = "text/css">

<title>The Dinosaur Company Order List</title>
<style>table, th, td {
	border: 1px solid black;
}</style>
</head>
<body>
<h2>. </h2>
<h1>The Dinosaur Company: Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

// Write query to retrieve all order headers

// For each order in the ResultSet

	// Print out the order header information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection

//connection information 
String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_chvingel";
String uid = "chvingel";
String pw = "35583153";

//declaring variables for scope
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
Connection con = null;

try{
	//make connection and statement
	con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	
	//start of the table
	out.println("<table>");
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
		out.println("<table>");
		out.println("<tr>");
		out.println("<th> Dinosaur Id </th>" + "<th> Price </th>");
		out.println("</tr>");
		
		//get all the product information for the order 
		/* String SQL2 = "SELECT did, price FROM OrderedProduct WHERE orderId = ?";
		PreparedStatement pstmt = con.prepareStatement(SQL2);
		pstmt.setInt(1, rst1.getInt(1));
		ResultSet rst2 = pstmt.executeQuery();
		while(rst2.next()){
			out.println("<tr>");
			out.println("<td>" + rst2.getInt("did") + "</td>");
			out.println("<td>" + currFormat.format(rst2.getDouble("price")) + "</td>");
			out.println("</tr>");
		} */
		out.println("</table>");
		out.println("</td></tr>");
		
	}
	//close the table 
	out.println("</table>");
}
catch(SQLException e){
	System.err.println(e);
}
finally{
	if(con != null){
		try{
			con.close();
		}
		catch(SQLException e2){
			out.println(e2);
		}
	}
}

%>

</body>
</html>
