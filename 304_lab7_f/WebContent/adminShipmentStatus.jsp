<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@include file="navigation.jsp"%>

<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<head>
<link href="navigation.css" rel="stylesheet" type="text/css">

<title>Admin View Shipment Status</title>
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
	<!--allow queries by pid-->

	<div class="page-header">
	<h2>.</h2>
		<h1 id="title">Search for a shipment by Park ID:</h1>
	</div>

	<form method="get" action="adminShipmentStatus.jsp">



		<select size="1" name="pid">
			<option selected disabled>Search by Park ID:</option>
			<option value="1">1 (Jurassic-Mania)</option>
			<option value="2">2 (Marine Dinos)</option>
			<option value="3">3 (Cretaceousness)</option>
			<option value="4">3 (Triassical)</option>
		</select>
		<h1></h1>
		<div class="d-flex">
			<input type="submit" value="Submit" class="btn btn-success"
				id="subbutton">
		</div>
	</form>
	<%
		// get pid to search for
		String Pid = request.getParameter("pid");

		String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
		String uid = "salvarez";
		String pw = "24165152";

		Connection con = null;
		// change shipped status and add shipDate
		try {
			con = DriverManager.getConnection(url, uid, pw);
			int pid = Integer.parseInt(Pid);

			String SQL = "SELECT Dinosaur.did, dname, Dinosaur.pid, shipped "
					+ " FROM Shipment JOIN Dinosaur ON Shipment.did = Dinosaur.did"
					+ " WHERE Dinosaur.pid = ? AND shipped = false";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, pid);
			ResultSet rst = pstmt.executeQuery();
			if (!rst.next())
				out.println("<h4>You're all up to date on your park's shipments! Way to go</h4>");
			else {
				rst.previous();
				out.println("<h2>Search Results:</h2>");
				out.println("<h4>Dinosaurs pending shipment from your park:</h4>");
				out.println(
						"<table border='3' CELLPADDING='4' CELLSPACING='3'><tr><th>Dino ID</th><th>Dino Name</th><th>Park</th><th>Shipped</th><th>Add Shipment</th></tr>");

				while (rst.next()) {
					out.println("<tr><td>" + rst.getInt(1) + "</td><td>" + rst.getString(2) + "</td><td>"
							+ rst.getInt(3) + "</td><td>" + rst.getBoolean(4) + "</td><td><a href='addShipment.jsp?did="+String.valueOf(rst.getInt(1)) +"&name="+rst.getString(2)+"&pid="+rst.getString(3)+"'>Add Shipment</a></td></tr>");
				}
				out.println("</table>");
			}
			
			String SQL2 = "SELECT Dinosaur.did, dname, Dinosaur.pid, shipped, shipDate "
					+ " FROM Shipment JOIN Dinosaur ON Shipment.did = Dinosaur.did"
					+ " WHERE Dinosaur.pid = ? AND shipped = true";
			PreparedStatement pstmt2 = con.prepareStatement(SQL2);
			pstmt2.setInt(1, pid);
			ResultSet rst2 = pstmt2.executeQuery();
			
			if (!rst2.next())
				out.println("<h4>No Dinosaurs have been shipped from your park</h4>");
			else {
				rst2.previous();
				out.println("<h4>Dinosaurs shipped from your park:</h4>");
				out.println(
						"<table border='3' CELLPADDING='4' CELLSPACING='3'><tr><th>Dino ID</th><th>Dino Name</th><th>Park</th><th>Shipped</th><th>Ship Date</th></tr>");

				while (rst2.next()) {
					out.println("<tr><td>" + rst2.getInt(1) + "</td><td>" + rst2.getString(2) + "</td><td>"
							+ rst2.getInt(3) + "</td><td>" + rst2.getBoolean(4) + "</td><td>" + rst2.getDate(5) + "</td></tr>");
				}
				out.println("</table>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>