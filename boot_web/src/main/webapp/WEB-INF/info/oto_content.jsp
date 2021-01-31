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
	margin-bottom: 60px;
}

.oto_sub_div{
	width:100%;padding:10px;border-bottom:solid #3063C2;
}
</style>
<div id="main_1" class="container-fluid"
	style="padding-top: 90px; padding-bottom: 90px;">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">1:1문의</p>
		<div class="line_01"></div>
		<br>
		<div style="width: 100%; text-align: right;"><a class="a_btn">삭제</a></div>
		<br>
		<div style="width: 100%; text-align: right;" class="font_15"><span id="writer">나</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="date">2020/01/01</span></div>
		<p class="font_30" id="title">1:1문의 제목</p>
		<hr>
		<nav class="font_20" id="content">안녕하세요 모여모여를 이용해 주셔서 감사합니다.안녕하세요 모여모여를 이용해
			주셔서 감사합니다.안녕하세요 모여모여를 이용해 주셔서 감사합니다.안녕하세요 모여모여를 이용해 주셔서 감사합니다.안녕하세요
			모여모여를 이용해 주셔서 감사합니다.안녕하세요 모여모여를 이용해 주셔서 감사합니다.안녕하세요 모여모여를 이용해 주셔서
			감사합니다.안녕하세요 모여모여를 이용해 주셔서 감사합니다.s</nav>
		<br>
		<div id="answer_div" style="width: 100%;text-align: right;"></div>
		<hr>
		<div id="sub_div"></div>
		<div class="div_01" style="width: 100%; margin-top: 40px;">
			<div class="fl margin_left_50 div_01_01 sub_div"
				style="text-align: right; width: 100%;">
				<button class="btn_01_01 font_30 margin_right_20"
					onclick="location.href='/'">홈으로</button>
				<c:choose>
					<c:when test="${user_id == 'admin'}">
						<button class="btn_01_01 font_30 margin_right_40" onclick="location.href='/admin/board_main'">관리</button>
					</c:when>
					<c:otherwise>
						<button class="btn_01_01 font_30 margin_right_40">1:1문의</button>
					</c:otherwise>
				</c:choose>
				
			</div>
		</div>
	</div>
</div>

<div id="popup1" class="overlay" style="">
	<div class="popup" id="manage_pop" style="">
		<a class="close" href="#" onclick="closePopup()">&times;</a>
		<br><br><br>
		<div id="field">
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		chkWindowWidth()
		setOtoContent()
		$(window).resize(function() {
			chkWindowWidth()
		})
	})
	function chkWindowWidth() {
		if ($(window).width() < 900) {
			$("#ray_01").css("margin-left", "3%");
			$("#ray_01").css("width", "95%");
		} else {
			$("#ray_01").css("margin-left", "20%");
			$("#ray_01").css("width", "58%");
		}
	}
	function setOtoContent(){
		$.ajax({
			type:"get",
			url:"get_oto",
			dataType:"text",
			data:{
				seq:"${seq}"
			},
			error:function(data){alert("error")}
		}).done(function(data){
			var data_obj = JSON.parse(data)
			var root_data = data_obj[0]
			data_obj.shift();
			$("#title").text(root_data.oto_qst_title)
			$("#writer").text(root_data.oto_qst_writer)
			$("#date").text(root_data.oto_qst_reg_date)
			$("#content").text(root_data.oto_qst_content)
			if(data_obj.length == 0 && root_data.oto_qst_writer != "${user_id}"){
				$("#answer_div").append("<a class='a_btn'>답글</a>")
			}
			for(var i=0;i<data_obj.length;i++){
				var answer_el = '<div class="oto_sub_div">'
					+'<div class="" style="width:100%;">'
					+'<p style="color: gray;text-align:right;">'+data_obj[i].oto_qst_writer+' '+data_obj[i].oto_qst_reg_date+'</p>'
					+'<p class="font_20"><span style="color:#3063C2">re:</span> '+data_obj[i].oto_qst_title+'</p>'
					+'<p>'+data_obj[i].oto_qst_content+'</p>'
					+'<div style="width:100%;text-align:right;"><a class="a_btn">답글</a></div>'
				+'</div>'
				+'</div>'
				var no_answer_el = '<div class="oto_sub_div">'
					+'<div class="" style="width:100%;">'
					+'<p style="color: gray;text-align:right;">'+data_obj[i].oto_qst_writer+' '+data_obj[i].oto_qst_reg_date+'</p>'
					+'<p class="font_20"><span style="color:#3063C2">re:</span> '+data_obj[i].oto_qst_title+'</p>'
					+'<p>'+data_obj[i].oto_qst_content+'</p>'
				+'</div>'
				+'</div>'
				var el = null
				if(i == data_obj.length - 1){
					if(data_obj[i].oto_qst_writer === '${user_id}'){
						el = no_answer_el	
					}else{
						el = answer_el
					}
				}else{
					el = no_answer_el
				}
				$("#sub_div").append(el)
			}
			
		})
	}
</script>