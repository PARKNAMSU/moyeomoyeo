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
<title>모여모여 비활성 계정 해제</title>
</head>
<body>
	<div class=".container-md" >
		<div class="" id="get_temp_main" style="margin-top:50px;margin-left:40%;">
			<img alt="" src="/resource/img/logo.png" style="width: 350px; height: 350px;margin-left:20px;"><br>
			<b style="font-size: 50px;margin-left:50px;margin-left:80px;" class="g_text">계정 활성화</b>
			<form action="#" method="post" style="width: 430px;">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="token" />
				<input type="text" name="email" id="email" placeholder="이메일" class="form-control"><br>
				<input type="password" name="password" id="password" placeholder="비밀번호" class="form-control"><br>
				<input type="password" name="password_ck" id="password_ck" placeholder="비밀번호 확인" class="form-control"><br>
				<input type="button" class="btn btn-primary" value="이메일로 발급" style="width: 200px;margin-right:23px;" onclick="setActive()">
				<input type="button" class="btn btn-primary" value="뒤로" style="width: 200px;" onclick="location.href='/login_page'">
			</form><br>
		</div>
	</div>
</body>
<script type="text/javascript">
const emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
const passwordRegExp = /^[a-zA-z0-9]{8,16}$/;
$(document).ready(function(){
	chkWindowWidth()
	$(window).resize(function(){
		chkWindowWidth()
	})
})
function chkWindowWidth(){
	if($(window).width()< 900){
		$("#get_temp_main").css("margin-left","6%");
	}else{
		$("#get_temp_main").css("margin-left","40%");
	}
}
function setActive(){
	if(!emailRegExp.test($("#email").val())){
		alert("이메일 형식이 아닙니다.")
		return false;
	}
	if(!passwordRegExp.test($("#password").val())){
		alert("비밀번호는 8~16자리입니다.")
		return false;
	}
	if($("#password").val() != $("#password_ck").val()){
		alert("비밀번호가 일치하지 않습니다.")
		return false;
	}
	 $.ajax({
		 type:"POST",
		 url:"/active_account",
		 dataType:"text",
		 data:{
			 email:$("#email").val(),
			 password:$("#password").val(),
			 active_yn:'y',
			 "${_csrf.parameterName}":"${_csrf.token}"
		 },
		 async : true,
		 success: function(data){
			 if(data === 'id_false'){
				 alert("존재하지 않는 이메일입니다.")
			 }else if(data === 'pass_false'){
				 alert("비밀번호가 일치하지 않습니다.")
			 }else{
				 location.href='/login_page'
				 alert("계정설정 완료")
			 }
		 },error: function(error){
			console.log(error)	 
		 }
	})
	
}
</script>
</html>