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
	 #search {
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
	
	.meet_el {
		width: 301px;
		margin-right: 10px;
		margin-bottom: 10px;
		background-color: #3063C2;
		border-radius: 3%;
		padding: 3%;
		box-shadow: 2px 2px 2px 2px #013ADF;
		overflow: hidden;
		color: white;
		height: 292.646px;
		cursor: pointer;
	}
	
	.cycle_01 {
		width: 40px;
		height: 40px;
		border-radius: 70%;
		background-color: #EBFBFF;
		text-align: center;
		font-size: 30px;
		color: black
	}
	
	.meet_sub_div_01 {
		width: 95%;
		overflow: hidden
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
						style="width: 40px; height: 40px;" onclick="getSearchRoom($('#search').val(),$('#search_type').val())">
				</div>
				<input autocomplete="off" id="search" type="text" style=""
				onkeyup="" onblur="">
				<select class="fl form-control" id="search_type" style="width:100px;height:40px;">
					<option value="name">제목</option>
					<option value="goal">목적</option>
				</select>
				<div class="clear"></div>
			</div>
		</div>
		<hr>
		<div >
			<p class="font_30">검색결과</p>
		</div>
		<div id="room_main_div">
		</div>
	</div>
</div>

<script>

function getSearchRoom(search,type){
	$("#room_main_div").empty()
	$.ajax({
		 type:"GET",
		 url:"/member/search_room",
		 dataType:"text",
		 data:{
			 search:search,
			 type:type
		 },
		 error:function(data){alert("error")}
	}).done(function(data){
		if(data === "na"){
			return false;
		}
		var data_obj = JSON.parse(data);
		console.log(data_obj)	
		data_obj.forEach(function(data){
			var end_date_div = returnConditionObj(data.end_date_yn,'y',
					'<div class="meet_sub_div_01" style="text-align:right;" id="end_date_div"><span class="font_15">to: '+data.end_date+'</span></div>','');
			var on_click = 'attendRoom(\''+data.meeting_code+'\')'
			var el = '<div class="meet_el fl" onclick="'+on_click+'" onmouseover="overMeet(this,\'over\',1)" onmouseleave="overMeet(this,\'leave\',1)" onclick="">'
			+'<div style="width:78%;overflow:hidden;height:40px;"><span class="font_30">'+data.meeting_name+'</span></div>'
			+'<div style="width:95%;height:2px;background-color:#EBFBFF"></div>'
			+'<div class="meet_sub_div_01" style="text-align:right;"><span class="font_15">from: '+data.reg_date+'</span></div>'
			+ end_date_div
			+'<div class="meet_sub_div_01" style="height:30px;"><span class="font_20">'+data.meeting_goal+'</span></div>'
			+'<div class="meet_sub_div_01" style="height:30px;"><span class="font_20">금액: '+data.meeting_fee+'￦</span></div>'
			+'<div class="meet_sub_div_01" style="height:30px;"><span class="font_20">생성자: '+data.admin_email+'</span></div>'
			+'<div class="meet_sub_div_01"><span class="font_20">참가인원: '+data.meeting_num+'명</span></div>'
			+'</div>'
			$("#room_main_div").append(el)
		})
	})
}

function attendRoom(code){
	if(!confirm("참여하시겠습니까?")){
		return false;
	}
	$.ajax({
		type:"post",
		url:"/member/attend_room",
		dataType:"text",
		data:{
			code:code,
			"${_csrf.parameterName}":"${_csrf.token}"
		},
		error:function(data){alert("error")}
	}).done(function(data){
		if(data === 'fail'){
			return false;
		}
		alert("참여완료")
		getSearchRoom($('#search').val(),$('#search_type').val())
	})
}
</script>