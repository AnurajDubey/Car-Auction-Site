<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Your Car Auction</title>
</head>
<body style="background-color:bisque;">
	<form method="post" action="createCarAuction.jsp">

	
	<h1 style="font-size:40px"> Create Your Car Auction</h1>
	
	
	<br/><br/>
	Model Name:<input type="text" name="name">
	<br/><br/>
	Mileage:<input type="text" name="mileage">
	<br/><br/>
	Drive Train:
	<select name = "drivetrain" id = "drivetrain" > 
					<option>All-wheel Drive</option>
					<option>Front-wheel Drive</option>
					<option>Rear-wheel Drive</option>
	</select>
	<br/><br/>
	Type of Car:
	<select name = "car_type" id = "car_type" > 
					<option>Sedan</option>
					<option>Sports</option>
					<option>Compact</option>
					<option>SUV</option>
					<option>Van</option>
					<option>Truck</option>
	</select>
	<br/><br/>
	
	<input type="submit" value="Create Your Car Auction!">
	
	</form>
</body>
</html>