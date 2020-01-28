<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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

</head>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<h2>.</h2>
<h1 align="center">Select a payment method</h1>
<h1></h1>
</head>
<body>
<%
//QUESTION! Do we check credit card expiry dates?
String cid  = String.valueOf(session.getAttribute("customerId_InternalUse"));
String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
String uid = "salvarez";
String pw = "24165152";

try (Connection con = DriverManager.getConnection(url, uid, pw);)
{
	//Check if the user has a payment method already for both Credit card and paypal
	List <String> paymentOptions = new ArrayList<>();
	String SQLCC = "SELECT cnum FROM CreditCard WHERE cid = ?";
	PreparedStatement pstmtCC = con.prepareStatement(SQLCC);
	pstmtCC.setString(1, cid);
	ResultSet rstCC = pstmtCC.executeQuery();
	if(rstCC.next() == true){
		rstCC = pstmtCC.executeQuery();
		while (rstCC.next()){
			paymentOptions.add("Credit Card - " + rstCC.getString(1));
		}
	}
	String SQLPP = "SELECT account FROM PayPal WHERE cid = ?";
	PreparedStatement pstmtPP = con.prepareStatement(SQLPP);
	pstmtPP.setString(1, cid);
	ResultSet rstPP = pstmtPP.executeQuery();
	if(rstPP.next() == true){
		rstPP = pstmtPP.executeQuery();
		while (rstPP.next()){
			paymentOptions.add("PayPal - " + rstPP.getString(1));
		}
	}
	
	if(paymentOptions.isEmpty()){
		out.println("No payments");
		//FIX THIS, THEY SHOULD PICK A CC OR PP
		String redirectURL = "addCC.jsp";
	    response.sendRedirect(redirectURL);
	} else{
		out.println("<select name = 'payment'>");
		for(int i = 0; i < paymentOptions.size(); i++){
			out.print("<option>" + paymentOptions.get(i)+ "</option>"); 
		}
		out.println("</select>");
	} 


}catch(Exception e){
	out.println(e);
}
%>
<form method="get" action="shipment.jsp">
<input type="submit" value="Submit">
</form>
<form method="get" action="addCC.jsp">
<input type="submit" value="Add a New Credit Card">
</form>
<form method="get" action="addPP.jsp">
<input type="submit" value="Add a Pay Pal Account">
</form>
<p id="demo"></p>
</body>
</html>