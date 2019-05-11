<%-- 
    Document   : dashboard
    Created on : 15 Apr, 2019, 10:22:40 PM
    Author     : winayak
--%>

<%@page import="hibernate.Sales_pojo"%>
<%@page import="java.util.Iterator"%>
<%@page import="hibernate.Purchases_pojo"%>
<%@page import="hibernate.Items_pojo"%>
<%@page import="configuration.App"%>
<%@page import="java.util.List"%>
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
            #skill1,#skill2{
                width: 100%;
                float: left;
                padding: 10px;
            }
            #skill1 span,#skill2 span{
                display: inline-block;
                height: 10px;
                float: left;
                padding: 7px 0px;
                border: 0px!important;
            }
            #skill1 span:nth-child(1),#skill2 span:nth-child(1){
                background: #95adb0;
            }
            #skill1 span:nth-child(2),#skill2 span:nth-child(2){
                background: #c58181;
            }
            #main h4 span a{
                padding: 14.5px 20px;
                display: inline-block;
                text-decoration: none;
            }
        </style>
        <script>
            $(document).ready(function(){
                var total1 = parseInt($("#val1").html())+parseInt($("#val2").html());
                var total2 = parseInt($("#val3").html())+parseInt($("#val4").html());
                console.log(total1);
                console.log(total2);
                var val1 = ($("#val1").html()/total1)*100;
                var val2 = ($("#val2").html()/total1)*100;
                var val3 = ($("#val3").html()/total2)*100;
                var val4 = ($("#val4").html()/total2)*100;
                console.log(val3);
                console.log(val4);
                $("#skill1 span").eq(0).css("width",val1+"%");
                $("#skill1 span").eq(1).css("width",val2+"%");
                $("#skill2 span").eq(0).css("width",val3+"%");
                $("#skill2 span").eq(1).css("width",val4+"%");
               
                $("#submit1").click(function(e){
                    e.preventDefault();
                    var cgst = $("#cgst").val();
                    var igst = $("#igst").val();
                    var sgst = $("#sgst").val();
                    var flag = 0;
  
                    if(cgst == ""){
                        $("#cgst").attr("placeholder","Required Field!!");
                        $("#cgst").addClass("inp");
                        flag = 1;
                    }
                    if(sgst == ""){
                        $("#sgst").attr("placeholder","Required Field!!");
                        $("#sgst").addClass("inp");
                        flag = 1;
                    }
                    if(igst == ""){
                        $("#igst").attr("placeholder","Required Field!!");
                        $("#igst").addClass("inp");
                        flag = 1;
                    }
                    console.log(igst+sgst+cgst);
                    if(flag==0){
                        $.ajax({
                            type: "post",
                            url: "Gst",
                            data: {cgst:cgst,igst:igst,sgst:sgst},
                            success:function(res){
                                alert(res);
                            },
                            error:function(res){
                                alert(res);
                            }
                        });
                    }
                    setTimeout(function(){
                        $("#myModal1 input").removeClass("inp");
                        $("#myModal1 input").attr("placeholder","");
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
        <div id="sidebar" class="collapse show col-md-4 col-xl-2">
            <a href="#" class="active">Dashboard</a>
            <a href="items.jsp">Items</a>
            <a href="sales.jsp">Sales</a>
            <a href="purchases.jsp">Purchases</a>
            <a href="contact.jsp">Contacts</a>
            <a href="myaccount.jsp">Account</a>
        </div>
        <% if(session.getAttribute("email") != null){%>
        <div class="col-12 col-lg-12 col-xl-10" id="main"> 
            <h4>Dashboard       
                <span  data-toggle="tooltip" title="GST"><a href="" data-toggle="modal" data-target="#myModal1">GST</a></span>
            </h4>
            <div class="col-12 col-lg-12 col-xl-6" id="rec">
                <div>
                    <h5>Total Receivables</h5>
                    <% 
                        App obj = new App();
                        List l = obj.fetch_sales();
                        Sales_pojo obj2 = new Sales_pojo();
                        Iterator i = l.iterator();
                        int sum = 0,sum2 = 0;
                        while(i.hasNext()){
                            obj2 = (Sales_pojo) i.next();
                            if(obj2.getstatus().equals("paid")){
                                sum = sum + Integer.parseInt(obj2.getamount());
                                
                            }
                            else if(obj2.getstatus().equals("pending")){
                                sum2 = sum2 + Integer.parseInt(obj2.getdamount());
                                
                            }
                        }
                    %>
                    <aside id="skill1"><span></span><span></span></aside>
                    <p><span>Received</span><span id="val1"><%=sum%></span></p>
                    <p style="float: right"><span>Due</span><span id="val2"><%=sum2%></span></p>
                </div>
            </div>
            <div class="col-12 col-lg-12 col-xl-6" id="pay">
                <div>
                    <h5>Total Payables</h5>
                    <% 
                        List l2 = obj.fetch_purchases();
                        Purchases_pojo obj3 = new Purchases_pojo();
                        Iterator i2 = l2.iterator();
                        int sum3 = 0,sum4 = 0;
                        while(i2.hasNext()){
                            obj3 = (Purchases_pojo) i2.next();
                            if(obj3.getstatus().equals("paid")){
                                sum3 = sum3 + Integer.parseInt(obj3.getamount());
                                
                            }
                            else if(obj3.getstatus().equals("pending")){
                                sum3 = sum3 + Integer.parseInt(obj3.getamount()) - Integer.parseInt(obj3.getdamount());
                                sum4 = sum4 + Integer.parseInt(obj3.getdamount());
                                
                            }
                        }
                    %>
                    <aside id="skill2"><span></span><span></span></aside>
                    <p><span>Paid</span><span id="val3"><%=sum3%></span></p>
                    <p style="float: right"><span>Due</span><span id="val4"><%=sum4%></span></p>
                </div>
            </div>
            <div class="col-12 col-lg-12 col-xl-8" id="trans">
                <div>
                    <h5>Pending Transactions</h5>
                    <table class="table">
                        <thead>
                          <tr>
                            <th>Name</th>
                            <th>Date</th>
                            <th>Amount</th>
                            <th>Type</th>
                          </tr>
                        </thead>
                        <tbody>
                            <% 
                                Purchases_pojo obj4 = new Purchases_pojo();
                                Iterator i3 = l2.iterator();
                                
                                while(i3.hasNext()){
                                    obj4 = (Purchases_pojo) i3.next();
                                    if(obj4.getstatus().equals("pending")){                                
                            %>
                                <tr>
                                  <td><%=obj4.getname()%></td>
                                  <td><%=obj4.getdate()%></td>
                                  <td><%=obj4.getdamount()%>
                                  </td>
                                  <td>Purchases</td>
                                </tr>
                            <%}
                                else{
                                    continue;
                                }
                            }%>
                            <% 
                                Sales_pojo obj5= new Sales_pojo();
                                Iterator i4 = l.iterator();
                                
                                while(i4.hasNext()){
                                    obj5 = (Sales_pojo) i4.next(); 
                                    if(obj5.getstatus().equals("pending")){   
                            %>
                                <tr>
                                  <td><%=obj5.getname()%></td>
                                  <td><%=obj5.getdate()%></td>
                                  <td><%=obj5.getamount()%></td>
                                  <td>Sales</td>
                                </tr>
                                 <%}
                                    else{
                                        continue;
                                    }
                                }%>
                        </tbody>
                      </table>
                </div>
            </div>
            <div class="col-12 col-lg-12 col-xl-4" id="alerts">
                <div>
                    <h5>Alerts</h5>
                </div>
            </div>
        </div>    
        <div class="modal fade" id="myModal1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                      <h4 class="modal-title">GST</h4>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="sgst">SGST</label>
                            <input type="number" class="form-control" id="sgst">
                        </div>
                        <div class="form-group">
                            <label for="cgst">CGST</label>
                            <input type="number" class="form-control" id="cgst">                            
                        </div>
                        <div class="form-group">
                            <label for="igst">IGST</label>
                            <input type="number" class="form-control" id="igst">
                        </div>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                      <button type="button" id="submit1">Save</button>
                    </div>

                </div>
            </div>
        </div>
        <%}
        else{
            out.println("session expired");
        }
        %>
    </body>
</html>

