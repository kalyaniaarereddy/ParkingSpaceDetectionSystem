<%--
CardDetails.jsp- file which prints user provided card details
@author: Abinaya Kethireddy
--%>

<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Card Details</title>
<style>
.top {
        position:absolute;
        left:0; right:0;
        height: 200px;
}
.left {
        position:absolute;
        left:0; top:130px; bottom: 0;
        
}
.main {
        position: absolute;
        left:70px; top:200px; right:0; bottom:0;
}
a 
{
text-decoration: none;
} 
header {
  background-color: #666;
  padding: 3px;
  text-align:center;
  font-size: 18px;
  color: white;
}

      
</style>
</head>
<body bgcolor="#D8D8D8">

<div class="top">
    <header>
 	<p align="center"><h1>Vehicle Parker</h1></p>
 
 	<p align="center">Hello, <%=(String)session.getAttribute("User") %></p>
  	<form action="LogoutServlet" method="post">
		<p align="right"><input type="submit" value="Logout" ></p>
	</form>
	</header>
</div>
<div class="left">
   <br/>
   <table>
   <tr><td>
  <a href="UserHomePage.jsp" class="w3-bar-item w3-button"><font color="white" size="4">HOME</font></a>
  </td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
  <td>
  <td>
  <a href="ParkingLotDesign.jsp" class="w3-bar-item w3-button"><font color="white" size="4">PARKING SPOTS</font></a>
  </td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
  <td>
  <a href="EntryTicket.jsp" class="w3-bar-item w3-button"><font color="white" size="4">BOOK SLOT</font></a>
  </td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
  <td>
  <a href="ExitTicket.jsp" class="w3-bar-item w3-button"><font color="white" size="4">EXIT GARAGE</font></a>
  </td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
  <td>
  <a href="PaymentMethod.jsp" class="w3-bar-item w3-button"><font color="white" size="4">ADD A CARD</font></a>
  </td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
  <td>
  <a href="CardDetails.jsp" class="w3-bar-item w3-button"><font color="white" size="4">MY PAYMENT METHOD</font></a>
  </td></tr>
  </table>
</div>
<div class="main">

<%
	String license="";
	ResultSet rs=null;
	ResultSet rs2= null;

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = null;
	PreparedStatement preparedStatement = null;
    try{
    	
    		
    		String user = (String)session.getAttribute("User");   	

         	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/garage","root","root");

         
         	String sql= "select Name,License from garage where Name=?";
         	preparedStatement = conn.prepareStatement(sql);
         	preparedStatement.setString(1,user);
         	rs = preparedStatement.executeQuery();
         	while(rs.next())
         	{
         		license=rs.getString("License");
         	}
         
         	String sql2= "select * from payment where License=license";
         	preparedStatement = conn.prepareStatement(sql2);
         	rs2 = preparedStatement.executeQuery();

       
     }
     catch (SQLException e) {
        	System.out.println("Error occurred " + e);
      }
	   
 %>
 <table width="90%" border="1">
	
 <% // write out the header cells containing the column labels
	try {
			out.write("<tr>");
    	  	out.write("<th>Name</th>");
 			out.write("<th>License Number</th>");
 			out.write("<th>Card Holder Name</th>");
 			out.write("<th>Card Number</th>");
 			out.write("</tr>");
			
         	while (rs2.next()) {       //this prints out name and license number  
         		out.write("<tr>");
            	out.write("<td>"+rs2.getString("Name")+"</td>");
            	out.write("<td>"+rs2.getString("License")+"</td>");
            	out.write("<td>"+rs2.getString("Holder")+"</td>");
            	out.write("<td>"+rs2.getString("CardNo")+"</td>");
            	out.write("</tr>");
         	}    	 	

      } // end of the try block
      catch (SQLException e) 
      {
         System.out.println("Error " + e);
      }
      
%>
</table>
</div>
</body>
</html>