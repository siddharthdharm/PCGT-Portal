<%@page import="javax.servlet.http.*, java.io.*,java.util.*, javax.servlet.*, java.text.*, java.sql.*" %>


    <!-- MODIFIED BY SIDDHARTH DHARM.
         LAST UPDATED ON 20/06/2017.
         BITS PILANI HYDERABAD CAMPUS. -->


<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>PCGT Database</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/sb-admin.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

<%

    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";         // JDBC Driver Name //
    final String DB_URL = "jdbc:mysql://localhost:3306/pcgt";   // URL of your Database //
    final String USER = "pcgt";                                 // Database credentials //
    final String PASS = "pcgt@mytrah";
    Connection conn = null;
    Statement stmt = null;

    int powercount = 0;
    int frequencycount = 0;
    int binnedcount = 0;
    String[] sitedetails = new String[15];
    String[] uncertainty = new String[30];
    String[] statwindspeed = new String[1000];
    String[] statpower = new String[1000];
    String[] statfreqwindspeed = new String[1000];
    String[] statfrequency = new String[1000];
    String[] result = new String[10];
    String[][] binned = new String[200][10];
    // String[] cp = new String[100000];
    // String[] ti = new String[100000];
    // String[] rho = new String[100000];
    // String[] corrwindspeed = new String[100000];
    // String[] corrwindspeedmin = new String[100000];
    // String[] corrwindspeedmax = new String[100000];
    // String[] corrwindspeedsig = new String[100000];
    // String[] corrpressure = new String[100000];

    try{

        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL,USER,PASS);

        String q1 = "SELECT * FROM `rawsitedetails`;";
        stmt = conn.createStatement();
        ResultSet rs1 = stmt.executeQuery(q1);
        while(rs1.next()){
            sitedetails[0] = rs1.getString("site_name");
            sitedetails[1] = rs1.getString("from_date");
            sitedetails[2] = rs1.getString("to_date");
            sitedetails[3] = rs1.getString("test_turbine");
            sitedetails[4] = rs1.getString("make");
            sitedetails[5] = rs1.getString("model");
            sitedetails[6] = rs1.getString("turbine_capacity");
            sitedetails[7] = rs1.getString("rotor_diameter");
            sitedetails[8] = rs1.getString("hub_height");
            sitedetails[9] = rs1.getString("test_turbine_location");
            sitedetails[10] = rs1.getString("reference_mast_location");
            sitedetails[11] = rs1.getString("presensorheight");
            sitedetails[12] = rs1.getString("turbinealtitude");
        }
        stmt.close();

        DecimalFormat df = new DecimalFormat("###.#####");

        /*String q2 = "SELECT * FROM `rawdata2`;";
        stmt = conn.createStatement();
        ResultSet rs2 = stmt.executeQuery(q2);
        i = 0;
        while(rs2.next()){
            cp[i] = df.format(rs2.getDouble("cp"));
            ti[i] = df.format(rs2.getDouble("ti"));
            rho[i] = df.format(rs2.getDouble("rho"));
            corrwindspeed[i] = df.format(rs2.getDouble("corrwindspeed"));
            corrwindspeedmin[i] = df.format(rs2.getDouble("corrwindspeedmin"));
            corrwindspeedmax[i] = df.format(rs2.getDouble("corrwindspeedmax"));
            corrwindspeedsig[i] = df.format(rs2.getDouble("corrwindspeedsig"));
            corrpressure[i] = df.format(rs2.getDouble("corrpressure"));
            i++;
        }
        stmt.close();*/

        String q3 = "SELECT * FROM `staticpower`;";
        stmt = conn.createStatement();
        ResultSet rs3 = stmt.executeQuery(q3);
        powercount = 0;
        while(rs3.next()){
            statwindspeed[powercount] = df.format(rs3.getDouble("statwindspeed"));
            statpower[powercount] = df.format(rs3.getDouble("statpower"));
            powercount++;
        }
        stmt.close();

        String q4 = "SELECT * FROM `staticfrequency`;";
        stmt = conn.createStatement();
        ResultSet rs4 = stmt.executeQuery(q4);
        frequencycount = 0;
        while(rs4.next()){
            statfreqwindspeed[frequencycount] = df.format(rs4.getDouble("statwindspeed2"));
            statfrequency[frequencycount] = df.format(rs4.getDouble("statfrequency2"));
            frequencycount++;
        }
        stmt.close();

        String q5 = "SELECT * FROM `uncertainty`;";
        stmt = conn.createStatement();
        ResultSet rs5 = stmt.executeQuery(q5);
        while(rs5.next()){
            uncertainty[0] = rs5.getString("Pn");
            uncertainty[1] = rs5.getString("Ucl");
            uncertainty[2] = rs5.getString("Uvl");
            uncertainty[3] = rs5.getString("Upl");
            uncertainty[4] = rs5.getString("Ud1");
            uncertainty[5] = rs5.getString("Pmr");
            uncertainty[6] = rs5.getString("Upt");
            uncertainty[7] = rs5.getString("Udp");
            uncertainty[8] = rs5.getString("Ud2");
            uncertainty[9] = rs5.getString("Vmr");
            uncertainty[10] = rs5.getString("Uac");
            uncertainty[11] = rs5.getString("Uf");
            uncertainty[12] = rs5.getString("k");
            uncertainty[13] = rs5.getString("Um");
            uncertainty[14] = rs5.getString("Udv");
            uncertainty[15] = rs5.getString("Ud3");
            uncertainty[16] = rs5.getString("Tmr");
            uncertainty[17] = rs5.getString("Uts");
            uncertainty[18] = rs5.getString("Urt");
            uncertainty[19] = rs5.getString("Umot");
            uncertainty[20] = rs5.getString("Udt");
            uncertainty[21] = rs5.getString("Ud4");
            uncertainty[22] = rs5.getString("Prmr");
            uncertainty[23] = rs5.getString("Uprc");
            uncertainty[24] = rs5.getString("Umtpr");
        }
        stmt.close();

        String q6 = "SELECT * FROM `result3`;";
        stmt = conn.createStatement();
        ResultSet rs6 = stmt.executeQuery(q6);
        while(rs6.next()){
            result[0] = df.format(rs6.getDouble("GAE"))+" kWh";
            result[1] = df.format(rs6.getDouble("TUE"))+" kWh";
            result[2] = df.format(rs6.getDouble("GEE"))+" kWh";
            result[3] = df.format(rs6.getDouble("UE"))+" %";
            result[4] = df.format(rs6.getDouble("PP"))+" %";
        }
        stmt.close();

        String q7 = "SELECT * FROM `binneddata` WHERE count > 0;";
        stmt = conn.createStatement();
        binnedcount = 0;
        ResultSet rs7 = stmt.executeQuery(q7);
        while(rs7.next()){
            binned[binnedcount][0] = df.format(rs7.getDouble("speedbin"));
            binned[binnedcount][1] = df.format(rs7.getDouble("speedbinmin"));
            binned[binnedcount][2] = df.format(rs7.getDouble("speedbinmax"));
            binned[binnedcount][3] = df.format(rs7.getDouble("windspeedavg"));
            binned[binnedcount][4] = df.format(rs7.getDouble("poweravg"));
            binned[binnedcount][5] = df.format(rs7.getDouble("pitchavg"));
            binned[binnedcount][6] = df.format(rs7.getDouble("rpmavg"));
            binned[binnedcount][7] = df.format(rs7.getDouble("cpavg"));
            binned[binnedcount][8] = df.format(rs7.getDouble("turbulenceavg"));
            binned[binnedcount][9] = df.format(rs7.getDouble("count"));
            binnedcount++;
        }
        stmt.close();

        conn.close();
    
    }catch(SQLException se){
    //out.println(se);
    //Handle errors for JDBC
    se.printStackTrace();
    }catch(Exception e){
    //out.println(e);
    //Handle errors for Class.forName
    e.printStackTrace();
    }finally{
    //finally block used to close resources
    try{
    if(stmt!=null)
    stmt.close();
    }catch(SQLException se2){
    }// nothing we can do
    try{
    if(conn!=null)
    conn.close();
    }catch(SQLException se){
    se.printStackTrace();
    }//end finally try
    }//end try


%>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html">Mytrah</a>
            </div>
            
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li class="active">
                        <a href="index.html"><i class="fa fa-fw fa-edit"></i> Data Entry</a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="tables.jsp"><i class="fa fa-fw fa-database"></i> View Database</a>
                    </li>
                    <li class="">
                        <a href="clear.jsp"> <i class="fa fa-fw fa-dashboard"></i> Clear Memory</a>
                    </li>
                    <li>
                        <a href="javascript:;" data-toggle="collapse" data-target="#demo" ><i class="fa fa-fw fa-book"></i> PCGT Database <i class="fa fa-fw fa-caret-down"></i></a>
                        <ul id="demo" class="collapse">
                    <li class="">
                        <a href="downloadsitedetails.jsp"> <i class="fa fa-fw fa-table"></i> Site Details</a>
                    </li>     
                    <li class="">
                        <a href="downloadfiltered.jsp"> <i class="fa fa-fw fa-table"></i> Filtered Data</a>
                    </li>
                    <li class="">
                        <a href="downloadbinned.jsp"> <i class="fa fa-fw fa-table"></i> Binned Data</a>
                    </li>
                    <li class="">
                        <a href="downloaduncertainty.jsp"> <i class="fa fa-fw fa-table"></i> Uncertainty Data</a>
                    </li>
                    <li class="">
                        <a href="downloadresult1.jsp"> <i class="fa fa-fw fa-newspaper-o"></i> RESULT 1</a>
                    </li>
                    <li class="">
                        <a href="downloadresult2.jsp"> <i class="fa fa-fw fa-newspaper-o"></i> RESULT 2</a>
                    </li>
                    <li class="">
                        <a href="downloadresult3.jsp"> <i class="fa fa-fw fa-newspaper-o"></i> RESULT 3</a>
                    </li>
                    <li class="">
                        <a href="serverconfig.jsp"> <i class="fa fa-fw fa-database"></i> Server Config</a>
                    </li>
                        </ul>
                    </li>
                    <li class="divider"></li>
                    <li class="">
                        <a href="credits.html"><i class="fa fa-fw fa-trophy"></i> Credits</a>
                    </li>
                    <li>
                        <div class="col-xs-offset-2"><center><i class="fa fa-fw fa-copyright"></i> Mytrah &nbsp;&nbsp;&nbsp; <script type="text/javascript">var cur = 2016; var year = new Date(); if(cur == year.getFullYear()) year = year.getFullYear(); else year = cur + ' - ' + year.getFullYear(); document.write(year);</script></center>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>

        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Tables
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="index.html">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-table"></i> Tables
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-6">
                        <h2>Site Details</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Detail</th>
                                        <th>Value</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Site Name</td>
                                        <td><% out.println(sitedetails[0]); %></td>
                                    </tr>
                                    <tr>
                                        <td>Measurement Period (FROM)</td>
                                        <td><% out.println(sitedetails[1]); %></td>
                                    </tr>
                                    <tr>
                                        <td>Measurement Period (TO)</td>
                                        <td><% out.println(sitedetails[2]); %></td>
                                    </tr>
                                    <tr>
                                        <td>Test Turbine</td>
                                        <td><% out.println(sitedetails[3]); %></td>
                                    </tr>
                                    <tr>
                                        <td>Make</td>
                                        <td><% out.println(sitedetails[4]); %></td>
                                    </tr>
                                    <tr>
                                        <td>Model</td>
                                        <td><% out.println(sitedetails[5]); %></td>
                                    </tr>
                                    <tr>
                                        <td>Turbine Capacity (kW)</td>
                                        <td><% out.println(sitedetails[6]); %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <h2>Site Details (contd.)</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Detail</th>
                                        <th>Value</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Rotor Diameter (m)</td>
                                        <td><% out.println(sitedetails[7]); %></td>
                                    </tr>
                                    <tr>
                                        <td>Hub Height (m)</td>
                                        <td><% out.println(sitedetails[8]); %></td>
                                    </tr>
                                    <tr>
                                        <td>Test Turbine Location</td>
                                        <td><% out.println(sitedetails[9]); %></td>
                                    </tr>
                                    <tr>
                                        <td>Reference Mast Location</td>
                                        <td><% out.println(sitedetails[10]); %></td>
                                    </tr>
                                    <tr>
                                        <td>Pressure Sensor Height (m)</td>
                                        <td><% out.println(sitedetails[11]); %></td>
                                    </tr>
                                    <tr>
                                        <td>Turbine Altitude (m)</td>
                                        <td><% out.println(sitedetails[12]); %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-12">
                        <h2>Uncertainty Data</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Pn</th>
                                        <th>Ucl</th>
                                        <th>Uvl</th>
                                        <th>Upl</th>
                                        <th>Ud1</th>
                                        <th>Pmr</th>
                                        <th>Upt</th>
                                        <th>Udp</th>
                                        <th>Ud2</th>
                                        <th>Vmr</th>
                                        <th>Uac</th>
                                        <th>Uf</th>
                                        <th>k</th>
                                        <th>Um</th>
                                        <th>Udv</th>
                                        <th>Ud3</th>
                                        <th>Tmr</th>
                                        <th>Uts</th>
                                        <th>Urt</th>
                                        <th>Umot</th>
                                        <th>Udt</th>
                                        <th>Ud4</th>
                                        <th>Prmr</th>
                                        <th>Uprc</th>
                                        <th>Umtpr</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                    <%  
                                        for(int j = 0; j < 25; j++) {
                                            out.println("<td>"+uncertainty[j]+"</td>");
                                        }
                                    %>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div><br>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-12">
                        <h2>Result</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Gross Actual Energy</th>
                                        <th>Total Uncertainty in Energy</th>
                                        <th>Gross Estimated Energy</th>
                                        <th>Uncertainty in Energy</th>
                                        <th>Percentage of Performance</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="success">
                                    <%  
                                        for(int j = 0; j < 5; j++) {
                                            out.println("<td>"+result[j]+"</td>");
                                        }
                                    %>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div><br>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-12">
                        <h2>Binned Data</h2><h5><b>(where Count > 0)</b></h5>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Speed Bin</th>
                                        <th>Speed_Min</th>
                                        <th>Speed_Max</th>
                                        <th>Wind_Avg</th>
                                        <th>Power_Avg</th>
                                        <th>Pitch_Avg</th>
                                        <th>RPM_Avg</th>
                                        <th>CP_Avg</th>
                                        <th>Turbulence_Avg</th>
                                        <th>Count</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%  
                                        for(int j = 0; j < binnedcount; j++) {
                                            out.println("<tr>");
                                            for(int k = 0; k < 10; k++)
                                                out.println("<td>"+binned[j][k]+"</td>");
                                            out.println("</tr>");
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div><br>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-6">
                        <h2>Static Power</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Wind Speed (m/s)</th>
                                        <th>Power</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for(int j = 0; j < powercount; j++) {
                                            out.println("<tr>");
                                            out.println("<td>"+statwindspeed[j]+"</td>");
                                            out.println("<td>"+statpower[j]+"</td>");
                                            out.println("</tr>");
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <h2>Static Frequency</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Wind Speed (m/s)</th>
                                        <th>Power</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for(int j = 0; j < frequencycount; j++) {
                                            out.println("<tr>");
                                            out.println("<td>"+statfreqwindspeed[j]+"</td>");
                                            out.println("<td>"+statfrequency[j]+"</td>");
                                            out.println("</tr>");
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>
