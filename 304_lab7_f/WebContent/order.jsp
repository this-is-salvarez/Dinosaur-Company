<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
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


</head><head>
<link href = "navigation.css" rel = "stylesheet" type = "text/css">

<title>Dinosaur Order Processing</title>
</head>
<style>
#subbutton {
	margin: 0px 3px;
}

body {
	front-size: 15pt;
}

.form-control {
	width: 50%;
}

td, th {
	padding: 8px;
}

th {
	background-color: #4CAF50;
	color: white;
}

tr:hover {
	background-color: #CCFFCC;
}
</style>
<body>

	<%
		try {
			@SuppressWarnings({ "unchecked" })
			HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
					.getAttribute("productList");

			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
			String uid = "salvarez";
			String pw = "24165152";

			Connection con = DriverManager.getConnection(url, uid, pw);

			// Use retrieval of auto-generated keys.
			String custName = (String) session.getAttribute("cname");
			String cID = String.valueOf(session.getAttribute("customerId_InternalUse"));
			int cid = Integer.parseInt(cID);

			String sqlInsertOrders = "INSERT INTO Orders (customerId, totalPrice) VALUES (?, 0.0)";
			PreparedStatement pstmt = con.prepareStatement(sqlInsertOrders, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, cid);
			pstmt.executeUpdate();
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			int orderId = keys.getInt(1);
			// Save order information to database

			// starting the table output
			out.println("<h2>. </h2>");
			out.println("<header><h1>Your Order Summary</h1></header>");
			out.println("<table border = '3 CELL PADDING = '4' CELLSPACING='3'>");
			out.println("<tr><th>Dinosaur Id</th><th>Dinosaur Name</th></tr>");

			double totalPrice = (Double) session.getAttribute("totalPrice");

			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext()) {
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String Did = (String) product.get(0);
				int did = Integer.parseInt(Did);
				System.out.println(did);
				String dName = (String) product.get(1);
				String Price = (String) product.get(2);
				double price = Double.parseDouble(Price);

				// add dinosaur to OrderedProduct
				String sql2 = "INSERT INTO OrderedProduct VALUES (?, ?, ?)";
				PreparedStatement pstmt2 = con.prepareStatement(sql2);
				pstmt2.setInt(1, orderId);
				pstmt2.setInt(2, did);
				pstmt2.setDouble(3, price);
				pstmt2.executeUpdate();

				// add to shipment, but keep shipment false and no shipdate
				String sql4 = "INSERT INTO Shipment (did, height, width, length, shipped) VALUES (?,6,6,10, false)";
				PreparedStatement pstmt4 = con.prepareStatement(sql4);
				pstmt4.setInt(1, did);
				pstmt4.executeUpdate();
				ResultSet keys4 = pstmt.getGeneratedKeys();
				keys4.next();
				int shipmentId = keys4.getInt(1);
				System.out.println(shipmentId);

				// Make the dinosaur unavailable
				String sqlUnavailable = "UPDATE Dinosaur SET available = 0 WHERE did = ?";
				PreparedStatement pstmtUnavailable = con.prepareStatement(sqlUnavailable);
				pstmtUnavailable.setInt(1, did);
				pstmtUnavailable.executeUpdate();

				// Print out order summary
				out.println("<tr>");
				out.println("<td>" + did + "</td>" + "<td>" + dName + "</td>");
				out.println("</tr>");
			}
			out.println("<tr><td colspan='6' align = 'right'>");
			out.println("<table>");
			out.println("<tr>");
			out.println("<th> Order Total </th>" + "<td>" + currFormat.format(totalPrice) + "</td>");
			out.println("</tr></table>");
			out.println("</table>");
			out.println("<header>");
			out.println("<h1>Order completed.  Will be shipped soon...</h1>");
			out.println("<h1>Your order reference number is: " + orderId + "</h1>");
			out.println("<h1>Shipping to customer: " + cid + ", Name: " + custName + "</h1>");
			out.println("</header>");

			// reset shopping cart
			productList = new HashMap<String, ArrayList<Object>>();
			session.setAttribute("productList", productList);

			// Update total amount for order record
			String sql3 = "UPDATE Orders SET totalPrice= ? WHERE orderId = ?";
			PreparedStatement pstmt3 = con.prepareStatement(sql3);
			pstmt3.setDouble(1, totalPrice);
			pstmt3.setInt(2, orderId);
			pstmt3.executeUpdate();

		} catch (SQLException e) {
			out.println("SQLException thrown" + e);
		} catch (Exception e) {
			out.println("Exception" + e);
		}
	%>
</BODY>
</HTML>

