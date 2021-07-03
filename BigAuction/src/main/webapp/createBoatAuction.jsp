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
		
	try{
		
		//Get parameters from elsewhere
		String string_date = (String) session.getAttribute("closeDate"); 
		String string_time = (String) session.getAttribute("closeTime");
		String string_am_or_pm = (String) session.getAttribute("am_or_pm");
		
		String string_datetime = string_date + " " + string_time + ":00";
		System.out.println(string_datetime); 
		String hh = string_time.substring(0,2); 
		String mm = string_time.substring(3,5);
		System.out.println(string_am_or_pm);
		System.out.println(string_am_or_pm.equals("PM"));
		System.out.println(hh);
		System.out.println("here");
		
		if (string_am_or_pm.equals("PM") && (Integer.parseInt(hh)>= 1 && Integer.parseInt(hh) <= 11 )) {
			System.out.println("here in if");
			int hour = Integer.parseInt(hh) + 12; 
			hh = String.valueOf(hour); 
		}
		else if (!string_am_or_pm.equals("PM") && Integer.parseInt(hh) == 12){
			System.out.println("here in else");
			int hour = Integer.parseInt(hh) - 12; 
			hh = String.valueOf(hour); 
		}
		
		string_datetime = string_date + " " + hh + ":" + mm + ":00" ; 
		String itemName = request.getParameter("name");
		String string_topspeed = request.getParameter("topspeed");
		String string_width = request.getParameter("width");
		String string_boattype = request.getParameter("boat_type");  
		String string_res = (String) session.getAttribute("reserve");
		String string_email = (String) session.getAttribute("email"); 
		String string_username = (String) session.getAttribute("user"); 
		String string_pw = (String) session.getAttribute("password"); 
		//convert to numbers
		int int_topspeed = Integer.parseInt(string_topspeed); 
 		int int_width = Integer.parseInt(string_width);  
 		int int_reserve = Integer.parseInt(string_res); 
	
		//get DB connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		
		Class.forName("com.mysql.jdbc.Driver");
		Statement stmt = con.createStatement();
		
		System.out.println("this is the email:" + string_email);
		System.out.println("this is the username:" + string_username); 
		System.out.println("this is the pw:" + string_pw); 
		
	
		

		
		//insert into auction
		String insert_in_auction = "INSERT INTO auction(endDate, valid, reserve) VALUES(?,?,?)"; 
		PreparedStatement ps = con.prepareStatement(insert_in_auction);
		ps.setString(1, string_datetime);
		ps.setBoolean(2, true); 
		ps.setFloat(3, int_reserve);
		ps.executeUpdate();
		
		
		//insert into item
		String insert_in_item = "INSERT INTO item(name) VALUES(?)"; 
		ps = con.prepareStatement(insert_in_item); 
		ps.setString(1, itemName);
		ps.executeUpdate(); 
		
		
		
		ResultSet rs = stmt.executeQuery("SELECT max(auctionID) as amount FROM auction");
		rs.next();
		String max_auctionID = rs.getString("amount");
		int int_maxAID = Integer.parseInt(max_auctionID);
		//stmt.executeQuery("INSERT INTO itemsSold(auctionID)" + max_auctionID ) ; 
		rs = stmt.executeQuery("SELECT max(itemID) as amount FROM item");
		rs.next();
		String max_itemID = rs.getString("amount");
		int int_maxIID = Integer.parseInt(max_itemID);
		 
		
		
		//insert into itemsSold  
		String insert_in_itemsSold = "INSERT INTO itemsSold(auctionID,itemID) VALUES(?,?)"; 
	    ps = con.prepareStatement(insert_in_itemsSold); 
	    ps.setInt(1, int_maxAID); 
	    ps.setInt(2, int_maxIID); 
		ps.executeUpdate();
	    

		
		
		//insert into seller
		String insert_in_seller = "INSERT INTO seller(auctionID, itemID, email) VALUES(?,?,?)"; 
		ps = con.prepareStatement(insert_in_seller); 
		ps.setInt(1, int_maxAID); 
	    ps.setInt(2, int_maxIID); 
	    ps.setString(3, string_email);
		ps.executeUpdate(); 

		
		
		
		//insert into car
		String insert_in_plane = "INSERT INTO boat(name, topspeed, width, boat_type, itemID) VALUES(?,?,?,?,?)" ; 
		ps = con.prepareStatement(insert_in_plane);
		ps.setString(1, itemName);
		ps.setInt(2, int_topspeed);
		ps.setInt(3, int_width); 
		ps.setString(4, string_boattype); 
		ps.setInt(5, int_maxIID);
		ps.executeUpdate();
	
		
		
		
		//reset value of session attributes
		session.setAttribute("reserve", null);
		session.setAttribute("closeDate", null);
		
		//redirect to success page
		response.sendRedirect("successCreatedAuction.jsp?int_maxIID=" + int_maxIID); 
		
	}
	 catch (Exception ex) {
		out.print(ex);
		System.out.println("failed");
		out.print("<br>Auction creation failed");
	}
	%>
</body>
</html>