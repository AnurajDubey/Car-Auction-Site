<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.BigAuction.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Admin Page</title>
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
		<h1>New Customer Representative</h1>
		<form method="post" action="CreateCustomerRepAccount.jsp">
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
		<h1>Generate Sales Report:</h1>
		
         <form method="post" action="SalesReport.jsp">
         <!--  bid(amount) order by value, confirm date passed (auction -> end date), display connecting itemID from bidFor: -->
          <input type="radio" name="command" value="item"/>Earnings per item
          <br>
          <!--  select all boats(select * from item i INNER JOIN boat b ON i.itemID = b.itemID WHere): -->
          <!--  connect to bidFor, use item ID to calculate amount (check if passed), return amount by type: -->
          <input type="radio" name="command" value="type"/>Earnings per item type
          <br>
          <!-- grab email from user table, match to buyer, get itemID from buyer, match to auction id to check end date  -->
          <!-- use itemID, match from bidFor to bidID, order by amount  -->
          <input type="radio" name="command" value="user"/>Earnings per End-User
          <br>
          <!--  same query as earnings per item type, return only the highest number -->
          <input type="radio" name="command" value="best selling items"/>Best Selling Items
          <br>
          <!--  return top 5 from end-user query -->
          <input type="radio" name="command" value="best buyer"/>Best Buyers
          <br>
          <br>
          <input type="submit" value="submit" />
          <br>
          <li> <a href='logout.jsp'>Log out</a> </li>
        </form>
        <br>
	
</body>
</html>