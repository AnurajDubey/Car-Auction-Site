<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.BigAuction.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Page</title>
<style>
    ul li { margin-bottom: 20px; }
</style>
</head>

<body style="background-color:bisque;">

 
	 

	
	<%
    	if ((session.getAttribute("user") == null)) {
	%>
		You are not logged in<br/>
		<a href="login.jsp">Please Login</a>
	<%	} else {
	%>
		<h1 style="font-size:40px"> Welcome <%=session.getAttribute("user")%>!</h1>
		
		<!--&nbsp;  -->
		

		
		<h1>Browse Questions:</h1>
		
         <form method="post" action="BrowseQuestions.jsp">
         		Enter keyword to search. For all leave blank:
				<input type="text" name="command">
				<br>
         </form>
         <br><br>
          <h1>Add Answer:</h1>
		
		 

         <form method="post">
				Question ID
				<input type="text" name="qID">
				<br>
				Answer to submit
				<input type="text" name="answer">
				<br>
				<input type="submit" value="Submit">
				<br>
				<li> <a href='logout.jsp'>Log out</a> </li>
		</form>
         
         
         <%
         
         ApplicationDB db = new ApplicationDB();
		 Connection con = db.getConnection();
         String theAnswer = request.getParameter("answer");
         String theqID = request.getParameter("qID");
         

         String str = "update questions set answer = '" + theAnswer + "' WHERE qID=" + theqID + "";
         con.createStatement().executeUpdate(str);
         
         con.close();
         
         %>
         
         

         
	<%
	    }
	%>
</body>
</html>