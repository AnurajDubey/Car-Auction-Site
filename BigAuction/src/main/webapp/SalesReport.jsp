<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.BigAuction.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sales Report</title>
	</head>
	<body>
	<style>
			input[type="text"], input[type="password"] {
			  width: 100%;
			  padding: 4px 4px;
			  margin: 4px 0;
			  box-sizing: border-box;
			  border: 2px solid #111;
			  background-color: #2D2D2D;
  			  color: white;
			  outline: none;
			}
			body {background-color: coral;}
		</style>
	<%

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Get the combobox from the AdminPage.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			
			
			
			if(entity.equals("item")){
				ResultSet itemIDs = con.createStatement().executeQuery("select DISTINCT itemID from bidFor where bidID IN(SELECT BF.bidID FROM bid AS B INNER JOIN bidFor AS BF ON B.bidID = BF.bidID INNER JOIN auction AS A ON BF.auctionID = A.auctionID WHERE A.endDate<='2021-05-30')");
				
				
				//print out item id's and print amount next to them
				//Make an HTML table to show the results in:
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Item ID");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Price Paid");
				out.print("</td>");
				out.print("</tr>");
				//parse out the results
				String itemID = "";
				while(itemIDs.next()){
					itemID = itemIDs.getString("itemID");

					String query2 = "SELECT MAX(AMOUNT) AS amount FROM bid WHERE bidID IN ";
					query2+= " (SELECT bidID FROM bidFor WHERE itemID = " + itemID + ")";
					
					ResultSet amounts = con.createStatement().executeQuery(query2);
					amounts.next();
					
					//make a row
					out.print("<tr>");

					out.print("<td>");
					out.print(itemID);
					out.print("</td>");

					out.print("<td>");
					out.print(amounts.getString("amount"));
					out.print("</td>");
					
					out.print("</tr>");
					
				}

				out.print("</table>");
			}
			
			else if(entity.equals("type")){
				ResultSet itemIDs = con.createStatement().executeQuery("select itemID from bidFor where bidID IN(SELECT BF.bidID FROM bid AS B INNER JOIN bidFor AS BF ON B.bidID = BF.bidID INNER JOIN auction AS A ON BF.auctionID = A.auctionID WHERE A.endDate<='2021-05-30')");
				int size =0;
				if (itemIDs != null) 
				{
					itemIDs.last();    // moves cursor to the last row
				  	size = itemIDs.getRow(); // get row id 
				}
				itemIDs.beforeFirst();
				
				int plane = 0;
				int boat = 0;
				int car = 0;
				
				for(int i = 0;i<size;i++){
					itemIDs.next();
					String itemID = itemIDs.getString("itemID");

					String query = "SELECT MAX(AMOUNT) AS amount FROM bid WHERE bidID IN ";
					query+= " (SELECT bidID FROM bidFor WHERE itemID = " + itemID + ")";
					ResultSet amounts = con.createStatement().executeQuery(query);
					amounts.next();
					
					
					String v = "";
					String query1 = ("SELECT * FROM boat WHERE itemID = " + itemID);
			        ResultSet result1 = con.createStatement().executeQuery(query1);
			        if(result1.next()==true){v = "boat";}
			        else
			        {
			            String newQuery = ("SELECT * FROM plane WHERE itemID = " + itemID + "");
			            ResultSet result2;
			            result2 = con.createStatement().executeQuery(newQuery);
			            if(result2.next()==true){v = "plane";}
			            else
			            {
			                String query3 = ("SELECT * FROM car WHERE itemID = " + itemID);
			                ResultSet result3;
			                result3 = con.createStatement().executeQuery(query3);
			                if(result3.next()==true){v = "car";}
			            }
			        }
			        
					if(v.equals("car"))
						car +=Integer.parseInt(amounts.getString("amount"));
					else if(v.equals("boat"))
						boat+=Integer.parseInt(amounts.getString("amount"));
					else if(v.equals("plane"))
						plane+=Integer.parseInt(amounts.getString("amount"));
			        
			        
				}
				
				//print values car boat and plane and connect them to string values
		        
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Type");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Total Amount Spent");
				out.print("</td>");
				out.print("</tr>");
				
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Boat");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print(boat);
				out.print("</td>");
				out.print("</tr>");
				
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Plane");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print(plane);
				out.print("</td>");
				out.print("</tr>");
				
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Car");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print(car);
				out.print("</td>");
				out.print("</tr>");
				
				
				out.print("</table>");

		        
			}
			
			
			else if(entity.equals("user")){
				
				//includes all email + bid id combos of correct dates
				ResultSet emailBidIDs = con.createStatement().executeQuery("select email,bidID from hasBid where bidID IN(SELECT BF.bidID FROM bid AS B INNER JOIN bidFor AS BF ON B.bidID = BF.bidID INNER JOIN auction AS A ON BF.auctionID = A.auctionID WHERE A.endDate<='2021-05-30')");
				int size = 0;
				if (emailBidIDs != null) 
				{
					emailBidIDs.last();    // moves cursor to the last row
				  	size = emailBidIDs.getRow(); // get row id 
				}
				emailBidIDs.beforeFirst();
				//size = length of amount of email/bidID tuples
				
				ArrayList<String> emailsArr = new ArrayList<String>();
				ArrayList<Integer> amountArr = new ArrayList<Integer>();

						
				for(int i = 0;i<size;i++){
					emailBidIDs.next();
					String currentBidID = emailBidIDs.getString("bidID");
					ResultSet itemID = con.createStatement().executeQuery("select itemID from bidFor where bidID = " + currentBidID + "");
					itemID.next();
					String itemIDNum = itemID.getString("itemID");
					

					String query2 = "SELECT MAX(AMOUNT) AS amount FROM bid WHERE bidID IN (SELECT bidID FROM bidFor WHERE itemID = " + itemIDNum + ")";
					ResultSet amounts = con.createStatement().executeQuery(query2);
					amounts.next();
					String price = amounts.getString("amount");
					
					ResultSet temp = con.createStatement().executeQuery("Select bidID FROM bid where amount = " + price + " and bidID IN (SELECT bidID FROM bidFor WHERE itemID = " + itemIDNum + ")");					
					temp.next();

					if(temp.getString("bidID").equals(currentBidID)== false){
						continue;
					}

					emailsArr.add((emailBidIDs.getString("email")));
					amountArr.add(Integer.parseInt(amounts.getString("amount")));
				}
				
				ArrayList<String> alreadyDone = new ArrayList<String>();
	
				
				for(int i =0;i<emailsArr.size();i++){
					if(alreadyDone.indexOf(emailsArr.get(i))==-1){
						alreadyDone.add(emailsArr.get(i));
					}
					else{
						
						int store = alreadyDone.indexOf(emailsArr.get(i));
						int temp = amountArr.get(i);
						amountArr.set(store,temp+amountArr.get(store));
						amountArr.remove(i);
						emailsArr.remove(i);
						i--;
					}
				}
				
				
		        //print out emails arraylist and print them next to the amounts connected at that index
				//Make an HTML table to show the results in:
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Email");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Amount Spent");
				out.print("</td>");
				out.print("</tr>");
				//parse out the results
				int counter = 0;
				while(counter<emailsArr.size()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current bar name:
					out.print(emailsArr.get(counter));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(amountArr.get(counter));
					out.print("</td>");
					out.print("<td>");
					out.print("</tr>");
					counter++;
				}
				out.print("</table>");
			}
			
			
			
			else if(entity.equals("best selling items")){
				ResultSet itemIDs = con.createStatement().executeQuery("select DISTINCT itemID from bidFor where bidID IN(SELECT BF.bidID FROM bid AS B INNER JOIN bidFor AS BF ON B.bidID = BF.bidID INNER JOIN auction AS A ON BF.auctionID = A.auctionID WHERE A.endDate<='2021-05-30')");
				int size =0;
				if (itemIDs != null) 
				{
					itemIDs.last();    // moves cursor to the last row
				  	size = itemIDs.getRow(); // get row id 
				}
				itemIDs.beforeFirst();
				//NOW HAVE ALL ITEM ID'S WHICH ARE CORRECT FOR LIST
				String[] itemArr = new String[size];
				String[] priceArr = new String[size];
				for(int i = 0;i<size;i++){
					itemIDs.next();
					String itemID = itemIDs.getString("itemID");

					String query2 = "SELECT MAX(AMOUNT) AS amount FROM bid WHERE bidID IN ";
					query2+= " (SELECT bidID FROM bidFor WHERE itemID = " + itemID + ")";
					ResultSet amounts = con.createStatement().executeQuery(query2);
					amounts.next();
					
					
					itemArr[i] = itemID;
					priceArr[i] = amounts.getString("amount");
				}
				int[] newItemArr = new int[size];
				int[] newPriceArr = new int[size];
				for(int a=0;a<size;a++){
					newItemArr[a] = Integer.parseInt(itemArr[a]);
					newPriceArr[a] = Integer.parseInt(priceArr[a]);
				}
				
		        for (int i = 0; i < size-1; i++){
		            for (int j = 0; j < size-i-1; j++){
		                if (newPriceArr[j] > newPriceArr[j+1]){
		                    int temp1 = newPriceArr[j];
		                    int temp2 = newItemArr[j];
		                    newPriceArr[j] = newPriceArr[j+1];
		                    newPriceArr[j+1] = temp1;
		                    newItemArr[j] = newItemArr[j+1];
		                    newItemArr[j+1] = temp2;
		                }
		            }
		        
		        }
		        
		        //print out the top 5 item arr for the item id and connect it to its amount at that index in amountarr
		      //Make an HTML table to show the results in:
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Item ID");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Price Paid");
				out.print("</td>");
				out.print("</tr>");
				//parse out the results
				int counter = 0;
				while(counter<5||counter<newItemArr.length) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current bar name:
					out.print(newItemArr[counter]);
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(newPriceArr[counter]);
					out.print("</td>");
					out.print("<td>");
					out.print("</tr>");
					counter++;
				}
				out.print("</table>");
			}
			
			else if(entity.equals("best buyer")){
				
				/*
				//includes all email + bid id combos of correct dates
				ResultSet emailBidIDs = con.createStatement().executeQuery("select email,bidID from hasBid where bidID IN(SELECT BF.bidID FROM bid AS B INNER JOIN bidFor AS BF ON B.bidID = BF.bidID INNER JOIN auction AS A ON BF.auctionID = A.auctionID WHERE A.endDate<='2009-05-17')");
				
				int size = 0;
				if (emailBidIDs != null) 
				{
					emailBidIDs.last();    // moves cursor to the last row
				  	size = emailBidIDs.getRow(); // get row id 
				}
				emailBidIDs.beforeFirst();
				//size = length of amount of email/bidID tuples
				
				String[] emailsArr = new String[size];
				int[] amountArr = new int[size];

						
				int offset = 0;
				for(int i = 0;i<size;i++){
					
					emailBidIDs.next();
					String currentBidID = emailBidIDs.getString("bidID");
					
					ResultSet itemID = con.createStatement().executeQuery("select itemID from bidFor where bidID = " + currentBidID + "");
					itemID.next();
					String currentItemID = itemID.getString("itemID");
					
					ResultSet amounts = con.createStatement().executeQuery("SELECT MAX(AMOUNT) AS amount FROM bid WHERE bidID IN (SELECT bidID FROM bidFor WHERE itemID = " + currentItemID + ")");	
					amounts.next();
					String price = amounts.getString("amount");
					
					
					ResultSet temp = con.createStatement().executeQuery("Select bidID FROM bid where amount = " + price + " and bidID IN (SELECT bidID FROM bidFor WHERE itemID = " + currentItemID + ")");					
					temp.next();

					if(temp.getString("bidID").equals(currentBidID)== false){
						offset--;
						continue;
					}
					
					System.out.println(currentBidID);
					System.out.println(amounts.getString("amount"));
					
					emailsArr[i+offset] = emailBidIDs.getString("email");
					amountArr[i+offset] = Integer.parseInt(amounts.getString("amount"));
				}
				
				ArrayList<String> alreadyDone = new ArrayList<String>();
				
				int i =0;
				int start = 0;
				while(emailsArr[i]!=null){
					if(alreadyDone.indexOf(emailsArr[i])==-1){
						alreadyDone.add(emailsArr[i]);
					}
					else{
						int store = alreadyDone.indexOf(emailsArr[i]);
						amountArr[store]+=amountArr[i];
		
						for (start = i; i < amountArr.length - 1; i++) {
							if(start==amountArr.length)
								amountArr[start] = -1;
							else
								amountArr[i] = amountArr[i + 1];
						}
						for (start = i; i < emailsArr.length - 1; i++) {
							if(start==emailsArr.length)
								emailsArr[start] = null;
							else
								emailsArr[i] = emailsArr[i + 1];
						}
						i--;
					}
					i++;
				}
				
				
				for (int a = 0; a < size-1; a++){
		            for (int b = 0; b < size-a-1; b++){
		                if (amountArr[b] > amountArr[b+1]){
		                    int temp1 = amountArr[b];
		                    String temp2 = emailsArr[b];
		                    amountArr[b] = amountArr[b+1];
		                    amountArr[b+1] = temp1;
		                    emailsArr[b] = emailsArr[b+1];
		                    emailsArr[b+1] = temp2;
		                }
		            }
		        
		        }
				
		        //print out top 5 from emails arr to get user emails and connect it to amountarr for amounts at that index
			
				//Make an HTML table to show the results in:
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Email");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Amount Spent");
				out.print("</td>");
				out.print("</tr>");
				//parse out the results
				int counter = 0;
				while(counter<5||counter<emailsArr.length) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current bar name:
					out.print(emailsArr[counter]);
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(amountArr[counter]);
					out.print("</td>");
					out.print("<td>");
					out.print("</tr>");
					counter++;
				}
				out.print("</table>");
				*/
				
				//includes all email + bid id combos of correct dates
				ResultSet emailBidIDs = con.createStatement().executeQuery("select email,bidID from hasBid where bidID IN(SELECT BF.bidID FROM bid AS B INNER JOIN bidFor AS BF ON B.bidID = BF.bidID INNER JOIN auction AS A ON BF.auctionID = A.auctionID WHERE A.endDate<='2021-05-30')");
				int size = 0;
				if (emailBidIDs != null) 
				{
					emailBidIDs.last();    // moves cursor to the last row
				  	size = emailBidIDs.getRow(); // get row id 
				}
				emailBidIDs.beforeFirst();
				//size = length of amount of email/bidID tuples
				
				ArrayList<String> emailsArr = new ArrayList<String>();
				ArrayList<Integer> amountArr = new ArrayList<Integer>();

						
				for(int i = 0;i<size;i++){
					emailBidIDs.next();
					String currentBidID = emailBidIDs.getString("bidID");
					ResultSet itemID = con.createStatement().executeQuery("select itemID from bidFor where bidID = " + currentBidID + "");
					itemID.next();
					String itemIDNum = itemID.getString("itemID");
					

					String query2 = "SELECT MAX(AMOUNT) AS amount FROM bid WHERE bidID IN (SELECT bidID FROM bidFor WHERE itemID = " + itemIDNum + ")";
					ResultSet amounts = con.createStatement().executeQuery(query2);
					amounts.next();
					String price = amounts.getString("amount");
					
					ResultSet temp = con.createStatement().executeQuery("Select bidID FROM bid where amount = " + price + " and bidID IN (SELECT bidID FROM bidFor WHERE itemID = " + itemIDNum + ")");					
					temp.next();

					if(temp.getString("bidID").equals(currentBidID)== false){
						continue;
					}

					emailsArr.add((emailBidIDs.getString("email")));
					amountArr.add(Integer.parseInt(amounts.getString("amount")));
				}
				
				ArrayList<String> alreadyDone = new ArrayList<String>();
	
				
				for(int i =0;i<emailsArr.size();i++){
					if(alreadyDone.indexOf(emailsArr.get(i))==-1){
						alreadyDone.add(emailsArr.get(i));
					}
					else{
						
						int store = alreadyDone.indexOf(emailsArr.get(i));
						int temp = amountArr.get(i);
						amountArr.set(store,temp+amountArr.get(store));
						//System.out.println(amountArr.get(store));
						amountArr.remove(i);
						emailsArr.remove(i);
						i--;
					}
				}
				
				String[] storeEmails = new String[emailsArr.size()];
				int[] holdAmounts = new int[amountArr.size()];
				
				
				for(int i =0;i<emailsArr.size();i++){
					storeEmails[i] = emailsArr.get(i);
					holdAmounts[i] = amountArr.get(i); 
				}
				
	
				
				int n = storeEmails.length;
		        for (int i = 0; i < n-1; i++)
		            for (int j = 0; j < n-i-1; j++)
		                if (holdAmounts[j] < holdAmounts[j+1])
		                {
		                    // swap arr[j+1] and arr[j]
		                    int temp1 = holdAmounts[j];
		                    String temp2 = storeEmails[j];
		                    holdAmounts[j] = holdAmounts[j+1];
		                    holdAmounts[j+1] = temp1;
		                    storeEmails[j] = storeEmails[j+1];
		                    storeEmails[j+1] = temp2;
		                }
				
				
		        //print out emails arraylist and print them next to the amounts connected at that index
				//Make an HTML table to show the results in:
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Email");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Amount Spent");
				out.print("</td>");
				out.print("</tr>");
				//parse out the results
				int counter = 0;
				while(counter<5||counter<storeEmails.length) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current bar name:
					out.print(storeEmails[counter]);
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(holdAmounts[counter]);
					out.print("</td>");
					out.print("<td>");
					out.print("</tr>");
					counter++;
				}
				out.print("</table>");
			}
			
			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>