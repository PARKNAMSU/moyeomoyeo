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
<title>모여모여 임시 비밀번호 발급</title>
</head>
<body>
	<div class=".container-md" >
		<div class="" id="get_temp_main" style="margin-top:50px;margin-left:40%;">
			<img alt="" src="/resource/img/logo.png" style="width: 350px; height: 350px;margin-left:20px;"><br>
			<b style="font-size: 50px;margin-left:50px;margin-left:80px;" class="g_text">비밀번호 발급</b>
			<form action="#" method="post" style="width: 430px;">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="token" />
				<input type="text" name="email" id="email" placeholder="이메일" class="form-control"><br>
				<input type="submit" class="btn btn-primary" value="이메일로 발급" style="width: 200px;margin-right:23px;">
				<input type="button" class="btn btn-primary" value="뒤로" style="width: 200px;" onclick="location.href='/login_page'">
			</form><br>
		</div>
	</div>
</body>
<script type="text/javascript">
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
</script>
</html>