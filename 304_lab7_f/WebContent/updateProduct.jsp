<%@ page import="java.sql.*,java.net.URLEncoder"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
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

<title>Update Dino</title>
</head>
<body>
<h1>.</h1>
	<h1 align="center">Add Dinosaur</h1>



	<form method="post" action="updateProductProcessing.jsp">
		<h2>Update Dinosaur Information</h2>
		<h3>Fill in the fields you wish to update</h3>
		<table style="with: 50%">
			<col width="250">
			<col width="300">

			<tr>
				<td><div>
						<label>Name: </label>
					</div></td>
				<td><input type="text" class="form-control" name="dname"/></td>
			</tr>

			<tr>
				<td><div>
						<label>Weight (in kg): </label>
					</div></td>
				<td><input type="text" class="form-control" name="weight"/></td>
			</tr>

			<tr>
				<td><div>
						<label>Price: </label>
					</div></td>
				<td><input type="text" class="form-control" name="price" /></td>
			</tr>

			<tr>
				<td><div>
						<label>Age: </label>
					</div></td>
				<td><input type="text" class="form-control" name="age" /></td>
			</tr>

			<tr>
				<td><div>
						<label>Gender: </label>
					</div></td>
				<td><select name=gender>
						<option selected disabled></option>
						<option value="male">Male</option>
						<option value="female">Female</option>
				</select></td>
			</tr>

			<tr>
				<td><div><label>Species: </label>
				</div></td>
				<td><select name="species">
						<option selected disabled></option>
						<option value="Tyrannosaurus Rex">Tyrannosaurus Rex</option>
						<option value="Brontosaurus">Brontosaurus</option>
						<option value="Plesiosaurus">Plesiosaurus</option>
						<option value="Stegosaurus">Stegosaurus</option>
						<option value="Velociraptor">Velociraptor</option>
						<option value="Pachycephalosaurus">Pachycephalosaurus</option>
						<option value="Suzhousaurus">Suzhousaurus</option>
				</select></td>
			</tr>

			<tr>
				<td><div>
						<label>Park: </label>
					</div></td><td>
				<select name="pid">
					<option selected disabled></option>
					<option value="1">1 (Jurassic-Mania)</option>
					<option value="2">2 (Marine Dinos)</option>
					<option value="3">3 (Cretaceousness)</option>
					<option value="4">3 (Triassical)</option>
				</select>
				</td>
			</tr>

			<tr>
				<td><div>
						<label>About Me: </label>
					</div></td>
				<td><input type="text" class="form-control" name="aboutMe" /></td>
			</tr>

			<tr>
					<td colspan="100%">
						<li>Instructions for importing a picture:</li>
						<ol>
							<li>Take a great picture that captures this dino's personality!</li>
							<li>Save the image you wish to use into the image folder using either a jpg or png extension. Make sure the name you use to save the picture is unique.</li>
							<li>In the below text field, enter in the name of the image you saved, including the extension.</li>
						</ol>
					</td>
				</tr>
				
				<tr>
					<td><div>
						<label>Name Picture Saved As: </label>
					</div></td>
					<td><input type="text" class="form-control" name="pictureName" /></td>
				</tr>
				
				
				
				
				<!-- available will always be true when a Dinnosaur is first entered -->

			</table>
			<input type="submit" value="Submit" />
	</form>
			<%
			String did = request.getParameter("did");
			session.setAttribute("did_updateDino", did);
			%>
			
</body>
</html>