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
		<p class="font_50" id="meeting_name">모임제목</p>
		<div class="line_01"></div>
		<br>
		<div style="text-align: right;" id="top_a_btn">
			
		</div>
		<br>
		<br>
		<p class="font_30" id="meeting_goal">모임목적(모임부제목)</p>
		<hr>
		<p>
			from: <span id="reg_date">2020/01/01</span><br>to: <span id="end_date">2021/01/01</span>
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
		<textarea rows="" cols="" class="form-control"></textarea><br>
		<div style="width:100%;text-align:right;margin-bottom:30px;">
			<button class="btn_01">입력</button>
			<input type="reset" value="취소" class="btn_01_01">
		</div>
		
		<div class="comments_div">
			<div class="comments_div_01">
				<div class="fl" style="width:50px;height:50px;border-radius:70%;overflow:hidden;">
					<img src="/resource/img/my1.jpg" style="width:100%;height:100%;">
				</div>
				<div class="fl" style="width:70%;margin-left:30px;">
					<p style="color:gray;">박남수  2020/01/01</p>
					<p>안녕하세요</p>
				</div>
				<div class="clear"></div>
			</div>

			<div class="comments_div_01" >
				<div class="fl" style="width:50px;height:50px;border-radius:70%;overflow:hidden;">
					<img src="/resource/img/my1.jpg" style="width:100%;height:100%;">
				</div>
				<div class="fl" style="width:70%;margin-left:30px;">
					<p style="color:gray;">박남수  2020/01/01</p>
					<p>하이항</p>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<hr>
		<div style="width:100%;">
			<p class="font_30">연락처</p>
			<p>전화번호: <span id="admin_connect_phone"></span></p>
			<p>이메일: <a id="admin_connect_email" href=""></a></p>
		</div>
		<hr>
		<div style="width:100%;margin-top:30px;text-align:right;" >
			<button class="btn_01_01 font_30 margin_right_20">모임 나가기</button><button class="btn_01_01 font_30">뒤로</button>
		</div>
		
	</div>
</div>
<script>

let money = 1000
let room_code = '${code}'
let pay_obj = new Object();

let top_a_btn_member = '<a class="a_btn" onclick="">신고</a>&nbsp;&nbsp;<a class="a_btn" onclick="">나가기</a>'
let top_a_btn_admin = '<a class="a_btn" onclick="">초대</a>&nbsp;&nbsp;<a class="a_btn" onclick="">삭제</a>'

$(document).ready(function(){
	chkWindowWidth()
	settingContent()
	$(window).resize(function(){
		chkWindowWidth()
	})
})
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
			var follow_a = '<a onclick="" class="a_btn">언팔로우</a>'
			var unfollow_a = '<a onclick="" class="a_btn">팔로우</a>'
			var pay_yn = returnConditionObj(item.pay_yn,'y',['지불','#3063C2'],['미지불','red']);
			var a_btn = returnConditionObj(item.follow_yn,'y',follow_a,unfollow_a);
			var name = returnConditionObj(item.email,'${user_id}','나',item.name);
			if(name === '나'){
				var pay_btn = returnConditionObj(item.pay_yn,'y','','결제')
				$("#top_a_btn").append(returnConditionObj(item.meeting_member_role,'admin',top_a_btn_admin,top_a_btn_member));
			}
			if(item.meeting_member_role === 'admin'){
				pay_yn = ['',''];
				$("#admin_connect_phone").text(pnum.substring(0,3)+"-"+pnum.substring(3,7)+"-"+pnum.substring(7,11))
				$("#admin_connect_email").text(item.email)
				$("#admin_connect_email").attr("href","mailto:"+item.email)
				pay_obj.name = item.name;
				pay_obj.email = item.email;
				pay_obj.phone = pnum.substring(0,3)+"-"+pnum.substring(3,7)+"-"+pnum.substring(7,11)
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
								+'<a onclick="" class="margin_right_20 a_btn">신고</a>'
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

function settingMeetingInfo(data){
	$("#meeting_goal").text(data.meeting_goal)
	$("#meeting_name").text(data.meeting_name)
	$("#reg_date").text(data.reg_date)
	$("#end_date").text(data.end_date)
	$("#meeting_fee").text(data.meeting_fee)
	$("#meeting_info").text(data.meeting_info)
	$("#max_num").text(data.meeting_num)
	pay_obj.room_name = data.meeting_name
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
        console.log(rsp);
        if (rsp.success) {
            var msg = '결제가 완료되었습니다.';
            msg += '고유ID : ' + rsp.imp_uid;
            msg += '상점 거래ID : ' + rsp.merchant_uid;
            msg += '결제 금액 : ' + rsp.paid_amount;
            msg += '카드 승인번호 : ' + rsp.apply_num;
            /*
            $.ajax({
                type: "GET", 
                url: "", //충전 금액값을 보낼 url 설정
                data: {
                    "amount" : money
                },
            });
            */
            console.log(msg)
        } else {
            var msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
        }
        alert(msg);
    });
}
</script>