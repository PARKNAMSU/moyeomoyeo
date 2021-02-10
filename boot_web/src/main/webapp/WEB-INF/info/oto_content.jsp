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
#manage_pop{
	padding:20px;
	margin-top:11%;
	background-color: #b8daff;
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
		<div style="width: 100%; text-align: right;"><a class="a_btn margin_right_10" id="main_mdf_bt" onclick=""></a><a class="a_btn" onclick="deleteOto()">삭제</a></div>
		<br>
		<div style="width: 100%; text-align: right;" class="font_15"><span id="writer">나</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="date">2020/01/01</span></div>
		<p class="font_30" id="title"></p><br>
		<nav class="font_20" id="content"></nav>
		<br>
		<div id="answer_div" style="width: 100%;text-align: right;"></div>
		<div class="line_01" style="background-color: black;"></div><br>
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
	<div class="popup" style="" id="manage_pop">
		<a class="close" href="#" onclick="closePopup()">&times;</a>
		<br><br><br>
		<div id="field">
			<p class="font_30">1:1문의 답글 등록</p>
			<input id="answer_title" style="background-color: transparent;box-shadow: 2px 2px 2px 2px" class="form-control">
			<textarea id="answer_content" rows="12" class="form-control" style="margin-top:15px;background-color: transparent;box-shadow: 2px 2px 2px 2px" ></textarea>
			<div style="width:100%;text-align:right;margin-top:15px;">
				<input type="button" class="btn_01_01 font_20" value="등록" onclick="addAnswer($('#answer_title'),$('#answer_content'))">
				<input type="button" class="btn_01_01 font_20" value="취소" onclick="closePopup()">
			</div>
		</div>
	</div>
</div>

<script>

	let oto_root_obj = null;
	
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
	function mdfOto(node,seq){
		var root = node.parent().parent()
		var title = root.find("#sub_title")
		var content = root.find("#sub_content")
		title.html("<input type='text' id='update_title"+seq+"' class='form-control' value='"+title.html()+"'>")
		content.html("<textarea class='form-control' id='update_content"+seq+"'>"+content.text()+"</textarea>")
		node.attr("onclick","updateOto("+seq+")")
	}
	function mdfOtoMain(seq){
		$("#title").html("<input type='text' id='update_title"+seq+"' class='form-control' value='"+$("#title").html()+"'>")
		$("#content").html("<textarea class='form-control' id='update_content"+seq+"'>"+$("#content").text()+"</textarea>")
		$("#main_mdf_bt").attr("onclick","updateOto("+seq+")")
	}
	function updateOto(seq){
		var title = $("#update_title"+seq).val()
		var content = $("#update_content"+seq).val()
		$.ajax({
			type:"get",
			dataType:"text",
			url:"/manage_oto",
			data:{
				oto_qst_seq:seq,
				oto_qst_title:title,
				oto_qst_content:content,
				type:"update"
			},
			error:function(data){alert("error")}
		}).done(function(data){
			setOtoContent()
		})
	}
	function deleteOto(){
		if(!confirm("정말로 삭제하시겠습니까?")){
			return false;
		}
		$.ajax({
			type:"get",
			dataType:"text",
			url:"/manage_oto",
			data:{
				oto_qst_seq:oto_root_obj.oto_qst_seq,
				type:"delete"
			},
			error:function(data){alert("error")}
		}).done(function(data){
			if("${user_id}" === 'admin'){
				location.href='/admin/board_main'
			}
			location.href='/oto_page'
		})
	}
	function addAnswer(title,content){
		console.log()
		if(!strCheck(title.val()) || !strCheck(content.val())){
			alert("내용을 입력해 주세요.")
			return false;
		}
		$.ajax({
			type:"get",
			dataType:"text",
			url:"/manage_oto",
			data:{
				oto_qst_title:title.val(),
				oto_qst_content:content.val(),
				oto_qst_root_seq:oto_root_obj.oto_qst_seq,
				type:"insert"
			},
			error:function(data){alert("error")}
		}).done(function(data){
			closePopup()
			setOtoContent()
		})
	}

	function setOtoContent(){
		$("#sub_div").empty()
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
			oto_root_obj = root_data
			data_obj.shift();
			$("#title").text(root_data.oto_qst_title)
			$("#writer").text(root_data.oto_qst_writer)
			$("#date").text(root_data.oto_qst_reg_date)
			$("#content").text(root_data.oto_qst_content)
			if("${user_id}" != "admin"){
				$("#main_mdf_bt").text("수정")
				$("#main_mdf_bt").attr("onclick","mdfOtoMain("+root_data.oto_qst_seq+")")
			}
			if(data_obj.length == 0 && root_data.oto_qst_writer != "${user_id}"){
				$("#answer_div").append("<a class='a_btn' onclick='openPopupDis()'>답글</a>")
			}
			for(var i=0;i<data_obj.length;i++){
				var answer_el = '<div class="oto_sub_div">'
					+'<div class="" style="width:100%;">'
					+'<p style="color: gray;text-align:right;">'+data_obj[i].oto_qst_writer+' '+data_obj[i].oto_qst_reg_date+'</p>'
					+'<p class="font_20"><span style="color:#3063C2">re:</span> '+data_obj[i].oto_qst_title+'</p>'
					+'<p>'+data_obj[i].oto_qst_content+'</p>'
					+'<div style="width:100%;text-align:right;"><a class="a_btn" onclick="openPopupDis()">답글</a></div>'
				+'</div>'
				+'</div>'
				var no_answer_el = '<div class="oto_sub_div">'
					+'<div class="" style="width:100%;">'
					+'<p style="color: gray;text-align:right;">'+data_obj[i].oto_qst_writer+' '+data_obj[i].oto_qst_reg_date+'</p>'
					+'<span style="color:#3063C2" class="font_20">re: </span><b class="font_20" id="sub_title">'+data_obj[i].oto_qst_title+'</b><br><br>'
					+'<p id="sub_content">'+data_obj[i].oto_qst_content+'</p>'
				+'</div>'
				+'</div>'
				var my_el = '<div class="oto_sub_div">'
					+'<div class="" style="width:100%;">'
					+'<p style="color: gray;text-align:right;">'+data_obj[i].oto_qst_writer+' '+data_obj[i].oto_qst_reg_date+'</p>'
					+'<span style="color:#3063C2" class="font_20">re: </span><b class="font_20" id="sub_title">'+data_obj[i].oto_qst_title+'</b><br><br>'
					+'<p id="sub_content">'+data_obj[i].oto_qst_content+'</p>'
					+'<div style="width:100%;text-align:right;"><a class="a_btn" onclick="mdfOto($(this),'+data_obj[i].oto_qst_seq+')">수정</a></div>'
				+'</div>'
				+'</div>'
				var el = null
				if(data_obj[i].oto_qst_writer != '${user_id}'){
					if(i == data_obj.length - 1){
						el = answer_el
					}else{
						el = no_answer_el
					}
				}else{
					el = my_el
				}
				$("#sub_div").append(el)
			}
			
		})
	}
</script>