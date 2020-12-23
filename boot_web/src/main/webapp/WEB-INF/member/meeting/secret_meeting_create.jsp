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
 		width: 330px;
 	}
</style>
<div id="main_1" class="container-fluid" style="padding-top:90px;padding-bottom:90px;">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">시크릿 모임 생성</p><br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">모임명</p>
			</aside>
			<div class="fl margin_left_50 div_01_01">
				<input type="text" class="form-control">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">모임 목적</p>
			</aside>
			<div class="fl margin_left_50 div_01_01">
				<input type="text" class="form-control">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">모임 타입</p>
			</aside>
			<div class="fl margin_left_50 div_01_01">
				<select class="form-control fl" style="width:49%;margin-right:10px;">
					<option>무기한</option>
					<option>기한</option>
				</select>
				<select class="form-control fl" style="width:49%;">
					<option>공통금액 설정</option>
					<option>개인별 특정금액 설정</option>
				</select>
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">인원</p>
			</aside>
			<div class="fl margin_left_50 div_01_01">
				<select class="form-control" style="width:49%;" id="number">

				</select>
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">모임 설명</p>
			</aside>
			<div class="fl margin_left_50 div_01_01">
				<textarea rows="10" cols="" class="form-control"></textarea>	
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">목표 금액</p>
			</aside>
			<div class="fl margin_left_50 div_01_01">
				<input type="range" class="form-control" max="100000000" min="0" value="0" onchange="getRangeVal(this)" id="goal_price">
				<input type="text" class="form-control fl" style="width:200px;" onkeydown="setRangeVal(this)" id="range_val"><b class="font_20">&nbsp;￦</b><br>
			</div>
			<div class="clear"></div>
		</div><br>
		<div class="div_01">
			<aside class="aside_01 fl" style="height:1px;"></aside>
			<div class="fl margin_left_50 div_01_01" style="text-align:right;">
				<button class="btn_01_01 font_30 " >생성</button>
				<button class="btn_01_01 font_30 margin_left_20" >취소</button>
			</div>
		</div>
		<br>
	</div>
</div>

<script>
	setSelectNum()
	function getRangeVal(selector){
		$("#range_val").val(selector.value)
	}
	function setRangeVal(selector){
		if(!isNaN(selector.value)){
			$("#goal_price").val(selector.value)
			$("#range_val").val(selector.value)
		}else{
			$("#goal_price").val(0)
			$("#range_val").val("")
		}
	}
	
	function setSelectNum(){
		for(var i=2; i<21; i++){
			var node = "<option value="+i+">"+i+"명</option>"
			$("#number").append(node);
		}
	}
</script>