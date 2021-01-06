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
		<div class="fl margin_right_20 cursur_p" onmouseover="overMenu(1,'over')" onmouseleave="overMenu(1,'leave')">
			<span class="font_30" style="color: #3063C2">진행중</span>
			<div class="line_01 vis_h" style="height:2px;" id="main_line_1"></div>
		</div>
		<div class="fl cursur_p" onmouseover="overMenu(2,'over')" onmouseleave="overMenu(2,'leave')">
			<span class="font_30" style="color: black">완료</span>
			<div class="line_01 vis_h" style="height:2px;" id="main_line_2"></div>
		</div><div class="clear"></div>
		<br>
			<div class="meet_el fl" onmouseover="overMeet(this,'over',1)" onmouseleave="overMeet(this,'leave',1)" onclick="">
				<div style="width:78%;overflow:hidden" class="fl"><span class="font_30">모임제목</span></div>
				<div class="fl cycle_01" style="">T</div><div class="clear"></div>
				<div style="width:95%;height:2px;background-color:#EBFBFF"></div>
				<div class="meet_sub_div_01" style="text-align:right;"><span class="font_15">from: 2020/01/01</span></div>
				<div class="meet_sub_div_01" style="text-align:right;"><span class="font_15">to: 2020/02/01</span></div>
				<div class="meet_sub_div_01"><span class="font_20">모임목적</span></div>
				<div class="meet_sub_div_01"><span class="font_20">금액: 100000￦</span></div>
				<div class="meet_sub_div_01"><span class="font_20">총무: 홍길동</span></div>
				<div class="meet_sub_div_01"><span class="font_20">참가인원: 10명</span></div>
				<div class="meet_sub_div_01" style="text-align:right;"><a class='font_15 delete_01' id='delete_el1'>나가기</a></div>
			</div>
			<div class="meet_el fl">
			
			</div>
			<div class="meet_el fl">
			
			</div>
			<div class="meet_el fl">
			
			</div>
			<div class="meet_el fl">
			
			</div>
			<div class="meet_el fl">
			
			</div>
	</div>
	<div class="clear"></div>
</div>
<script>
	$(".meet_el").css("height",$(".meet_el").width()+50+"px")
	$(document).ready(function(){
		chkWindowWidth()
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
			$("#delete_el"+idx).css("display","initial")
		}else if(type === 'leave'){
			$(selector).css("opacity","1")
			$("#delete_el"+idx).css("display","none")
		}
	}
	function overMenu(idx,type){
		if(type === 'over'){
			$("#main_line_"+idx).css("visibility","visible")
		}else if(type === 'leave'){
			$("#main_line_"+idx).css("visibility","hidden")
		}
	}
</script>