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
}

.aside_01 {
	text-align: right;
	width: 90px;
}

.div_01_01 {
	width: 630px;
	margin-left: 50px;
}

.div_01_02 {
	width: 300px;
}
</style>
<div id="main_1" class="container-fluid"
	style="padding-top: 90px; padding-bottom: 90px;">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">회원정보</p>
		<div class="line_01"></div>
		<div style="width:100%;margin-top:50px">
			<div class="fl" id="img_div" style="width:20%;border-radius:70%;overflow: hidden;">
				<img alt="" src="/resource/img/my1.jpg" style="width:100%;height:100%;" id="img_url">
			</div>
			<div class="fl" style="width:78%;padding:3%;">
				<p class="font_30"><span id="name"></span> (<span id="nick_name"></span>)</p>
				<p class="font_15" style="width:50%;" id="intro"></p>
			</div>
			<div class="clear"></div>
		</div>
		<div style="width:58%;text-align:right;">
			<p style=""><a class="a_btn" id="follow_yn"></a>&nbsp;&nbsp;<a class="a_btn">신고</a></p>
		</div>
		<br><hr>
		<div style="width:100%;text-align:right;">
			<input class="btn_01_01 margin_right_20 font_30" type="button" value="친구목록" onclick="location.href='/member/my_friends'">
			<input class="btn_01_01 font_30" type="button" value="홈으로" onclick="location.href='/'">
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	chkWindowWidth()
	setUserInfo()
	$(window).resize(function(){
		chkWindowWidth()
	})
})

let user_info = '${user_info}';
let follow_yn = ${follow_yn};
function chkWindowWidth(){
	if($(window).width()< 900){
		$("#ray_01").css("margin-left","3%");
		$("#ray_01").css("width","95%");
		$("#img_div").css("height",$("#img_div").css("width"))
	}else{
		$("#ray_01").css("margin-left","20%");
		$("#ray_01").css("width","58%");
		$("#img_div").css("height",$("#img_div").css("width"))
	}
}
function setUserInfo(){
	var user_obj = JSON.parse(user_info)
	console.log(follow_yn)
	console.log(user_obj)
	$("#img_url").attr("src",getImgUrl(user_obj.profile_url))
	$("#name").text(user_obj.name)
	$("#nick_name").text(user_obj.nick_name)
	$("#intro").text(user_obj.introduce)
	$("#follow_yn").text(returnConditionObj(follow_yn,1,"언팔로우","팔로우"))
	$("#follow_yn").attr("onclick",returnConditionObj(follow_yn,1,"unfollowMember('"+user_obj.email+"')","followMember('"+user_obj.email+"')"))
}

function unfollowMember(email){
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
		location.reload();
	})
}
function followMember(email){
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
		location.reload();
	})
}

</script>