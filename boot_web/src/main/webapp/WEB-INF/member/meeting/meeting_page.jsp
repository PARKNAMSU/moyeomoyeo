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
	width: 58%;margin-bottom:60px;
}

.friends_div_01_01 {
	width: 100%;
	height: 600px;
	background-color: #B9E2FA;
	box-shadow: 2px 2px 2px 2px #3063C2;
	overflow: scroll;
	border-radius: 5px;
}

.friends_div_01_01::-webkit-scrollbar {
	width: 15px;
}

.friends_div_01_01::-webkit-scrollbar-track {
	background-color: transparent;
}

.friends_div_01_01::-webkit-scrollbar-thumb {
	border-radius: 5px;
	background-color: #3063C2;
}

.friends_div_01_01::-webkit-scrollbar-button {
	width: 0;
	height: 0;
}

.friends_div_01_02 {
	width: 100%;
	height: 100px;
	padding: 20px;
	border-bottom: solid 1.5px #3063C2;
}

.img_div_01 {
	width: 59px;
	height: 100%;
	border-radius: 70%;
	overflow: hidden;
}

.on_cycle {
	width: 15px;
	height: 15px;
	border-radius: 70%;
	background-color: #52E252;

}
.off_cycle {
	width: 15px;
	height: 15px;
	border-radius: 70%;
	background-color: red;

}
.comments_div{
	width:100%;
}
.comments_div_01{
	width:100%;background-color:#B9E2FA;padding:10px;border-bottom:solid #3063C2;
}
</style>
<div id="main_1" class="container-fluid"
	style="padding-top: 90px; padding-bottom: 90px;">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50" id="meeting_name"></p>
		<div class="line_01"></div>
		<br>
		<div style="text-align: right;" id="top_a_btn">
			
		</div>
		<br>
		<br>
		<p class="font_30" id="meeting_goal">모임목적(모임부제목)</p>
		<hr>
		<p>
			from: <span id="reg_date">2020/01/01</span><br><span id="end_date_div">to: <span id="end_date">2021/01/01</span></span>
		</p>
		<div style="width:100%;text-align:right;"><a class="a_btn" style="font-size:16px;" onclick="importPay()" id="pay_btn">결제</a></div>
		<p class="font_30" style="text-align: right;">
			<span id="meeting_fee">40000</span>￦&nbsp;<span class="font_20">(n/1금액)</span>
		</p>
		<hr>
		<div class="fl font_20"
			style="width: 420px; margin-right: 50px; text-align: center;">
			<p class="font_30">모임설명</p>
			<p id="meeting_info"></p>
		</div>
		
		<div class="fl" style="width: 420px;">
			<div style="text-align: center;">

				<p class="font_30">참여명단 (<span id="now_num">1</span>/<span id="max_num">5</span>)</p>
				<div style="" class="friends_div_01_01" id="attend_member_div">
			
				</div>

			</div>
		</div>
		
		<div class="clear"></div>
		<hr>
		<p class="font_30">코멘츠</p>
		<textarea rows="" cols="" class="form-control" id="content"></textarea><br>
		<div style="width:100%;text-align:right;margin-bottom:30px;">
			<button class="btn_01" onclick="addComment($('#content').val())">입력</button>
			<input type="button" value="취소" class="btn_01_01" onclick="$('#content').val('')">
		</div>
		
		<div class="comments_div">

		</div>
		<div style="width:100%;text-align:center;" id="more_comments">
		</div>
		<hr>
		<div style="width:100%;">
			<p class="font_30">연락처</p>
			<p>전화번호: <span id="admin_connect_phone"></span></p>
			<p>이메일: <a id="admin_connect_email" href=""></a></p>
		</div>
		<hr>
		<div style="width:100%;margin-top:30px;text-align:right;" >
			<button class="btn_01_01 font_30 margin_right_20" onclick="location.href='/'">홈으로</button>
			<button class="btn_01_01 font_30" onclick="history.back()">뒤로</button>
		</div>
		
	</div>
</div>
<script>

let money = 1000
let room_code = '${code}'
let room_end_date_yn = 'y'
let pay_obj = new Object();
let df_comments_num = 5;
let comments_num = df_comments_num;
let top_a_btn_member = '<a class="a_btn" onclick="">신고</a>&nbsp;&nbsp;<a class="a_btn" onclick="exitRoom()">나가기</a>'
let a_btn_end_date_y= '<a class="a_btn" onclick="followMember()">초대</a>&nbsp;&nbsp;<a class="a_btn" onclick="updateRoom($(this))">수정</a>';
let a_btn_end_date_n = '<a class="a_btn" onclick="followMember()">초대</a>&nbsp;&nbsp;<a class="a_btn" onclick="updateRoom($(this))">수정</a>&nbsp;&nbsp;<a class="a_btn" onclick="">끝내기</a>';
let top_a_btn_admin = null;

$(document).ready(function(){
	chkWindowWidth()
	settingContent()
	settingComments()
	$(window).resize(function(){
		chkWindowWidth()
	})
})
function exitRoom(){
	$.ajax({
		type:"post",
		dataType:"text",
		url:"/member/exit_room",
		data:{
			code:room_code,
			type:"exit",
			"${_csrf.parameterName}":"${_csrf.token}"
		},
		error:function(data){alert('error')}
	}).done(function(data){
		location.href='/member/my_meeting'
	})
}
function settingContent(){
	console.log(room_code)
	$.ajax({
		type:"GET",
		dataType:"text",
		url:"/member/room_info",
		async:false,
		data:{
			code:room_code
		},
		error:function(data){alert("error")}
	}).done(function(data){
		$("#attend_member_div").empty()
		var data_obj = JSON.parse(data);
		console.log(data_obj)
		settingMeetingInfo(data_obj[0][0])
		$("#now_num").text(data_obj[1].length)
		data_obj[1].forEach(function(item){
			var pnum = item.phone_number
			var follow_a = '<a onclick="" class="a_btn">언팔로우</a><a onclick="" class="margin_left_20 a_btn">신고</a>'
			var unfollow_a = '<a onclick="" class="a_btn">팔로우</a><a onclick="" class="margin_left_20 a_btn">신고</a>'
			var pay_yn = returnConditionObj(item.pay_yn,'y',['지불','#3063C2'],['미지불','red']);
			var a_btn = returnConditionObj(item.follow_yn,'y',follow_a,unfollow_a);
			var name = returnConditionObj(item.email,'${user_id}','나',item.name);
			if(name === '나'){
				var pay_btn = returnConditionObj(item.pay_yn,'y','','결제')
				$("#top_a_btn").append(returnConditionObj(item.meeting_member_role,'admin',top_a_btn_admin,top_a_btn_member));
				a_btn = '<br>'
			}
			if(item.meeting_member_role === 'admin'){
				pay_yn = ['',''];
				if(pnum != null && pnum != ''){
					$("#admin_connect_phone").text(pnum.substring(0,3)+"-"+pnum.substring(3,7)+"-"+pnum.substring(7,11))
					pay_obj.phone = pnum.substring(0,3)+"-"+pnum.substring(3,7)+"-"+pnum.substring(7,11)
				}
				$("#admin_connect_email").text(item.email)
				$("#admin_connect_email").attr("href","mailto:"+item.email)
				pay_obj.name = item.name;
				pay_obj.email = item.email;
				name = returnConditionObj(item.email,'${user_id}','나',item.name) + " (총무)"
				pay_btn = ''
			}
			$("#pay_btn").text(pay_btn)
			var el = '<div class="friends_div_01_02">'
						+'<div class="fl img_div_01 margin_right_20">'
							+'<img alt="" src="'+getImgUrl(item.profile_url)+'"'
							+'style="width: 100%; height: 100%">'
						+'</div>'
						+'<div class="fl" style="width: 270px; height: 100%;">'
							+'<div style="text-align: right; width: 100%;">'
								+'<div class="fl" style="color:'+pay_yn[1]+';">'+pay_yn[0]+'</div>'
								+ a_btn
							+'</div>'
							+'<div style="text-align: left;">'
								+'<p>'+name+'</p>'	
							+'</div>'
						+'</div>'
						+'<div class="clear"></div>'
					+'</div>'
			$("#attend_member_div").append(el)
		})
	})
}
function updateRoom(node){
	console.log(name)
	$("#meeting_name").html("<input type='text' id='meeting_name_val' value='"+$("#meeting_name").text()+"' >")
	$("#meeting_goal").html("<input type='text' id='meeting_goal_val' value='"+$("#meeting_goal").text()+"' >")
	$("#end_date").html("<input type='text' id='end_date_val' value='"+$("#end_date").text()+"' x>")
	$("#meeting_info").html("<textArea id='meeting_info_val' style='width:100%;height:550px;'>"+$("#meeting_info").text()+"</textArea>")
	
	$("#end_date_val").datepicker({
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
	$(".ui-datepicker-trigger").height("28px")
	
	node.attr("onclick","setUpdateMeeting()")
}
function setUpdateMeeting(){
	var name = $("#meeting_name_val").val();
	var goal = $("#meeting_goal_val").val();
	var end_date = returnConditionObj(room_end_date_yn,'y',$("#end_date_val").val(),null);
	var info = $("#meeting_info_val").val();
	$.ajax({
		type:"post",
		dataType:"text",
		url:"/member/set_meeting_room",
		data:{
			meeting_code:room_code,
			meeting_name:name,
			meeting_goal:goal,
			meeting_info:info,
			end_date_str:end_date,
			end_date_yn:room_end_date_yn,
			"${_csrf.parameterName}":"${_csrf.token}"
		},
		error:function(data){alert("error")}
	}).done(function(data){
		location.reload();
	})
	
}

function settingMeetingInfo(data){
	$("#meeting_goal").text(data.meeting_goal)
	$("#meeting_name").text(data.meeting_name)
	$("#reg_date").text(data.reg_date)
	$("#end_date").text(data.end_date)
	$("#meeting_fee").text(data.meeting_fee)
	$("#meeting_info").text(data.meeting_info)
	$("#max_num").text(data.meeting_num)
	pay_obj.room_name = data.meeting_name
	if(data.end_date_yn == 'n'){
		console.log(data.end_date_yn)
		$("span").remove("#end_date_div")
		room_end_date_yn = 'n'
	}
	top_a_btn_admin = returnConditionObj(data.end_date_yn,'y',a_btn_end_date_y,a_btn_end_date_n)
}

function chkWindowWidth(){
	if($(window).width()< 900){
		$("#ray_01").css("margin-left","3%");
		$("#ray_01").css("width","95%");
	}else{
		$("#ray_01").css("margin-left","20%");
		$("#ray_01").css("width","58%");
	}
}
function importPay(){
	 // getter
    var IMP = window.IMP;
    IMP.init('imp31545010');
    IMP.request_pay({
        pg: 'kakao',
        merchant_uid: 'merchant_' + new Date().getTime(),
        name: pay_obj.room_name,
        amount: money,
        buyer_email:pay_obj.email,
        buyer_name:pay_obj.name,
        buyer_tel:pay_obj.phone,
        buyer_addr: '',
        buyer_postcode:''
    }, function (rsp) {
        if (rsp.success) {
            var msg = '결제가 완료되었습니다.';
            msg += '고유ID : ' + rsp.imp_uid;
            msg += '상점 거래ID : ' + rsp.merchant_uid;
            msg += '결제 금액 : ' + rsp.paid_amount;
            msg += '카드 승인번호 : ' + rsp.apply_num;
            $.ajax({
                type: "POST", 
                url: "/member/set_meeting_member", //충전 금액값을 보낼 url 설정
                data: {
                    type:"pay",
                    yn:"y",
                    code:room_code,
                    "${_csrf.parameterName}":"${_csrf.token}"
                },
                error:function(data){alert("에러")}
            }).done(function(data){
                alert("결제가 완료되었습니다.")
                settingContent()
            })
        } else {
            var msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
        }
    });
}

function addComment(content){
	if(content === "" || content == null){
		alert("내용을 입력하세요.")
		return false;
	}
    $.ajax({
        type: "POST", 
        url: "/member/add_comment", //충전 금액값을 보낼 url 설정
        data: {
            meeting_code:room_code,
            comments_content:content,
            "${_csrf.parameterName}":"${_csrf.token}"
        },
        error:function(data){alert("에러")}
    }).done(function(data){
    	$('#content').val('')
    	settingComments()
    })
}

function settingComments(){
	$(".comments_div").empty();
	$("#more_comments").empty();
	 $.ajax({
        type: "POST", 
        url: "/member/get_comments", //충전 금액값을 보낼 url 설정
        data: {
            code:room_code,
            comments_num:comments_num,
            "${_csrf.parameterName}":"${_csrf.token}"
        },
        error:function(data){alert("에러")}
    }).done(function(data){
    	if(data === "na"){
			return false;
    	}
        var data_obj = JSON.parse(data)
        console.log(data_obj)
        var sub_el = "<b style='color:gray;cursor:pointer;' onclick='setCommentsNum(\"more\")'>더보기..</b>"
        var sub_el2 = "<b style='color:gray;cursor:pointer;' onclick='setCommentsNum(\"rm\")'>접기..</b>"
    	if(data_obj.length > comments_num){
    		for(var i=0; i<comments_num; i++){
    			setCommentsEl(data_obj[i])
    		}
    		$("#more_comments").append(sub_el)
    	}else{
    		if(data_obj.length > df_comments_num){
    			$("#more_comments").append(sub_el2)
    		}
    		data_obj.forEach(function(item){
    			setCommentsEl(item)
    		})
    	}
    })
}
function setCommentsEl(data){
	var a_btn = returnConditionObj(data.email,'${user_id}',
			'<a class="a_btn margin_right_10" onclick="setUpdate($(this),'+data.comments_seq+')">수정</a><a class="a_btn margin_right_10" onclick="rmComment('+data.comments_seq+')">삭제</a>','<a class="a_btn margin_right_10">신고</a>')	
	var el = '<div class="comments_div_01">'
		+'<div class="fl" style="width:50px;height:50px;border-radius:70%;overflow:hidden;">'
			+'<img src="'+getImgUrl(data.profile_url)+'" style="width:100%;height:100%;">'
		+'</div>'
		+'<div class="fl" id="comment_contents" style="width:70%;margin-left:30px;">'
			+'<div class="fl font_20" style="width:20%;"><p style="">'+data.name+'</p></div>'
			+'<div class="fl" style="width:49%;"><span style="color:gray;text-align:right">'+data.reg_date+'</span></div>'
			+'<div class="clear"></div>'
			+'<p id="content">'+data.comments_content+'</p>'
		+'</div>'
		+'<div class="clear"></div>'
		+'<div style="width:100%;text-align:right;">'+a_btn+'</div>'
	+'</div>'
	$(".comments_div").append(el)
}

function setCommentsNum(type){
	if(type === "rm"){
		comments_num = 5;
	}else{
		comments_num += 5;
	}
	settingComments()
}
function followMember(){
	postForm('/member/meeting_invite',["code","${_csrf.parameterName}"],[room_code,"${_csrf.token}"] ,"POST");
}
function rmComment(seq){
	if(!confirm("삭제하시겠습니까?")){
		return false;
	}
	$.ajax({
		type:"GET",
		dataType:"text",
		url:"/member/set_comment",
		data:{
			seq:seq,
			type:"delete"
		},
		error:function(data){alert("에러")}
	}).done(function(data){
		settingComments()
	})
}
function setUpdate(node,seq){
	var p_el = node.parent()
	var el = node.parent().siblings('#comment_contents').children("#content")
	el.html("<input type='text' style='width:100%;background-color:#B9E2FA;' value='"+el.text()+"' id='temp_"+seq+"'>")
	p_el.empty()
	p_el.append('<a class="a_btn margin_right_10" onclick="updateComment('+seq+',$(\'#temp_'+seq+'\').val())">수정</a><a class="a_btn margin_right_10" onclick="settingComments()">취소</a>')
	
}
function updateComment(seq,content){
	console.log(content)
	if(content === "" || content == null){
		alert("수정하실 댓글을 입력해주세요.")
		return false;
	}
	$.ajax({
		type:"GET",
		dataType:"text",
		url:"/member/set_comment",
		data:{
			seq:seq,
			content:content,
			type:"update"
		},
		error:function(data){alert("에러")}
	}).done(function(data){
		settingComments()
	})
}
</script>