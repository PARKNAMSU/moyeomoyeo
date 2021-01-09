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
	border: solid #3063C2 1.5px;
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
	border-bottom: solid 0.2px gray;
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
		<p class="font_50">모임제목</p>
		<div class="line_01"></div>
		<br>
		<div style="text-align: right;">
			<a class="a_btn">신고</a>&nbsp;&nbsp;<a class="a_btn">나가기</a>
		</div>
		<br>
		<br>
		<p class="font_30">모임목적(모임부제목)</p>
		<hr>
		<p>
			from: 2020/01/01<br>to: 2021/01/01
		</p>
		<div style="width:100%;text-align:right;"><a class="a_btn" style="font-size:16px;">결제</a></div>
		<p class="font_30" style="text-align: right;">
			40000￦&nbsp;<span class="font_20">(n/1금액)</span>
		</p>
		<hr>
		<div class="fl font_20"
			style="width: 420px; margin-right: 50px; text-align: center;">
			<p class="font_30">모임설명</p>
			<p>모임에대한내용 모임에대한내용 모임에대한내용 모임에대한내용 모임에대한내용 모임에대한내용 모임에대한내용
				모임에대한내용 모임에대한내용 모임에대한내용 모임에대한내용 모임에대한내용 모임에대한내용 모임에대한내용 모임에대한내용</p>
		</div>
		
		<div class="fl" style="width: 420px;">
			<div style="text-align: center;">

				<p class="font_30">참여명단 (1/5)</p>
				<div style="" class="friends_div_01_01">
					<div class="friends_div_01_02">
						<div class="fl img_div_01 margin_right_20">
							<img alt="" src="/resource/img/my1.jpg"
								style="width: 100%; height: 100%">
						</div>
						<div class="fl" style="width: 270px; height: 100%;">
							<div style="text-align: right; width: 100%;">
								<div class="fl">40000￦</div>
								<a onclick="invite('test')" class="margin_right_20 a_btn">신고</a><a
									onclick="" class="a_btn">언팔로우</a>
							</div>
							<div style="text-align: left;">
								<p>뎀바바와드록바 (홍길동)</p>

							</div>
						</div>
						<div class="clear"></div>
					</div>
					
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
		
		<div style="width:100%;margin-top:30px;text-align:right;" >
			<button class="btn_01_01 font_30 margin_right_20">모임 나가기</button><button class="btn_01_01 font_30">뒤로</button>
		</div>
		
	</div>
</div>
<script>

let money = 1000

$(document).ready(function(){
	chkWindowWidth()
	$(window).resize(function(){
		chkWindowWidth()
	})
})
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
        name: '모임제목',
        amount: money,
        buyer_email: 'iamport@siot.do',
        buyer_name: '구매자이름',
        buyer_tel: '010-1234-5678',
        buyer_addr: '인천광역시 부평구',
        buyer_postcode: '123-456'
    }, function (rsp) {
        console.log(rsp);
        if (rsp.success) {
            var msg = '결제가 완료되었습니다.';
            msg += '고유ID : ' + rsp.imp_uid;
            msg += '상점 거래ID : ' + rsp.merchant_uid;
            msg += '결제 금액 : ' + rsp.paid_amount;
            msg += '카드 승인번호 : ' + rsp.apply_num;
            $.ajax({
                type: "GET", 
                url: "", //충전 금액값을 보낼 url 설정
                data: {
                    "amount" : money
                },
            });
        } else {
            var msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
        }
        alert(msg);
    });
}
</script>