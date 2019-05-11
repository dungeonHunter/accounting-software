<%-- 
    Document   : dashboard
    Created on : 15 Apr, 2019, 10:22:40 PM
    Author     : winayak
--%>

<%@page import="hibernate.Contact_pojo"%>
<%@page import="hibernate.Items_pojo"%>
<%@page import="hibernate.Sales_pojo"%>
<%@page import="java.util.Iterator"%>
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
        
        <script type="text/javascript" src="js/jquery.classyqr.js"></script>
        
        <script src="https://rawgit.com/sitepoint-editors/jsqrcode/master/src/qr_packed.js"></script>

        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <!-- font awesome icons -->
        <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
        
        <link rel="stylesheet" href="css/index.css">
        <style>
            #main .table th{
                width: 11.11%;
            }
            #main h4 a{
                color: black;
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
            .table tr{
                position: relative;
            }
            .table tbody tr .tabin{
                width: 100px;
                position: absolute;
                text-align: center;
                transform: translate(-50%,25%);
                left: 50%;
                background: rgb(255,255,255,0.9);
                border: 0px;
                padding: 10px;
                display: none;
                cursor: pointer;
            }
            .table tbody tr .tabout{
                width: 50%;
                position: absolute;
                text-align: center;
                transform: translate(-50%,25%);
                left: 50%;
                background: rgb(255,255,255,0.9);
                border: 0px;
                padding: 10px;
                display: none;
                cursor: pointer;
            }
        </style>
        <script>
            $(document).ready(function(){
                var prodiv = $(".pro_div").eq(0).html();
                $("#ddate").parent("div").hide();
                $("#damount").parent("div").hide();
                
                $("#status").change(function(){
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
                    var damount = $("#damount").val();
                    var ddate = $("#ddate").val();
                    var status = $("#status").val();
                    var products = "";
                    var amount = $("#amount").val();
                    var mode = $("#mode").val();
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
                    if($(".products").eq(0).children("option").length==0){
                         alert("please add items first!!");
                         flag =1;
                    } 
                    $(".qty").each(function(){
                       if(parseInt($(this).val())<=0){
                            $(this).attr("placeholder","must be greater than 0!!");
                            $(this).addClass("inp");
                            flag =1;
                       } 
                    });
                    if(mode == ""){
                        $("#mode").attr("placeholder","Required Field!!");
                        $("#mode").addClass("inp");
                        flag = 1;
                    }
                    var i = 0;
                    var amt = 0;
                    $(".products").each(function(){
                        var op = $(this).children("option").text();
                        op = op.replace(/\n/g,"")
                        var pri = op.split("-");
                        amt = amt+parseInt(pri[1])*parseInt($(".qty").eq(i).val());
                        console.log(op+pri[1]+amt);
                        if(products == ""){
                            products = $(this).val()+"("+$(".qty").eq(i).val()+")";
                        }
                        else{
                            products = products+","+$(this).val()+"("+$(".qty").eq(i).val()+")";
                        }
                        i++;
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
                            flag = 1;
                        }
                    }
                    else{
                        damount = 0;
                        ddate = "";
                    }
                    $("#amount").val(amt);
                    amount = amt;
                    if(amount == "" || amount<=0){
                        $("#amount").attr("placeholder","Required Field!!");
                        $("#amount").addClass("inp");
                        flag = 1;
                    }
                    console.log(products);
                    if(flag==0){
                        $.ajax({
                            type: "post",
                            url: "Sales",
                            data: {ddate:ddate,name:name,damount:damount,amount:amount,status:status,products:products,mode:mode},
                            success:function(res){
                                if(res==1){
                                    alert("success!!");
                                }
                                else{
                                    var rarr = res.split("\\,");
                                    var i = 0;
                                    var str = "";
                                    while(i!=rarr.length){
                                        str = rarr[i]+"\n";
                                        i++;
                                    }
                                    alert("Please restock these items first!! \n"+res);
                                }
                            },
                            error:function(res){
                                alert("Error!!");
                            }
                        });
                    }
                    setTimeout(function(){
                        $("#myModal1 input").removeClass("inp");
                        $("#myModal1 input").attr("placeholder","");
                        $("#submit1").prop("disabled",false);
                    },2000);
                });   
                var inflag = 0;
                $("#invoice").click(function(){
                    if(inflag == 0){
                        $(".table tbody .tabin").show();
                        $(".table tbody .tabout").show();
                        inflag=1;
                    }
                    else{
                        $(".table tbody tr .tabin").hide();
                        $(".table tbody .tabout").hide();
                        inflag=0;
                    }
                });
                $(".tabin").click(function(){
                    window.location = "invoice.jsp?code="+$(this).parent().children("td").eq(1).html();
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
        <div id="sidebar" class="col-xl-2 collapse show">
            <a href="dashboard.jsp">Dashboard</a>
            <a href="items.jsp">Items</a>
            <a href="#" class="active">Sales</a>
            <a href="purchases.jsp">Purchases</a>
            <a href="contact.jsp">Contacts</a>
            <a href="myaccount.jsp">Account</a>
        </div>
        <% if(session.getAttribute("email") != null){
        %>
        <div class="col-12 col-lg-12 col-xl-10" id="main"> 
            <h4>
                <span  data-toggle="tooltip" title="Add Sales" style="float: left;transform:translate(-10px,-10px);border-left: 0px;border-right: 1px solid #d0d0d0;"><i class="fas fa-plus" data-toggle="modal" data-target="#myModal1"></i></span>
                Sales 
                <span id="scan"  data-toggle="tooltip" title="Scan Item"><a href="#" data-toggle="modal" data-target="#myModal2"><i class="fas fa-camera"></i></a></span>
                <span id="invoice" data-toggle="tooltip" title="Invoice"><i class="fas fa-file-invoice"></i></span>
            </h4>   
            <div class="table_div">
                <table class="table">
                   <thead>
                     <tr>
                       <th>Customer</th>
                       <th>Order No</th>
                       <th>Date</th>
                       <th>Status</th>
                       <th>Due date</th>  
                       <th>Due Amount</th>  
                       <th>Amount</th>      
                       <th>Products</th>
                       <th>Payment Mode</th>
                     </tr>
                   </thead>
                   <tbody>
                        <% 
                            App obj = new App();
                            List l = obj.fetch_sales();
                            Sales_pojo obj2 = new Sales_pojo();
                            Iterator i = l.iterator();
                            while(i.hasNext()){
                                obj2 = (Sales_pojo) i.next();
                        %>
                            <tr>
                                <td><%out.println(obj2.getname());%></td>
                                <td><%out.println(obj2.getorderno());%></td>
                                <td><%out.println(obj2.getdate());%></td>
                                <td><%out.println(obj2.getstatus());%></td>
                                <td><%out.println(obj2.getddate());%></td>
                                <td><%out.println(obj2.getdamount());%></td>
                                <td><%out.println(obj2.getamount());%></td>
                                <td><%out.println(obj2.getproducts());%></td>
                                <td><%out.println(obj2.getmode());%></td>
                                <% 
                                    Contact_pojo obj3 = new Contact_pojo();
                                    List l2 = obj.fetch_contact();
                                    Iterator i2 = l2.iterator();
                                    int flag = 0;
                                    while(i2.hasNext()){
                                        obj3 = (Contact_pojo) i2.next();
                                        String name1 = obj3.getname().replaceAll("\\s","");
                                        String name2 = obj2.getname().replaceAll("\\s","");
                                        if(name1.equals(name2)){
                                            flag = 1;
                                            break;
                                        }
                                    }
                                %>
                                <% if(flag==1){
                                    out.println("<td class=tabin>view</td>");
                                }
                                else{
                                    out.println("<td class=tabout>Please add information about this customer to view invoice.</td>");
                                }%>
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
                      <h4 class="modal-title">Add Sales</h4>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="name">Customer</label>
                            <input type="text" class="form-control" id="name">
                        </div>
                        <div class="form-group">
                            <label for="status">Status</label>
                            <select class="form-control" id="status">
                                <option value="paid">Paid</option>
                                <option value="pending">Pending</option>                                
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="ddate">Due Date</label>
                            <input type="date" class="form-control" id="ddate">
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
                                    <option value="<%out.print(obj3.getcode());%>"><%out.print(obj3.getname());%>-<%out.print(obj3.getsp());%></option>
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
                            <label for="stock">Amount</label>
                            <input type="number" class="form-control" id="amount">
                        </div>
                        <div class="form-group">
                            <label for="stock">Amount Paid</label>
                            <input type="number" class="form-control" id="damount">
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
                                             
        <div class="modal" id="myModal2">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                  <h4 class="modal-title">Scan product</h4>
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <div class="form-group">
                        <input type=file accept="image/*" capture=environment onclick="return showQRIntro();" onchange="openQRCamera(this);" tabindex=-1 class="form-control">
                    </div>                    
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
        <script>
            function showQRIntro() {
                return confirm("Use your camera to take a picture of a QR code.");
              }
            function openQRCamera(node) {
                var reader = new FileReader();
                reader.onload = function() {
                  node.value = "";
                  qrcode.callback = function(res) {
                    if(res instanceof Error) {
                      alert("No QR code found. Please make sure the QR code is within the camera's frame and try again.");
                    } else {
                      alert(res);
                    }
                  };
                  qrcode.decode(reader.result);
                };
                reader.readAsDataURL(node.files[0]);
            }
        </script>
    </body>
</html>
