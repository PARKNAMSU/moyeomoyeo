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
	<form id="create_form" method="post" >
	<input type="hidden" name="meeting_type" value="secret" >
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="token" />
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">시크릿 모임 생성</p>
		<div class="line_01"></div><br><br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">모임명</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input type="text" class="form-control" id="meeting_name" name="meeting_name">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">모임 목적</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input name="meeting_goal" type="text" class="form-control" id="meeting_goal">
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01">
			<aside class="aside_01 fl">
				<p class="font_20">모임 타입</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<select name="end_date_yn"  class="form-control fl" style="width:49%;margin-right:10px;" onclick="set_date_node($(this))">
					<option value="y" >기한</option>
					<option value="n" >무기한</option>
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
				<select name="meeting_num" class="form-control" style="width:49%;" id="number">

				</select>
			</div>
			<div class="clear"></div>
		</div>
		<br>
		<div class="div_01" id="meeting_date">
			<aside class="aside_01 fl">
				<p class="font_20">날짜</p>
			</aside>
			<div class="fl margin_left_50 div_01_01 sub_div">
				<input id="end_date" name="end_date_str" type="text" class="form-control fl" readonly="readonly" style="width:49%;">
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
				<input type="range" class="form-control"  min="0" value="0" onchange="getRangeVal(this)" id="goal_price" name="meeting_fee">
				<input type="text" class="form-control fl" style="width:200px;text-align:right;" onkeyup="setRangeVal(this)" id="range_val"><b class="font_20">&nbsp;￦</b><br>
			</div>
			<div class="clear"></div>
		</div><br>
		<div class="div_01">
			<aside class="aside_01 fl" style="height:1px;"></aside>
			<div class="fl margin_left_50 div_01_01 sub_div" style="text-align:right;">
				<input type="button" value="생성" class="btn_01_01 font_30 " 
				onclick="createRoom($('#meeting_name').val(),$('#meeting_goal').val(),$('#goal_price').val(),$('#create_form'))">
				<button class="btn_01_01 font_30 margin_left_20" onclick="history.back()">취소</button>
			</div>
		</div>
		<br>
	</div>
	</form>
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
		$("#end_date").datepicker({
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
	function set_date_node(node){
		if(node.val() === 'n'){
			$("#meeting_date").val("")
			$("#meeting_date").css("display","none");
			return false;
		}
		$("#meeting_date").css("display","initial");
	}
	function createRoom(name,goal,fee,form){
		if(name.length <6){
			alert("제목은 6글자 이상입니다.")
			return false;
		}
		if(goal == null || goal == ''){
			alert("목적은 반드시 입력해야 합니다.")
			return false;
		}
		if(fee < 1000){
			alert("금액은 1000원 이상입니다.")
			return false;
		}
		console.log(form.serialize())

		$.ajax({
			type:"POST",
			dataType:"text",
			url:"/member/create_meeting",
			data:form.serialize(),
			sucess:function(data){},
			error:function(data){alert("error")}
		}).done(function(data){
			alert("성공")
		})
			
	}
</script>