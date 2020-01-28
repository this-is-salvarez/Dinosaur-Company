<html>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<head>

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
<h1 align = "center">Login</h1>

<form method="post" action="loginProcessing.jsp">
			<table style="with: 50%">
				<tr>
					<td><div class = "required"><label>Username (E-mail): </label></div></td>
					<td><input type="email" name="email" required/></td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Password: </label></div></td>
					<td><input type = "password" name = "password" required/></td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Type of User: </label></div></td>
					<td><input type = "radio" name = "adminLogin" value = "false" checked = "checked">Customer<br></td>
					<td><input type = "radio" name = "adminLogin" value = "true">Admin<br></td>			
				</tr>
				
		</table>
			<input type="submit" value="Submit" /></form>
<h1> </h1>

<form method="get" action="forgotPassword.jsp">
<input type="submit" value="Forgot Password?">
</form>
<form method="get" action="forgotEmail.jsp">
<input type="submit" value="Forgot Email?">
</form>


</body>
</html>
