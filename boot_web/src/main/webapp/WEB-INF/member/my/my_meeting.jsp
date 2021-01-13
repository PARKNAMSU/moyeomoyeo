<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
#ray_01 {
	color: black;
	text-align: left;
	margin-top: 90px;
	width: 58%;
}

.meet_el {
	width: 301px;
	margin-right: 10px;
	margin-bottom: 10px;
	background-color: #3063C2;
	border-radius: 3%;
	padding: 3%;
	box-shadow: 2px 2px 2px 2px #013ADF;
	overflow: hidden;
	color: white;
	height: 292.646px;
	cursor: pointer;
}

.cycle_01 {
	width: 40px;
	height: 40px;
	border-radius: 70%;
	background-color: #EBFBFF;
	text-align: center;
	font-size: 30px;
	color: black
}

.meet_sub_div_01 {
	width: 95%;
	overflow: hidden
}

.delete_01 {
	color: black;
	z-index: 5;
	text-align: right;
	display:none;
}
</style>
<div id="main_1" class="container-fluid" style="padding-top:90px;padding-bottom:90px;">
	<div class="ray_20" id="ray_01" style="">
		<b class="font_50">나의 모임</b>
		<div class="line_01"></div>
		<div><b>T: 합산 금액</b> <b>I: 개인별 금액</b> <b>O: 오픈 모임</b></div>
		<br><br>
		<div class="fl margin_right_20 cursur_p" onclick="chgFinishYn('n',$('#during_txt'),$('#finish_txt'))" onmouseover="overMenu(1,'over')" onmouseleave="overMenu(1,'leave')">
			<span class="font_30" style="color: #3063C2" id="during_txt">진행중</span>
			<div class="line_01 vis_h" style="height:2px;" id="main_line_1"></div>
		</div>
		<div class="fl cursur_p" onclick="chgFinishYn('y',$('#finish_txt'),$('#during_txt'))" onmouseover="overMenu(2,'over')" onmouseleave="overMenu(2,'leave')">
			<span class="font_30" style="color: black" id="finish_txt">완료</span>
			<div class="line_01 vis_h" style="height:2px;" id="main_line_2"></div>
		</div><div class="clear"></div>
		<div id="room_main_div">
		</div>
	</div>
	<div class="clear"></div>
</div>
<script>
	var finish_yn = "n";
	$(".meet_el").css("height",$(".meet_el").width()+50+"px")
	$(document).ready(function(){
		chkWindowWidth()
		getMyRoom()
		$(window).resize(function(){
			chkWindowWidth()
		})
	})
	function chkWindowWidth(){
		if($(window).width()< 900){
			$("#ray_01").css("margin-left","3%");
			$("#ray_01").css("width","95%");
		}else{
			$("#ray_01").css("margin-left","20%");
			$("#ray_01").css("width","58%");
		}
	}
	
	function overMeet(selector,type,idx){
		if(type === 'over'){
			$(selector).css("opacity","0.8")
		}else if(type === 'leave'){
			$(selector).css("opacity","1")
		}
	}
	function overMenu(idx,type){
		if(type === 'over'){
			$("#main_line_"+idx).css("visibility","visible")
		}else if(type === 'leave'){
			$("#main_line_"+idx).css("visibility","hidden")
		}
	}
	function getMyRoom(){
		$("#room_main_div").empty()
		$.ajax({
			 type:"GET",
			 url:"/member/my_room",
			 dataType:"text",
			 data:{
				 type:finish_yn
			 },
			 error:function(data){alert("error")}
		}).done(function(data){
			var data_obj = JSON.parse(data);
			console.log(data_obj)	
			data_obj.forEach(function(data){
				var type = null;
				if(data.meeting_type === "secret"){
					type = "S"
				}else{
					type = "O"
				}
				var el = '<div class="meet_el fl" onclick="mvMeetingDetail(\''+data.meeting_code+'\')" onmouseover="overMeet(this,\'over\',1)" onmouseleave="overMeet(this,\'leave\',1)" onclick="">'
				+'<div style="width:78%;overflow:hidden;height:40px;" class="fl"><span class="font_30">'+data.meeting_name+'</span></div>'
				+'<div class="fl cycle_01" style="">'+type+'</div><div class="clear"></div>'
				+'<div style="width:95%;height:2px;background-color:#EBFBFF"></div>'
				+'<div class="meet_sub_div_01" style="text-align:right;"><span class="font_15">from: '+data.reg_date+'</span></div>'
				+'<div class="meet_sub_div_01" style="text-align:right;"><span class="font_15">to: '+data.end_date+'</span></div>'
				+'<div class="meet_sub_div_01" style="height:30px;"><span class="font_20">'+data.meeting_goal+'</span></div>'
				+'<div class="meet_sub_div_01" style="height:30px;"><span class="font_20">금액: '+data.meeting_fee+'￦</span></div>'
				+'<div class="meet_sub_div_01" style="height:30px;"><span class="font_20">생성자: '+data.admin_email+'</span></div>'
				+'<div class="meet_sub_div_01"><span class="font_20">참가인원: '+data.meeting_num+'명</span></div>'
				+'</div>'
				$("#room_main_div").append(el)
			})
		})
	}
	function chgFinishYn(yn,c_el,el){
		finish_yn = yn
		c_el.css("color","color: #3063C2")
		el.css("color","black")
		getMyRoom()
	}
	function mvMeetingDetail(code){
		postForm("/member/meeting_page", ["meeting_code","${_csrf.parameterName}"], [code,"${_csrf.token}"] ,'post')
	}
</script>