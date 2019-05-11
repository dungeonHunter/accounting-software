<%-- 
    Document   : invoice
    Created on : 7 May, 2019, 11:53:11 PM
    Author     : winayak
--%>

<%@page import="hibernate.Login_pojo"%>
<%@page import="hibernate.Contact_pojo"%>
<%@page import="hibernate.Items_pojo"%>
<%@page import="java.util.Iterator"%>
<%@page import="hibernate.Sales_pojo"%>
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
            .table tr{
                width : 20%;
            }
            #invoice{
                width: 900px;
                padding: 20px 0;
                margin: auto;
                overflow: hidden;
            }
            #invoice p{
                border: 0px;
                margin: 0px;
                border: 0px;
                background: #fff;
            }
            #invoice .info p{
                margin-bottom: 0px;
                border-radius: 5px;
                padding: 5px;
                background: #f7f7f7;
                border: 1px solid #dedede;
            }
            #invoice div{
                float: left;
                padding: 10px;
            }
            .head{
                text-align: center;
                width: 100%;
                margin-bottom: 10px;
            }
            #invoice>div:nth-child(7),#invoice div:nth-child(9){                
                float: right!important;
            }
            #invoice .info,#invoice .last{
                padding :10px;
                width: 50%;
            }
            .info_table{
                margin-top: 20px;
                width: 100%;;
            }
            #invoice div:nth-child(9){
                text-align: left;
                width: 100%;
            }
            #invoice div:nth-child(10){
                text-align: right;
                width: 100%;
            }
            #invoice div:nth-child(4){
                width: 100%;
            }
/*            #myModal3 .modal-dialog.modal-dialog-centered{
                min-width: 800px;
            }*/
            .last p{
                padding-bottom: 0px;
            }
            #invoice h5{
                margin-bottom: 15px;
            }
            .head p{
                padding-top: 0px;
            }
            .table thead th{
                width: 20%;
                white-space: nowrap;
            }
            @media only screen and (max-width:1200px){
                #invoice{
                    width: 100%;
                }
                #invoice div{
                    width: 100%!important;
                }
            }
        </style>
        <script>
            $(document).ready(function(){
                var sgst = parseInt($("#sgst").html());
                var igst = parseInt($("#igst").html());
                var cgst = parseInt($("#cgst").html());
                var amt = parseInt($("#total3").html());
                amt = amt + sgst*amt/100 + cgst*amt/100 + igst*amt/100;
                $("#total1").html("Total : "+amt);
                $("#total2").html("Total amount after tax : "+amt);
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
            <a href="sales.jsp" class="active">Sales</a>
            <a href="purchases.jsp">Purchases</a>
            <a href="contact.jsp">Contacts</a>
            <a href="myaccount.jsp">Account</a>
        </div>
        <% if(session.getAttribute("email") != null){
        %>
        <div id="invoice">
            <div class="head">
                <h5>TAX INVOICE</h5>
                <h3>KATHPAL FANCY DRESS</h3>
                <p>Sirsla Road,Mohan Nagar,Kurukshetra(Haryana)</p>
                <p>Deals in : All kinds of dresses for rent and hire for cultural programs</p>
            </div>
            <div class="info">
                <% 
                    App obj = new App();
                    List l = obj.fetch_sales();
                    Sales_pojo obj2 = new Sales_pojo();
                    Iterator i = l.iterator();
                    while(i.hasNext()){
                        obj2 = (Sales_pojo) i.next();
                        if(obj2.getorderno()==Integer.parseInt(request.getParameter("code"))){
                            break;
                        }
                    }
                    Contact_pojo obj4 = new Contact_pojo();
                    List l2 = obj.fetch_contact();
                    Iterator i2 = l2.iterator();
                    int flag = 0;
                    while(i2.hasNext()){
                        obj4 = (Contact_pojo) i2.next();
                        String name1 = obj4.getname().replaceAll("\\s","");
                        String name2 = obj2.getname().replaceAll("\\s","");
                        if(name1.equals(name2)){
                            flag = 1;
                            break;
                        }
                    }
                %>
                <p>Date <%out.println(obj2.getdate());%></p>
                <p>Invoice No <%out.println(obj2.getorderno());%></p>
                <p>State Code</p>                        
            </div>
            <div class="info">
                <p>Transportation Mode</p>
                <p>Vehicle Number</p>
                <p>Date of supply</p>
                <p>Place of supply</p>
            </div>
            <div class="info">
                <h5>Details of receiver(billed to)</h5>
                <p>name <%out.println(obj4.getname());%></p>
                <p>address <%out.println(obj4.getaddress());%></p>
                <p>city <%out.println(obj4.getcity());%></p>
                <p>PAN No <%out.println(obj4.getpanno());%></p>
                <p>State <%out.println(obj4.getstate());%></p>      
                <p>State Code <%out.println(obj4.getstatecode());%></p>
            </div>
            <div class="info_table">
                <table class="table">
                    <thead>
                      <tr>
                        <th>Description</th>
                        <th>Qty</th>
                        <th>Rate</th>
                        <th>Amount</th>  
                      </tr>
                    </thead>
                    <tbody>
                        <%  String[] products = obj2.getproducts().split("\\,");
                            int j= 0;
                            List l3 = obj.fetch_items();
                            Items_pojo obj3 = new Items_pojo();
                            while(j!=products.length){
                                String[] icode = products[j].split("\\(");
                                Iterator i3 = l3.iterator();
                                while(i3.hasNext()){
                                    obj3 = (Items_pojo) i3.next();
                                    if(obj3.getcode().equals(icode[0])){
                                        break;
                                    }
                                }
                                icode[1] = icode[1].replaceAll("[()]","");
                        %>
                        <tr>
                            <td><%out.println(obj3.getname());%></td>
                            <td><%out.println(icode[1]);%></td>
                            <td><%out.println(obj3.getsp());%></td>
                            <td><%out.println(obj3.getsp());%></td>
                        </tr>        
                            <%j++;}%>
                    </tbody>
                </table>
            </div>

            <div class="info">
                <h5>Bank Details</h5>
                <p>Account No : <%out.println(obj4.getacc_no());%></p>
                <p>Branch IFSC : <%out.println(obj4.getbifsc());%></p>
            </div>
            <div class="info">
                <p>Total Amount Before Tax : <span id="total3"><%out.println(obj2.getamount());%></span></p>
                <% 
                    Login_pojo obj5 = new Login_pojo();
                    List l4 = obj.fetch_category(session.getAttribute("email").toString());
                    Iterator i4 = l4.iterator();
                    while(i4.hasNext()){
                        obj5 = (Login_pojo)i4.next();
                    }
                %>
                <p>Add CGST@ : <span id="cgst"><% out.println(obj5.getcgst());%></span></p>
                <p>Add SGST@ : <span id="sgst"><% out.println(obj5.getsgst());%></span></p>
                <p>Add IGST@ : <span id="igst"><% out.println(obj5.getigst());%></span></p>
                <p id="total2"></p>
                <p>Transport charges :</p>
                <p id="total1"></p>
            </div>
            <div class="info">
                <p>Total invoice amount in words : </p>
            </div>
            <div class="last">
                <h5>Term and Conditions:</h5>
                <p>Goods once sold will not be taken back</p>
                <p>Interests @ 18% will be charged if payments is not within 30 days</p>
                <p>All disputes subject to kurukshetra jurisdiction</p>
            </div>
            <div class="last">
                <p>Certified that the particulars above are true and correct</p>
                <p>For:KATHPAL FANCY DRESS</p>
                <br><br><br><br>
                <i>Auth. Sign</i>
            </div>
        </div>
        <%}%>
    </body>
</html>
