<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.BigAuction.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
	<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%
try {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	
	Class.forName("com.mysql.jdbc.Driver");
	Statement stmt = con.createStatement();
	String string_email = (String) session.getAttribute("email"); 
	String itemID = request.getParameter("itemID");
	String string_amount = request.getParameter("bid");
	int amount = Integer.parseInt(string_amount); 
	int int_itemID = Integer.parseInt(itemID); 
	
	
	
	//insert into bid
	String insert_in_bid = "INSERT INTO bid(amount) VALUES(?)" ; 
	PreparedStatement ps = con.prepareStatement(insert_in_bid);
	ps.setInt(1, amount);
	ps.executeUpdate();
	
	
	
	ResultSet rs = stmt.executeQuery("SELECT max(bidID) as amount FROM bid");
	rs.next();
	String string_bidID = rs.getString("amount");
	int bidID = Integer.parseInt(string_bidID);
	
	rs = stmt.executeQuery("SELECT auctionID as amount FROM auction WHERE auctionID =" + itemID );
	rs.next();
	String string_auctionID = rs.getString("amount");
	int auctionID = Integer.parseInt(string_auctionID);
	
	
	
	//insert into bidFor
	String insert_in_bidFor = "INSERT INTO bidFor(auctionID, bidID, itemID) VALUES(?,?,?)" ; 
	ps = con.prepareStatement(insert_in_bidFor);
	ps.setInt(1, auctionID);
	ps.setInt(2, bidID);
	ps.setInt(3, int_itemID);
	ps.executeUpdate();
	
	
	
	//insert into hasBid
	String insert_in_hasBid = "INSERT INTO hasBid(email, bidID) VALUES(?,?)" ; 
	ps = con.prepareStatement(insert_in_hasBid);
	ps.setString(1, string_email);
	ps.setInt(2, bidID);
	ps.executeUpdate();
	
	
	
	//insert into buyer
	String insert_in_buyer = "INSERT INTO buyer(auctionID, email, itemID) VALUES(?,?,?)" ; 
	ps = con.prepareStatement(insert_in_buyer);
	ps.setInt(1, auctionID); 
	ps.setString(2, string_email);
	ps.setInt(3, int_itemID);
	ps.executeUpdate();
	
	
  // show success message
  %>
  Your bid of $<%=string_amount%> was successfully placed on the item with itemID:<%=itemID%>>
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
	
	
	
	
	
	
	
	
	
	
	
	

</body>
</html>