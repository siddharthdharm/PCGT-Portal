<%@page import="javax.servlet.http.*, java.io.*,java.util.*, javax.servlet.*, java.text.*, java.sql.*" %>


    <!--CODE BY HIGHCHARTS.
        MODIFIED BY SIDDHARTH DHARM.
        LAST UPDATED ON 20/06/2017.
        BITS PILANI HYDERABAD CAMPUS.-->


<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Scatter Graphs</title>

		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
		<style type="text/css">
${demo.css}
		</style>
	</head>
	<body>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<%

    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";         // JDBC Driver Name //
    final String DB_URL = "jdbc:mysql://localhost:3306/pcgt";   // URL of your Database //
    final String USER = "pcgt";                                 // Database credentials //
    final String PASS = "pcgt@mytrah";
    Connection conn = null;
    Statement stmt = null;
    String result3location = "";

    double w = 0;
    int rows = 0;
    int i = 0;
    StringBuilder set = new StringBuilder("[ ");
    StringBuilder set1 = new StringBuilder("[ ");
    StringBuilder set2 = new StringBuilder("[ ");
    StringBuilder set3 = new StringBuilder("[ ");
    StringBuilder set4 = new StringBuilder("[ ");
    StringBuilder set5 = new StringBuilder("[ ");
    StringBuilder set6 = new StringBuilder("[ ");
    StringBuilder set7 = new StringBuilder("[ ");
    StringBuilder set8 = new StringBuilder("[ ");
    StringBuilder set9 = new StringBuilder("[ ");
    StringBuilder set10 = new StringBuilder("[ ");
    StringBuilder set11 = new StringBuilder("[ ");
    StringBuilder set12 = new StringBuilder("[ ");
    StringBuilder set13 = new StringBuilder("[ ");
    StringBuilder set14 = new StringBuilder("[ ");
    StringBuilder set15 = new StringBuilder("[ ");
    StringBuilder set16 = new StringBuilder("[ ");

    try{

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL,USER,PASS);

    String g2 = "SELECT COUNT(*) FROM `binneddata` WHERE count > 0;";
    stmt = conn.createStatement();
    ResultSet rs1 = stmt.executeQuery(g2);
    while(rs1.next()){
    int count = rs1.getInt("COUNT(*)");
    rows = count;
    }
    stmt.close();

    String g1 = "SELECT * FROM `binneddata` WHERE count > 0;";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(g1);
    i = 0;
    while(rs.next()){
        double windspeedavg = rs.getDouble("windspeedavg");
        double power = rs.getDouble("poweravg");
        double stddev = rs.getDouble("stddev");
        double pitchavg = rs.getDouble("pitchavg");
        double cpavg = rs.getDouble("cpavg");
        
        if(i==rows-1) {
            set.append("["+windspeedavg+", "+power+"] ");
            set13.append("["+windspeedavg+", "+pitchavg+"] ");
            set14.append("["+windspeedavg+", "+cpavg+"] ");
        }
        else if(i<rows-1) {
            set.append("["+windspeedavg+", "+power+"], ");
            set13.append("["+windspeedavg+", "+pitchavg+"], ");
            set14.append("["+windspeedavg+", "+cpavg+"], ");
        }
        i++;
    }
    set.append(" ]");
    set13.append(" ]");
    set14.append(" ]");

    stmt.close();


    String g3 = "SELECT COUNT(*) FROM rawdata2";
    stmt = conn.createStatement();
    ResultSet rs2 = stmt.executeQuery(g3);
    while(rs2.next()){
    int count = rs2.getInt("COUNT(*)");
    rows = count;
    }
    stmt.close();

    i = 0;
    String g4 = "SELECT * from rawdata2";
    stmt = conn.createStatement();
    ResultSet rs3 = stmt.executeQuery(g4);
    while(rs3.next()){

    double powermin = rs3.getDouble("power_min");
    double powermax = rs3.getDouble("power_max");
    double windspeed = rs3.getDouble("windspeed");
    double pitch = rs3.getDouble("pitchangle");
    double cp = rs3.getDouble("cp");
    double gridfrequency = rs3.getDouble("frequency");
    double rotorrpm = rs3.getDouble("rotorrpm");
    double rotorrpm_sd = rs3.getDouble("rotorrpm_sd");
    double turbulenceintensity = rs3.getDouble("ti");
    double temp = rs3.getDouble("temperature");
    double pressure = rs3.getDouble("pressure");
    double rawpower = rs3.getDouble("power");
    double powersd = rs3.getDouble("power_sd");
    double rotorrpmmin = rs3.getDouble("rotorrpm_min");
    double rotorrpmmax = rs3.getDouble("rotorrpm_max");

    if(i==rows-1){
    set1.append("["+windspeed+", "+powersd+"] ");
    set2.append("["+windspeed+", "+powermin+"] ");
    set3.append("["+windspeed+", "+powermax+"] ");
    set4.append("["+windspeed+", "+pitch+"] ");
    set5.append("["+windspeed+", "+cp+"] ");
    set6.append("["+windspeed+", "+gridfrequency+"] ");
    set7.append("["+windspeed+", "+rotorrpm+"] ");
    set8.append("["+windspeed+", "+rotorrpm_sd+"] ");
    set9.append("["+windspeed+", "+turbulenceintensity+"] ");
    set10.append("["+windspeed+", "+temp+"] ");
    set11.append("["+windspeed+", "+pressure+"] ");
    set12.append("["+windspeed+", "+rawpower+"] ");
    set15.append("["+windspeed+", "+rotorrpmmin+"] ");
    set16.append("["+windspeed+", "+rotorrpmmax+"] ");

    }
    else if(i<rows-1){
    set1.append("["+windspeed+", "+powersd+"], ");
    set2.append("["+windspeed+", "+powermin+"], ");
    set3.append("["+windspeed+", "+powermax+"], ");
    set4.append("["+windspeed+", "+pitch+"], ");
    set5.append("["+windspeed+", "+cp+"], ");
    set6.append("["+windspeed+", "+gridfrequency+"], ");
    set7.append("["+windspeed+", "+rotorrpm+"], ");
    set8.append("["+windspeed+", "+rotorrpm_sd+"], ");
    set9.append("["+windspeed+", "+turbulenceintensity+"], ");
    set10.append("["+windspeed+", "+temp+"], ");
    set11.append("["+windspeed+", "+pressure+"], ");
    set12.append("["+windspeed+", "+rawpower+"], ");
    set15.append("["+windspeed+", "+rotorrpmmin+"], ");
    set16.append("["+windspeed+", "+rotorrpmmax+"], ");

    }
    
    i++;

    }
    set1.append(" ]");
    set2.append(" ]");
    set3.append(" ]");
    set4.append(" ]");
    set5.append(" ]");
    set6.append(" ]");
    set7.append(" ]");
    set8.append(" ]");
    set9.append(" ]");
    set10.append(" ]");
    set11.append(" ]");
    set12.append(" ]");
    set15.append(" ]");
    set16.append(" ]");

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

<div id="container" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>

		<script type="text/javascript">

Highcharts.chart('container', {

    chart: {
        type: 'spline',
        name: 'Average',
        data: <% out.println(set); %>,
        marker: {
            lineWidth: 2,
            lineColor: Highcharts.getOptions().colors[3],
            fillColor: 'white'
        }
    },

    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Binned Wind Speed vs. Power'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Power (kW)'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Power Min',
        color: 'rgba(265, 165, 0, .5)',
        data: <% out.println(set2); %>
    }, {
        name: 'Power Max',
        color: 'rgba(10, 222, 222, .5)',
        data: <% out.println(set3); %>
    }, {
        name: 'Power Mean',
        color: 'rgba(128, 128, 128, .5)',
        data: <% out.println(set12); %>
    }, {
        name: 'Power STD DEV',
        color: 'rgba(255, 255, 0, .5)',
        data: <% out.println(set1); %>
    }, {
        type: 'line',
        name: 'Binned Mean',
        color: 'rgba(255, 0, 0, 1)',
        data: <% out.println(set); %>
    }]
});


		</script><br><br>


        <!-- 2nd Scatter Plot -->


        <div id="container1" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container1', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Pitch vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Power (kW)'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Pitch',
        color: 'rgba(163, 255, 43, 0.5)',
        data: <% out.println(set4); %>
    }, {
        type: 'line',
        name: 'Binned Pitch Mean',
        color: 'rgba(255, 0, 0, 1)',
        data: <% out.println(set13); %>
    }]
});


        </script><br><br>


        <!-- 3rd Scatter Plot -->


        <div id="container2" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container2', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Cp vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Cp'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Cp',
        color: 'rgba(163, 255, 43, 0.5)',
        data: <% out.println(set5); %>
    }, {
        type: 'line',
        name: 'Binned Cp Mean',
        color: 'rgba(255, 0, 0, 1)',
        data: <% out.println(set14); %>
    }]
});


        </script><br><br>


        <!-- 4th Scatter Plot -->


        <div id="container3" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container3', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Grid Frequency vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Grid Frequency'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Grid Frequency',
        color: 'rgba(35, 102, 237, .5)',
        data: <% out.println(set6); %>
    }]
});


        </script><br><br>


        <!-- 5th Scatter Plot -->


        <div id="container4" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container4', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Rotor RPM vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'ROTOR RPM'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Rotor RPM',
        color: 'rgba(35, 102, 237, .5)',
        data: <% out.println(set7); %>
    }, {
        name: 'Rotor RPM S.D',
        color: 'rgba(4, 145, 16, .5)',
        data: <% out.println(set8); %>
    }]
});


        </script><br><br>


        <!-- 6th Scatter Plot -->


        <div id="container5" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container5', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Rotor RPM (Max and Min) vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'RPM'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Rotor RPM Min',
        color: 'rgba(255, 0, 0, 1)',
        data: <% out.println(set15); %>
    }, {
        name: 'Rotor RPM Max',
        color: 'rgba(35, 102, 237, .5)',
        data: <% out.println(set16); %>
    }]
});


        </script><br><br>


        <!-- 7th Scatter Plot -->


        <div id="container6" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container6', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Turbulence Intensity vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Turbulence Intensity'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Turbulence Intensity',
        color: 'rgba(35, 102, 237, .5)',
        data: <% out.println(set9); %>
    }]
});


        </script><br><br>


        <!-- 8th Scatter Plot -->


        <div id="container7" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container7', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Temperature vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Temperature'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Temperature',
        color: 'rgba(35, 102, 237, .5)',
        data: <% out.println(set10); %>
    }]
});


        </script><br><br>


        <!-- 9th Scatter Plot -->


        <div id="container8" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container8', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Atmospheric Pressure vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Atmospheric Pressure'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Atmospheric Pressure',
        color: 'rgba(35, 102, 237, .5)',
        data: <% out.println(set11); %>
    }]
});


        </script><br><br>

	</body>
</html>