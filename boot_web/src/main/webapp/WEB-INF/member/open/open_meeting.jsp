<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
 	#ray_01{
 		color:black;text-align:left;margin-top:190px;
 	}
</style>
<div id="main_1" class="container-fluid" style="padding-top:90px;">
	<img alt="" src="/resource/img/secret/friends1.svg" style="position:absolute;width:500px;height:500px;left:1000px;top:200px;">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50" style="">오픈 모임</p>
		<p class="font_20">여러 사람들과 다양한 재미를 추구하세요.<br>지금 오픈 모임을 생성하여<br>원하시는 모임에 참가하세요!</p><br><br>
		<button class="btn_01" style="margin-right:20px;" onmouseover=" overButton(this,'btn_01_01','btn_01')" onmouseleave="overButton(this,'btn_01','btn_01_01')" onclick="location.href='/secret_meeting_create'"><span class="font_30">오픈 모임 생성</span></button>
		<button class="btn_01" onmouseover=" overButton(this,'btn_01_01','btn_01')" onmouseleave="overButton(this,'btn_01','btn_01_01')" onclick="location.href='/my_meeting'"><span class="font_30">모임 둘러보기</span></button>
	</div>
</div>

<script>
	function overButton(selector,add_class,rm_class){
		$(selector).removeClass(rm_class);
		$(selector).addClass(add_class);
	}
</script>