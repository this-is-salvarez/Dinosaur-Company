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


</head><head>
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
<title>Add Dinosaur</title>
</head>
<body>

<h1 align = "center">Add Dinosaur</h1>



<form method="post" action="addProductProcessing.jsp">
	<h2>Add Dinosaur Information</h2>
			<table style="with: 50%">
				<col width = "250">
				<col width = "300">
				
				<tr>
					<td><div class = "required"><label>Name: </label></div></td>
					<td>
						<input type="text" name="dname" required/>
					</td>
				</tr>
			
				<tr>
					<td><div class = "required"><label>Weight (in kg): </label></div></td>
					<td><input type="text" name="weight" required/></td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Price: </label></div></td>
					<td><input type = "text" name = "price" required/></td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Age: </label></div></td>
					<td><input type = "text" name = "age" required/></td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Gender: </label></div></td>
					<td>
					    <select name = gender required>
					    	<option></option>
					    	<option value = "male">Male</option>
					    	<option value = "female">Female</option>
					    </select>
					</td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Species: </label></div></td>
					<td>
						<select name = "species" required>
							<option></option>
					    	<option value = "Tyrannosaurus Rex">Tyrannosaurus Rex</option>
					    	<option value = "Brontosaurus">Brontosaurus</option>
					    	<option value = "Plesiosaurus">Plesiosaurus</option>
					    	<option value = "Stegosaurus">Stegosaurus</option>
					    	<option value = "Velociraptor">Velociraptor</option>
					    	<option value = "Pachycephalosaurus">Pachycephalosaurus</option>
					    	<option value = "Suzhousaurus">Suzhousaurus</option>
					    </select>
					</td>
				</tr>
				
				<tr>
					<td><div class = "required"><label>Park Id: </label></div></td>
					<td>
						<select size="1" name="pid">
							<option selected disabled>Search by Park ID:</option>
							<option value ="1">1 (Jurassic-Mania)</option>
							<option value ="2">2 (Marine Dinos)</option>
							<option value ="3">3 (Cretaceousness)</option>
							<option value ="4">3 (Triassical)</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td><div><label>About Me: </label></div></td>
					<td><input type = "text" name = "aboutMe"/></td>
				</tr>
				
				<tr>
					<td colspan ="100%">
						<li>Instructions for importing a picture:</li>
						<ol>
							<li>Take a great picture that captures this dino's personality!</li>
							<li>Save the image you wish to use into the image folder using either a jpg or png extension. Make sure the name you use to save the picture is unique.</li>
							<li>In the below text field, enter in the name of the image you saved, including the extension.</li>
						</ol>
					</td>
				</tr>
				
				<tr>
					<td><div><label>Name Picture Saved As: </label></div></td>
					<td><input type = "text" name = "pictureName"/></td>
				</tr>
				
				
				
				
				<!-- available will always be true when a Dinnosaur is first entered -->
				
		</table>
			<input type="submit" value="Submit" /></form>
			
</body>
</html>