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
		String v = request.getParameter("vehicleCategory");
		String att1 = "", att2= "", att1Value= "", att2Value= "", name= "", type= "", endDate = "";
		if(v.equals("boat")){att1 = "topspeed"; att2 = "width";}
		else if(v.equals("plane")) {att1 = "wingspan"; att2 = "capacity";}
		else {att1 = "mileage"; att2 = "drivetrain";}
		String sort = request.getParameter("sortBy");
		String query = "SELECT * FROM " + v + " AS v";
		query+= " INNER JOIN seller s ON v.itemID = s.itemID INNER JOIN auction a ON v.itemID = a.auctionID ";
		query+= " WHERE v.itemID IN (SELECT itemID FROM itemsSold WHERE auctionID IN";
		query+= " (SELECT auctionID FROM auction WHERE valid = true)) ORDER BY " + sort;
		System.out.println(query);
	    result = stmt.executeQuery(query);
	    %>
	    <p>Behold, the fine <%= v %>s on sale:</p>
	    <table>
		<tr>   
			<td>Name~~~~~</td> 
			<td>Type~~~~~</td>
			<td>
						
							<% if(v.equals("boat")) 
									out.write("Topspeed~~~~~");
								else if(v.equals("plane")) 
									out.write("Wingspan~~~~~");
								else 
									out.write("Mileage~~~~~");%>
						
			</td>
			<td>
						
							<% if(v.equals("boat")) 
									out.write("Width~~~~~");
								else if(v.equals("plane")) 
									out.write("Capacity~~~~~");
								else 
									out.write("drivetrain~~~~~");%>
						
			</td>
			<td>ItemID~~~~~</td> 
			<td>Seller~~~~~~~~~~~~~~~~</td> 
			<td>View Seller~~~~~</td>
			<td>Current bid~~~~~</td>
			<td>End date~~~~~</td>
			<td>View Auction</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { 
				String itemID = result.getString("itemID");%>
				<tr>    
					<td>
						
							<%= result.getString("name") %>
						
					</td>
					<td>
						
							<%= result.getString(v + "_type") %>
						
					</td>
					
					
					<td>
						
							<% if(v.equals("boat")) 
									out.write(result.getString("topspeed"));
								else if(v.equals("plane")) 
									out.write(result.getString("wingspan"));
								else 
									out.write(result.getString("mileage"));%>
						
					</td>
					<td>
						
							<% if(v.equals("boat")) 
									out.write(result.getString("width"));
								else if(v.equals("plane")) 
									out.write(result.getString("capacity"));
								else 
									out.write(result.getString("drivetrain"));%>
						
					</td>
					<td><%= result.getString("itemID")%></td>
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
			%>
		</table>
		<form method="get" action="browseBy.jsp">
					<select name="sortBy" size=1>
						<option value="name">Sort by name</option>
						<option value="itemID">Sort by itemID</option>
						<option value="endDate">Sort by end date</option>
						<%if(v.equals("boat")) {%> 
							<option value="topspeed">Sort by speed</option>
							<option value="width">Sort by width</option>
							<option value="boat_type">Sort by boat type</option>
						<%}if(v.equals("plane")) {%> 
							<option value="wingspan">Sort by wingspan</option>
							<option value="capacity">Sort by width</option>
							<option value="plane_type">Sort by plane type</option>
						<%}if(v.equals("car")) {%> 
							<option value="mileage">Sort by speed</option>
							<option value="drivetrain">Sort by width</option>
							<option value="car_type">Sort by car type</option><%} %>
					</select>&nbsp;<br> 
					<input type="submit" value="SORT!">
					<input name = "vehicleCategory" type = "hidden" value = <%=v %>>
		</form>
		<br>
		
		You can search by: <%=v %> type, name, or any attribute value (just type in the number!)
		<form method="post" action="searchBy.jsp">
			<table>
				<tr><td><input type="text" name="searchTerm"></td></tr>
			</table>
			<input type="submit" value="Search!">
			<input name = "vehicleCategory" type = "hidden" value = <%=v %>>
		</form>
		<br><br>
		
		Set an alert: fill in fields that are specific to the item you want, leave others blank if any will do.
			
		<form method="post" action="alertSet.jsp">
			<table>
				<tr><td>Name</td></tr>
				<tr><td><input type="text" name="name"></td></tr>
				<tr><td><%=v %> Type</td></tr>
				<tr><td><input type="text" name= "type"></td></tr>
				<tr><td><%=att1 %></td></tr>
				<tr><td><input type="text" name="att1"></td></tr>
				<tr><td><%=att2 %></td></tr>
				<tr><td><input type="text" name="att2"></td></tr>
			</table>
			<input type="submit" value="Set Alert">
			<input name = "vehicleCategory" type = "hidden" value = <%=v %>>
		</form>
		
		<a href="browse.jsp?sortBy=itemID">Back to all auctions</a>
	    <% 
	    con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<br>some broblems teehee");
	}
%>








</body>
</html>