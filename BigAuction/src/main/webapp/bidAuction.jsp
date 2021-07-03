<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.BigAuction.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
	<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bid in auction</title>
</head>

<body style="background-color:bisque;">
	

	<h1 style="font-size:40px"> Bid in your auction</h1>
	
	<% 
	String itemID = request.getParameter("itemID");
	 
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt2 = con.createStatement();
    String query2 = "SELECT MAX(AMOUNT) AS amount FROM bid WHERE bidID IN ";
    query2+= " (SELECT bidID FROM bidFor WHERE itemID = " + itemID + ")";
    ResultSet result2 = stmt2.executeQuery(query2);
    result2.next();
    if(result2.getString("amount")!=null) out.write("Highest current bid:" + result2.getString("amount"));
    else out.write("No bids yet. Be the first!"); 
    %>
	
	<h1>Bid (Manual)</h1>
<form method="post" action="createBid.jsp?itemID=<%=itemID%>">
    <table>
        <tr><td>Bid your amount</td></tr>
        <tr><td><input type="text" name="bid"></td></tr>
    </table>
    <input type="submit" value="Post Your Bid">
</form>
<br>
<h1>Bid (Automatic)</h1>
<form method="post" action="createBidAuto.jsp">
    <table>
        <tr><td>Bid your amount</td></tr>
        <tr><td><input type="text" name="bid"></td></tr>
        <tr><td>Bid increment</td></tr>
        <tr><td><input type="text" name="increment"></td></tr>
        <tr><td>Upper limit</td></tr>
        <tr><td><input type="password" name="limit"></td></tr>
    </table>
    <input type="submit" value="Post Your Auto Bid">
</form>

</body>
</html>