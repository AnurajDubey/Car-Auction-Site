<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.BigAuction.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Account</title>
</head>
<body>
	<%
	try {
		//Get parameters from the HTML form at login.jsp
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Class.forName("com.mysql.jdbc.Driver");
		Statement stmt = con.createStatement();
		ResultSet rs1, rs2;
	    boolean failed = false;
	    rs1 = stmt.executeQuery("SELECT * FROM users WHERE email='" + email + "'");
	    if (rs1.isBeforeFirst()) {
	    	%>
	    	Duplicate email in database
	    	<br>
	    	<a href='login.jsp'>Try Again</a>
	    	<%
	    	failed = true;
	    }
	    rs2 = stmt.executeQuery("SELECT * FROM users WHERE username='" + username + "'");
	    if (!failed && rs2.isBeforeFirst()) {
	    	%>
	    	Duplicate username in database
	    	<br>
	    	<a href='login.jsp'>Try Again</a>
	    	<%
	    	failed = true;
	    }
	    if (!failed) {
		    stmt.executeUpdate("INSERT INTO users(email, username, password) VALUES('" + email + "','" + username + "','" + password + "')");
	        session.setAttribute("user", username); // the username will be stored in the session
	        session.setAttribute("email", email); 
	        session.setAttribute("password", password); 
	        out.println("welcome " + username);
	        out.println("<a href='logout.jsp'>Log out</a>");
	        response.sendRedirect("success.jsp");
	        failed = false;
	    }
// 		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
// 		con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<br>account creation failed");
	}
	%>
</body>
</html>