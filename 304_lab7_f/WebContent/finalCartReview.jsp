<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
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

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Final Cart Review</title>
</head>
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
<body>
<div class="page-header">
<h1 id="title">Final Cart Review</h1>
<h3 id="title">All taxes and shipping information displayed:</h3>
</div>

<div>
<%
@SuppressWarnings({ "unchecked" })
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
		.getAttribute("productList");
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
String uid = "salvarez";
String pw = "24165152";
%>
</div>


<div>
<h3>Your Dinosaurs</h3>
<%
// list dinosaurs ordered and prices
try (Connection con = DriverManager.getConnection(url, uid, pw);){

	// starting the table output
	out.println("<table border = '3 CELL PADDING = '4' CELLSPACING='3'>");
	out.println("<tr><th>Dinosaur Id</th><th>Dinosaur Name</th><th>Dino Price</th><th>Shrinkage Cost</th><th>Handlers Cost</th><th>Shipment Cost</th><th>Dino Subtotal</th></tr>");
	
	double totalPrice = 0;
	
	// traverse shopping cart	
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) {
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String Did = (String) product.get(0);
		int did = Integer.parseInt(Did);
		String dName = (String)product.get(1);
		String Price = (String) product.get(2);
		double price = Double.parseDouble(Price);
		double subtotal = 0;
	
		// get handlers for each dinosaur
		String sql = "SELECT shrinkageStrength, handlers FROM Species JOIN Dinosaur ON Species.speciesName = Dinosaur.speciesName WHERE did = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1,did);
		ResultSet rst = pstmt.executeQuery();
		rst.next();
		int shrinkage = rst.getInt(1);
		int handlers = rst.getInt(2);
		subtotal = shrinkage*1000 + handlers*1000 + price + 150;
	
		// fill in table
		// Print out order summary
		out.println("<tr>");
		out.println("<td>" + did + "</td><td>" + dName + "</td><td>" + currFormat.format(price) + "</td><td>" + currFormat.format(1000*shrinkage) + "</td><td>" + currFormat.format(1000*handlers) + "</td><td>" + currFormat.format(150) + "</td><td>" + currFormat.format(subtotal) + "</tf>");
		out.println("</tr>");
		
		totalPrice +=subtotal;
	}
	
	// complete table with subtotal, taxes, total price
			out.println("<tr><td colspan='7' align = 'right'>");
			out.println("<table>");
			out.println("<tr>");
			out.println("<td>Order Subtotal: </td>" + "<td>" + currFormat.format(totalPrice) + "</td>");
			out.println("</tr></table>");
			
		 	// admin 50% discount
			if ((boolean)session.getAttribute("admin") == true){
				// print out discount
				totalPrice = totalPrice*0.5;
				out.println("<tr><td colspan='7' align = 'right'>");
				out.println("<table>");
				out.println("<tr>");
				out.println("<td>Admin Discount (50% off): </td>" + "<td>-" + currFormat.format(totalPrice) + "</td>");
				out.println("</tr></table>");
			}
		 
			
			double tax = totalPrice * 0.12;
			out.println("<tr><td colspan='7' align = 'right'>");
			out.println("<table>");
			out.println("<tr>");
			out.println("<td>Taxes (%12): </td>" + "<td>" + currFormat.format(tax) + "</td>");
			out.println("</tr></table>");
			
			out.println("<tr><td colspan='7' align = 'right'>");
			out.println("<table>");
			out.println("<tr>");
			out.println("<th>Order Total </th>" + "<td>" + currFormat.format(totalPrice + tax) + "</td>");
			out.println("</tr></table>");
			
			session.setAttribute("totalPrice", totalPrice + tax);
			
	out.println("</table>");
	out.println("<header>");

} catch (Exception e){
	System.out.println("Exception" + e);
}

%>

</div>
<form method="get" action="order.jsp">
<input type="submit" value="Confirm Order">
</form>
<form method="get" action="showcart.jsp">
<input type="submit" value="Edit Cart">
</form>
</div>

</body>
</html>