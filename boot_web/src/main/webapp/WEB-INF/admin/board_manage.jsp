<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
	.board_main1{
		width:537px;
		height:824px;
		box-shadow: 2px 2px 2px 2px gray;
		padding:20px; 
		margin-left:20px;
	}
</style>
<div style="margin-top:110px;"></div>
<div class="board_main1 fl">
	<p class="font_40">게시판 관리</p>
	<table class="table table-info table-hover table-striped t_align_c"
		id="board">
		<thead class="table-primary ">
			<tr>
				<th scope="col" style="width: 10%;">no.</th>
				<th scope="col" style="width: 60%;">제목</th>
				<th scope="col" style="width: 19%;">작성자</th>
				<th scope="col" style="width: 18%;">날짜</th>
			</tr>
		</thead>
		<tbody id="board_body">
		</tbody>
	</table>
	<div class="div_01" style="width:100%;margin-top:20px;">
		<div class="fl margin_left_40 div_01_01 sub_div" style="text-align:right;width:100%;">
			<button class="btn_01_01 font_30 margin_right_40">게시판 생성</button>
		</div>
	</div>
</div>
<div class="board_main1 fl">
	<p class="font_40">1:1문의 관리</p>
	<table class="table table-info table-hover table-striped t_align_c"
		id="oto">
		<thead class="table-primary ">
			<tr>
				<th scope="col" style="width: 10%;">no.</th>
				<th scope="col" style="width: 60%;">제목</th>
				<th scope="col" style="width: 19%;">작성자</th>
				<th scope="col" style="width: 18%;">날짜</th>
			</tr>
		</thead>
		<tbody id="oto_body">
		</tbody>
	</table>
</div>
<div class="board_main1 fl">
	<p class="font_40">자주묻는 질문 관리</p>
	<table class="table table-info table-hover table-striped t_align_c"
		id="often">
		<thead class="table-primary ">
			<tr>
				<th scope="col" style="width: 10%;">no.</th>
				<th scope="col" style="width: 53%;">제목</th>
				<th scope="col" style="width: 19%;">작성자</th>
				<th scope="col" style="width: 18%;">날짜</th>
			</tr>
		</thead>
		<tbody id="often_body">
		</tbody>
	</table>
	<div class="div_01" style="width:100%;margin-top:20px;">
		<div class="fl margin_left_40 div_01_01 sub_div" style="text-align:right;width:100%;">
			<button class="btn_01_01 font_30 margin_right_40">추가</button>
		</div>
	</div>
</div>

<script>
let info = [["01","테스트제목","admin","2020/01/01"],["01","테스트제목","admin","2020/01/01"],["01","테스트제목","admin","2020/01/01"],["01","테스트제목","admin","2020/01/01"],["01","테스트제목","admin","2020/01/01"],["01","테스트제목","admin","2020/01/01"],["01","테스트제목","admin","2020/01/01"],["01","테스트제목","admin","2020/01/01"],["01","테스트제목","admin","2020/01/01"],["01","테스트제목","admin","2020/01/01"],["02","테스트제목2","admin","2020/01/01"],["03","테스트제목3","admin","2020/01/01"]]
setTable("board")
setTable("oto")
setTable("often")
function setTable(tb){
	info.forEach(function(item){
		var el = "<tr class='cursur_p'><td>"+item[0]+"</td>"
		+"<td>"+item[1]+"</td>"
		+"<td>"+item[2]+"</td>"
		+"<td>"+item[3]+"</td>"
		+"</tr>"
		$("#"+tb+"_body").append(el)
	})
	$("#"+tb).DataTable({
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
}
</script>