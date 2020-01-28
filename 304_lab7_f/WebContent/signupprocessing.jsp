<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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


<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>The Dinosaur Store's Sign Up Processing </title>
</head>
<body>
<h2>. </h2>
<%
	// Get customer information 
	String cname = request.getParameter("cname");
	//out.println("cname: " + cname);
	String email = request.getParameter("email");
	//out.println("email: " + email);
	String password = request.getParameter("password");
	//out.println("password: " + password);
	String country = request.getParameter("country");
	//out.println("country: " + country);
	String province = request.getParameter("province");
	//out.println("province: " + province);
	String city = request.getParameter("city");
	//out.println("city: " + city); 
	String postalCode = request.getParameter("postalCode");
	//out.println("postal code: " + postalCode);
	String address = request.getParameter("address");
	//out.println("address: " + address);
	String phoneNumber = request.getParameter("phone");		
	//out.println("phone: " + phoneNumber);
	String question = request.getParameter("question");
	//out.println("question: " + question);
	String answer = request.getParameter("answer");
	//out.println("answer: " + answer);
		
	 try{
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			
			String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
			String uid = "salvarez";
			String pw = "24165152";
			
			Connection con = DriverManager.getConnection(url, uid, pw);
			
			
			//Check if the user's email already exists in the database.
			//If it does, print out said error message and redirect to login page
			//If it does not, proceed with inputing user information
			String SQL_email = "SELECT * FROM Customer WHERE email = ?";
			PreparedStatement pstmt_email = con.prepareStatement(SQL_email);
			pstmt_email.setString(1, email);
			ResultSet rst_email = pstmt_email.executeQuery();
			
			if(rst_email.next()){
				//print a message and direct to the login screen 
				out.println("<h1>Opps...</h1>");
				out.println("<h3>You already have an account with us.  Please use the following link to login.</h3>");
				out.println("<h2 align = 'center'><a href = 'login.jsp'>Login</a></h2>");
			}
			
			
			else{
				String SQL = "INSERT INTO Customer(cname, password, city, phone, email, province, postalCode, address, country, secQuestion, secAnswer) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement pstmt = con.prepareStatement(SQL);
				//pstmt.setInt(1, cid)
				pstmt.setString(1, cname);
				pstmt.setString(2, password);
				pstmt.setString(3, city);
				pstmt.setString(4, phoneNumber);
				pstmt.setString(5, email);
				pstmt.setString(6, province);
				pstmt.setString(7, postalCode);
				pstmt.setString(8, address);
				pstmt.setString(9, country);
				pstmt.setString(10, question);
				pstmt.setString(11, answer);
				pstmt.execute();

				
				String SQL2 = "SELECT cid FROM Customer WHERE email = ?";
				PreparedStatement pstmt2 = con.prepareStatement(SQL2);
				pstmt2.setString(1, email);
				ResultSet rst2 = pstmt2.executeQuery();
				rst2.next();
				int cid = rst2.getInt(1);
	
				
				out.println("<h3 align = 'center'>Congratulations.  You have successfully created an account with The Dinosaur Company.  Please login to continue.</h3>");
				
				String SQL_cid = "SELECT cid FROM Customer WHERE email = ?";
				PreparedStatement pstmt_cid = con.prepareStatement(SQL_cid);
				pstmt_cid.setString(1, email);
				ResultSet rst_cid = pstmt_cid.executeQuery();
				
				out.println("<h2>Please take note of your customer id: </h2>");
				while(rst_cid.next()){
					out.println(rst_cid.getString(1));
				} 
				
				out.println("<h2 align = 'center'><a href = 'login.jsp'>Login</a></h2>");
				
						
			}
			
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