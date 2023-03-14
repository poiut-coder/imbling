<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
         
<!DOCTYPE html>
<html lang="ko">

<head>

    <jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />

    <title>임블링 관리자 페이지</title>

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

    <jsp:include page="/WEB-INF/views/modules/admin/admin-sidebar.jsp" />

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">

			<jsp:include page="/WEB-INF/views/modules/admin/admin-topbar.jsp" />	

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Content Row -->
                    <div class="row">

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2" onClick="location.href ='/member/userlist'" style="cursor:pointer;">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                현재까지 가입한 회원 수</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${joinedUser}명</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-user fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2" onClick="location.href ='/admin/list'" style="cursor:pointer;">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                지금까지 등록된 상품들</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${productAmount}개</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-gifts fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2" onClick="location.href ='/admin/order-list'" style="cursor:pointer;">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">배송 준비중인 주문
                                            </div>
                                            <div class="row no-gutters align-items-center">
                                                <div class="col-auto">
                                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${unPreparedOrder}건</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-box fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pending Requests Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2" onClick="location.href ='/board/notice'" style="cursor:pointer;">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                답변을 기다리는 문의글</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${needReply}건</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Content Row -->

                    <div class="row">

                        <!-- Area Chart -->
                        <div class="col-xl-8 col-lg-7">
                            <div class="card shadow mb-4">
                              <!-- Card Header -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">이번달 매출</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area">
                                        <canvas id="DrawLineChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Content Row -->
                    
                    <!-- Content Row -->

                    <div class="row">
                        <!-- Bar Chart -->
                        <div class="col-xl-4 col-lg-5">
                            <div class="card shadow mb-4">
                                <!-- Card Header -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">구매내역이 있는 회원 비율</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-pie pt-4 pb-2">
                                        <canvas id="barChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                       <!-- Pie Chart -->
                        <div class="col-xl-4 col-lg-5">
                            <div class="card shadow mb-4">
                                <!-- Card Header -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">승인/미승인 회원 비율</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-pie pt-4 pb-2">
                                        <canvas id="pieChart" ></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Pie Chart2 -->
                        <div class="col-xl-4 col-lg-5">
                            <div class="card shadow mb-4">
                                <!-- Card Header -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">주문 내역이 있는 상품 비율</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-pie pt-4 pb-2">
                                        <canvas id="pieChart2" ></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>

                    <!-- Content Row -->
                    

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2021</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

	<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp" />

</body>
<script type="text/javascript">
$(function(){
// 라인차트 시작
// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

function number_format(number, decimals, dec_point, thousands_sep) {
  // *     example: number_format(1234.56, 2, ',', ' ');
  // *     return: '1 234,56'
  number = (number + '').replace(',', '').replace(' ', '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}

var list = [];
var pricelist = [];
var dataset = null;

$.ajax({
	"url": "/sales-data-by-date",
	"method": "get",
	"dataType": "json", 
	"success": function(data) {
		dataset=data;
		for(var i=0; i<dataset.length; i++){
			list.push(dataset[i].orderAddr);
			pricelist.push(Number(dataset[i].orderNo));
			setTimeout(lineChart,100);
		}
	},
	"error": function(err) {
		console.log('매출 데이터 호출 실패.');
	}
});

// Area Chart Example
var ctx = document.getElementById("DrawLineChart");

function lineChart(){
	new Chart(ctx, {
		  type: 'line',
		  data: {
		    labels: list,
		    datasets: [{
		      label: "매출액",
		      lineTension: 0.3,
		      backgroundColor: "rgba(78, 115, 223, 0.05)",
		      borderColor: "rgba(78, 115, 223, 1)",
		      pointRadius: 3,
		      pointBackgroundColor: "rgba(78, 115, 223, 1)",
		      pointBorderColor: "rgba(78, 115, 223, 1)",
		      pointHoverRadius: 3,
		      pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
		      pointHoverBorderColor: "rgba(78, 115, 223, 1)",
		      pointHitRadius: 10,
		      pointBorderWidth: 2,
		      data: pricelist
		    }],
		  },
		  options: {
		    maintainAspectRatio: false,
		    layout: {
		      padding: {
		        left: 10,
		        right: 25,
		        top: 25,
		        bottom: 0
		      }
		    },
		    scales: {
		      xAxes: [{
		        time: {
		          unit: 'date'
		        },
		        gridLines: {
		          display: false,
		          drawBorder: false
		        },
		        ticks: {
		          maxTicksLimit: 7
		        }
		      }],
		      yAxes: [{
		        ticks: {
		          maxTicksLimit: 5,
		          padding: 10,
		          callback: function(value, index, values) {
		            return number_format(value)+'원';
		          }
		        },
		        gridLines: {
		          color: "rgb(234, 236, 244)",
		          zeroLineColor: "rgb(234, 236, 244)",
		          drawBorder: false,
		          borderDash: [2],
		          zeroLineBorderDash: [2]
		        }
		      }],
		    },
		    legend: {
		      display: false
		    },
		    tooltips: {
		      backgroundColor: "rgb(255,255,255)",
		      bodyFontColor: "#858796",
		      titleMarginBottom: 10,
		      titleFontColor: '#6e707e',
		      titleFontSize: 14,
		      borderColor: '#dddfeb',
		      borderWidth: 1,
		      xPadding: 15,
		      yPadding: 15,
		      displayColors: false,
		      intersect: false,
		      mode: 'index',
		      caretPadding: 10,
		      callbacks: {
		        label: function(tooltipItem, chart) {
		          var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
		          return datasetLabel + ': ' + number_format(tooltipItem.yLabel)+"원";
		        }
		      }
		    }
		  }
		});
}
//라인 차트 끝	

//바 차트 시작
var barDataset = [];

$.ajax({
	"url": "/purchase-data",
	"method": "get",
	"dataType": "json", 
	"success": function(data) {
		barDataset=data;
		setTimeout(barChart,100);
	},
	"error": function(err) {
		console.log('구매 회원 데이터 호출 실패.');
	}
});

var bpc = document.getElementById("barChart");

function barChart(){
	new Chart(bpc, {
		type: 'bar',
	    data: {
	    	labels: ['전체회원(승인회원)', '구매내역 있음','구매내역 없음'],
	        datasets: [{
	          data: barDataset,
	          backgroundColor: [
	            '#9DCEFF',
	            'pink',
	            '#F2F3F6'
	          ],
	          borderWidth: 0,
	          scaleBeginAtZero: true,
	        }
	      ]
	    },
	    options:{
                legend: {
                    display: false
                },
        	    scales: {
        			yAxes: [{
        				ticks: {
        					min: 0
        				}
        			}]
        		}
        }
	})
};
//바 차트 끝

//도넛 차트 시작
var pieDataset = [];

$.ajax({
	"url": "/valid-user-data",
	"method": "get",
	"dataType": "json", 
	"success": function(data) {
		pieDataset=data;
		setTimeout(pieChart,100);
	},
	"error": function(err) {
		console.log('승인 회원 데이터 호출 실패.');
	}
});

var dpc = document.getElementById("pieChart");

function pieChart(){
	new Chart(dpc, {
		type: 'doughnut',
	    data: {
	    	labels: ['승인', '미승인'],
	        datasets: [{
	          data: pieDataset,
	          backgroundColor: [
	            '#9DCEFF',
	            '#F2F3F6'
	          ],
	          borderWidth: 0,
	          scaleBeginAtZero: true,
	        }
	      ]
	    },
		options: { 
			rotation: 1 * Math.PI, 
			circumference: 1 * Math.PI,
		} 
	})
}
//도넛 차트 끝

//파이 차트 시작
var circleDataset = [];

$.ajax({
	"url": "/order-data",
	"method": "get",
	"dataType": "json", 
	"success": function(data) {
		circleDataset=data;
		setTimeout(circleChart,100);
	},
	"error": function(err) {
		console.log('판매 상품 데이터 호출 실패.');
	}
});

var cpc = document.getElementById("pieChart2");

function circleChart(){
	new Chart(cpc, {
		type: 'pie',
	    data: {
	    	labels: ['주문 내역 있음', '주문 내역 없음'],
	        datasets: [{
	          data: circleDataset,
	          backgroundColor: [
	            'lightyellow',
	            'pink'
	          ],
	          borderWidth: 0,
	          scaleBeginAtZero: true,
	        }
	      ]
	    }
	})
}
//파이 차트 끝

});
</script>

</html>