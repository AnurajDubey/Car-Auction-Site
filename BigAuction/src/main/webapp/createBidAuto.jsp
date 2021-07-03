<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.BigAuction.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Bidding in Auction</title>
	</head>
	
	<style>
		body {background-color: bisque;}
	</style>
	<body>
		<%
		try {
			// Get the email of the user
			String email = session.getAttribute("email").toString();
			
			// Get parameters from the HTML form at bidAuction.jsp
			String itemID = request.getParameter("itemID");
			String bid = request.getParameter("bid");
			String increment = request.getParameter("increment");
			String limit = request.getParameter("limit");
			
			// Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			// Create a SQL statement
			Class.forName("com.mysql.jdbc.Driver");
			Statement stmt = con.createStatement();
			ResultSet rs1, rs2, rs3, rs4; 
			stmt.executeUpdate("INSERT INTO bid(amount) VALUES('" + bid + "'')");
			rs1 = stmt.executeQuery("SELECT max(bidID) as amount FROM bid");
			rs1.next();
			String string_bidID = rs1.getString("amount");
			stmt.executeUpdate("INSERT INTO hasBid(email, bidID) VALUES('" + email + "','" + string_bidID +"')");
			stmt.executeUpdate("INSERT INTO bidFor(auctionID, bidID, itemID) VALUES('" + string_bidID + "','" + string_bidID + "','" + itemID + "')");
			stmt.executeUpdate("INSERT INTO buyer(auctionID, email, itemID, automatic, increment, limit) VALUES('" + email + "','" + itemID + "', 1 " + "," + increment + "','" + limit +")");
			boolean isDone = false;
			String currentBid = "", currentLimit = "", currentIncrement = "", currentHighestBid = "", currentEmail = "";
			double currentBidNum = 0, currentLimitNum = 0, currentIncrementNum = 0, currentHighestBidNum = 0, newBidNum = 0;
			while(!isDone) {
				// find all find all auto bids for the given itemID
				rs2 = stmt.executeQuery("SELECT BU.email, BU.itemID, B.bidID, B.amount, BU.limit, BU.increment "
						+ "FROM buyer AS BU "
						+ "INNER JOIN "
						+ "bidFor AS BF "
						+ "ON BU.itemID = BF.itemID AND BU.automatic = TRUE AND BF.itemID = " + itemID + " "
						+ "INNER JOIN "
						+ "bid AS B "
						+ "ON BF.bidID = B.bidID");
				// if there are auto bids that have been passed ...
				if (rs2.isBeforeFirst()) {
					while(rs2.next()) {
						// get their current bid/limit/increment for the given itemID
						currentBid = rs2.getString("bid");
						currentBidNum = Double.parseDouble(currentBid);
						currentLimit = rs2.getString("limit");
						currentLimitNum = Double.parseDouble(currentLimit);
						currentIncrement = rs2.getString("increment");
						currentIncrementNum = Double.parseDouble(currentIncrement);
						currentEmail = rs2.getString("email");
						// get the highest bid for the current itemID
					    rs3 = stmt.executeQuery("SELECT MAX(AMOUNT) AS amount FROM bid WHERE bidID IN "
					    		+ "(SELECT bidID FROM bidFor WHERE itemID = " + itemID + ")");
					    rs3.next();
					    currentHighestBid = rs3.getString("amount");
						currentHighestBidNum = Double.parseDouble(currentHighestBid);
					    // check if their limit who be reached if they bid by their increment
					    newBidNum = currentHighestBidNum + currentIncrementNum;
					    if (newBidNum > currentLimitNum) {
					    	// the limit has been reached, so alert the user
					    	stmt.executeUpdate("INSERT INTO notification(email, itemID, notification_text)"
					    		+ "VALUES('" + currentEmail + "', "
					    		+ "'" + itemID + "', "
					    		+ "'Your auto bid limit of " + currentLimit + " for itemID: " + itemID + " has been surpassed'");
					    }
					    else { // increment the auto bids of the users by the increment
					    	stmt.executeUpdate("INSERT INTO bid(amount) VALUES('" + String.valueOf(newBidNum) + "'')");
							rs4 = stmt.executeQuery("SELECT max(bidID) as amount FROM bid");
							rs4.next();
							string_bidID = rs4.getString("amount");
							stmt.executeUpdate("INSERT INTO hasBid(email, bidID) VALUES('" + currentEmail + "','" + string_bidID +"')");
							stmt.executeUpdate("INSERT INTO bidFor(auctionID, bidID, itemID) VALUES('" + string_bidID + "','" + string_bidID + "','" + itemID + "')");
							stmt.executeUpdate("INSERT INTO buyer(auctionID, email, itemID) VALUES('" + currentEmail + "','" + itemID + ")");
					    }
					}
				}
				// there are no autobids then stop the loop
				else
					isDone = true;
			}
			
			// show success message
    		%>
	    	Your bid of $<%=bid%> was successfully placed on the item with itemID:<%=itemID%>>
	    	<a href="browse.jsp">View other Auctions</a>
	    	<%
		} catch (Exception ex) {
	    	%>
	    	An error has occurred please try again. [<%=ex%>>]
		    <a href="success.jsp">Return to main page</a>
	    	<%
	    }
	    	
	    %>
</body>
</html>