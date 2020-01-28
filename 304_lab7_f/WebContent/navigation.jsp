<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>

 <%
try{
	boolean login = (boolean) session.getAttribute("login");
	boolean admin = (boolean) session.getAttribute("admin");
	String cname2 = (String) session.getAttribute("cname");
	
	String email = (String) session.getAttribute("customerId_InternalUse");
	
	
	String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
	String uid = "salvarez";
	String pw = "24165152";
	

%>
	<ul id = "nav">
 	<!-- What should be in the navigation bar no matter what -->
 	<li><a href = "shop.jsp">Home</a></li>
	<li><a href = "about_us.jsp">About/Contact Us</a></li>
	<li><a href = "viewReview.jsp">View Customer Reviews</a></li>
	
 	<% 
 	//out.println(login);
 	//out.println(admin);
 	if(login == true){
		if(admin == true){
 	%>
 		 <!-- What should be in the navigation bar if the user is logged in as an admin -->
 		<li><a href = "listprod.jsp">List Products</a>
 		<li><a href = "addProduct.jsp">Add a Product</a> 
 		<li><a href = "AdminQuery.jsp">View Data</a><li>
 		<li><a href = "adminShipmentStatus.jsp">List Shipments</a><li>
		<li style = "float:right"><a class = "active" href = "logout.jsp">Logout</a></li>
		<li style = "float:right"><a class = "active" href = showcart.jsp>View Cart</a></li>
		
 		<li style = "float:right" id = "navName"><font color = "white"><%out.println("Hello, " + cname2);%></font></li>
 	<% 
 		} 
		else{
			%>
			<!-- What should be in the navigation bar if the user is logged in as a customer -->
			<li><a href = "listprod.jsp">List Products</a></li>
			<li><a href = "listorder.jsp">List Orders</a><li>
			<li style = "float:right"><a class = "active" href = "logout.jsp">Logout</a></li>
			<li style = "float:right"><a class = "active" href = showcart.jsp>View Cart</a></li>
			<li style = "float:right" id = "navName"><font color = "white"><%out.println("Hello, " + cname2);%></font></li>
			
		<%	
		}
 	}
 	else{ 
 	%>
 		<!-- What should be in the navigation bar if the user is not logged in -->
 		<li><a href = "listprod.jsp">List Products</a></li>
 		<li style = "float:right"><a class = "active" href = "login.jsp">Login</a></li>
		<li style = "float:right"><a class = "active" href = "signup.jsp">Sign Up</a></li>
 	<%
 	} 
 	%>
 </ul>
<% 
}
catch(NullPointerException e){
	session.setAttribute("login", false);
	session.setAttribute("admin", false);
	session.setAttribute("customerId_InternalUse", null);
	session.setAttribute("cname", null);
	
	boolean login = (boolean) session.getAttribute("login");
	boolean admin = (boolean) session.getAttribute("admin");
	
	
	//String cname = (String) session.getAttribute("customerId_InternalUse");

	%>
	
	<ul id = "nav">
 	<!-- What should be in the navigation bar no matter what -->
 	<li><a href = "shop.jsp">Home</a></li>
	<li><a href = "about_us.jsp">About/Contact Us</a></li>
 	<% 
 	//out.println(login);
 	//out.println(admin);
 	if(login == true){
		if(admin == true){
 	%>
 		 <!-- What should be in the navigation bar if the user is logged in as an admin -->
 		<li><a href = "listprod.jsp">List Products</a>
 		<li><a href = "addProduct.jsp">Add a Product</a> 
 		<li><a href = "AdminQuery.jsp">View Data</a><li>
 		<li><a href = "adminShipmentStatus.jsp">List Shipments</a><li>
 	
 		
		<li style = "float:right">< class = "active" href = "logout.jsp">Logout</a></li>
		<li style = "float:right"><a class = "active" href = showcart.jsp>View Cart</a></li>
		
		<%-- <li style = "float:right"><a><%out.println("Hello, " + cname2);%></a></li> --%>
 	
 	<% 
 		} 
		else{
			%>
			<!-- What should be in the navigation bar if the user is logged in as a customer -->
			<li><a href = "listprod.jsp">List Products</a></li>
			<li><a href = "listorder.jsp">List Orders</a><li> 
			
			
			<li style = "float:right"><a class = "active" href = "logout.jsp">Logout</a></li>
			<li style = "float:right" id = "navName"><a class = "active" href = showcart.jsp>View Cart</a>
			<%-- <li style = "float:right"><a><%out.println("Hello, " + cname2);%></a></li> --%>
			
			
		<%	
		}
 	}
 	else{ 
 	%>
 		<!-- What should be in the navigation bar if the user is not logged in -->
 		<li><a href = "listprod.jsp">List Products</a></li>
 		
 		<li style = "float:right"><a class = "active" href = "login.jsp">Login</a></li>
		<li style = "float:right"><a class = "active" href = "signup.jsp">Sign Up</a></li>
			
 	<%
 	}
 	
 	%>
 </ul>
	
<%	
}
/* catch(SQLException e1){
	out.println("SQL Exception: " + e1);
} */
catch(Exception e2){
	out.println("Exception: " + e2);
}
%>