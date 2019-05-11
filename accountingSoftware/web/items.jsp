<%-- 
    Document   : dashboard
    Created on : 15 Apr, 2019, 10:22:40 PM
    Author     : winayak
--%>

<%@page import="hibernate.Login_pojo"%>
<%@page import="java.util.Iterator"%>
<%@page import="hibernate.Items_pojo"%>
<%@page import="java.util.List"%>
<%@page import="configuration.App"%>
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
            #main .table th{
                width: 11.11%;
            }
            .form-group{
                overflow: hidden;
                
            }
            label{
                width: 100%;
            }
            #code{
                width: 80%;
                float: left;
                border-radius: 5px 0px 0px 5px;
            }
            #code+button{
                background: #f1f1f1;
                border-radius: 0px 5px 5px 0px;
                border: 0;
                border: 1px solid #dedede;
                padding: 8.5px;
                width: 20%;
            }
            #myModal3 input{
                border-radius: 5px 0px 0px 5px;
            }
            #myModal3 input+button{
                background: #f1f1f1;
                border: 0;
                border: 1px solid #dedede;
                padding: 8.5px;
                border-radius: 0px 5px 5px 0px;
                width: 20%;
            }
            #myModal3 input{
                width: 80%;
                float: left;
            }
            .qrcode{
                text-align: center;
            }
            #main h4 a{
                color: black;
            }
            @media only screen and (max-width:1220px){
                #myModal3 input+button,#code+button{
                    width: 35%;
                }
                #myModal3 input,#code{
                    width: 65%;
                }
                
            }
        </style>
        <script>
            $(document).ready(function(){
                $("#submit1").click(function(e){
                    e.preventDefault();
                    var name = $("#name").val();
                    var desc = $("#desc").val();
                    var code = $("#code").val();
                    var cp = $("#cp").val();
                    var sp = $("#sp").val();
                    var cat = $("#cat").val();
                    var scat = $("#scat").val();
                    var stock = $("#stock").val();
                    var flag = 0;
                    if($("#name").val() == ""){
                        $("#name").attr("placeholder","Required Field!!");
                        $("#name").addClass("inp");
                        flag = 1;
                    }
                    if($("#desc").val() == ""){
                        $("#desc").attr("placeholder","Required Field!!");
                        $("#desc").addClass("inp");
                        flag = 1;
                    }
                    if($("#code").val() == ""){
                        $("#code").attr("placeholder","Required Field!!");
                        $("#code").addClass("inp");
                        flag = 1;
                    }
                    if($("#sp").val() == ""){
                        $("#sp").attr("placeholder","Required Field!!");
                        $("#sp").addClass("inp");
                        flag = 1;
                    }
                    if($("#cp").val() == ""){
                        $("#cp").attr("placeholder","Required Field!!");
                        $("#cp").addClass("inp");
                        flag = 1;
                    }
                    if($("#stock").val() == ""){
                        $("#stock").attr("placeholder","Required Field!!");
                        $("#stock").addClass("inp");
                        flag = 1;
                    }
                    if($("#cat").val() == ""){
                        $("#cat").attr("placeholder","Required Field!!");
                        $("#cat").addClass("inp");
                        flag = 1;
                    }
                    if($("#scat").val() == ""){
                        $("#scat").attr("placeholder","Required Field!!");
                        $("#scat").addClass("inp");
                        flag = 1;
                    }
                    console.log(cat);
                    console.log(scat);
                    if(flag==0){
                        $.ajax({
                            type: "post",
                            url: "Items",
                            data: {name:name,desc:desc,sp:sp,cp:cp,stock:stock,code:code,cat:cat,scat:scat},
                            success:function(res){
                                alert(res);   
                            },
                            error:function(res){
                                alert("Error!!");
                            }
                        });
                    }
                    setTimeout(function(){
                        $("#myModal1 input").attr("placeholder","");
                        $("#myModal1 input").removeClass("inp");
                        $("#submit1").prop("disabled",false);
                    },2000);
                });
            });   
            $(document).ready(function(){
                $("#submit2").click(function(e){
                    e.preventDefault();
                    var cat = $("#cat2").val();
                    var flag = 0;                    
                    if($("#cat2").val() == ""){
                        $("#cat2").attr("placeholder","Required Field!!");
                        $("#cat2").addClass("inp");
                        flag = 1;
                    }
                    console.log(cat);
                    if(flag==0){
                        $.ajax({
                            type: "post",
                            url: "Addcategory",
                            data: {cat:cat},
                            success:function(res){
                                alert(res);   
                            },
                            error:function(res){
                                alert("Error!!");
                            }
                        });
                    }
                    setTimeout(function(){
                        $("#myModal2 input").removeClass("inp");
                        $("#myModal2 input").attr("placeholder","");
                        $("#submit2").prop("disabled",false);
                    },2000);
                });
            });   
            $(document).ready(function() {
                $("#code+button").click(function(){
                    $("#code").val(Date.now());
                });                
                $("#generatei").click(function(){
                    var text = $("#myModal3 input").val();
                    if(text == ""){
                        $("#myModal3 input").attr("placeholder","Required Field!!");
                        $("#myModal3 input").addClass("inp");
                        setTimeout(function(){
                            $("#myModal3 input").removeClass("inp");
                            $("#myModal3 input").attr("placeholder","");
                            $("#generatei").prop("disabled",false);
                        },2000);
                    }
                    else{
                        console.log(text);
                        $("#qr").empty();
                        $("#qr").append("<img>");
                        $("#qr img").attr("src","https://chart.googleapis.com/chart?cht=qr&chs=250x250&chl="+text);
                    }
                });
            });

        </script>
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
        <div id="sidebar" class="collapse show col-xl-2">
            <a href="dashboard.jsp">Dashboard</a>
            <a href="#" class="active">Items</a>
            <a href="sales.jsp">Sales</a>
            <a href="purchases.jsp">Purchases</a>
            <a href="contact.jsp">Contacts</a>
            <a href="myaccount.jsp">Account</a>
        </div>
        <% if(session.getAttribute("email") != null){
        %>
        <div class="col-12 col-lg-12 col-xl-10" id="main"> 
            <h4>
                <span  data-toggle="tooltip" title="Add Items" style="float: left;transform:translate(-10px,-10px);border-left: 0px;border-right: 1px solid #d0d0d0;"><i data-toggle="modal" data-target="#myModal1" class="fas fa-plus"></i></span>
                Items                 
                <span  data-toggle="tooltip" title="Generate QR Code" id="generate"><a href="#" data-toggle="modal" data-target="#myModal3"><i class="fas fa-qrcode"></i></a></span>
                <span  data-toggle="tooltip" title="Category" id="category"><i data-toggle="modal" data-target="#myModal2" class="fas fa-list-alt"></i></span>
            </h4>
            <div class="table_div">
                <table class="table">
                    <thead>
                      <tr>
                        <th>Name</th>
                        <th>Category</th>    
                        <th>Sub-category</th>    
                        <th>Description</th>
                        <th>Item Code</th>
                        <th>Cost Price</th>
                        <th>Selling Price</th>
                        <th>Stock</th>    
                        <th>Sold</th>    
                      </tr>
                    </thead>
                    <tbody>
                        <% 
                            App obj = new App();
                            List l = obj.fetch_items();
                            Items_pojo obj2 = new Items_pojo();
                            Iterator i = l.iterator();
                            while(i.hasNext()){
                                obj2 = (Items_pojo) i.next();
                        %>
                        <tr>
                            <td><%out.println(obj2.getname());%></td>
                            <td><%out.println(obj2.getcat());%></td>
                          <td><%out.println(obj2.getscat());%></td>
                          <td><%out.println(obj2.getdesc());%></td>
                          <td><%out.println(obj2.getcode());%></td>
                          <td><%out.println(obj2.getcp());%></td>
                          <td><%out.println(obj2.getsp());%></td>
                          <td><%out.println(obj2.getstock());%></td>
                          <td><%out.println(obj2.getisold());%></td>
                        </tr>   
                        <%}%>                
                    </tbody>
                </table>  
            </div>
        </div>
        
        <div class="modal fade" id="myModal1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                      <h4 class="modal-title">Add Items</h4>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="name">
                        </div>
                        <div class="form-group">
                            <label for="desc">Description</label>
                            <input type="text" class="form-control" id="desc">
                        </div>
                        <div class="form-group">
                            <label for="code">Code</label>
                            <input type="text" class="form-control" id="code" disabled>
                            <button>Generate</button>
                        </div>
                        <div class="form-group">
                            <label for="cp">Cost Price</label>
                            <input type="number" class="form-control" id="cp">
                        </div>
                        <div class="form-group">
                            <label for="sp">Selling Price</label>
                            <input type="number" class="form-control" id="sp">
                        </div>
                        <div class="form-group">
                            <label for="stock">Stock</label>
                            <input type="number" class="form-control" id="stock">
                        </div>
                        <div class="form-group">
                            <label for="cat">Category</label>
                            <select id="cat" class="form-control">
                                <% 
                                    String email = session.getAttribute("email").toString();
                                    List l2 = obj.fetch_category(email);
                                    Login_pojo obj3 = new Login_pojo();
                                    Iterator i2 = l2.iterator();
                                    int o = 0;
                                    String cat[] = {""};
                                    while(i2.hasNext()){
                                        obj3 = (Login_pojo)i2.next();
                                        cat = obj3.getcategory().split("\\,");                                        
                                    }
                                %>
                                <%while(o!=cat.length){%>
                                    <option value="<%out.println(cat[o]);%>"><%out.println(cat[o]);o++;%></option>   
                                <%}%> 
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="scat">Sub-category</label>
                            <input type="text" class="form-control" id="scat">
                        </div>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                      <button type="button" id="submit1">Save</button>
                    </div>

                </div>
            </div>
        </div>     
                
        <div class="modal fade" id="myModal2">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                      <h4 class="modal-title">Add Category</h4>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="cat2">Category</label>
                            <input type="text" class="form-control" id="cat2">
                        </div>
                        <% o=0;while(o!=cat.length){%>
                            <p><%out.println(cat[o]);o++;%></p></tr>   
                        <%}%>  
                        <br>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                      <button type="button" id="submit2">Save</button>
                    </div>

                </div>
            </div>
        </div>    
                                       
        <div class="modal" id="myModal3">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                  <h4 class="modal-title">QR code</h4>
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <div class="form-group">
                        <input type="text" class="form-control" required>
                        <button id="generatei">Generate</button>
                    </div>
                    <div class="qrcode" id="qr"></div>
                </div>

                <div class="modal-footer">
                    <button type="button" data-dismiss="modal">Close</button>
                </div>
              </div>
            </div>
        </div>       
        <%
            }
            else{
                out.println("session expired");
            }
        %>
    </body>
</html>
