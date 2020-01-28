<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
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
<h2>.</h2>
<title>Your Shopping Cart</title>
</head>
<style>
body{
	front-size: 15pt;
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
<body>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
String dname = "";

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	out.println("<h2>. </h2>");
	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table border='3' CELLPADDING='4' CELLSPACING='3'><tr><th>Dino ID</th><th>Dinosaur Name</th>");
	out.println("<th>Price</th><th></th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 3)
		{
			out.println("Expected product with three entries. Got: "+product);
			continue;
		}
		
		dname = (String)product.get(1);
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+dname+"</td>");

		//out.print("<td align=\"center\">"+product.get(3)+"</td>");
		String price = (String)product.get(2);
		Double pr = 0.0;
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		
		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td><td><a href='deleteFromCart.jsp?id=" +product.get(0)+ "&dname=" +URLEncoder.encode(dname, "UTF-8")+"'>Delete From Cart</a></td>");
		out.println("</tr>");
		total = total +pr;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.println("<h2><a href=\"selectPaymentMethod.jsp\">Check Out</a></h2>");
}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html> 

