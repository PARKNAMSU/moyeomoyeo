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
}

.div_01_02 {
	width: 300px;
}
</style>
<div id="main_1" class="container-fluid"
	style="padding-top: 90px; padding-bottom: 90px;">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">내정보</p>
		<div class="line_01"></div>
		<br> <br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<img alt="" src="/resource/img/user.svg"
					style="width: 40px; height: 40px;">
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<div>
					<p class="font_20">박남수</p>
					<a style="font-size: 15px;" onclick="openPopup('/my_profile_img_pop')" class="a_btn">프로필 사진 변경</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a style="font-size: 15px;" onclick="openPopup('/my_password_chg_pop')" class="a_btn">비밀번호 변경</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a style="font-size: 15px;" onclick="openPopup('/my_inval_account_pop')" class="a_btn">계정 비활성화</a>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">이름</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input type="text" class="form-control">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">닉네임</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input type="text" class="form-control">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">소개</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<textarea rows="10" cols="" class="form-control"></textarea>
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">비밀번호</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input type="text" class="form-control">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">비밀번호 확인</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input type="text" class="form-control">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl" style="height: 1px;"></aside>
			<div class="fl margin_left_50 div_01_01 sub_div"
				style="text-align: right;">
				<button class="btn_01_01 font_30 ">변경</button>
				<button class="btn_01_01 font_30 margin_left_20">취소</button>
			</div>
		</div>
	</div>
</div>


<div id="popup1" class="overlay" style="">
	<div class="popup" style="">
		<a class="close" href="#" onclick="closePopup()">&times;</a>
		<br><br><br>
		<div id="field">
		
		</div>
	</div>
</div>
		
<script>
	function openPopup(url){
		$("#popup1").css("display","initial")
		$("#field").load(url)		
	}
	function closePopup(){
		$("#popup1").css("display","none")
	}
</script>