<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Your Plane Auction</title>
</head>
<body style="background-color:bisque;">
	<form method="post" action="createPlaneAuction.jsp">

	
	<h1 style="font-size:40px"> Create Your Plane Auction</h1>
	
	
	<br/><br/>
	Model/Plane Name:<input type="text" name="name">
	<br/><br/>
	Wing Span/Helicopter Length (feet):<input type="text" name="wingspan">
	<br/><br/>
	Capacity:<input type="text" name="capacity">
	<br/><br/>
	Type of Plane:
	<select name = "plane_type" id = "plane_type" > 
					<option>Helicopter</option>
					<option>Luxury Jet</option>
					<option>Airliner</option>

	</select>
	<br/><br/>
	
	<input type="submit" value="Create Your Plane Auction!">
	
	</form>
</body>
</html>