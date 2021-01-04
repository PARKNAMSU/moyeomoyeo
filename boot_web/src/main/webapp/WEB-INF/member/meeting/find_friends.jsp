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

#searchbox:focus {
	outline: none;
}

#searchbox {
	width: 80%;
	height: 40px;
	border: none;
	border-right: 0px;
	border-top: 0px;
	boder-left: 0px;
	boder-bottom: 0px;
	font-size: 20px;
	background-color: #B9E2FA;
}

#glass_div {
	width: 40px;
	height: 40px;
	cursor:pointer;
}
.friends_div_01 {
	width: 420px;
}

.friends_div_01_01 {
	width: 100%;
	height: 600px;
	border: solid #3063C2 1.5px;
	overflow: scroll;
	border-radius: 5px;
}

.friends_div_01_01::-webkit-scrollbar {
	width: 15px;
}

.friends_div_01_01::-webkit-scrollbar-track {
	background-color: transparent;
}

.friends_div_01_01::-webkit-scrollbar-thumb {
	border-radius: 5px;
	background-color: #3063C2;
}

.friends_div_01_01::-webkit-scrollbar-button {
	width: 0;
	height: 0;
}

.friends_div_01_02 {
	width: 100%;
	height: 100px;
	padding: 20px;
	border-bottom: solid 0.2px gray;
}

.img_div_01 {
	width: 59px;
	height: 100%;
	border-radius: 70%;
	overflow: hidden;
}
</style>
<div id="main_1" class="container-fluid"
	style="padding-top: 90px; padding-bottom: 90px; ">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">친구찾기</p>
		<div class="line_01"></div>
		<br><br>
		<div class="fl" style="width: 450px;">
			<div style="" id="hsearchdiv">
				<div class="fl" id="glass_div">
					<img alt="" src="/resource/img/mglass.png"
						style="width: 100%; height: 100%;">
				</div>
				<form action="">
					<input autocomplete="off" id="searchbox" type="text" style=""
						onkeyup="finduser(this)" onblur="blursearch()">
				</form>
			</div>
		</div>
		<div class="fl font_20" style="width: 450px; margin-right: 50px;">
			<p>원하시는 친구를 찾아서 함께 모임 및 여행을 즐겨보세요!</p>
			<img src="/resource/img/friends2.svg" style="width:150px;height:150px;margin-left:300px;">
		</div>
		<div class="clear"></div><br><br><hr>
		
		<div class="fl friends_div_01 margin_right_40">
			<div class="clear"></div>
			<div style="width: 100%">
				<b class="font_30">검색결과</b>
			</div>
			<div style="" class="friends_div_01_01">
				<div class="friends_div_01_02">
					<div class="fl img_div_01 margin_right_20" >
						<img alt="" src="/resource/img/my1.jpg" style="width:100%;height:100%">
					</div>
					<div class="fl" style="width:270px;height:100%;">
						<div style="text-align:right;width:100%;"><a href="#">팔로우</a></div>
						<div><p>뎀바바와드록바 (홍길동)</p></div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		
		<div class="fl friends_div_01 ">
			<div class="clear"></div>
			<div style="width: 100%">
				<b class="font_30">추천친구</b>
			</div>
			<div style="" class="friends_div_01_01">
				<div class="friends_div_01_02">
					<div class="fl img_div_01 margin_right_20" >
						<img alt="" src="/resource/img/my1.jpg" style="width:100%;height:100%">
					</div>
					<div class="fl" style="width:270px;height:100%;">
						<div style="text-align:right;width:100%;"><a href="#">팔로우</a></div>
						<div><p>뎀바바와드록바 (홍길동)</p></div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<div class="clear"></div>
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