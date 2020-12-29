<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>

#inv_account_div::-webkit-scrollbar {
	width: 15px;
}

#inv_account_div::-webkit-scrollbar-track {
	background-color: transparent;
}

#inv_account_div::-webkit-scrollbar-thumb {
	border-radius: 5px;
	background-color: #bebebe;
}

#inv_account_div::-webkit-scrollbar-button {
	width: 0;
	height: 0;
}
</style>

<div style="overflow: scroll;" id="inv_account_div">
	<h2 style="text-align: center;">계정 비활성화</h2>
	<div class="div_01">
		<aside class="aside_01 fl" style="width: 10%;">
			<p class="font_15">비밀번호</p>
		</aside>
		<div class="fl margin_left_10 div_01_01 sub_div" style="width: 80%;">
			<input type="password" class="form-control">
		</div>
		<div class="clear"></div>
	</div>
	<br>
	<div class="div_01">
		<aside class="aside_01 fl" style="width: 10%;">
			<p class="font_15">비밀번호 확인</p>
		</aside>
		<div class="fl margin_left_10 div_01_01 sub_div" style="width: 80%;">
			<input type="password" class="form-control">
		</div>
		<div class="clear"></div>
	</div>
	<br>
	<div >
		<aside class="aside_01 fl" style="height: 1px;"></aside>
		<div class="fl margin_left_50 div_01_01 sub_div"
			style="text-align: right;width:80%">
			<button class="btn_01_01 font_20 ">비활성화</button>
			<button class="btn_01_01 font_20 margin_left_10">취소</button>
		</div>
	</div>
</div >
<div class="clear"></div>