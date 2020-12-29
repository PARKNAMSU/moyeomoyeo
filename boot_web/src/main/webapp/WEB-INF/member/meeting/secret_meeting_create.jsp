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
 		width: 300px;
 	}
</style>
<div id="main_1" class="container-fluid" style="padding-top:90px;padding-bottom:90px;">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">시크릿 모임 생성</p>
		<div style="height:1px;width:100%;background-color:black;"></div><br><br>

		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">모임명</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input type="text" class="form-control">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">모임 목적</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input type="text" class="form-control">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">모임 타입</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<select class="form-control fl" style="width:49%;margin-right:10px;">
					<option>무기한</option>
					<option>기한</option>
				</select>
				<select class="form-control fl" style="width:49%;" onclick="setMaxPrice($(this).val())">
					<option value="common" onclick="setMaxPrice('individual')">공통금액 설정</option>
					<option value="spec" onclick="setMaxPrice('together')">개인별 특정금액 설정</option>
				</select>
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">최대인원</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<select class="form-control" style="width:49%;" id="number">

				</select>
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">날짜</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input id="finish_date" type="text" class="form-control fl" disabled="disabled" style="width:49%;">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">모임 설명</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<textarea rows="10" cols="" class="form-control"></textarea>	
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20" id="price_text">개인별 금액</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input type="range" class="form-control"  min="0" value="0" onchange="getRangeVal(this)" id="goal_price">
				<input type="text" class="form-control fl" style="width:200px;text-align:right;" onkeyup="setRangeVal(this)" id="range_val"><b class="font_20">&nbsp;￦</b><br>
			</div>
			<div class="clear"></div>
		</div><br>
		<div class="div_01">
			<aside class="aside_01 fl" style="height:1px;"></aside>
			<div class="fl margin_left_50 div_01_01 sub_div" style="text-align:right;">
				<button class="btn_01_01 font_30 " >생성</button>
				<button class="btn_01_01 font_30 margin_left_20" >취소</button>
			</div>
		</div>
		<br>
	</div>
</div>

<script>
	let max_price = 10000000
	const priceRegEx = /^(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
	chkWindowWidth()
	setDatePicker()
	setSelectNum()
	$("#goal_price").attr("max",max_price)
	$(window).resize(function(){
		chkWindowWidth()
	})
	
	function setDatePicker(){
		$("#finish_date").datepicker({
			dateFormat: 'yy-mm-dd',
			minDate: "+1D",
			showOn: "button",
			buttonText:"날짜",
			yearSuffix: "년",
		    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
		    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
		    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
		    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
		})
		$('#datepicker').datepicker('setDate', 'today');
		$(".ui-datepicker-trigger").addClass("btn_01_01")
		$(".ui-datepicker-trigger").height("33px")
	}
	function chkWindowWidth(){
		if($(window).width()<900){
			$(".sub_div").removeClass("div_01_01")
			$(".sub_div").addClass("div_01_02")
			$("#ray_01").css("margin-left","0%")
			
		}else{
			$(".sub_div").removeClass("div_01_02")
			$(".sub_div").addClass("div_01_01")
			$("#ray_01").css("margin-left","20%")
		}
	}
	
	function getRangeVal(selector){
		$("#range_val").val(selector.value)
	}
	function setRangeVal(selector){
		if(selector.value>max_price ){
			alert("최대금액은 "+max_price+"원을 넘을 수 없습니다.")
			$("#goal_price").val(0)
			$("#range_val").val("0")
		}
		if(!isNaN(selector.value) || priceRegEx.test(selector.value)){
			$("#goal_price").val(selector.value)
			$("#range_val").val(selector.value)
		}else{
			$("#goal_price").val(0)
			$("#range_val").val("0")
		}
	}
	function setSelectNum(){
		for(var i=2; i<21; i++){
			var node = "<option value="+i+">"+i+"명</option>"
			$("#number").append(node);
		}
	}
	function setMaxPrice(type){
		
		if(type === 'spec'){
			max_price = 100000000
			$("#price_text").html("총 금액")
		}else{
			max_price = 1000000
			$("#price_text").html("개인별 금액")
		}
		$("#goal_price").attr("max",max_price)
		console.log(max_price)
		$("#goal_price").val(0)
		$("#range_val").val("0")
	}
</script>