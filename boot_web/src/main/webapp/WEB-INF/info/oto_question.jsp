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
</style>
<div id="main_1" class="container-fluid"
	style="padding-top: 90px; padding-bottom: 90px;">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">1:1문의</p>
		<div class="line_01"></div>
		<br>
		<br>

		<table class="table table-info table-hover table-striped t_align_c"
			id="board">
			<thead class="table-primary ">
				<tr>
					<th scope="col" style="width: 10%;">no.</th>
					<th scope="col" style="width: 60%;">제목</th>
					<th scope="col" style="width: 10%;">작성자</th>
					<th scope="col" style="width: 20%;">날짜</th>
				</tr>
			</thead>
			<tbody id="board_body">
			</tbody>
		</table>
		<div class="div_01" style="width:100%;margin-top:40px;">
			<div class="fl margin_left_50 div_01_01 sub_div" style="text-align:right;width:100%;">
				<button class="btn_01_01 font_30 margin_right_20" onclick="location.href='/often_page'">자주묻는 질문</button>
				<button class="btn_01_01 font_30 margin_right_40" onclick="openPopup()">문의하기</button>
			</div>
		</div>
	</div>
</div>

<div id="popup1" class="overlay" style="">
	<div class="popup" style="" id="manage_pop">
		<a class="close" href="#" onclick="closePopup()">&times;</a>
		<br><br><br>
		<div id="field">
			<p class="font_30">1:1문의 등록</p>
			<input id="title" style="background-color: transparent;box-shadow: 2px 2px 2px 2px" class="form-control">
			<textarea id="content" rows="12" class="form-control" style="margin-top:15px;background-color: transparent;box-shadow: 2px 2px 2px 2px" ></textarea>
			<div style="width:100%;text-align:right;margin-top:15px;">
				<input type="button" class="btn_01_01 font_20" value="등록" onclick="addOtoQst($('#title'),$('#content'))">
				<input type="button" class="btn_01_01 font_20" value="취소" onclick="closePopup()">
			</div>
		</div>
	</div>
</div>

<script>

let board_tb = null;
	$(document).ready(function(){
		chkWindowWidth()
		findBoard("/get_all_oto","board")
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
	
	const url_param = {
		"board":"/oto_info_page",
	}
	
	function setTable(tb,data,url){
		if(  typeof data == 'object'){
			data.forEach(function(item){

				var el = "<tr class='cursur_p' onclick='mvQst(\""+url+"\","+item.oto_qst_seq+")'>"
				+"<td>"+item.oto_qst_seq+"</td>"
				+"<td>"+item.oto_qst_title+"</td>"
				+"<td>"+item.oto_qst_writer+"</td>"
				+"<td>"+item.oto_qst_reg_date+"</td>"
				+"</tr>"
				$("#"+tb+"_body").append(el)
			})
		}	
	}
	
	function mvQst(url,val){
		postForm(url,["seq","${_csrf.parameterName}"],[val,"${_csrf.token}"],"post")
	}
	function findBoard(url,type){
		
		$.ajax({
			type:"get",
			url:url,
			dataType:"text",
			data:{
				type:"user"
			},
			error:function(data){alert("error")}
		}).done(function(data){
			console.log(JSON.parse(data))
			$("#"+type+"_body").empty()
			setTable(type,JSON.parse(data),url_param[type])
			if(board_tb == null){
				board_tb = setDataTable(type)
			}

		})
	}

	function setDataTable(type){
		var el = $("#"+type).DataTable({
			"scrollY":        "500px",
	        "scrollCollapse": true,
	        "paging":         false,
	        "language": {
	            "lengthMenu": "Display _MENU_ records per page",
	            "zeroRecords": "Nothing found - sorry",
	            "info": "",
	            "infoEmpty": "No records available",
	            "infoFiltered": "(filtered from _MAX_ total records)"
	        }
		});
		return el;
	}
	function openPopup(){
		$("#popup1").css("display","initial")
	}
	function closePopup(){
		$("#popup1").css("display","none")
	}
	
	function addOtoQst(title,content){
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
				type:"insert"
			},
			error:function(data){alert("error")}
		}).done(function(data){
			closePopup()
			findBoard("/get_all_oto","board")
		})
			
	}




</script>
