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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding a Dinosaur Processing </title>
</head>
<body>

<%
	// Get customer information 
	String dname = request.getParameter("dname");
	//out.println("dname: " + dname);
	String weight = request.getParameter("weight");
	//out.println("weight: " + weight);
	String price = request.getParameter("price");
	//out.println("price: " + price);
	String age = request.getParameter("age");
	//out.println("age: " + age);
	String gender = request.getParameter("gender");
	//out.println("gender: " + gender);
	String aboutMe = request.getParameter("aboutMe");
	//out.println("about Me: " + aboutMe); 
	String pictureName = request.getParameter("pictureName");
	String pictureNameFinal = "images/" + pictureName;
	//out.println("picture Name: " + pictureName);
	String species = request.getParameter("species");
	//out.println("species: " + species);
	String parkId = request.getParameter("pid");
	Integer pid = Integer.parseInt(parkId);
	
	try{
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			
		String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
		String uid = "salvarez";
		String pw = "24165152";
			
		Connection con = DriverManager.getConnection(url, uid, pw);
		
		//make necessary conversions (all are required so don't need to handle that)
		int weight_num = Integer.parseInt(weight);
		double price_num = Double.parseDouble(price);
		int age_num = Integer.parseInt(age);
		
		//availability will always be true when a new dinosaur gets entered
		boolean available = true;
		
		String SQL = "INSERT INTO Dinosaur(dname, weight, price, age, gender, aboutMe, picture, speciesName, available, pid) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = con.prepareStatement(SQL);
		
		pstmt.setString(1, dname);
		pstmt.setInt(2, weight_num);
		pstmt.setDouble(3, price_num);
		pstmt.setInt(4, age_num);
		pstmt.setString(5, gender);
		pstmt.setString(6, aboutMe);
		pstmt.setString(7, pictureNameFinal);
		pstmt.setString(8, species);
		pstmt.setBoolean(9, available);
		pstmt.setInt(10, pid);
	
			
		pstmt.execute();
			
			out.println("<h3 align = 'center'>Your dinosaur has been successfully added.</h3>");
			out.println("<h2 align = 'center'><a href = 'shop.jsp'>Home</a></h2>");
			
					
		
			
		}
		
		catch(SQLException e1){
			out.println("SQL Exception thrown: " + e1);
			out.println("It appears that some of your input was not formatted correctly.  Please complete the form again and retry.");
		}
		catch(Exception e2){
			out.println("Exception thrown: " + e2);
			}  
		
	%>


</body>
</html>