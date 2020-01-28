<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thank you!</title>
</head>
<body>
<h2>.</h2>
<h2>We are processing your review!</h2>
<%
String message = request.getParameter("message");
String cid = (String) session.getAttribute("customerId_InternalUse");
String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_salvarez";
String uid = "salvarez";
String pw = "24165152";

try(Connection con = DriverManager.getConnection(url, uid, pw);){
	String SQL = "INSERT INTO Review VALUES (?, ?)";
	PreparedStatement pstmt = con.prepareStatement(SQL);
	pstmt.setInt(1, Integer.valueOf(cid));
	pstmt.setString(2, message);
	pstmt.execute();
	String redirectURL = "shop.jsp";
    response.sendRedirect(redirectURL);
}
%>
</body>
</html>