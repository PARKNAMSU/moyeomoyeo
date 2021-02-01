<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
	#board_pop_01{
		width:953px;
		padding:20px;

	}
	.board_title_div{
		width:100px;
		text-align:right;
		font-size:20px;
		margin-right:20px;
		float: left;
	}
	.board_content{
		width:700px;
	}
</style>

<div id="board_pop_01">
	<div style="text-align: center;"><p class="font_30" id="manage_main_title">게시판 생성</p></div>
	<div style="margin-bottom:20px;">
		<div class="board_title_div">제목</div>
		<input class="form-control fl board_content" id="board_title">
		<div class="clear"></div>
	</div>
	<div style="margin-bottom:20px;">
		<div class="board_title_div">내용</div>
		<textarea id="board_content" class="form-control fl board_content" rows="16"></textarea>
		<div class="clear"></div>
	</div>
	<div style="width:820px;text-align:right;" id="bottom_btn_div">
		<input type="button" value="생성" class="btn_01_01 font_20" onclick="setBoard()" id="board_bottom_btn">
	</div>
</div>
<script>
var seq = ${seq};
var t = "${type}";
setBoardContent(seq,t)

function setBoardContent(seq,_type){
	type = _type
	board_seq = seq
	if(type === "insert"){
		return false;
	}
	$("#board_bottom_btn").attr("value","수정")
	$("#manage_main_title").text("게시판 수정")
	$("#bottom_btn_div").append('<input type="button" value="삭제" class="btn_01_01 font_20" onclick="deleteBoard()" id="board_bottom_btn" style="margin-left:20px">')
	$.ajax({
		type:"get",
		url:"/get_board",
		dataType:"text",
		data:{seq:board_seq},
		error:function(data){alert("error")}
	}).done(function(data){
		var data_obj = JSON.parse(data) 
		console.log(data)
		$("#board_title").val(data_obj.board_title)
		$("#board_content").val(data_obj.board_content)
	})
}
function setBoard(){
	var title = $("#board_title").val()
	var content = $("#board_content").val()
	if(title.length < 6 || content.length <10){
		alert("제목 또는 내용의 길이가 너무 짧습니다.")
		return false;
	}
	var data_param = null;
	console.log(type)
	if(type != 'insert'){
		data_param = {
				board_title:title,
				board_content:content,
				type:type,
				table_type:'board',
				board_seq:board_seq
		}
	}else{
		data_param = {
				board_title:title,
				table_type:'board',
				board_content:content,
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
		findBoard("/get_all_board","board")
		closePopup()
	})
}

function deleteBoard(){
	if(!confirm("정말로 삭제하시겠습니까?")){
		return false;
	}
	type = "delete"
	setBoard()
}
</script>