<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<!-- jquery, bootstrap -->
<script src="/resource/js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- 구글 폰트  css : font-family: 'Do Hyeon', sans-serif-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/resource/css/common.css">
<title>모여모여 로그인</title>
</head>
<body>
	<c:if test="${user_id != null}">
		<script>location.href='/'</script>
	</c:if>
	<div class=".container-md" >
		<div class="" style="margin-top:100px;margin-left:40%;" id="login_main" >
			<img alt="" src="/resource/img/logo.png" style="width: 350px; height: 350px;margin-left:20px;cursor:pointer;"  onclick="location.href='/'"><br>
			<b style="font-size: 100px" class="g_text">Welcome!!</b>
			<form action="#" method="post" style="width: 430px;" id="login_form">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="token" />
				<input type="text" name="email" id="email" placeholder="email" class="form-control"><br>
				<input type="password" name="password" id="password" placeholder="password" class="form-control"><br>
				<input type="button" class="btn btn-primary" value="Login" style="width: 430px;" onclick="loginCk($('#login_form'))" >
			</form><br>
			<div style="width:430px;">
				 <span style="margin-left: 80px;">비밀번호를 잊어버리셨습니까?</span><a href="/get_temp_pw">&nbsp;비밀번호 발급</a>
				 <hr>
				 <span style="margin-left: 10px;">계정이 없으십니까?</span><a href="/sign_up_page">&nbsp;회원가입</a>
				 <span style="margin-left: 30px;">계정이 비활성화 상태입니까?</span><a href="/active_setting">&nbsp;활성화</a>
				 
			</div>
		</div>
	</div>
</body>
<script>
	const emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
	//const passwordRegExp = /^[a-zA-z0-9]{8,16}$/;
	let error = "${error}"
	console.log(error)
	$(document).ready(function(){
		chkWindowWidth()
		errorCk()
		$(window).resize(function(){
			chkWindowWidth()
		})
	})

	function errorCk(){
		if(error === 'deactive'){
			alert("계정이 비활성화 상태입니다.")
		}
		if(error === 'login_fail'){
			alert("아이디 또는 비밀번호를 확인하세요.")
		}
		if(error === 'stop'){
			alert("계정이 정지 상태입니다.")
		}
	}
	function loginCk(form){
		var email = $("#email").val()
		if(!emailRegExp.test(email) && email != 'admin'){
			alert("이메일 형식이 올바르지 않습니다.")
			return false;
		}
		form.submit()
	}
	function chkWindowWidth(){
		if($(window).width()< 900){
			$("#login_main").css("margin-left","6%");
		}else{
			$("#login_main").css("margin-left","40%");
		}
	}
</script>
</html>