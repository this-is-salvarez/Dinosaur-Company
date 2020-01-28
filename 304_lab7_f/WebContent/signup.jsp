<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@include file = "navigation.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

<style>


 .required:after {
    color: #e32;
    content: ' *';
    display:inline;
}


* {box-sizing: border-box}

/* Full-width input fields */
  input[type=text], input[type=password] {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border: none;
  background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}

hr {
  border: 1px solid #f1f1f1;
  margin-bottom: 25px;
}

/* Set a style for all buttons */
button {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  opacity: 0.9;
}

button:hover {
  opacity:1;
}

/* Extra styles for the cancel button */
.cancelbtn {
  padding: 14px 20px;
  background-color: #f44336;
}

/* Float cancel and signup buttons and add an equal width */
.cancelbtn, .signupbtn {
  float: left;
  width: 50%;
}

/* Add padding to container elements */
.container {
  padding: 16px;
}

/* Clear floats */
.clearfix::after {
  content: "";
  clear: both;
  display: table;
}

/* Change styles for cancel button and signup button on extra small screens */
@media screen and (max-width: 300px) {
  .cancelbtn, .signupbtn {
    width: 100%;
  }
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Up</title>
</head>
<body>
<h2>. </h2>
<h1 align = "center">Sign Up</h1>



<form method="post" action="signupprocessing.jsp">
	<h2>Add User Information</h2>
			<table style="with: 50%">
				
				<tr>
					
					<td><div class = "required"><label>Name (First and Last): </label></div></td>
					<td>
						<input type="text" name="cname" required/>
					</td>
					
				</tr>
			
				<tr>
					<td><div class = "required"><label>E-mail: </label></div></td>
					<td><input type="email" name="email" required/></td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Password: </label></div></td>
					<td><input type = "password" name = "password" required/></td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Country: </label></div></td>
					<td>
					    <select name = country required>
					    	<option></option>
					    	<option value = "Canada">Canada</option>
					    </select>
					</td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Province/Territory: </label></div></td>
					<td>
						<select name = "province" required>
							<option></option>
					    	<option value = "AB">AB</option>
					    	<option value = "BC">BC</option>
					    	<option value = "MB">MB</option>
					    	<option value = "NB">NB</option>
					    	<option value = "NL">NL</option>
					    	<option value = "NS">NS</option>
					    	<option value = "NT">NT</option>
					    	<option value = "NU">NU</option>
					    	<option value = "ON">ON</option>
					    	<option value = "PE">PE</option>
					    	<option value = "SK">SK</option>
					    	<option value = "QC">QC</option>
					    	<option value = "YT">YT</option>
					    </select>
					</td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>City: </label></div></td>				
					<td><input type="text" name="city" required/></td>
				</tr>
			
				
				<tr>
					<td><div class = "required"><label>Postal Code: </label></div></td>
					<td><input type="text" name="postalCode" required/></td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Address: </label></div></td>
					<td><input type="text" name="address" required/></td>
				</tr>
				
				<tr>
					<td><div><label>Phone Number: </label></div></td>
					<td><input type="text" name="phone" /></td>
				</tr>
				
				<!-- <tr>
					<td><div class = "required"><label>Security Question: </label></div></td>
					<td>
						<select name = "question" required>
							<option></option>
					    	<option value = "1">Who was your grade one teacher?</option>
					    	<option value = "2">What was the name of your first pet?</option>
					    	<option value = "3">What was the name of your childhood best friend?</option>
				    	</select>
					</td>
				</tr> -->
				
				<tr>
					<td><div class = "required"><label>Security Question: </label></div></td>
					<td><input type="text" name="question" /></td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Answer: </label></div></td>
					<td><input type="text" name="answer" /></td>
				</tr>
				
			
				
		</table>
			<input type="submit" value="Submit" /></form>
			
</body>
</html>