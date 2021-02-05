<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
	
	.admin_div_01{
		width:819px;
		height:403px;
		margin-left:20px;
		margin-top:20px;
		box-shadow: 2px 2px 2px 2px gray;
		padding:20px; 
	}
	.date_txt{
		width:83px;
	}
	.date_txt_end{
		width:83px;
	}
	.chart_div{
		width:95%;
		height:65%;
	}
</style>
<div style="margin-top:90px;"></div>
<div class="admin_div_01 fl">
	<p class="font_40">회원가입 통계</p>
	<p style="width:90%;text-align:right;">
		<input type="text" class="date_txt" readonly="readonly" 
		onchange="ckSearchDate($('#to_sign_up'),$(this))" id="from_sign_up"> ~ <input type="text" class="date_txt_end" readonly="readonly" onchange="ckSearchDate($(this),$('#from_sign_up'))" id="to_sign_up">
		&nbsp;<input type="button" class="btn_01_01" style="height:31px" value="검색"  onclick="setChart($('#from_sign_up').val(),$('#to_sign_up').val(),'sign_up','sign_up_chart')" >   	
	</p>
	<div id="sign_up_chart" class="chart_div"></div>
</div>
<div class="admin_div_01 fl">
	<p class="font_40">모임 통계</p>
	<p style="width:90%;text-align:right;">
		<input type="text" class="date_txt" readonly="readonly" 
		onchange="ckSearchDate($('#to_meeting'),$(this))" id="from_meeting"> ~ <input type="text" class="date_txt_end" readonly="readonly" onchange="ckSearchDate($(this),$('#from_meeting'))" id="to_meeting">   	
		&nbsp;<input type="button" class="btn_01_01" style="height:31px" 
		onclick="setChart($('#from_meeting').val(),$('#to_meeting').val(),'meeting','meeting_chart',['secret','open'])" value="검색"> 
	</p>
	<div id="meeting_chart" class="chart_div"></div>
</div>
<div class="admin_div_01 fl">
	<p class="font_40">모임 참가인원 통계</p>
	<p style="width:90%;text-align:right;">
		<input type="text" class="date_txt" readonly="readonly" 
		onchange="ckSearchDate($('#to_meeting_member'),$(this))" id="from_meeting_member"> ~ 
		<input type="text" class="date_txt_end" readonly="readonly" 
		onchange="ckSearchDate($(this),$('#from_meeting_member'))" id="to_meeting_member">   	
		&nbsp;<input type="button" class="btn_01_01" style="height:31px"
		onclick="setChart($('#from_meeting_member').val(),$('#to_meeting_member').val(),'meeting_member','meeting_member_chart')" value="검색" > 
	</p>
	<div id="meeting_member_chart" class="chart_div"></div>
</div>
<div class="admin_div_01 fl">
	<p class="font_40">신고 통계</p>
	<p style="width:90%;text-align:right;">
		<input type="text" class="date_txt" readonly="readonly" 
		onchange="ckSearchDate($('#to_blame'),$(this))" id="from_blame"> ~ 
		<input type="text" class="date_txt_end" readonly="readonly" 
		onchange="ckSearchDate($(this),$('#from_blame'))" id="to_blame">   	
		&nbsp;<input type="button" class="btn_01_01" style="height:31px"
		onclick="setChart($('#from_blame').val(),$('#to_blame').val(),'blame','blame_chart')" value="검색" > 
	</p>
	<div id="blame_chart" class="chart_div"></div>
</div>
<div class="clear"></div>

<script>
const color_array = ["black","green","skyblue"]
let now = new Date()
let def_to_date = dateToString(now,"-")
now.setDate(now.getDate()-30)
let def_from_date = dateToString(now,"-")
setDatePicker()
setChart(def_from_date,def_to_date,"sign_up","sign_up_chart")
setChart(def_from_date,def_to_date,"meeting","meeting_chart",['secret','open'])
setChart(def_from_date,def_to_date,"meeting_member","meeting_member_chart")
setChart(def_from_date,def_to_date,"blame","blame_chart",['meeting','comment'])
function chartOpt(xAxisData,series){
	var customOption = {
			grid:{
				top:'3%',
				bottom:'10%',
				right:'5%',
				left:'5%',
			},legend: {
				type : 'scroll',
				itemGap : 20,
				itemHeight: 12,
				textStyle:{
					fontSize: 12
				},
				pageIconColor : '#C40452'
			},
		    tooltip: {
		        trigger: 'axis'
		    },
			xAxis: {
				type: 'category',
		        data: xAxisData,
		        boundaryGap: false
		    },
		    yAxis:{
				type: 'value'
			},
			min: function(item){
				 return 0;
			 },
			 max: function(item){
				 return item.max+item.min;
			 },
			series: series
		}
	return customOption
}

function setChart(from,to,type,dom,m_type){
	if(from == '' || from == null || to == '' || to == null){
		alert("날짜를 입력해 주세요.")
		return false;
	}
	$.ajax({
		type:"get",
		dataType:"text",
		url:"/admin/statistics",
		data:{
			to_date:to,
			from_date:from,
			type:type,
			m_type:m_type
		},
		error:function(data){alert("error")}
	}).done(function(data){
		console.log(data)
		var data_obj = JSON.parse(data)
		console.log(data_obj)
		var _dom = document.getElementById(dom)
		chart = echarts.init(_dom);
		var series = []
		var date_list = []
		var temp = 0;
		for(var i=0; i<data_obj.length; i++){
			var data_val = []
			var data_nm = null;
			data_obj[i].forEach(function(item){
				if(i == 0){
					date_list.push(item.date)
				}
				data_val.push(item.num)
				data_nm =item.unit
			})
			series.push({
				type: 'line',
				name: data_nm,
				color: color_array[i],
				data: data_val,
		        hoverAnimation: false,
		        lineStyle: {
		        	width: 1
		        }
			})
		}
		
		var chart_opt= chartOpt(date_list,series);
		chart.setOption(chart_opt);
	})
}
function setDataForUnit(list){
	var temp_unit = '';
	var temp_list = [];
	var temp_key_list = [];
	var temp_date_list = [];
	var obj = new Object();
	var a = 0;
	list.forEach(function(item){
		if(temp_unit === ''){
			temp_key_list.push(item.unit)
			temp_unit = item.unit
		}
		if(temp_unit != item.unit){
			temp_key_list.push(item.unit)
			obj[temp_unit] = temp_list
			temp_unit = item.unit
			temp_list = []
		}
		temp_list.push(item)
		if(list.length-1 == a){
			obj["key_list"] = temp_key_list
			obj[temp_unit] = temp_list
		}
		a++
	})
	return obj;
}

function setDatePicker(){
	$(".date_txt").datepicker({
		dateFormat: 'yy-mm-dd',
		showOn: "button",
		buttonText:"from",
		yearSuffix: "년",
	    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
	})
	$(".date_txt_end").datepicker({
		dateFormat: 'yy-mm-dd',
		showOn: "button",
		buttonText:"to",
		yearSuffix: "년",
	    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
	})
	$('#datepicker').datepicker('setDate', 'today');
	$(".ui-datepicker-trigger").addClass("btn_01_01")
	$(".ui-datepicker-trigger").height("25px")
}

function ckSearchDate(to_node,from_node){
	var to_val = to_node.val()
	var from_val = from_node.val()
	if(to_val != '' && to_val != null && from_val != '' && from_val != null){
		if(stringToDate(from_val,"-")>stringToDate(to_val,"-")){
			to_node.val("")
			from_node.val("")
			return false;
		}
	}
}
function searchDate(to_node,from_node){
	if(to_val != '' && to_val != null && from_val != '' && from_val != null){
		return false;
	}
	
}
</script>