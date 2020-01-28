<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@include file = "navigation.jsp"%>

<!DOCTYPE html>

<html>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<head>
<link href = "navigation.css" rel = "stylesheet" type = "text/css">

<title>Dino Catalogue</title>

<style>

#cartb{
float: right;
 

}
#title{
margin-top: 40px;
}


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






</style>


</head>
<body>

<script>
$(document).ready(function(){
    $('[data-toggle="popover"]').popover(); 
});
</script>
<div class="page-header">
<h2>.</h2>
<h1 id="title">Search for a dinosaur by name:</h1>
</div>



<form method="get" action="listprod.jsp">



<select size="1" name="era">
  <option selected disabled>Search by Era:</option>
  <option>Triassic</option>
  <option>Jurassic</option>
  <option>Cretaceous</option>
</select>



<select size="1" name="species">
  <option selected disabled>Search by Species:</option>
  <option>Tyrannosaurus Rex</option>
  <option>Triceratops</option>
  <option>Velociraptor</option>
  <option>Stegosaurus</option>
  <option>Brontosaurus</option>
  <option>Plesiosaurus</option>
  <option>Pachycephalosaurus</option>
  <option>Suzhousaurus</option>
  </select>

  
<select size="1" name="gender">
 <option selected disabled>Search by Gender:</option>
 <option>female</option>
 <option>male</option>
</select>


<h1></h1>

<div class="d-flex">
 <input type="text" class="form-control" id="usr" name="dinoName" placeholder="Leave blank for all dinosaurs..." id="seachfield">

<input type="submit" value="Submit" class="btn btn-success" id="subbutton">  

 </div>

</form>




<%// Get product name to search for

String dinoName = request.getParameter("dinoName");
String gender = request.getParameter("gender");
String species = request.getParameter("species");
String era = request.getParameter("era");

PreparedStatement pstmt = null;
ResultSet rst = null;
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
String uid = "salvarez";
String pw = "24165152";

try(Connection con = DriverManager.getConnection(url, uid, pw);){
	

	String SQL = "SELECT S.era,D.speciesName,D.dname,D.age,D.gender,D.price,D.did,S.speciesDescription,D.picture From Dinosaur D,Species S WHERE D.speciesName=S.speciesName AND D.available=?";
	
	boolean hasName = dinoName!=null;
	boolean hasG = gender!=null;
	boolean hasS = species != null;
	boolean hasE = era != null;

	if(hasName){
		dinoName=dinoName.trim(); //removes white spaces from search
		if(dinoName.equals("")){ //if search only contains whitespaces, we set hasName to false
			hasName=false;
		}
	}
	
	
	
	String search=dinoName;
	if(search==null){
		search="";

	}else{
		 search= search.replaceAll(" ", "");

	}
	
	
	
	String nSQL,gSQL,sSQL,eSQL = "";
	int psCount = 1;
	
	if(hasName){
		dinoName = "%"+dinoName+"%";
		nSQL = " AND D.dname LIKE ?";
		SQL+=nSQL;
	}
	
	if(hasG){
		gSQL = " AND D.gender=?";
		SQL+=gSQL;
	}
	
	if(hasS){
		sSQL = " AND D.speciesName=?";
		SQL+=sSQL;
	}
	
	if(hasE){
		eSQL = " AND S.era=?";
		SQL+=eSQL;
	}
	
	pstmt=con.prepareStatement(SQL);
	pstmt.setInt(psCount, 1);
	psCount++;
	
	if(hasName){
		pstmt.setString(psCount, dinoName);
		psCount++;
	}
	
	if(hasG){
		pstmt.setString(psCount, gender);
		psCount++;
	}
	
	if(hasS){
		pstmt.setString(psCount, species);
		psCount++;
	}
	
	if(hasE){
		pstmt.setString(psCount, era);
		psCount++;
	}
	
	rst=pstmt.executeQuery();

    out.println("<h2>Search Results: "+ search+"</h2>");
	
	out.println("<table border='1' frame=void rules=rows CELLPADDING='4' CELLSPACING='3' style = 'border-collapse: collapse;'><tr><th>View</th><th>Era</th><th>Species</th><th>Name</th><th>Age</th><th>Gender</th><th>Price</th><th>Picture</th>");
	if ((boolean)session.getAttribute("admin") == true)
		out.println("<th>Update</th><th>Delete</th>");
	out.println("</tr>");
	
	// fill in table.
	while (rst.next()) {		
		out.println("<tr><td><a href='viewDino.jsp?id="+rst.getInt(7)+"&name="+rst.getString(3)+"&price="+rst.getString(6)+"'>View Dinosaur</a></td><td>"+rst.getString(1)+"</td><td><a href='#' style='color:#0B6121' title='Species Description' data-toggle='popover' data-trigger='hover' data-content='"+rst.getString(8)+"'>"+rst.getString(2)+"</a></td><td>"+rst.getString(3)+"</td><td>"+rst.getString(4)+"</td><td>"+rst.getString(5)+"</td><td>" +currFormat.format(rst.getDouble(6))+"</td><td><img  src='"+rst.getString(9)+"'; style='width:180px;height:80px  class = 'img-rounded'''</td>"); 
		// if admin, allow for delete/update products
		if ((boolean)session.getAttribute("admin") == true)
			out.println("<td><a href ='updateProduct.jsp?did=" + rst.getInt(7) +"'>Update</a></td><td><a href ='deleteProduct.jsp?did=" + rst.getInt(7) +"'>Delete</a></td>");
	}
	out.println("</tr></table></body></html>");	
	
}
	catch(SQLException e){
		out.println(e);
	}

	

//Note: Forces loading of SQL Server driver

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=<productId>&name=<productName>&price=<productPrice>
// Note: As some product names contain special characters, need to encode URL parameter for product name like this: URLEncoder.encode(productName, "Windows-1252")
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>