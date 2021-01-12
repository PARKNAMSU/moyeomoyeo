<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
.main {
	height: 600px;
	padding-top: 90px;
}

#main_1 {
	margin-top: 85px;
	position: relative;
	z-index: 1;
}

#main_1::after {
	background-image: url('/resource/img/index_bg.png');
	background-repeat: no-repeat;
	opacity: 0.5;
	position: absolute;
	z-index: -1;
	content: "";
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-size: cover;
}
</style>
<div>
	<div id="main_1" class="container-fluid main" style="">
		<div class="ray_20" style="color: black; text-align: left;">
			<p class="font_50" style="">모여모여 시크릿 모임</p>
			<p class="font_20">
				소규모 모임 경비 마련에 어울리는<br>모여모여 시크릿 모임을 이용하여 친구들,<br>가족들 혹은 연인과
				잊을 수 없는 추억을 만드세요!
			</p>
			<button class="btn_01"
				onmouseover=" overButton(this,'btn_01_01','btn_01')"
				onmouseleave="overButton(this,'btn_01','btn_01_01')"
				onclick="postForm('/member/secret_meeting','${_csrf.parameterName}','${_csrf.token}','post')">
				<span class="font_30">시크릿 모임</span>
			</button>
		</div>
	</div>
	<div class="container-fluid main" style="background-color: #3063C2;">
		<div class="ray_20" id="ray_20_02"
			style="color: white; text-align: right;">
			<p class="font_50" style="">모여모여 오픈 모임</p>
			<p class="font_20">
				중,대규모 모임 경비 마련에 어울리는<br>모여모여 오픈 모임을 이용하여 망년회,<br>동호회 및 단합회
				등을 더욱 신나게 즐기세요!
			</p>
			<button class="btn_02"
				onmouseover=" overButton(this,'btn_02_01','btn_02')"
				onmouseleave="overButton(this,'btn_02','btn_02_01')"
				onclick="location.href='/member/open_meeting'">
				<span class="font_30">오픈 모임</span>
			</button>
		</div>
	</div>
	<div class="container-fluid main" style="background-color: #EBFBFF;">
		<div class="ray_20" style="color: black; text-align: left;">
			<p class="font_50" style="">모여모여 친구 찾기</p>
			<p class="font_20">
				같이 참여하고 싶은 친구들을 찾아보세요.<br>친구로 등록하면 더 쉽게 모임을 함께할 수 있습니다!
			</p>
			<button class="btn_01"
				onmouseover=" overButton(this,'btn_01_01','btn_01')"
				onmouseleave="overButton(this,'btn_01','btn_01_01')"
				onclick="location.href='/member/find_friends'">
				<span class="font_30">친구 찾기</span>
			</button>
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
		if($(window).width()<900){
			$("#ray_20_02").css("text-align","left")
			$(".ray_20").css("margin-left","10%")
		}else{
			$("#ray_20_02").css("text-align","right")
			$(".ray_20").css("margin-left","20%")
		}
	}
	
	function overButton(selector,add_class,rm_class){
		$(selector).removeClass(rm_class);
		$(selector).addClass(add_class);
	}
</script>