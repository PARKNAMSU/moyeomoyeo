<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
	#often_pop_01{
		width:953px;
		padding:20px;

	}
	.often_title_div{
		width:100px;
		text-align:right;
		font-size:20px;
		margin-right:20px;
		float: left;
	}
	.often_content{
		width:700px;
	}
</style>

<div id="often_pop_01">
	<div style="text-align: center;"><p class="font_30" id="manage_main_title">자주묻는 질문 생성</p></div>
	<div style="margin-bottom:20px;">
		<div class="often_title_div">제목</div>
		<input class="form-control fl often_content" id="often_title">
		<div class="clear"></div>
	</div>
	<div style="margin-bottom:20px;">
		<div class="often_title_div">내용</div>
		<textarea id="often_content" class="form-control fl often_content" rows="16"></textarea>
		<div class="clear"></div>
	</div>
	<div style="width:820px;text-align:right;" id="bottom_btn_div">
		<input type="button" value="생성" class="btn_01_01 font_20" onclick="setoften()" id="often_bottom_btn">
	</div>
</div>
<script>
var seq = ${seq};
var t = "${type}";
setoftenContent(seq,t)

function setoftenContent(seq,_type){
	type = _type
	often_seq = seq
	if(type === "insert"){
		return false;
	}
	$("#often_bottom_btn").attr("value","수정")
	$("#manage_main_title").text("질문 수정")
	$("#bottom_btn_div").append('<input type="button" value="삭제" class="btn_01_01 font_20" onclick="deleteoften()" id="often_bottom_btn" style="margin-left:20px">')
	$.ajax({
		type:"get",
		url:"/get_often",
		dataType:"text",
		data:{seq:often_seq},
		error:function(data){alert("error")}
	}).done(function(data){
		var data_obj = JSON.parse(data) 
		console.log(data)
		$("#often_title").val(data_obj.often_title)
		$("#often_content").val(data_obj.often_content)
	})
}
function setoften(){
	var title = $("#often_title").val()
	var content = $("#often_content").val()
	if(title.length < 6 || content.length <10){
		alert("제목 또는 내용의 길이가 너무 짧습니다.")
		return false;
	}
	var data_param = null;
	console.log(type)
	if(type != 'insert'){
		data_param = {
				often_title:title,
				often_content:content,
				type:type,
				table_type:'often',
				often_seq:often_seq
		}
	}else{
		data_param = {
				often_title:title,
				often_content:content,
				table_type:'often',
				type:type
		}
	}
	$.ajax({
		type:"get",
		url:"/admin/manage_board",
		dataType:"text",
		data:data_param,
		error:function(data){
			alert("error")
		}
	}).done(function(data){
		findBoard("/get_all_often","often")
		closePopup()
	})
}

function deleteoften(){
	if(!confirm("정말로 삭제하시겠습니까?")){
		return false;
	}
	type = "delete"
	setoften()
}
</script>