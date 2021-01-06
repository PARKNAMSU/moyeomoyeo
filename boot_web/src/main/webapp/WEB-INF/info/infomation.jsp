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
			id="info">
			<thead class="table-primary ">
				<tr>
					<th scope="col" style="width: 10%;">no.</th>
					<th scope="col" style="width: 60%;">제목</th>
					<th scope="col" style="width: 10%;">작성자</th>
					<th scope="col" style="width: 20%;">날짜</th>
				</tr>
			</thead>
			<tbody id="info_body">
			</tbody>
		</table>
		<div class="div_01" style="width:100%;margin-top:40px;">
			<div class="fl margin_left_50 div_01_01 sub_div" style="text-align:right;width:100%;">
				<button class="btn_01_01 font_30 margin_right_20" onclick="location.href='/'">1:1문의</button>
				<button class="btn_01_01 font_30 margin_right_40">홈으로</button>
			</div>
		</div>
	</div>
</div>
<script>
	let info = [["01","테스트제목","admin","2020/01/01"],["02","테스트제목2","admin","2020/01/01"],["03","테스트제목3","admin","2020/01/01"]]	
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
	function setTable(){
		info.forEach(function(item){
			var el = "<tr class='cursur_p'><td>"+item[0]+"</td>"
			+"<td>"+item[1]+"</td>"
			+"<td>"+item[2]+"</td>"
			+"<td>"+item[3]+"</td>"
			+"</tr>"
			$("#info_body").append(el)
		})
		$("#info").DataTable();
	}
	
</script>