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
		String att1, att2;
		if(v.equals("boat")){att1 = "topspeed"; att2 = "width";}
		else if(v.equals("plane")) {att1 = "wingspan"; att2 = "capacity";}
		else {att1 = "mileage"; att2 = "drivetrain";}
		String name = request.getParameter("name");
		String type = request.getParameter("type");
		String att1Value = request.getParameter("att1");
		String att2Value = request.getParameter("att2");
		String query = "INSERT INTO alerts VALUES(0, '" + v + "', '" + type + "', '" + name + "', '" + att1Value + "', '" + att2Value + "')";
		System.out.println(query);
		stmt.executeUpdate(query);
		String email = (String)session.getAttribute("email"); System.out.println(email);
		String query2 = "SELECT max(alertID) as alertID FROM alerts";
		result = stmt.executeQuery(query2);
		result.next();
		String alertID = result.getString("alertID");
		String query3 = "INSERT INTO hasAlerts VALUES("+ alertID + ", '" + email + "')";
		System.out.println(query3);
	    stmt.executeUpdate(query3);
	   %>
	   
	   You have set an alert for a <%=v %> with name: <%=name%>, type: <%=type%>, <%=att1 %>: <%=att1Value %>, <%=att2 %>: <%=att2Value %>
	   <br><br><a href="browse.jsp?sortBy=itemID">Back to all auctions</a>
	   <%

	    
	} catch (Exception ex) {
		out.print(ex);
		out.print("<br>some kinda problem");
	}
%>









</body>
</html>