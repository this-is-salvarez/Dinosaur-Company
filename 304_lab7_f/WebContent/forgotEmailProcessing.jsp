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


</head>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>The Dinosaur Store's Sign Up Processing </title>
</head>
<body>
<h2>. </h2>
<h1>Forgot your email</h1>

<%
		// Retrieve security question, forgotpasswordcid
		int fpcid;
		if (request.getParameter("cid") == null){
			fpcid = (Integer) session.getAttribute("cid_forgotPassword");
		}else{
		 	fpcid = Integer.parseInt(request.getParameter("cid"));
			session.setAttribute("cid_forgotPassword", fpcid);
		}
		String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
		String uid = "salvarez";
		String pw = "24165152";
	try(Connection con = DriverManager.getConnection(url, uid, pw);){
			String SQL = "SELECT secQuestion FROM Customer WHERE cid = ?";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1,fpcid);
			ResultSet rst = pstmt.executeQuery();
			if(rst.next() == false){
				//how to add a text that says, incorrect cid??
				String redirectURL = "forgotPassword.jsp";
			    response.sendRedirect(redirectURL);
			}else{
				session.setAttribute("cid_ForgotPassword", fpcid);
				rst = pstmt.executeQuery();
				rst.next();
				out.println(rst.getString(1));
			}
		}
		catch(SQLException e1){
			out.println("SQL Exception thrown: " + e1);
		}
		
	%>
<form method="post" action="forgotEmailProcessing2.jsp">
			<table style="with: 50%">
				<tr>
					<td><div class = "required"><label>Answer: </label></div></td>
					<td>
						<input type="text" name="securityAnswer" required/>
					</td>
				</tr>	
		</table>
			<input type="submit" value="Submit" /></form>
</body>
</html>