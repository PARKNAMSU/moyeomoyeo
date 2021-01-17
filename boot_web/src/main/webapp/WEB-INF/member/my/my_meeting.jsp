<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
#ray_01 {
	color: black;
	text-align: left;
	margin-top: 90px;
	width: 58%;
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

.delete_01 {
	color: black;
	z-index: 5;
	text-align: right;
	display:none;
}
</style>
<div id="main_1" class="container-fluid" style="padding-top:90px;padding-bottom:90px;">
	<div class="ray_20" id="ray_01" style="">
		<b class="font_50">나의 모임</b>
		<div class="line_01"></div>
		<div><b>S: 시크릿 모임</b><b>O: 오픈 모임</b></div>
		<br><br>
		<div style="width:100%;">
			<div class="fl margin_right_20 cursur_p" onclick="chgFinishYn('n','y',$('#during_txt'),$('#finish_txt'),$('#invite_txt'))" onmouseover="overMenu(1,'over')" onmouseleave="overMenu(1,'leave')">
				<span class="font_30" style="color: #3063C2" id="during_txt">진행중</span>
				<div class="line_01 vis_h" style="height:2px;" id="main_line_1"></div>
			</div>
			<div class="fl margin_right_20 cursur_p" onclick="chgFinishYn('y','y',$('#finish_txt'),$('#during_txt'),$('#invite_txt'))" onmouseover="overMenu(2,'over')" onmouseleave="overMenu(2,'leave')">
				<span class="font_30" style="color: black" id="finish_txt">완료</span>
				<div class="line_01 vis_h" style="height:2px;" id="main_line_2"></div>
			</div>
				<div class="fl cursur_p" onclick="chgFinishYn('n','n',$('#invite_txt'),$('#during_txt'),$('#finish_txt'))" onmouseover="overMenu(3,'over')" onmouseleave="overMenu(3,'leave')">
				<span class="font_30" style="color: black" id="invite_txt">미확인</span>
				<div class="line_01 vis_h" style="height:2px;" id="main_line_3"></div>
			</div>
			<div class="clear" style="margin-bottom:20px;"></div>
			<div id="room_main_div" style="width:100%;">
			</div>
			<div class="clear"></div>
		</div>

	</div>
	
</div>
<script>
	var finish_yn = "n";
	var accept_yn = "y";
	$(".meet_el").css("height",$(".meet_el").width()+50+"px")
	$(document).ready(function(){
		chkWindowWidth()
		getMyRoom()
		$(window).resize(function(){
			chkWindowWidth()
		})
	})
	function chkWindowWidth(){
		if($(window).width()< 900){
			$("#ray_01").css("margin-left","0%");
			$("#ray_01").css("width","100%");
			$("#ray_01").css("text-align","center")

		}else{
			$("#ray_01").css("margin-left","20%");
			$("#ray_01").css("width","58%");
			$("#ray_01").css("text-align","left")
		}
	}
	
	function overMeet(selector,type,idx){
		if(type === 'over'){
			$(selector).css("opacity","0.8")
		}else if(type === 'leave'){
			$(selector).css("opacity","1")
		}
	}
	function overMenu(idx,type){
		if(type === 'over'){
			$("#main_line_"+idx).css("visibility","visible")
		}else if(type === 'leave'){
			$("#main_line_"+idx).css("visibility","hidden")
		}
	}
	function getMyRoom(){
		$("#room_main_div").empty()
		$.ajax({
			 type:"GET",
			 url:"/member/my_room",
			 dataType:"text",
			 data:{
				 type:finish_yn,
				 accept_type:accept_yn
			 },
			 error:function(data){alert("error")}
		}).done(function(data){
			if(data != "na"){
				var data_obj = JSON.parse(data);
			}else{
				return false;
			}
			data_obj.forEach(function(data){
				var type = null;
				if(data.meeting_type === "secret"){
					type = "S"
				}else{
					type = "O"
				} 
				var end_date_div = returnConditionObj(data.end_date_yn,'y',
						'<div class="meet_sub_div_01" style="text-align:right;" id="end_date_div"><span class="font_15">to: '+data.end_date+'</span></div>','');
				var on_click = returnConditionObj(accept_yn,'y',"mvMeetingDetail('"+data.meeting_code+"')","acceptMeetingInvite('"+data.meeting_code+"')")
				var on_click_fns = "clickFinishRoom('"+data.meeting_code+"')"
				var el = '<div class="meet_el fl" onclick="'+returnConditionObj(finish_yn,'n',on_click,on_click_fns)+'" onmouseover="overMeet(this,\'over\',1)" onmouseleave="overMeet(this,\'leave\',1)" onclick="">'
				+'<div style="width:78%;overflow:hidden;height:40px;" class="fl"><span class="font_30">'+data.meeting_name+'</span></div>'
				+'<div class="fl cycle_01" style="">'+type+'</div><div class="clear"></div>'
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
	function clickFinishRoom(code){
		if(!confirm("이미 종료된 모임입니다. 해당 모임에서 나가시겠습니까?")){
			return false;
		}
		$.ajax({
			type:"post",
			url:"/member/exit_room",
			dataType:"text",
			data:{
				code:code,
				type:"remove",
				"${_csrf.parameterName}":"${_csrf.token}"
			},
			error:function(data){alert("에러")}
			
		}).done(function(data){
			getMyRoom()
		})
	}
	
	function chgFinishYn(yn,nc_yn,c_el,el,el2){
		finish_yn = yn
		accept_yn = nc_yn
		c_el.css("color","color: #3063C2")
		el.css("color","black")
		el2.css("color","black")
		getMyRoom()
	}
	function mvMeetingDetail(code){
		postForm("/member/meeting_page", ["meeting_code","${_csrf.parameterName}"], [code,"${_csrf.token}"] ,'post')
	}
	function acceptMeetingInvite(code){
		if(confirm("초대를 수락하시겠습니까?")){
            $.ajax({
                type: "POST", 
                url: "/member/set_meeting_member", //충전 금액값을 보낼 url 설정
                data: {
                    type:"accept",
                    yn:"y",
                    code:code,
                    "${_csrf.parameterName}":"${_csrf.token}"
                },
                error:function(data){alert("에러")}
            }).done(function(data){
            	getMyRoom()
            })
		}else{
			if(confirm("해당 초대를 삭제하시겠습니까?")){
	            $.ajax({
	                type: "POST", 
	                url: "/member/set_meeting_member", //충전 금액값을 보낼 url 설정
	                data: {
	                    type:"delete",
	                    code:code,
	                    "${_csrf.parameterName}":"${_csrf.token}"
	                },
	                error:function(data){alert("에러")}
	            }).done(function(data){
	            	
	            	alert()
	            	getMyRoom()
	            })
			}
		}
	}
</script>