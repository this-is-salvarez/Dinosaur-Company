<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update Product Processing</title>
</head>
<body>
	<h2>.</h2>
	<%
	// Get customer information 
	String dID = (String)session.getAttribute("did_updateDino");
	try{
		int did = Integer.parseInt(dID);
	
	String dname = request.getParameter("dname");
	String weight = request.getParameter("weight");
	String price = request.getParameter("price");
	String age = request.getParameter("age");
	String gender = request.getParameter("gender");
	String aboutMe = request.getParameter("aboutMe");
	String pictureName = request.getParameter("pictureName");
	String species = request.getParameter("species");
	String pid = request.getParameter("pid");
	
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			
		String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
		String uid = "salvarez";
		String pw = "24165152";
			
		Connection con = DriverManager.getConnection(url, uid, pw);
		
		//make necessary conversions (all are required so don't need to handle that)
		int weight_num;
		double price_num;
		int age_num;
		int pid_num;
		
		if (!dname.equals("")){
			String sql = "UPDATE Dinosaur SET dname = ? WHERE did =?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dname);
			pstmt.setInt(2,did);
			pstmt.executeUpdate();
		}
		if (!weight.equals("")){
			weight_num = Integer.parseInt(weight);
			String sql = "UPDATE Dinosaur SET weight = ? WHERE did =?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, weight_num);
			pstmt.setInt(2,did);
			pstmt.executeUpdate();
		}
		if (!price.equals("")){
			price_num= Double.parseDouble(price);
			String sql = "UPDATE Dinosaur SET price = ? WHERE did =?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setDouble(1, price_num);
			pstmt.setInt(2,did);
			pstmt.executeUpdate();
		}
		if (!age.equals("")){
			age_num = Integer.parseInt(age);
			String sql = "UPDATE Dinosaur SET age = ? WHERE did =?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, age_num);
			pstmt.setInt(2,did);
			pstmt.executeUpdate();
		}
		if (gender!=null){
			String sql = "UPDATE Dinosaur SET gender = ? WHERE did =?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gender);
			pstmt.setInt(2,did);
			pstmt.executeUpdate();
		}
		if (!aboutMe.equals("")){
			String sql = "UPDATE Dinosaur SET aboutMe = ? WHERE did =?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, aboutMe);
			pstmt.setInt(2,did);
			pstmt.executeUpdate();
		}
		if (!pictureName.equals("")){
			String sql = "UPDATE Dinosaur SET picture = ? WHERE did =?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pictureName);
			pstmt.setInt(2,did);
			pstmt.executeUpdate();
		}
		if (species!=null){
			String sql = "UPDATE Dinosaur SET speciesName = ? WHERE did =?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, species);
			pstmt.setInt(2,did);
			pstmt.executeUpdate();
		}
		if (pid!=null){
			pid_num = Integer.parseInt(pid);
			String sql = "UPDATE Dinosaur SET pid = ? WHERE did =?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pid);
			pstmt.setInt(2,did);
			pstmt.executeUpdate();
		}
		
			out.println("<h3 align = 'center'>Your dinosaur has been successfully updated.</h3>");
			out.println("<a href='listprod.jsp'>Back to Dinosaur Catalogue</a>");
		}
		
		catch(SQLException e1){
			out.println("SQL Exception thrown: " + e1);
			out.println("It appears that some of your input was not formatted correctly.  Please complete the form again and retry.");
		}
		catch(Exception e2){
			out.println("Exception thrown: " + e2);
			e2.printStackTrace();
			}  
		
	%>
</body>
</html>