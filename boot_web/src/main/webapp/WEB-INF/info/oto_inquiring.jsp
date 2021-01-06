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
	style="padding-top: 90px; padding-bottom: 90px; ">
	<div class="ray_20" id="ray_01" style="">
		<p class="font_50">1:1문의</p>
		<div class="line_01"></div><br><br>
		<table class="table table-info table-hover table-striped t_align_c" id="info">
		  <thead class="table-primary ">
		    <tr>
		      <th scope="col" style="width:12%;">no.</th>
		      <th scope="col" style="width:66%;">제목</th>
		      <th scope="col" style="width:22%;">날짜</th>
		    </tr>
		  </thead>
		  <tbody id="info_body">
		  </tbody>
		</table>
		
	</div>
</div>
<script>
	let info = [["01","테스트제목","2020/01/01"],["02","테스트제목2","2020/01/01"],["03","테스트제목3","2020/01/01"]]	
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
			+"</tr>"
			$("#info_body").append(el)
		})
		$("#info").DataTable();
	}
	
</script>