var graph_data=document.getElementById("data_hid").innerHTML
var graph_parsed=JSON.parse(graph_data);
console.log(graph_parsed)
//var topcrops=graph_parsed
/*
var topcrops_sorted=Object.keys(topcrops).sort(function(a,b){
    if(a!='req' | b!='req'){
        return topcrops[b]['total']-topcrops[a]['total']
    }
})

*/
/*-------------- Dashboard Main chart start ------------*/
if ($('#amlinechart4').length) {
    var chart = AmCharts.makeChart("amlinechart4", {
        "type": "serial",
        "theme": "light",
        "legend": {
            "useGraphSettings": true
        },
        "dataProvider": [{
            "Day": 'Monday',
            "Bus": graph_parsed['total_bus']['monday'],
            "Metro": graph_parsed['total_metro']['monday']
        }, {
            "Day": 'Tuesday',
            "Bus": graph_parsed['total_bus']['tuesday'],
            "Metro": graph_parsed['total_metro']['tuesday']
        }, {
            "Day": 'Wednesday',
            "Bus": graph_parsed['total_bus']['wednesday'],
            "Metro": graph_parsed['total_metro']['wednesday']
        }, {
            "Day": 'Thursday',
            "Bus": graph_parsed['total_bus']['thursday'],
            "Metro": graph_parsed['total_metro']['thursday']
        }, {
            "Day": 'Friday',
            "Bus": graph_parsed['total_bus']['friday'],
            "Metro": graph_parsed['total_metro']['friday']
        }, {
            "Day": 'Saturday',
            "Bus": graph_parsed['total_bus']['saturday'],
            "Metro": graph_parsed['total_metro']['saturday']
        }, {
            "Day": 'Sunday',
            "Bus": graph_parsed['total_bus']['sunday'],
            "Metro": graph_parsed['total_metro']['sunday']
        }],
        "startDuration": 0.5,
        "graphs": [{
            "balloonText": "No. of people travelling via Bus are [[value]]",
            "bullet": "round",
            "title": "Bus Travellers (in Thousands)",
            "valueField": "Bus",
            "fillAlphas": 0,
            "lineColor": "#9656e7",
            "type": "smoothedLine",
            "lineThickness": 2,
            "negativeLineColor": "#c69cfd"
        }, {
            "balloonText": "No. of people travelling via Metro are [[value]]",
            "bullet": "round",
            "title": "Metro Travellers (in Thousands)",
            "valueField": "Metro",
            "fillAlphas": 0,
            "lineColor": "#31aeef",
            "type": "smoothedLine",
            "lineThickness": 2,
            "negativeLineColor": "#31aeef",
        }],
        "chartCursor": {
            "cursorAlpha": 5,
            "zoomable": true
        },
        "categoryField": "Day",
        "categoryAxis": {
            
            'labelRotation':45,
            "gridPosition": "start",
            "axisAlpha": 0,
            "fillAlpha": 0.05,
            "fillColor": "#000000",
            "gridAlpha": 0,
            "position": "top"
        },
        "export": {
            "enabled": false
        }
    });
}


/*-------------- individual crop chart start ------------*/
if ($('#amlinechart5').length) {

    data=[
        {'route':'Red Line','people':graph_parsed['total_metroline']['red']},
        {'route':'Yellow Line','people':graph_parsed['total_metroline']['yellow']},
        {'route':'Blue Line','people':graph_parsed['total_metroline']['blue']},
        {'route':'Green Line','people':graph_parsed['total_metroline']['green']},
        {'route':'Violet Line','people':graph_parsed['total_metroline']['violet']},
        {'route':'Orange Line','people':graph_parsed['total_metroline']['orange']},
        {'route':'Magenta Line','people':graph_parsed['total_metroline']['magenta']},
        {'route':'Pink Line','people':graph_parsed['total_metroline']['pink']}
]
    
    

    var chart = AmCharts.makeChart("amlinechart5", {
        "type": "serial",
        "theme": "light",
        "marginRight": 20,
        "marginTop": 17,
        "autoMarginOffset": 20,
        "dataProvider": data,
        "valueAxes": [{
            "logarithmic": false,
            "dashLength": 1,
            "position": "left"
        }],
        "graphs": [{
            "bullet": "round",
            "id": "g1",
            "bulletBorderAlpha": 1,
            "bulletColor": "#FFFFFF",
            "bulletSize": 7,
            "lineThickness": 2,
            "title": "people",
            "type": "smoothedLine",
            "useLineColorForBulletBorder": true,
            "valueField": "people"
        }],
        "chartCursor": {
            "valueLineEnabled": true,
            "valueLineBalloonEnabled": true,
            "valueLineAlpha": 0.5,
            "fullWidth": true,
            "cursorAlpha": 0.05
        },
        "categoryField": "route",
        
        "export": {
            "enabled": false
        }
    });
}

//----------------------------------------

if ($('#ambarchart4').length) {
    
        data=[
            {'route':'Bus No:1','people':graph_parsed['total_busno']['1']},
            {'route':'Bus No:2','people':graph_parsed['total_busno']['2']},
            {'route':'Bus No:3','people':graph_parsed['total_busno']['3']},
            {'route':'Bus No:4','people':graph_parsed['total_busno']['4']},
            {'route':'Bus No:5','people':graph_parsed['total_busno']['5']},
            {'route':'Bus No:6','people':graph_parsed['total_busno']['6']},
            {'route':'Bus No:7','people':graph_parsed['total_busno']['7']},
            {'route':'Bus No:8','people':graph_parsed['total_busno']['8']},
            {'route':'Bus No:9','people':graph_parsed['total_busno']['9']},
            {'route':'Bus No:10','people':graph_parsed['total_busno']['10']},
            {'route':'Bus No:11','people':graph_parsed['total_busno']['11']},
            {'route':'Bus No:12','people':graph_parsed['total_busno']['12']},
            {'route':'Bus No:13','people':graph_parsed['total_busno']['13']},
            {'route':'Bus No:14','people':graph_parsed['total_busno']['14']},
            {'route':'Bus No:15','people':graph_parsed['total_busno']['15']}
        ]
        
    
        var chart = AmCharts.makeChart("ambarchart4", {
            "type": "serial",
            "theme": "light",
            "marginRight": 20,
            "marginTop": 17,
            "autoMarginOffset": 20,
            "dataProvider": data,
            "valueAxes": [{
                "logarithmic": false,
                "dashLength": 1,
                "position": "left"
            }],
            "graphs": [{
                "bullet": "round",
                "id": "g1",
                "bulletBorderAlpha": 1,
                "bulletColor": "#FFFFFF",
                "bulletSize": 7,
                "lineThickness": 2,
                "title": "people",
                "type": "smoothedLine",
                "useLineColorForBulletBorder": true,
                "valueField": "people"
            }],
            "chartCursor": {
                "valueLineEnabled": true,
                "valueLineBalloonEnabled": true,
                "valueLineAlpha": 0.5,
                "fullWidth": true,
                "cursorAlpha": 0.05
            },
            "categoryField": "route",
            
            "export": {
                "enabled": false
            }
        });
    }



   
am4core.useTheme(am4themes_animated);
// Themes end

var chart = am4core.create("chartdiv", am4charts.PieChart3D);
chart.hiddenState.properties.opacity = 0; // this creates initial fade-in

chart.data = [
  {
    type: "Bus",
    value: graph_parsed['usage']['bus']
  },
  {
    type: "Metro",
    value: graph_parsed['usage']['metro']
  },
  {
    type: "Train",
    value: graph_parsed['usage']['train']
  },
  {
    type: "Flight",
    value: graph_parsed['usage']['flight']
  }
];

chart.innerRadius = am4core.percent(40);
chart.depth = 120;

chart.legend = new am4charts.Legend();

var series = chart.series.push(new am4charts.PieSeries3D());
series.dataFields.value = "value";
series.dataFields.depthValue = "value";
series.dataFields.category = "type";
series.slices.template.cornerRadius = 5;
series.colors.step = 3;