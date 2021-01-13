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
	width: 90%;
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
	cursor: pointer;
}

.friends_div_01 {
	width: 420px;
}

.friends_div_01_01 {
	width: 100%;
	height: 600px;
	cursor:pointer;
	overflow: scroll;
	border-radius: 5px;
	background-color: #B9E2FA;
	box-shadow: 2px 2px 2px 2px #3063C2;
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
	border-bottom: solid 1.5px #3063C2;
}

.img_div_01 {
	width: 59px;
	height: 100%;
	border-radius: 70%;
	overflow: hidden;
}
</style>
<div id="main_1" class="container-fluid"
	style="padding-top: 90px; padding-bottom: 90px;">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">친구찾기</p>
		<div class="line_01"></div>
		<br>
		<br>
		<div class="fl" style="width: 450px;background-color: #B9E2FA;">
			<div style="" id="hsearchdiv">
				<div class="fl" id="glass_div" onclick="findFriend($('#searchbox').val(),$('#search_opt').val())">
					<img alt="" src="/resource/img/mglass.png"
						style="width: 100%; height: 100%;">
				</div>
				<form action="">
					<input autocomplete="off" id="searchbox" type="text" style="">
				</form>
			</div>
		</div>
		<div class="fl " style="width: 200px;">
			<select class="form-control" id="search_opt">
				<option value="email">이메일</option>
				<option value="name">이름</option>
				<option value="nick_name">닉네임</option>
			</select>
		</div>
		<div class="clear"></div>
		<br>
		<br>
		<hr>

		<div class="fl friends_div_01 margin_right_40">
			<div class="clear"></div>
			<div style="width: 100%">
				<b class="font_30">검색결과</b>
			</div>
			<div style="" class="friends_div_01_01" id="result_sc">
			</div>
		</div>

		<div class="fl friends_div_01 ">
			<div class="clear"></div>
			<div style="width: 100%">
				<b class="font_30">내친구</b>
			</div>
			<div style="" class="friends_div_01_01" id="result_reco">
			</div>
		</div>
		<div class="clear"></div>
		<div style="width:91.5%;text-align:right;margin-top:20px;">
			<button class="btn_01_01 font_30 margin_right_20" onclick="location.href='/member/my_friends'">내친구</button>
			<button class="btn_01_01 font_30" onclick="location.href='/'">메인</button>
		</div>
	</div>
</div>
<script>
	var search_start = "off";
	$(document).ready(function() {
		chkWindowWidth()
		recommendFriend()
		$(window).resize(function() {
			chkWindowWidth()
		})
	})
	function chkWindowWidth() {
		if ($(window).width() < 900) {
			$("#ray_01").css("margin-left", "3%");
			$("#ray_01").css("width", "95%");
			$(".friends_div_01_01").css("margin-left","3%")
		} else {
			$("#ray_01").css("margin-left", "20%");
			$("#ray_01").css("width", "58%");
			$(".friends_div_01_01").css("margin-left","0%")
		}
	}
	function findFriend(search,search_opt){
		$("#result_sc").empty()
		search_start = "on"
		$.ajax({
			 type:"post",
			 url:"/member/search_friend",
			 dataType:"text",
			 async:false,
			 data:{
				 search:search,
				 search_opt:search_opt,
				 "${_csrf.parameterName}":"${_csrf.token}"
			 },
			 beforeSend:function(xhr){
				console.log('요청') 				
			 },
			 error:function(data){
				 alert("error")
			 }
		}).done(function( data ) {
			if(data === "na"){
				alert("존재하지 않는 회원입니다.")
				return false;
			}
			var data_obj = JSON.parse(data)
			console.log(data_obj[0].res)
			for(var i=0 ; i<data_obj.length; i++){
				var img_url = getImgUrl(data_obj[i].profile_url)
				var a_btn = '';
				a_btn = '<a class="a_btn" onclick="">초대</a>'
				var friends_el = '	<div class="friends_div_01_02">'
					+'<div class="fl img_div_01 margin_right_20">'
						+'<img alt="" src="'+img_url+'" style="width: 100%; height: 100%">'
					+'</div>'
					+'<div class="fl" style="width: 270px; height: 100%;">'
						+'<div style="text-align: right; width: 100%;">'
						+a_btn
						+'</div>'
					+'<div>'
					+	'<p>'+data_obj[i].name+'('+data_obj[i].nick_name+')'+'</p>'
					+'</div>'
				+'</div>'
				+'<div class="clear"></div>'
				+'</div>'
				$("#result_sc").append(friends_el)
			}	  
		})
	}
	function recommendFriend(){
		$("#result_reco").empty()
		$.ajax({
			type:"GET",
			url:"/member/recommend_friend",
			dataType:"text",
			async:false,
			sucess:function(data){},
			error:function(data){alert("error")}
		}).done(function(data){
			var data_obj = JSON.parse(data)
			console.log(data_obj)
			for(var i = 0; i < data_obj.length; i++){
				var img_url = getImgUrl(data_obj[i].profile_url)
				var friends_el = '	<div class="friends_div_01_02">'
					+'<div class="fl img_div_01 margin_right_20">'
						+'<img alt="" src="'+img_url+'" style="width: 100%; height: 100%">'
					+'</div>'
					+'<div class="fl" style="width: 270px; height: 100%;">'
						+'<div style="text-align: right; width: 100%;">'
						+'<a class="a_btn" onclick="">초대</a>'
						+'</div>'
					+'<div>'
					+	'<p>'+data_obj[i].name+'('+data_obj[i].nick_name+')'+'</p>'
					+'</div>'
				+'</div>'
				+'<div class="clear"></div>'
				+'</div>'
				$("#result_reco").append(friends_el)	
			}
		})	
	}
</script>