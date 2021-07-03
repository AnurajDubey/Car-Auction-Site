<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Your Boat Auction</title>
</head>
<body style="background-color:bisque;">
	<form method="post" action="createBoatAuction.jsp">

	
	<h1 style="font-size:40px"> Create Your Boat Auction</h1>
	
	
	<br/><br/>
	Model/Boat Name:<input type="text" name="name">
	<br/><br/>
	Top Speed (mph):<input type="text" name="topspeed">
	<br/><br/>
	Width (feet):<input type="text" name="width">
	<br/><br/>
	Type of Boat:
	<select name = "boat_type" id = "boat_type" > 
					<option>Yacht</option>
					<option>Sailboat</option>
					<option>Caravel</option>
					
	</select>
	<br/><br/>
	
	<input type="submit" value="Create Your Boat Auction!">
	
	</form>
</body>
</html>