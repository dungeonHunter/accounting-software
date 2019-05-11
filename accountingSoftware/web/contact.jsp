<%-- 
    Document   : dashboard
    Created on : 15 Apr, 2019, 10:22:40 PM
    Author     : winayak
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="hibernate.Sales_pojo"%>
<%@page import="hibernate.Contact_pojo"%>
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

        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

        <!-- font awesome icons -->
        <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>        
        
        <link rel="stylesheet" href="css/index.css">
        <style>
            #main .table th{
                width: 9.1%;
            }
        </style>
        <script>
             $(document).ready(function(){
                $("#submit1").click(function(e){
                    e.preventDefault();
                    var email = $("#email").val();
                    var name = $("#name").val();
                    var phone = $("#tel").val();
                    var comp = $("#comp").val();
                    var state = $("#state").val();
                    var scode = $("#scode").val();
                    var address = $("#add").val();
                    var pno = $("#pno").val();
                    var ifsc = $("#bifsc").val();
                    var city = $("#city").val();
                    var accno = $("#accno").val();
                    var flag = 0;
                    var re = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/igm;
                    if($("#name").val() == ""){
                        $("#name").attr("placeholder","Required Field!!");
                        $("#name").addClass("inp");
                        flag = 1;
                    }
                    if($("#email").val() == ""){
                        $("#email").attr("placeholder","Required Field!!");
                        $("#email").addClass("inp");
                        flag = 1;
                    }
                    else if(!re.test(email)){
                        $("#email").attr("placeholder","Required Field!!");
                        $("#email").addClass("inp");
                        flag = 1;
                    }
                    if($("#tel").val() == ""){
                        $("#tel").attr("placeholder","Required Field!!");
                        $("#tel").addClass("inp");
                        flag = 1;
                    }
//                    if($("#comp").val() == ""){
//                        $("#comp").attr("placeholder","Required Field!!");
//                        $("#comp").addClass("inp");
//                        flag = 1;
//                    }
                    if($("#add").val() == ""){
                        $("#add").attr("placeholder","Required Field!!");
                        $("#add").addClass("inp");
                        flag = 1;
                    }
                    if($("#city").val() == ""){
                        $("#city").attr("placeholder","Required Field!!");
                        $("#city").addClass("inp");
                        flag = 1;
                    }
                    if($("#state").val() == ""){
                        $("#state").attr("placeholder","Required Field!!");
                        $("#state").addClass("inp");
                        flag = 1;
                    }
//                    if($("#scode").val() == ""){
//                        $("#scode").attr("placeholder","Required Field!!");
//                        $("#scode").addClass("inp");
//                        flag = 1;
//                    }
//                    if($("#pno").val() == ""){
//                        $("#pno").attr("placeholder","Required Field!!");
//                        $("#pno").addClass("inp");
//                        flag = 1;
//                    }
//                    if($("#accno").val() == ""){
//                        $("#accno").attr("placeholder","Required Field!!");
//                        $("#accno").addClass("inp");
//                        flag = 1;
//                    }
//                    if($("#bifsc").val() == ""){
//                        $("#bifsc").attr("placeholder","Required Field!!");
//                        $("#bifsc").addClass("inp");
//                        flag = 1;
//                    }
                    if(flag==0){
                        $.ajax({
                            type: "post",
                            url: "Contact",
                            data: {email:email,name:name,comp:comp,phone:phone,address:address,scode:scode,state:state,city:city,pno:pno,ifsc:ifsc,accno:accno},
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
            <a href="purchases.jsp">Purchases</a>
            <a href="#" class="active">Contacts</a>
            <a href="myaccount.jsp">Account</a>
        </div>
        <% if(session.getAttribute("email") != null){
        %>
        <div class="col-12 col-lg-12 col-xl-10" id="main"> 
            <h4>
                <span  data-toggle="tooltip" title="Add Info" style="float: left;transform:translate(-10px,-10px);border-left: 0px;border-right: 1px solid #d0d0d0;"><i  data-toggle="modal" data-target="#myModal1" class="fas fa-plus"></i></span>
                Contacts
                <span id="edit"  data-toggle="tooltip" title="Edit"><i class="fas fa-pencil-alt"></i></span>
            </h4>           
            <div class="table_div">
                <table class="table">
                    <thead>
                      <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <!--<th>Balance</th>-->
                        <th>Company name</th>   
                        <th>Address</th>
                        <th>State Code</th>
                        <th>City</th>   
                        <th>State</th>
                        <th>Pan No</th>
                        <th>IFSC</th>
                        <th>Account No</th>   
                      </tr>
                    </thead>
                    <tbody>
                       <% 
                            App obj = new App();
                            List l = obj.fetch_contact();
                            Contact_pojo obj2 = new Contact_pojo();
                            Iterator i = l.iterator();
                            while(i.hasNext()){
                                obj2 = (Contact_pojo) i.next();
                        %>
                        <tr>
                            <td><%out.println(obj2.getname());%></td>
                          <td><%out.println(obj2.getemail());%></td>
                          <td><%out.println(obj2.getphone());%></td>
    <!--                      <td></td>-->
                          <td><%out.println(obj2.getcomp());%></td>
                          <td><%out.println(obj2.getaddress());%></td>
                          <td><%out.println(obj2.getstatecode());%></td>
                          <td><%out.println(obj2.getcity());%></td>
                          <td><%out.println(obj2.getstate());%></td>
                          <td><%out.println(obj2.getpanno());%></td>
                          <td><%out.println(obj2.getbifsc());%></td>
                          <td><%out.println(obj2.getacc_no());%></td>
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
                      <h4 class="modal-title">Add Contacts</h4>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <select id="name" class="form-control">
                                <% 
                                    List l2 = obj.fetch_sales();
                                    Sales_pojo obj3 = new Sales_pojo();
                                    Iterator i2 = l2.iterator();
                                    List l3 = new ArrayList();
                                    String name= "";
                                    while(i2.hasNext()){
                                        obj3 = (Sales_pojo) i2.next();
                                        l3.add(obj3.getname());
                                    }
                                    if(l3!=null){
                                        LinkedHashSet<String> hashSet = new LinkedHashSet(l3);
                                        ArrayList l4 = new ArrayList(hashSet);
                                        Iterator i3 = l4.iterator();
                                %>
                                <%      while(i3.hasNext()){
                                            name = i3.next().toString();
                                %>
                                            <option value="<%out.println(name);%>"><%out.println(name);%></option>
                                <%      }
                                %>
                                <%  }
                                
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email">
                        </div>
                        <div class="form-group">
                            <label for="tel">Phone Number</label>
                            <input type="tel" class="form-control" id="tel">
                        </div>
                        <div class="form-group">
                            <label for="comp">Company Name</label>
                            <input type="text" class="form-control" id="comp">
                        </div>
                        <div class="form-group">
                            <label for="add">Address</label>
                            <input type="text" class="form-control" id="add">
                        </div>
                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" class="form-control" id="city">
                        </div>
                        <div class="form-group">
                            <label for="pno">Pan No</label>
                            <input type="number" class="form-control" id="pno">
                        </div>
                        <div class="form-group">
                            <label for="state">State</label>
                            <input type="text" class="form-control" id="state">
                        </div>
                        <div class="form-group">
                            <label for="scode">State code</label>
                            <input type="number" class="form-control" id="scode">
                        </div>
                        <div class="form-group">
                            <label for="accno">Account No</label>
                            <input type="number" class="form-control" id="accno">
                        </div>
                        <div class="form-group">
                            <label for="bifsc">IFSC</label>
                            <input type="number" class="form-control" id="bifsc">
                        </div>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" id="submit1">Save</button>
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

