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

.friends_div_01 {
	width: 420px;
}

.friends_div_01_01 {
	width: 100%;
	height: 600px;
	background-color: #B9E2FA;
	box-shadow: 2px 2px 2px 2px #3063C2;
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
		<p class="font_50">친구 목록</p>
		<div class="line_01"></div>
		<br>
		<div class="fl friends_div_01 margin_right_40">
			<div class="clear"></div>
			<div style="width: 100%">
				<b class="font_30">팔로잉</b>
			</div>
			<div style="" class="friends_div_01_01" id="my_follow_div">
			</div>
			<div></div>
		</div>
		<div class="fl friends_div_01">
			<div class="clear"></div>
			<div style="width: 100%">
				<b class="font_30">팔로워</b>
			</div>
			<div style="" class="friends_div_01_01" id="my_follower_div">

			</div>
		</div>
		<div class="clear" style="margin-bottom:20px;"></div>
		<div style="width:91.5%;text-align:right;">
			<button class="btn_01_01 font_30 margin_right_20" onclick="location.href='/member/find_friends'">친구검색</button>
			<button class="btn_01_01 font_30" onclick="location.href='/member/my_info'">내정보</button>
		</div>
	</div>
</div>

<div id="popup1" class="overlay" style="">
	<div class="popup" style="">
		<a class="close" onclick="closePopup()">&times;</a>
		<br><br><br>
		<div id="field">
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	chkWindowWidth()
	getFollowMember()
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
function invite(email){
	$("#popup1").css("display","initial")
	$("#field").load("/invite_pop")
}
function closePopup(){
	$("#popup1").css("display","none")
}
function getFollowMember(){
	$("#my_follower_div").empty()
	$("#my_follow_div").empty()
	$.ajax({
		type:"GET",
		url:"/member/get_follow",
		dataType:"text",
		async:false,
		sucess:function(data){},
		error:function(data){alert("error")}
	}).done(function(data){
		var data_obj = JSON.parse(data);
		console.log(data_obj)
		var a = 0;
		data_obj.forEach(function(item){
			item.forEach(function(val){
				var p_el = null;
				var a_bt = null;
				if(a === 0){
					p_el = $("#my_follower_div")
					if(val.res === 'n'){
						a_bt = '<a class="a_btn" onclick="followMember(\''+val.email+'\',this)">팔로우</a>'
					}else{
						a_bt = '<a class="margin_right_20 a_btn">초대</a><a onclick="unfollowMember(\''+val.email+'\',this,\'follower\')" class="a_btn">언팔로우</a>'
					}
				}else{
					p_el = $("#my_follow_div")
					a_bt = '<a class="margin_right_20 a_btn">초대</a><a onclick="unfollowMember(\''+val.email+'\',this,\'following\')" class="a_btn">언팔로우</a>'
				}
				var el = '<div class="friends_div_01_02">'
				+'<div class="fl img_div_01 margin_right_20" >'
				+	'<img alt="" src="'+getImgUrl(val.profile_url)+'" style="width:100%;height:100%">'
				+'</div>'
				+'<div class="fl" style="width:270px;height:100%;">'
				+	'<div style="text-align:right;width:100%;">'+a_bt+'</div>'
				+	'<div><p>'+val.nick_name+' ('+val.name+')</p></div>'
				+'</div>'
				+'<div class="clear"></div>'
				+'</div>';
				p_el.append(el)
			})
			a++;
		})
	})
}

function unfollowMember(email,t,field){
	var el = $(t);
	console.log(email)
	$.ajax({
		 type:"post",
		 url:"/member/set_follow",
		 dataType:"text",
		 data:{
			 follow_email:email,
			 follow_yn:"n",
			 "${_csrf.parameterName}":"${_csrf.token}"
		 },
		 async:false,
		 sucess:function(data){},
		 error:function(error){alert("error")}
	}).done(function(data) {
		if(field === 'follower'){
			getFollowMember()
		}else{
			getFollowMember()
		}
	})
}
function followMember(email,t){
	var el = $(t);
	$.ajax({
		type:"post",
		 url:"/member/set_follow",
		 dataType:"text",
		 data:{
			 follow_email:email,
			 follow_yn:"y",
			 "${_csrf.parameterName}":"${_csrf.token}"
		 },
		 async:false,
		 sucess:function(data){},
		 error:function(error){alert("error")}
	}).done(function(data) {
		getFollowMember()
	})
}
</script>