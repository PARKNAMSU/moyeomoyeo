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
	margin-bottom: 60px;
}

</style>
<div id="main_1" class="container-fluid"
	style="padding-top: 90px; padding-bottom: 90px; ">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">자주묻는 질문</p>
		<div class="line_01"></div><br><br>
		<div style="width:100%;text-align:right;" class="font_15">작성자 : <span id="writer"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="reg_date"></span></div>
		<p class="font_30" id="title"></p>
		<hr>
		<nav class="font_20" id="content">
		</nav>
		<br>
		<div class="div_01" style="width:100%;margin-top:40px;">
			<div class="fl margin_left_50 div_01_01 sub_div" style="text-align:right;width:100%;">
				<button class="btn_01_01 font_30 margin_right_20" onclick="location.href='/'">홈으로</button>
				<button class="btn_01_01 font_30 margin_right_40" onclick="location.href='/often_page'">자주묻는 질문</button>
			</div>
		</div>
	</div>
</div>

<script>
let board_seq = ${seq}

$(document).ready(function(){
	chkWindowWidth()
	setBoardContent()
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

function setBoardContent(){
	$.ajax({
		type:"get",
		url:"/get_often",
		dataType:"text",
		data:{seq:board_seq},
		error:function(data){alert("error")}
	}).done(function(data){
		var data_obj = JSON.parse(data) 
		$("#title").text(data_obj.often_title)
		$("#writer").text(data_obj.often_writer)
		$("#reg_date").text(data_obj.often_reg_date)
		$("#content").text(data_obj.often_content)
	})
}
</script>