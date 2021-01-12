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
					<p class="font_20">${member.name}</p>
					<a style="font-size: 15px;" onclick="openPopup('/profile_pop')" class="a_btn">프로필 사진 변경</a>&nbsp;&nbsp;&nbsp;&nbsp;
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
				<input type="text" class="form-control" value="${member.name}" id="name">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">닉네임</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input type="text" class="form-control" value="${member.nick_name}" id="nick_name">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">소개</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<textarea rows="10" cols="" class="form-control" id="intro">${member.introduce}</textarea>
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">휴대폰 번호</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<select class="form-control fl" id="phone_corp" style="width:19%;margin-right:3%;">
					<option value="SKT" id="sk">SKT</option>
					<option value="KTF" id="kt">KT</option>
					<option value="LGT" id="lg">LGU+</option>
					<option value="MVNO" id="mv">알뜰폰</option>
				</select>
				<input style="width:77%;" type="text" class="form-control fl" id="phone_number" value="${member.phone_number}">
			</div>
			<div class="clear"></div>
		</div><br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">비밀번호</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input type="password" class="form-control" id="pass">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">비밀번호 확인</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input type="password" class="form-control" id="pass_ck">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl" style="height: 1px;"></aside>
			<div class="fl margin_left_50 div_01_01 sub_div"
				style="text-align: right;">
				<button class="btn_01_01 font_30 " 
					onclick="chgInfo($('#pass').val(),$('#intro').val(),$('#name').val(),$('#nick_name').val(),$('#phone_number').val(),$('#phone_corp').val())"
				>변경</button>
				<button class="btn_01_01 font_30 margin_left_20" onclick="location.href='/'">취소</button>
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
	const phone_corp = "${member.phone_corp}"
	const email = "${member.email}"
	
	phoneCorpCk()
	
	function phoneCorpCk(){
		if(phone_corp === 'KTF'){
			$("#kt").attr("selected","selected")
		}else if(phone_corp === 'LGT'){
			$("#lg").attr("selected","selected")
		}else if(phone_corp === 'MVNO'){
			$("#mv").attr("selected","selected")
		}
	}
	function openPopup(url){
		$("#popup1").css("display","initial")
		$("#field").load(url)		
	}
	function closePopup(){
		$("#popup1").css("display","none")
	}
	function chgInfo(password,intro,name,nick_name,phone_number,phone_corp){
		console.log(phone_number)
		if(!passwordRegExp.test(password)){
			alert("비밀번호는 8~16자리입니다.")
			return false;
		}
		if(password != $('#pass_ck').val()){
			alert("비밀번호가 일치하지 않습니다.")
			return false;
		}
		if(!phoneRegExp.test($.trim(phone_number))){
			alert("휴대폰 형식이 맞지 않습니다.")
			return false;
		}
		if(!nameRegExp.test(name)){
			alert("이름형식이 맞지 않습니다.")
			return false;
		}
		if(!n_nameRegExp.test(nick_name)){
			alert("닉네임 형식이 맞지 않습니다.")
			return false;
		}
		$.ajax({
			 type:"POST",
			 url:"/member/chg_account",
			 dataType:"text",
			 data:{
				 email:email,
				 password:password,
				 name:name,
				 nick_name:nick_name,
				 introduce:intro,
				 phone_number:phone_number,
				 phone_corp:phone_corp,
				 "${_csrf.parameterName}":"${_csrf.token}"
			 },
			 async : true,
			 success: function(data){
				if(data === "true"){
					alert("변경완료");
					location.reload()
				}else{
					alert("비밀번호가 일치하지 않습니다.")
				}
			 },
			 error: function(){
				 alert("error")
			 }
		})
	}
	function chgPass(pass,pass_ck,chg_pass,chg_pass_ck){
		if(pass != pass_ck){
			alert("비밀번호가 일치하지 않습니다.")
			return false;
		}
		if(chg_pass != chg_pass_ck){
			alert("비밀번호가 일치하지 않습니다.")
			return false;
		}
		if(!passwordRegExp.test(pass)){
			alert("비밀번호 형식이 맞지 않습니다.")
			return false;
		}
		if(!passwordRegExp.test(chg_pass)){
			alert("비밀번호 형식이 맞지 않습니다.")
			return false;
		}
		$.ajax({
			 type:"POST",
			 url:"/member/chg_account",
			 dataType:"text",
			 data:{
				 email:email,
				 password:pass,
				 chg_pass:chg_pass,
				 type:"chg_pass",
				 "${_csrf.parameterName}":"${_csrf.token}"
			 },
			 async : true,
			 success: function(data){
				if(data === "true"){
					closePopup()
					alert("변경완료")
				}else{
					alert("비밀번호가 일치하지 않습니다.")
				}
			 },
			 error: function(){
				 alert("error")
			 }
		})
	}
</script>