<%-- 
    Document   : dashboard
    Created on : 15 Apr, 2019, 10:22:40 PM
    Author     : winayak
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>JSP Page</title>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <!-- Popper JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        
        <!-- font awesome icons -->
        <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>

        <link rel="stylesheet" href="css/index.css">
        <style>
  
        </style>
    </head>
    <body>
	<nav>
            <h3>PersAcc</h3>
            <span data-toggle="collapse" data-target="#sidebar"><i class="fas fa-list"></i></span>
            <div class="dropdown dropleft">
                <span data-toggle="dropdown">
                    <i class="fas fa-user"></i>
                </span>
                <div class="dropdown-menu">
                    <a href="#" class="dropdown-item"><% out.println(session.getAttribute("uname")); %></a>
                    <a class="dropdown-item" href="Logout">Logout</a>
                </div>
            </div>
	</nav>
        <div id="sidebar" class="collapse show col-md-4 col-xl-2">
            <a href="dashboard.jsp">Dashboard</a>
            <a href="items.jsp">Items</a>
            <a href="sales.jsp">Sales</a>
            <a href="purchases.jsp">Purchases</a>
            <a href="contact.jsp">Contacts</a>
            <a href="#" class="active">Account</a>
        </div>
        <% if(session.getAttribute("email") != null){
            
        }
          else{
              out.println("session expired");
          }
        %>
    </body>
</html>
