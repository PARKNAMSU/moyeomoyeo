<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
 	#ray_01{
 		color:black;text-align:left;margin-top:90px;
 		width:58%;
 	}
 	.aside_01{
 		text-align:right;
 		width: 90px;
 	}
 	.div_01{

 	}
 	.div_01_01{
 		width: 630px;
 	}
 	 .div_01_02{
 		width: 300px;
 	}
	 #searchbox {
		width: 70%;
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
		cursor:pointer;
	}
</style>
<div id="main_1" class="container-fluid" style="padding-top:90px;padding-bottom:90px;">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">오픈 모임 찾기</p>
		<div class="line_01"></div><br><br>
		<div style="width: 500px;">
			<div style="" id="hsearchdiv">
				<div class="fl" id="glass_div">
					<img alt="" src="/resource/img/mglass.png"
						style="width: 40px; height: 40px;">
				</div>
				<input autocomplete="off" id="searchbox" type="text" style=""
				onkeyup="finduser(this)" onblur="blursearch()">
				<select class="fl form-control" style="width:100px;height:40px;">
					<option value="name">제목</option>
					<option value="goal">목적</option>
					<option value="email">이메일</option>
				</select>
				<div class="clear"></div>
			</div>
		</div>
		<hr>
		<div>
			<p class="font_30">검색결과</p>
		</div>
	</div>
</div>