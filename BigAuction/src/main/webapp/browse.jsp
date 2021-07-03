<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.BigAuction.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Browse!</title>
</head>
<body>

<% 
try {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Class.forName("com.mysql.jdbc.Driver");
		Statement stmt = con.createStatement();
		ResultSet result;
		String sort = request.getParameter("sortBy");
		if(sort==null || sort.equals("itemID")) sort = "v.itemID";
		String query = "SELECT * FROM item AS v";
		query+= " INNER JOIN seller s ON v.itemID = s.itemID INNER JOIN auction a ON v.itemID = a.auctionID";
		query+= " WHERE v.itemID IN (SELECT itemID FROM itemsSold WHERE auctionID IN";
		query+= " (SELECT auctionID FROM auction WHERE valid = true)) ORDER BY " + sort;
		System.out.println(query);
	    result = stmt.executeQuery(query);
	    %>
	    <p>BEHOLD: the fine wares and goodes on sale</p>
	    <table>
		<tr>    
			<td>Name~~~~~</td>
			<td>ItemID~~~~~</td>
			<td>Seller~~~~~~~~~~~~~~~</td>
			<td>View Seller~~~~~</td>
			<td>Price~~~~~</td>
			<td>End date~~~~~</td>
			<td>View Auction</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { 
				String itemID = result.getString("itemID");%>
				<tr>    
					<td><%= result.getString("name") %></td>
					<td><%= result.getString("itemID") %></td>
					<td><%= result.getString("email") %></td>
					<td>
							<a href="viewUser.jsp?email=<%=result.getString("email")%>">View this user</a>
					</td>
					<td>
							<% 
								Statement stmt2 = con.createStatement();
								String query2 = "SELECT MAX(AMOUNT) AS amount FROM bid WHERE bidID IN ";
								query2+= " (SELECT bidID FROM bidFor WHERE itemID = " + itemID + ")";
								ResultSet result2 = stmt2.executeQuery(query2);
								result2.next();
								if(result2.getString("amount")!=null) out.write(result2.getString("amount"));
								else out.write("0");
							%>

						</td>
						<td><%= result.getString("endDate") %></td>
						<td>
							<a href="viewAuction.jsp?itemID=<%=itemID%>">View this auction</a>
						</td>
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			con.close();
			
			%>
			</table>
			<br>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				<form method="get" action="browseBy.jsp">
					<select name="vehicleCategory" size=1>
						<option value="boat">Show me boats!</option>
						<option value="car">Show me cars!</option>
						<option value="plane">Show me planes!</option>
					</select>&nbsp;<br> <input type="submit" value="GO!">
				</form>
			<br>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			<br>
			Note: you can sort by boat-, car-, and plane-specific categories by first choosing to view a vehicle type above!
			<br>
			You can also search once you select a vehicle type above.
				
				<form method="get" action="browse.jsp">
					<select name="sortBy" size=1>
						<option value="name">Sort by name</option>
						<option value="itemID">Sort by itemID</option>
						<option value="endDate">Sort by end date</option>
					</select>&nbsp;<br> <input type="submit" value="SORT!">
				</form>
				<br><br>
				<a href="success.jsp">Back to main menu</a>
				
			
			
		
	    <% 
	    
	} catch (Exception ex) {
		out.print(ex);
		out.print("<br>some kinda problem");
	}
%>








</body>
</html>