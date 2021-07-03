<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.BigAuction.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Check</title>
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
		ResultSet rs;
		ResultSet admin;
		ResultSet rep;
	    rs = stmt.executeQuery("select * from users where username='" + username + "' and password='" + password + "'");
	    
	    
	    if (rs.isBeforeFirst()) {
	    	admin = con.createStatement().executeQuery("select * from users where email in (select * from admin) and username='" + username + "' and password='" + password + "'");
			rep = con.createStatement().executeQuery("select * from users where email in (select * from rep) and username='" + username + "' and password='" + password + "'");
			if(rep.isBeforeFirst()){
		    	session.setAttribute("user", username); // the username will be stored in the session
		        out.println("welcome " + username);
		        out.println("<a href='logout.jsp'>Log out</a>");
		        response.sendRedirect("CustomerRepScreen.jsp");
		    }
			else if(admin.isBeforeFirst()){
		    	session.setAttribute("user", username); // the username will be stored in the session
		        out.println("welcome " + username);
		        out.println("<a href='logout.jsp'>Log out</a>");
		        response.sendRedirect("AdminPage.jsp");
		    }
			else{
				rs = stmt.executeQuery("select email as amount from users where username='" + username + "' and password='" + password + "'");
	            rs.next();
	            email = rs.getString("amount");
	            session.setAttribute("user", username); // the username will be stored in the session
	            session.setAttribute("email", email); //the email will also be stored in the session
	            session.setAttribute("password", password); //the pw will also be stored in the session
	            out.println("welcome " + username);
	            out.println("<a href='logout.jsp'>Log out</a>");
	            response.sendRedirect("success.jsp");
	        
	    	
			}
		} else {
	    	%>
	    	Invalid Password
	    	<br>
	    	<a href='login.jsp'>try again</a>
			<input type="submit" value="Try Again" href="login.jsp">
	    	<%
	    }
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<br>login failed");
	}
%>
</body>
</html>