<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.BigAuction.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body style="background-color:bisque;">
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			//Get the combobox from the index.jsp
			String entity = request.getParameter("command");
			
			String str = "";
			
			if(entity.equals(""))
				str = "SELECT qID,question,answer FROM questions";
			else
				str = "Select qID,question,answer FROM questions WHERE question LIKE '%" + entity + "%'";
			
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//Run the query against the database.
			ResultSet result = con.createStatement().executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");
			
			//make a row
			out.print("<tr>");
			
			out.print("<td>");
			//print out column header
			out.print("Q ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Question");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Answer");
			out.print("</td>");
			//make a column

			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				
				out.print("<td>");
				//print out column header
				out.print(result.getString("qID"));
				out.print("</td>");
				
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("question"));
				out.print("</td>");
				
				
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("answer"));
				out.print("</td>");


				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>
