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
		<p class="font_50">공지사항</p>
		<div class="line_01"></div><br><br>
		<div style="width:100%;text-align:right;" class="font_15">작성자 : admin &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2020/01/01</div>
		<p class="font_30">공지사항 제목</p>
		<hr>
		<nav class="font_20">
			안녕하세요 모여모여를 이용해 주셔서 감사합니다.안녕하세요 모여모여를 이용해 주셔서 감사합니다.안녕하세요 모여모여를 이용해 주셔서 감사합니다.안녕하세요 모여모여를 이용해 주셔서 감사합니다.안녕하세요 모여모여를 이용해 주셔서 감사합니다.안녕하세요 모여모여를 이용해 주셔서 감사합니다.안녕하세요 모여모여를 이용해 주셔서 감사합니다.안녕하세요 모여모여를 이용해 주셔서 감사합니다.s
		</nav>
		<br>
		<div class="div_01" style="width:100%;margin-top:40px;">
			<div class="fl margin_left_50 div_01_01 sub_div" style="text-align:right;width:100%;">
				<button class="btn_01_01 font_30 margin_right_20" onclick="location.href='/'">홈으로</button>
				<button class="btn_01_01 font_30 margin_right_40">공지사항</button>
			</div>
		</div>
	</div>
</div>

<script>
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
</script>