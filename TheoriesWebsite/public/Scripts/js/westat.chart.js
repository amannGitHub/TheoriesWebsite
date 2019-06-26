(function ($) {
        var rowData = [];
        $("#datatable tr").each(function(){
            var cellData = [];
            var tableCell = $(this).find('td');
            if (tableCell.length) {
                tableCell.each(function(){
                        cellData.push($(this).html());
                });
                //alert(cellData);
                rowData.push({
                        name: cellData[0],
                        desc: cellData[1],
                        y: parseInt(cellData[2]),
                        cont: cellData[3],
                        //link: name.find('a').attr('href')
                });
            }
        });

        $('#ps-timeline-1').highcharts({
             chart: {
                 type: 'line',
                 marginLeft: 40,
                 marginRight:100,
                 marginTop:50,
                 marginBottom:100,
		 //width:1260,
             },
             title: {
                 text: ''
             },
             subtitle: {
                 //text: 'Theories sorted by year first published'
             },
	     legend: {
		enabled: false
	     },
             credits: {
		enabled: false
             },
             yAxis: [{
                // ceiling: 2015,
                // floor: 1900,
                 //allowDecimals: false,
                 title: {
                     text: '',
		//     style: {
		//	fontSize: '20px',
		//	color: '#000',
		//	fontWeight: '700',
		//	fontFamily: "'Open Sans', Sans-serif",
		//     },
		     //margin: 30
                 },
		 //alternateGridColor: '#fefefe',
		 tickInterval: 5,
		 gridLineColor: '#e5ebef',
		 gridLineWidth: 2,
		 //gridLineDashStyle: '',
		 lineWidth: 1,
		 lineColor:'#e5ebef',
		 //gridZIndex: 1,
		 labels: {
			useHTML: true,
			//distance:40,
			//align: 'right',
			x: 33,
			y: 7,
			//padding:20
			left:0,
			style: {
				color: '#0c7486',
				fontSize: '16px',
				fontFamily: "'Open Sans', sans-serif",
				fontWeight: '700',
				backgroundColor: '#d7e0e6',
				paddingRight: '15px',
				paddingLeft: '15px',
				paddingTop: '5px',
				paddingBottom: '5px',
				borderWidth: '1px',
				borderColor: '#d7e0e6',
				borderRadius: '5px',
				borderStyle: 'solid',
                                //top:'0 !important',
                                //y:0,
                                //x:0,
                                //bottom:0
			},
			formatter: function () {
				return '<div class="yAxes">' + this.value + '</div>';
			}
			
		}
		
		
             }/*, { // right y axis
                linkedTo: 0,
                gridLineWidth: 0,
                opposite: true,
                title: {
                    text: null
                },
                labels: {
                        useHTML: true,
                        left:0,
			style: {
				color: '#B55727',
				fontSize: '16px',
				fontFamily: "'Open Sans', sans-serif",
				fontWeight: '700',
				backgroundColor: '#fff',
				padding: '6px',
				borderWidth: '1px',
				borderColor: '#B55727',
				borderRadius: '5px',
				borderStyle: 'solid'
			},
			formatter: function () {
				return '<div class="yAxes">' + this.value + '</div>';
			}
                },
                showFirstLabel: false
            }*/],
             xAxis: {
                 //allowDecimals: false,
		 labels: {
			enabled: false
		},
		tickColor: 'transparent',
		lineWidth: 0
             },
             tooltip: {
                enabled: false,
//		shape: '',
//		//snap: 1,
//                useHTML: true,
//                shared: false,
//                headerFormat: '<div class="theoDetail clearfix">',
//                pointFormat: '<div class="tlTitle">{point.name}</div><div class="keyConst"><strong>Key Constructs</strong><br />{point.cont}</div><div class="keyDet"><strong>Description</strong><br />{point.desc}</div>',
//                footerFormat: '</div>',
//                //positioner: function (w, h, point) {
//                //    return { x: point.plotX - w / 2, y: point.plotY + 10};
//                //}
//		//zIndex: 1000,
//                //padding: 0,
//                style: {
//                        padding:0,
//                },
//                borderWidth:0,
//                backgroundColor: 'none',
//                shadow: false
             },
             plotOptions: {
                 series: {
                    // cursor: 'pointer',
                    // point: {
                    //    events: {
                    //        click: function (e) {
                    //            hs.htmlExpand(null, {
                    //                pageOrigin: {
                    //                    x: e.pageX || e.clientX,
                    //                    y: e.pageY || e.clientY
                    //                },
                    //                //headingText: this.name,
                    //                maincontentText: '<div class="tlTitle">' + this.name + '</div>' +
                    //                '<div class="keyConst"><strong>Key Constructs</strong><br />' + this.cont +
                    //                '</div><div class="keyDet"><strong>Description</strong><br />' + this.desc + '</div>',
                    //                width: 300
                    //            });
                    //        }
                    //    }
                    //},
                     lineWidth:0,
                     lineColor: 'transparent',
		     enableMouseTracking: false,
                     marker: {
                         enabled: true,
                         fillColor: '#0c7486',
                         lineWidth: 0,
                         lineColor: '#B55727',
                         x:-5,
			 width: 9,
			 height: 9,
//			 states: {
//			  hover: {
//				enabled: false,
//				fillColor: '#FF0000',
//				lineWidth: 0,
//				lineColor: '#B55727',
//				x:-6,
//				width: 10,
//				height: 10,
//                            },
//			    select: {
//				enabled: true,
//				fillColor: '#FF0000',
//				lineWidth: 0,
//				lineColor: '#B55727',
//				x:-6,
//				width: 10,
//				height: 10,
//			    }
//			 }
                     },
                     dataLabels: {
                        enabled: true,
                        //shape: 'callout',
                        //borderRadius: 5,
			//backgroundColor: '#fff',
			//borderWidth: 0,
			//borderColor: '#B55727',
			//zIndex:-1,
			//padding:10,
                         style: {
                             color: '#000',
                             textShadow: 'none',
			     fontFamily: "'Open Sans', sans-serif",
			     fontSize: '30px',
			     fontWeight: '400',
                         },
                         align: 'center',
                         formatter: function () {
          			return '<div class="labWrapper clearfix">' + this.point.y + '<br /><h3 class="ps-accordion-head theory-timeline">' + this.point.name + '</h3><div class="ps-accordion-body labDet theory-timeline">' + //<span class="tlTitle">' + this.point.name + '</span>' +
                                    '<div class="keyConst"><strong>Key Constructs</strong><br />' + this.point.cont +
                                    '</div><div class="keyDet"><strong>Description</strong><br />' + this.point.desc + '</div></div></div>'
                        },
                        useHTML: true,
                        //y: 10,
			//x: -100,
                        verticalAlign: 'middle',
			zIndex: 2,
			//inside: false,
                        //padding:0,
                     },
		     //stickyTracking: false,
                 }
             },
             series: [{
                 name: 'Theories Timeline',
                 data: rowData
             }]
             
        });
	// Timeline pager
	$('.w-timeline-pager .w-tm-left a').click(function (e) {
		e.preventDefault();
		var leftPos = $('.theo-timeline').scrollLeft();
		console.log(leftPos);
		$(".theo-timeline").animate({
		    scrollLeft: leftPos - 250
		}, 350);
	});
	    
	$('.w-timeline-pager .w-tm-right a').click(function (e) {
		e.preventDefault();
		var leftPos = $('.theo-timeline').scrollLeft();
		console.log(leftPos);
		$(".theo-timeline").animate({
		    scrollLeft: leftPos + 250
		}, 350);
	});
	//var Paged = function() {
	//	this.$container = $('.w-timeline');
	//    
	//	this.init = function() {
	//	    var self = this;
	//	    $('.w-timeline-pager .w-tm-left a').on('click', function(e) {
	//		e.preventDefault();
	//		self.$container.addClass('to-left');
	//	    });
	//    
	//	    $('.w-timeline-pager .w-tm-right a').on('click', function(e) {
	//		e.preventDefault();
	//		self.$container.removeClass('to-right');
	//	    });
	//	}
	//	this.init();
	//}
	//var Paged = new Paged();
	//$('.w-timeline-pager').each(function(){
	//	var parent = $('.w-timeline').width();
	//	var timline = $('.highcharts-container').width();
	//	
	//	
	//});
})(jQuery);