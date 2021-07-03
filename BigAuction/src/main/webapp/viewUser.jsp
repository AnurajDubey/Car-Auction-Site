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
		
		String email = request.getParameter("email");
		String query1 = "SELECT * FROM item i INNER JOIN seller s ON s.itemID = i.itemID INNER JOIN auction a ON i.itemID = a.auctionID WHERE s.email = '" + email + "'";
		System.out.println(query1);
	    result = stmt.executeQuery(query1);
	    %>
	    <p>Behold, the history of the user <%=email %></p>
	    <br>
	    <p>Auctions in as seller:</p>
	    <table>
		<tr>
			<td>Name~~~~~</td>
			<td>ItemID~~~~~</td>
			<td>Price~~~~~</td>
			<td>End date~~~~~</td>
			<td>View Auction</td>   

		</tr>
			<%while (result.next()) { 
				String itemID = result.getString("itemID");%>
				<tr>    
					<td><%= result.getString("name") %></td>
					<td><%= result.getString("itemID") %></td>
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
			
			%>
		</table>
		<br>
		
		<%ResultSet result3;
		
		String query3 = "SELECT * FROM item i INNER JOIN buyer b ON b.itemID = i.itemID INNER JOIN auction a ON i.itemID = a.auctionID WHERE b.email = '" + email + "'";
		System.out.println(query3);
	    result3 = stmt.executeQuery(query3);
	    %>
	    <br>
	    <p>Auctions in as buyer:</p>
	    <table>
		<tr>
			<td>Name~~~~~</td>
			<td>ItemID~~~~~</td>
			<td>Price~~~~~</td>
			<td>End date~~~~~</td>
			<td>View Auction</td>   

		</tr>
			<%while (result3.next()) { 
				String itemID = result3.getString("itemID");%>
				<tr>    
					<td><%= result3.getString("name") %></td>
					<td><%= result3.getString("itemID") %></td>
					<td>
							<% 
								Statement stmt2 = con.createStatement();
								String query4 = "SELECT MAX(AMOUNT) AS amount FROM bid WHERE bidID IN ";
								query4+= " (SELECT bidID FROM bidFor WHERE itemID = " + itemID + ")";
								ResultSet result4 = stmt2.executeQuery(query4);
								result4.next();
								out.write(result4.getString("amount"));
							%>

						</td>
						<td><%= result3.getString("endDate") %></td>
						<td>
							<a href="viewAuction.jsp?itemID=<%=itemID%>">View this auction</a>
						</td>
				</tr>
				

			<% }

			//close the connection.
			
			%>
		</table>

		<a href="browse.jsp?sortBy=itemID">Back to all auctions</a>
	    <% 
	    db.closeConnection(con);
	    con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<br>some broblems teehee");
	}
%>








</body>
</html>