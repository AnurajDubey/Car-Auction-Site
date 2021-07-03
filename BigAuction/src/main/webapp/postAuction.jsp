<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>

<html>
<head>


<meta charset="UTF-8">
<title>Post An Auction</title>
</head>


<body style="background-color:bisque;">
	<form method="post" action="checkSelectedVehicleType.jsp">
			
				<br/><br/>
				Select Vehicle Type: 
				<select name = "vehicleType" id = "vehicleType" > 
					<option>Car</option>
					<option>Plane</option>
					<option>Boat</option>
				</select>
				
				
				<br/><br/>
				
				Set A Closing Date (yyyy-mm-dd):<input type="text" name="closeDate" id = "closeDate">
				
				  
				<table>
					<tr><td>Time of Day (hh:mm):&ensp;&ensp;<input type="text" id="closeTime" name="closeTime"></td></tr>
					
					<tr><td>
					<select name = "am_or_pm" id = "am_or_pm" > 
						<option>AM</option>
						<option>PM</option>
					</select>
					</td></tr>
					
							
				</table>
				
				
				
				
				
				<br/><br/>
				
				Set Reserve Price:<input type="text" name="reserve" id = "reserve">
				
				<br/><br/>
					
					
			
			<input type="submit" value="Continue">
		</form>
		
		
		
</body>
</html>