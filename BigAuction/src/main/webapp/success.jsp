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
		
		<ul>
		
			<li> <a href='postAuction.jsp'>Post An Auction</a> </li>
			<li> <a href='browse.jsp'>Browse</a> </li>
		
		
			<li> <a href='logout.jsp'>Log out</a> </li>
		
		</ul>
		
		
		<h1>Browse Questions:</h1>
		
         <form method="post" action="BrowseQuestions.jsp">
         		Enter keyword to search. For all leave blank:
				<input type="text" name="command">
				<br>
         </form>
         
         <h1>Add Questions:</h1>
		
		
         <form method="post" >
         		Enter your question
				<input type="text" name="command">
				<br>
         </form>
         
         
         
         <%
         ApplicationDB db = new ApplicationDB();
		 Connection con = db.getConnection();
         String entity = request.getParameter("command");
         String str = "insert into questions (question,answer) values ('" + entity + "', 'No answer')";
         System.out.println(str);
         con.createStatement().executeUpdate(str);
  
         %>
         
         
         
         
         
         
         
		<br>

		Notifications:
		
		
	<%
	    }
	%>
	
<% 
try {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
				Class.forName("com.mysql.jdbc.Driver");
				Statement stmt = con.createStatement();
				ResultSet result, rs2, rs3, rs4;
				String email = (String)session.getAttribute("email"); System.out.println(email);
				String query = "SELECT * FROM notifications WHERE email = '" + email + "'";
				System.out.println(query);
			    result = con.createStatement().executeQuery(query);
			    // find the auctions that have ended
			    rs2 = con.createStatement().executeQuery("SELECT A.auctionID, A.valid, A.reserve "
			    		+ "FROM auction AS A "
			    		+ "WHERE A.endDate < NOW()");
			    // if there are auctions that have ended
			    String auctionID = "", valid = "", reserve = "", highestBid = "", currentEmail = "";
			    double highestBidNum = 0, reserveNum = 0;
			    if(rs2.isBeforeFirst()) {
			    	// go through every auction that has ended
			    	while(rs2.next()) {
			    		// get the auctionID, validity, and reserve of every auction that ended
				    	valid = rs2.getString("valid");
				    	auctionID = rs2.getString("aucitonID");
				    	reserve = rs2.getString("reserve");
				    	if (valid.equals("0")) // if the auction has already ended skip to the next row
				    		continue;
				    	else {
				    		// otherwise set the validity to false
				    		con.createStatement().executeUpdate("UPDATE auction SET valid = 0 WHERE auctionID = " + auctionID);
			    			// get the highest bid on the auction that ended
						    rs3 = con.createStatement().executeQuery("SELECT MAX(AMOUNT) AS amount FROM bid WHERE bidID IN "
						    		+ " (SELECT bidID FROM bidFor WHERE itemID = " + auctionID + ")");
						    rs3.next();
						    if(rs3.getString("amount")!=null) {
						    	highestBid = rs3.getString("amount");
						    }
						    else {
						    	highestBid = "0";
						    }
						    // check if the highest bid is higher than the reserve
						    highestBidNum = Double.parseDouble(highestBid);
						    reserveNum = Double.parseDouble(reserve);
						    if (reserveNum > highestBidNum) { // if the reserve is higher (strictly?) than the last bid none is the winner.
						    	; // do nothing except set valid to false (already done)
						    }
						    else {
						    	// alert the winner (whoever placed the highest bid) that they won
						    	// get the email of whoever placed the highest bid on this item
						    	rs4 = con.createStatement().executeQuery("SELECT BU.email, B.amount, B.bidID, BU.itemID, BU.auctionID "
						    			+ "FROM buyer AS BU "
						    			+ "INNER JOIN "
						    			+ "bidFor AS BF "
						    			+ "ON BU.auctionID = BF.auctionID "
						    			+ "INNER JOIN "
						    			+ "bid AS B "
						    			+ "ON BF.bidID = B.bidID "
						    			+ "WHERE BU.auctionID = `" + auctionID + "` AND B.amount = `" + highestBid + "`");
						    	rs4.next();
						    	currentEmail = rs4.getString("email");
						    	// create the notification 
						    	con.createStatement().executeUpdate("INSERT INTO notification(email, itemID, notification_text)"
							    		+ "VALUES('" + currentEmail + "', "
							    		+ "'" + auctionID + "', "
							    		+ "'Your have won an auction for auctionID: " + auctionID + "'");
						    }
				    	}
				    	
			    	}
			    }
			    // if there are no auctions that have ended 
			    else {
			    	; // do nothing
			    }
			    
			    
	    %>
	    <table>
		<tr>   
			<td>ItemID~~~~~</td> 
			<td>Notification text:</td>
			<td>
						
							
						
			</td>
			<td>
						
							
						
			</td>

		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("itemID")%></td>
					<td><%= result.getString("notification_text")%></td>
					<td>
							<a href="viewAuction.jsp?itemID=<%=result.getString("itemID")%>">View this auction</a>
					</td>
		
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
		<br>
		

		<br><br>
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




</body>
</html>