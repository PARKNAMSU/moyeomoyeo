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
		<p class="font_50" style="">시크릿 모임</p>
		<p class="font_20">추억은 함께하면 배가됩니다.<br>지금 시크릿 모임을 생성하여<br>함께하고 싶은 친구들을 초대해 보세요!</p><br><br>
		<button class="btn_01" style="margin-right:20px;" onmouseover=" overButton(this,'btn_01_01','btn_01')" onmouseleave="overButton(this,'btn_01','btn_01_01')" onclick="location.href='/secret_meeting_create'"><span class="font_30">시크릿 모임 생성</span></button>
		<button class="btn_01" onmouseover=" overButton(this,'btn_01_01','btn_01')" onmouseleave="overButton(this,'btn_01','btn_01_01')" onclick="location.href='/member/my_meeting'"><span class="font_30">내 모임 목록</span></button>
		
	</div>
</div>

<script>
	function overButton(selector,add_class,rm_class){
		$(selector).removeClass(rm_class);
		$(selector).addClass(add_class);
	}
</script>