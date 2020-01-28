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
<h2>. </h2>
<title>Shipment Breakdown</title>
</head>
<body>
	<h1 align="center">Shipment Cost Breakdown</h1>

	<%
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
		String uid = "salvarez";
		String pw = "24165152";

		// declare total price variables
		int shrinkageTotalPrice = 0;
		int handlerTotalPrice = 0;
		int shippingTotalPrice = 0;
	%>

	<div>
		<h3>Our Cutting-Edge Shrinkage Powers</h3>
		<p>In order to safely ship our dinosaurs, we shrink them to fit
			into a 10ft x 6ft x 6ft crate. Our shrinking powers are
			top-of-the-line and are safe for the dinosaurs. It's just temporary -
			only for the dinosaur's shipment. Upon delivery, we return the
			dinosaurs to their full size. Extra shrinkage power is needed for
			larger dinosaurs, so it will cost more. Shrinkages cost $1000 per
			shrinkage strength level.</p>
		<p>The breakdown of shrinkages for your order is written below:</p>
		<p></p>
		<%
			try (Connection con = DriverManager.getConnection(url, uid, pw);) {

				// starting the table output
				out.println("<table border = '3 CELL PADDING = '4' CELLSPACING='3'>");
				out.println(
						"<tr><th>Dinosaur Id</th><th>Dinosaur Name</th><th>Shrinkage Strength</th><th>Cost</th></tr>");

				// traverse shopping cart	
				Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
				while (iterator.hasNext()) {
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					String Did = (String) product.get(0);
					int did = Integer.parseInt(Did);

					// get shrinkage strength for each dinosaur
					String sql = "SELECT shrinkageStrength FROM Species JOIN Dinosaur ON Species.speciesName = Dinosaur.speciesName WHERE did = ?";
					PreparedStatement pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, did);
					ResultSet rst = pstmt.executeQuery();
					rst.next();

					String dName = (String) product.get(1);
					int shrinkage = rst.getInt(1);

					// fill in table
					// Print out order summary
					out.println("<tr>");
					out.println("<td>" + did + "</td>" + "<td>" + dName + "</td>" + "<td>" + shrinkage + "</td>"
							+ "<td>" + currFormat.format(1000 * shrinkage) + "</td>");
					out.println("</tr>");

					shrinkageTotalPrice += shrinkage * 1000;
				}

				// complete table with shrinkage total price
				out.println("<tr><td colspan='5' align = 'right'>");
				out.println("<table>");
				out.println("<tr>");
				out.println("<th> Shrinkage Strength Price Total </th>" + "<td>"
						+ currFormat.format(shrinkageTotalPrice) + "</td>");
				out.println("</tr></table>");
				out.println("</table>");
				out.println("<header>");

			} catch (Exception e) {
				System.out.println("Exception" + e);
			}
		%>
	</div>

	<div>
		<h3>Handlers</h3>
		<p>Handlers are important for the dinosaur's safety during
			shipment. They accompany the dinosaur throughout the shipment
			process, feeding it and caring for it until it arrives safely at your
			door. They even stay to help you set up your dinosaur at your home,
			and make sure you understand the proper care instructions. Each
			dinosaur has a minimum of 2 handlers, but some dinosaurs need more
			care. Each handler costs $1000.</p>
		<p>The breakdown of the handlers for your order is written below:
		</p>
		<p></p>
		<%
			//make connection

			try (Connection con = DriverManager.getConnection(url, uid, pw);) {

				// starting the table output
				out.println("<table border = '3 CELL PADDING = '4' CELLSPACING='3'>");
				out.println("<tr><th>Dinosaur Id</th><th>Dinosaur Name</th><th>Handlers</th><th>Cost</th></tr>");

				// traverse shopping cart	
				Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
				while (iterator.hasNext()) {
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					String Did = (String) product.get(0);
					int did = Integer.parseInt(Did);

					// get handlers for each dinosaur
					String sql = "SELECT handlers FROM Species JOIN Dinosaur ON Species.speciesName = Dinosaur.speciesName WHERE did = ?";
					PreparedStatement pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, did);
					ResultSet rst = pstmt.executeQuery();
					rst.next();

					String dName = (String) product.get(1);
					int handlers = rst.getInt(1);

					// fill in table
					// Print out order summary
					out.println("<tr>");
					out.println("<td>" + did + "</td>" + "<td>" + dName + "</td>" + "<td>" + handlers + "</td>" + "<td>"
							+ currFormat.format(1000 * handlers) + "</td>");
					out.println("</tr>");

					handlerTotalPrice += handlers * 1000;
				}

				// complete table with handler total price
				out.println("<tr><td colspan='5' align = 'right'>");
				out.println("<table>");
				out.println("<tr>");
				out.println(
						"<th> Handlers Price Total </th>" + "<td>" + currFormat.format(handlerTotalPrice) + "</td>");
				out.println("</tr></table>");
				out.println("</table>");
				out.println("<header>");

			} catch (Exception e) {
				System.out.println("Exception" + e);
			}
		%>
	</div>

	<div>
		<h3>Shipping Costs</h3>
		<p>Dinosaurs are a flat rate of $150 each to ship anywhere in
			Canada. We transport by ground.</p>
		<p>The breakdown of the shipping costs for your order are written
			below:</p>
		<p></p>
		<%
			try (Connection con = DriverManager.getConnection(url, uid, pw);) {

				// starting the table output
				out.println("<table border = '3 CELL PADDING = '4' CELLSPACING='3'>");
				out.println("<tr><th>Dinosaur Id</th><th>Dinosaur Name</th><th>Shipping Cost</th></tr>");

				// traverse shopping cart	
				Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
				while (iterator.hasNext()) {
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					String Did = (String) product.get(0);
					int did = Integer.parseInt(Did);
					String dName = (String) product.get(1);

					// fill in table
					// Print out order summary
					out.println("<tr>");
					out.println("<td>" + did + "</td>" + "<td>" + dName + "</td>" + "<td>" + currFormat.format(150)
							+ "</td>");
					out.println("</tr>");

					shippingTotalPrice += 150;
				}

				// complete table with shipping total price
				out.println("<tr><td colspan='5' align = 'right'>");
				out.println("<table>");
				out.println("<tr>");
				out.println(
						"<th>Shipping Price Total </th>" + "<td>" + currFormat.format(shippingTotalPrice) + "</td>");
				out.println("</tr></table>");
				out.println("</table>");
				out.println("<header>");

			} catch (Exception e) {
				System.out.println("Exception" + e);
			}
		%>
	</div>

	<div>
		<h2>Your Total Cost for Shipment Breakdown</h2>
		<%
			out.println("<table border = '3 CELL PADDING = '4' CELLSPACING='3'><tr>");
			out.println(
					"<td>Shrinkage Strength Total</td><td>" + currFormat.format(shrinkageTotalPrice) + "</td></tr>");
			out.println("<tr><td>Handler Total</td><td>" + currFormat.format(handlerTotalPrice) + "</td></tr>");
			out.println("<tr><td>Shipping Total</td><td>" + currFormat.format(shippingTotalPrice) + "</td></tr>");
			out.println("<tr><th>Shipment Costs Total</th><td>"
					+ currFormat.format(shippingTotalPrice + shrinkageTotalPrice + handlerTotalPrice) + "</td></tr>");
			out.println("</table>");
		%>

	</div>

	<form method="get" action="finalCartReview.jsp">
		<input type="submit" value="Final Order Review">
	</form>
	<form method="get" action="showcart.jsp">
		<input type="submit" value="Edit Cart">
	</form>
</body>
</html>