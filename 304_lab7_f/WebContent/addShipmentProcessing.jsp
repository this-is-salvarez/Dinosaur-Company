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
<h2>.</h2>
<title>Add Shipment Processing</title>
</head>
<body>
<h2>.</h2>
<%
		String date = request.getParameter("date");
		String dID = (String)session.getAttribute("did_shipment");
	
		String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
		String uid = "salvarez";
		String pw = "24165152";

		Connection con = null;
		// change shipped status and add shipDate
		try {
			con = DriverManager.getConnection(url, uid, pw);

			int did = Integer.parseInt(dID);
			// run a query to add shipment to dinosaur
			String sql = "UPDATE Shipment SET shipDate = ?, shipped = true WHERE did = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setInt(2, did);
			pstmt.executeUpdate();
			out.println("Successfully updated shipment");
			out.println("<a href='adminShipmentStatus.jsp'>Back to Shipments</a>");
			
		} catch (NumberFormatException e) {
			out.println("Update not successful");
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>