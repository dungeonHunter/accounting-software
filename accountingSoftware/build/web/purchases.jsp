<%-- 
    Document   : dashboard
    Created on : 15 Apr, 2019, 10:22:40 PM
    Author     : winayak
--%>

<%@page import="hibernate.Items_pojo"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="hibernate.Purchases_pojo"%>
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
                width: 12.25%;
            }
            .pro_div{
                width: 100%;
                display: inline-block;
            }
            #myModal1 .form-group{
                overflow: hidden;
            }
            #myModal1 label{
                width: 100%;
            }
            #pro_but button{
                background: #f1f1f1;
                border-radius: 5px;
                border: 0;
                border: 1px solid #dedede;
                margin-top: 15px;
                padding: 8.5px;
                width: 50%;
                float: left;
            }
            #pro_o{
                white-space: nowrap;
                overflow-x: scroll;
                display: inline-block;
                width: 100%;
            }
            .pro_div{
                position: relative;
            }
            .pro_div button{
                background: #f1f1f1;
                position: absolute;
                top:50%;
                left: 50%;
                transform: translate(-50%,-50%);
                color: #333;
                padding: 10px 15px;
                border-radius: 5px;
                display: none;
            }
        </style>
        <script>
            $(document).ready(function(){
                var prodiv = $(".pro_div").eq(0).html();
                $("#ddate").parent("div").hide();
                $("#damount").parent("div").hide();
                
                $(document).on("change","#status",function(){
                    if($(this).val()=="pending"){
                        $("#ddate").parent("div").show();
                        $("#damount").parent("div").show();
                    }
                    else{
                        $("#ddate").parent("div").hide();
                        $("#damount").parent("div").hide();
                    }
                });
                var flag2 = 0;
                $("#pro_but button").eq(1).click(function(){
                    if(flag2==0){
                        $(".pro_div").css("opacity","0.5");
                        flag2 = 1;  
                        $(".pro_div input").attr("disabled",true);
                        $(".pro_div select").attr("disabled",true);
                        $(".pro_div button").show();
                        $("#pro_but button").eq(0).attr("disabled",true);
                    }
                    else{
                        $(".pro_div").css("opacity","1");
                        $(".pro_div input").attr("disabled",false);
                        $(".pro_div select").attr("disabled",false);
                        $(".pro_div button").hide();
                        $("#pro_but button").eq(0).attr("disabled",false);
                        flag2 = 0;   
                    }
                });
                
                $(document).on("click",".pro_div button",function(){
                    if(flag2==1){
                        $(this).parent().remove();
                        $(".pro_div").css("opacity","1");
                        $(".pro_div input").attr("disabled",false);
                        $(".pro_div select").attr("disabled",false);
                        $(".pro_div button").hide();
                        $("#pro_but button").eq(0).attr("disabled",false);
                        flag2=0;
                    }
                });
                
                                
                
                $("#pro_but button").eq(0).click(function(){
                    $("#pro_o").append("<div class='"+"pro_div"+"'>"+prodiv+"</div>");
                });
                $("#submit1").click(function(e){
                    e.preventDefault();
                    var name = $("#name").val();
                    var status = $("#status").val();
                    var damount = $("#damount").val();
                    var ddate = $("#ddate").val();
                    var amount = $("#amount").val();
                    var mode = $("#mode").val();
                    var products = "";
                    var flag = 0;
                    if(name == ""){
                        $("#name").attr("placeholder","Required Field!!");
                        $("#name").addClass("inp");
                        flag = 1;
                    }
                    if(status == ""){
                        $("#status").attr("placeholder","Required Field!!");
                        $("#status").addClass("inp");
                        flag = 1;
                    }
                    if(ddate == "" && status=="pending"){
                        $("#ddate").attr("placeholder","Required Field!!");
                        $("#ddate").addClass("inp");
                        flag = 1;
                    }
                    if(amount == ""){
                        $("#amount").attr("placeholder","Required Field!!");
                        $("#amount").addClass("inp");
                        flag = 1;
                    }
                    else if(parseInt(amount) <=0){
                        $("#amount").val("");
                        $("#amount").attr("placeholder","must be greater than 0");
                        $("#amount").addClass("inp");
                        flag = 1;
                    }
                    if($(".products").eq(0).children("option").length==0){
                         alert("please add items first!!");
                         flag =1;
                    } 
                    if(mode == ""){
                        $("#mode").attr("placeholder","Required Field!!");
                        $("#mode").addClass("inp");
                        flag = 1;
                    }
                    var i = 0;
                    $(".products").each(function(){
                        if(products == ""){
                            products = $(this).val()+"("+$(".qty").eq(i).val()+")";
                        }
                        else{
                            products = products+","+$(this).val()+"("+$(".qty").eq(i).val()+")";
                        }
                        i++;
                    });
                    $(".qty").each(function(){
                       if(parseInt($(this).val())<=0){                      
                            $(this).attr("placeholder","must be greater than 0!!");
                            $(this).addClass("inp");
                            flag =1;
                       } 
                    });
                    if(status=="pending"){
                        if($("#damount").val() == ""){
                            $("#damount").attr("placeholder","Required Field!!");
                            $("#damount").addClass("inp");
                            flag = 1;
                        }

                        else if(parseInt(damount)>parseInt(amount) || parseInt(damount)<=0){
                            $("#damount").val("");
                            $("#damount").attr("placeholder","must be greater than 0 and less than amount");
                            $("#damount").addClass("inp");
                            console.log(damount);
                            console.log(amount);
                            flag = 1;
                        }
                    }
                    else{
                        damount = 0;
                        ddate = "";
                    }
                    if(flag==0){
                        $.ajax({
                            type: "post",
                            url: "Purchases",
                            data: {name:name,damount:damount,status:status,amount:amount,ddate:ddate,products:products,mode:mode},
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
            <a href="items.jsp">Items</a>
            <a href="sales.jsp">Sales</a>
            <a href="#" class="active">Purchases</a>
            <a href="contact.jsp">Contacts</a>
            <a href="myaccount.jsp">Account</a>
        </div>
        <div>
        <% if(session.getAttribute("email") != null){
        %>
        <div class="col-12 col-lg-12 col-xl-10" id="main"> 
            <h4>
                <span  data-toggle="tooltip" title="Add Purchases" style="float: left;transform:translate(-10px,-10px);border-left: 0px;border-right: 1px solid #d0d0d0;" ><i data-toggle="modal" data-target="#myModal1" class="fas fa-plus"></i></span>
                Purchases         
            </h4> 
            <div class="table_div">
                <table class="table">
                    <thead>
                      <tr>                    
                        <th>Vendor name</th>
                        <th>Status</th>   
                        <th>Due Amount</th>   
                        <th>Amount</th>    
                        <th>Products</th>
                        <th>Date</th>
                        <th>Due Date</th>
                        <th>Mode</th>    
                      </tr>
                    </thead>
                    <tbody>
                       <% 
                            App obj = new App();
                            List l = obj.fetch_purchases();
                            Purchases_pojo obj2 = new Purchases_pojo();
                            Iterator i = l.iterator();
                            while(i.hasNext()){
                                obj2 = (Purchases_pojo) i.next();
                        %>
                            <tr>
                                <td><%out.println(obj2.getname());%></td>
                                <td><%out.println(obj2.getstatus());%></td>
                                <td><%out.println(obj2.getdamount());%></td>
                                <td><%out.println(obj2.getamount());%></td>
                                <td><%out.println(obj2.getproducts());%></td>
                                <td><%out.println(obj2.getdate());%></td>
                                <td><%out.println(obj2.getddate());%></td>
                                <td><%out.println(obj2.getmode());%></td>
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
                      <h4 class="modal-title">Add Purchases</h4>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="name">Vendor Name</label>
                            <input type="text" class="form-control" id="name">
                        </div>
                        <div class="form-group">
                            <label for="cp">Status</label>
                            <select class="form-control" id="status">
                                <option value="paid">Paid</option>
                                <option value="pending">Pending</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="date">Due Date</label>
                            <input type="date" class="form-control" id="ddate">
                        </div>
                        <div class="form-group">
                            <label for="damount">Amount Paid</label>
                            <input type="number" class="form-control" id="damount">
                        </div>
                        <div class="form-group">
                            <label for="sp">Amount</label>
                            <input type="number" class="form-control" id="amount">
                        </div>
                        <div class="form-group">
                            <label for="products">Products</label>
                            <div id="pro_o">
                                <div class="pro_div">
                                    <select class="form-control products">
                                    <% 
                                    Items_pojo obj3 = new Items_pojo();
                                    List l2 = obj.fetch_items();
                                    Iterator i2 = l2.iterator();
                                    while(i2.hasNext()){
                                        obj3 = (Items_pojo) i2.next();
                                    %>
                                    <option value="<%out.println(obj3.getcode());%>"><span class="pro"><%out.println(obj3.getname());%><span><span class="price"><%out.println(obj3.getsp());%><span></option>
                                    <%}%>
                                    </select>
                                    <br>
                                    <input type="text" class="form-control qty" value="0">
                                    <button><i class="fas fa-trash"></i></button>
                                </div>
                            </div>
                            <div id="pro_but">
                                <button><i class="fas fa-plus"></i></button>
                                <button><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="mode">Mode</label>
                            <input type="text" class="form-control" id="mode">
                        </div>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                      <button type="button" id="submit1">Save</button>
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
