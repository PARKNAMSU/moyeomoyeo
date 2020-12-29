<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>

</style>

<div style="" id="invite_div">
	<h2 style="text-align: center;">친구 초대</h2>
	<div class="line_01" style="height:2px;"></div><br> 
	<div class="div_01">
		<div class="div_01">
			<aside class="aside_01 fl margin_left_10" style="width:10%;">
				<p class="font_15">모임 목록</p>
			</aside>
			<div class="fl margin_left_10 div_01_01 sub_div" style="width: 80%;">
				<select class="form-control">
					<option>모임1</option>
					<option>모임2</option>
				</select>
			</div>
			<div class="clear"></div>
		</div>
		<div>
			<aside class="aside_01 fl" style="height: 1px;"></aside>
			<div class="fl margin_left_50 div_01_01 sub_div"
				style="text-align: right;width:80%">
				<button class="btn_01_01 font_20 ">초대</button>
				<button class="btn_01_01 font_20 margin_left_10">취소</button>
			</div>
		</div>
		<div class="clear"></div>
		<br>
	</div>
</div>