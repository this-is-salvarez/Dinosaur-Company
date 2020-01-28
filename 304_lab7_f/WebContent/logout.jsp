<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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


</head><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>You logged out</title>
</head>
<body>
<% 
session.setAttribute("customerId_InternalUse", "no_user");
session.setAttribute("login", false);
session.setAttribute("admin", false);
String redirectURL = "shop.jsp";
response.sendRedirect(redirectURL);
%>
</body>
<h2>. </h2>
<h2 align="center"><a href="shop.jsp">Go Home</a></h2>

</html>
