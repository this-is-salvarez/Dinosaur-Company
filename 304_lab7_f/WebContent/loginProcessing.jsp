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

<title>The Dinosaur Login Processing Page</title>
</head>
<body>
<h2>. </h2>
	<%
		// Get customer id and password
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String adminLogin = request.getParameter("adminLogin");

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
		String uid = "salvarez";
		String pw = "24165152";

		try(Connection con = DriverManager.getConnection(url, uid, pw);){

		// validate id
		String SQLTRY2 = "SELECT * FROM Customer WHERE email = ?";
		PreparedStatement pstmtTRY = con.prepareStatement(SQLTRY2);
		pstmtTRY.setString(1, email);
		ResultSet rstTry2 = pstmtTRY.executeQuery();
		
		
		
		//check if the email query returns nothing 
		//if nothing is returned print out an error message and ask them to sign in.  
		if(!rstTry2.next()){
			out.println("<h1>Oops....</h1>");
			out.println("<h3>Invalid username or non-existing user.  Please try again by clicking login or create an account with us by clicking sign up.<h3>");
			out.println("<h2 align = 'center'><a href = 'login.jsp'>Login</a></h2>");
			out.println("<h2 align = 'center'><a href = 'signup.jsp'>Signup</a></h2>");
		}
		
		else{
			String queriedPass = rstTry2.getString(3);
			if(!password.equals(queriedPass)){
				out.println("<h1>Oops...</h1>");
				out.println("<h3>Invalid password.  Please try again.</h3>");
				out.println("<h2 align = 'center'><a href = 'login.jsp'>Login</a></h2>");
			}
			else{
				//the password was valid so save the data in a session var 
				//if they logged in as admin, make sure they are set up in the database as an admin.  
				String cid = Integer.toString(rstTry2.getInt("cid"));

				if(adminLogin.equals("true")){
					//check if the user is actually an admin 
					boolean queriedAdmin = rstTry2.getBoolean("admin");
					String cname = rstTry2.getString("cname");
					if(queriedAdmin == true){
						session.setAttribute("customerId_InternalUse", cid);
						session.setAttribute("email", email);
						session.setAttribute("password_InternalUse", password);
						session.setAttribute("admin", true);
						session.setAttribute("login", true);
						session.setAttribute("cname", cname);
						out.println("<h2>. </h2>");
						out.println("<h2 align= 'center'><a href = 'shop.jsp'>Admin Home Page</a></h2>");
						String redirectURL = "shop.jsp";
					    response.sendRedirect(redirectURL);
							
					}
					else{
						out.println("<h1>Oops...</h1>");
						out.println("<h3>You do not have admin access.  Please try again with the proper credentials.</h3>");
						out.println("<h2 align = 'center'><a href = 'login.jsp'>Login</a></h2>");
					}
				}
				//else procede to normal page. 
				else{
					String cname = rstTry2.getString("cname");
					session.setAttribute("customerId_InternalUse", cid);
					session.setAttribute("cname", cname);
					session.setAttribute("email", email);
					session.setAttribute("password_InternalUse", password);
					session.setAttribute("Admin", adminLogin);
					session.setAttribute("login", true);
					out.println("<h2>. </h2>");
					out.println("<h2 align= 'center'><a href = 'listprod.jsp'>Begin Shopping</a></h2>");
					String redirectURL = "shop.jsp";
				    response.sendRedirect(redirectURL);
				}
			}
		}
		
		
			
		
		}catch(Exception e){
			
		}
		
		
		
	%>