<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<!-- jquery, bootstrap -->
<script src="/resource/js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="/resource/css/common.css">
<!-- 구글 폰트  css : font-family: 'Do Hyeon', sans-serif-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<title>모여모여 회원가입</title>
</head>
<body>
	<div class=".container-md" >
		<div class="" id="sign_up_main" style="margin-top:50px;margin-left:40%;">
			<img alt="" src="/resource/img/logo.png" style="width: 350px; height: 350px;margin-left:20px;"><br>
			<b style="font-size: 50px;margin-left:50px;margin-left:120px;" class="g_text">회원가입</b>
			<form action="" method="post" style="width: 430px;">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="token" />
				<input type="text" name="email" id="email" placeholder="이메일" class="form-control fl" style="width:57%;margin-right:3%;">
				<input type="button" class="btn btn-primary" style="width:19%;font-size:12px;height:38px" onclick="emailCk('email',this)" value="중복확인">
				<input type="button" id="identi_bt" class="btn btn-primary" style="width:19%;font-size:12px;height:38px" onclick="emailIdentify('email',this)" value="인증번호" disabled="disabled"><br><br>
				<input type="text" name="email_code" id="email_code" placeholder="인증코드" class="form-control" ><br>
				<input type="password" name="password" id="password" placeholder="비밀번호" class="form-control"><br>
				<input type="password" name="password_ck" id="password_ck" placeholder="비밀번호 확인" class="form-control"><br>
				<input type="text" name="name" id="name" placeholder="이름" class="form-control"><br>
				<input type="text" name="nick_name" id="nick_name" placeholder="닉네임" class="form-control"><br>
				<input type="button" class="btn btn-primary" value="회원가입" style="width: 200px;margin-right:23px;" onclick="signUpCk('password','password_ck','name','nick_name')">
				<input type="button" class="btn btn-primary" value="취소" style="width: 200px;" onclick="location.href='/login_page'">
			</form><br>
		</div>
	</div>
</body>
<script type="text/javascript">
const emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
const passwordRegExp = /^[a-zA-z0-9]{8,16}$/;
const nameRegExp = /^[a-zA-z가-힣]{2,12}$/;
const n_nameRegExp = /^[a-zA-z0-9]{3,15}$/;
let email_ck_yn = 'n';
let email_code = 'fkdslgrejgiregjoregjoilerjkjm31212312fjeiwsofjw';
$(document).ready(function(){
	chkWindowWidth()
	$(window).resize(function(){
		chkWindowWidth()
	})
})
function chkWindowWidth(){
	if($(window).width()< 900){
		$("#sign_up_main").css("margin-left","6%");
	}else{
		$("#sign_up_main").css("margin-left","40%");
	}
}
function signUpCk(pass,pass_ck,name,n_name){
	var _pass = $("#"+pass).val()
	var _pass_ck = $("#"+pass_ck).val()
	var _name = $("#"+name).val()
	var _n_name = $("#"+n_name).val()
	if(!passwordRegExp.test(_pass)){
		alert("비밀번호는 8~16자리입니다.")
		return false;
	}
	if(_pass != _pass_ck){
		alert("비밀번호가 일치하지 않습니다.")
		return false;
	}
	if(!nameRegExp.test(_name)){
		alert("이름형식이 맞지 않습니다.")
		return false;
	}
	if(!n_nameRegExp.test(_n_name)){
		alert("닉네임 형식이 맞지 않습니다.")
		return false;
	}
	if($("#email_code").val() != email_code){
		alert("인증코드가 일치하지 않습니다.")
		return false;
	}
	 $.ajax({
		 type:"POST",
		 url:"/create_user",
		 dataType:"text",
		 data:{
			 email:$("#email").val(),
			 password:_pass,
			 name:_name,
			 nick_name:_n_name,
			 "${_csrf.parameterName}":"${_csrf.token}"
		 },
		 async : true,
		 success: function(data){
			 location.href='/login_page'
			 alert("회원가입 완료")
		 },error: function(error){
			console.log(error)	 
		 }
	})
}
function emailCk(email,node){
	var email_val = $("#"+email).val()
	if(!emailRegExp.test(email_val)){
		alert("이메일 형식이 맞지 않습니다.")
	}else{
		 $.ajax({
			 type:"POST",
			 url:"/email_ck",
			 dataType:"text",
			 data:{
				 email:email_val,
				 "${_csrf.parameterName}":"${_csrf.token}"
			 },
			 async : true,
			 success: function(data){
				 if(data === 'sucess'){
					 alert("사용가능한 이메일입니다.")
					 email_ck_yn = 'y'
					 $("#"+email).attr("disabled","disabled")
					 $(node).attr("disabled","disabled")
					 $("#identi_bt").removeAttr("disabled")
				 }else{
					 alert("이미 등록된 이메일입니다.")
				 }
			 },
			 error:function(error){
				 console.log(error)
			 }
		})
	}
}
function emailIdentify(email,node){
	var email_val = $("#"+email).val()
	 $.ajax({
		 type:"POST",
		 url:"/email_identify",
		 dataType:"text",
		 data:{
			 email:email_val,
			 "${_csrf.parameterName}":"${_csrf.token}"
		 },
		 async : true,
		 success: function(data){
			 email_code = data
			 alert("인증코드를 입력하세요.")
			 $(node).attr("disabled","disabled")
		 },
		 error : function(error){
		 	console.log(error)
		 }
	 })
}
</script>
</html>
