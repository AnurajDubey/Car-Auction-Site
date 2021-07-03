<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.BigAuction.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Start Page</title>
	</head>
	
	<body>
		<style>
			input[type="text"], input[type="password"] {
			  width: 100%;
			  padding: 4px 4px;
			  margin: 4px 0;
			  box-sizing: border-box;
			  border: 2px solid #111;
			  background-color: #2D2D2D;
  			  color: white;
			  outline: none;
			}
			body {background-color: coral;}
		</style>
		<h1>Login</h1>
		<form method="post" action="checkLogin.jsp">
			<table>
				<tr><td>Username</td></tr>
				<tr><td><input type="text" name="username"></td></tr>
				<tr><td>Password</td></tr>
				<tr><td><input type="password" name="password"></td></tr>
			</table>
			<input type="submit" value="Login">
		</form>
		<br>
		<h1>New User</h1>
		<form method="post" action="createAccount.jsp">
			<table>
				<tr><td>Email</td></tr>
				<tr><td><input type="text" name="email"></td></tr>
				<tr><td>Username</td></tr>
				<tr><td><input type="text" name="username"></td></tr>
				<tr><td>Password</td></tr>
				<tr><td><input type="password" name="password"></td></tr>
			</table>
			<input type="submit" value="Create Account">
		</form>
	<br>

</body>
</html>