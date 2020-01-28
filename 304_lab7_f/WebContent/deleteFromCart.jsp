<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete From Cart</title>
</head>
<body>
<%
String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
String uid = "salvarez";
String pw = "24165152";
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
		String id = request.getParameter("id");
		String dname = request.getParameter("dname");
		
		try(Connection con = DriverManager.getConnection(url, uid, pw);){
			productList.remove(id);
			out.println("Deleted from cart: " + dname);
		} catch (Exception e){
			
		}
		%>
		<h2 align="center"><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html>