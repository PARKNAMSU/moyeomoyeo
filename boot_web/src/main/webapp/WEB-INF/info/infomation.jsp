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
</style>
<div id="main_1" class="container-fluid"
	style="padding-top: 90px; padding-bottom: 90px;">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">공지사항</p>
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
				<button class="btn_01_01 font_30 margin_right_20" onclick="location.href='/oto_page'">1:1문의</button>
				<button class="btn_01_01 font_30 margin_right_40">홈으로</button>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		chkWindowWidth()
		setTable()
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
	findBoard("/get_all_board","board")
	
	const url_param = {
		"board":"/board_info_page",
	}
	let board_tb = null;

	function setTable(tb,data,url){
		if(  typeof data == 'object'){
			data.forEach(function(item){
				var el = "<tr class='cursur_p' onclick='location.href=\""+url+"?seq="+item.seq+"\"'>"
				+"<td>"+item.seq+"</td>"
				+"<td>"+item.title+"</td>"
				+"<td>"+item.writer+"</td>"
				+"<td>"+item.reg_date+"</td>"
				+"</tr>"
				$("#"+tb+"_body").append(el)
			})
		}
		
	}
	function findBoard(url,type){
		$("#"+type+"_body").empty()
		$.ajax({
			type:"get",
			url:url,
			dataType:"text",
			error:function(data){alert("error")}
		}).done(function(data){
			console.log(JSON.parse(data))
			setTable(type,JSON.parse(data),url_param[type])
			if(type === 'board'){
				if(board_tb == null){
					board_tb = setDataTable(type)
				}
			}
			if(type === 'often'){
				if(often_tb == null){
					often_tb = setDataTable(type)
				}
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
	function openPopup(url){
		console.log(url)
		$("#popup1").css("display","initial")
		console.log(url)
		$("#field").load(url)
	}
	function closePopup(){
		$("#popup1").css("display","none")
		$("#field").empty()
	}
	


</script>
