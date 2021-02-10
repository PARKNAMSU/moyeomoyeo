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
	#manage_pop{
		width:1000px;
		padding:20px;
		margin-top:10%;
		background-color: #b8daff;
	}
</style>
<div style="margin-top:110px;"></div>
<div class="board_main1 fl">
	<p class="font_40">공지사항 관리</p>
	<table class="table table-info table-hover table-striped t_align_c"
		id="board">
		<thead class="table-primary ">
			<tr style="font-size:12px;">
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
			<button class="btn_01_01 font_30 margin_right_40" onclick="openPopup('/admin/board_manage_pop')">추가</button>
		</div>
	</div>
</div>
<div class="board_main1 fl">
	<p class="font_40">1:1문의 관리</p>
	<table class="table table-info table-hover table-striped t_align_c"
		id="oto">
		<thead class="table-primary ">
			<tr style="font-size:12px;">
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
			<tr style="font-size:12px;">
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
			<button class="btn_01_01 font_30 margin_right_40" onclick="openPopup('/admin/often_manage_pop')">추가</button>
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
findBoard("/get_all_board","board")
findBoard("/get_all_often","often")
findBoard("/get_all_oto","oto")
const url_param = {
	"board":"/admin/board_manage_pop",
	"often":"/admin/often_manage_pop",
	"oto":"/oto_info_page"
}


let board_tb = null;
let often_tb = null;
let oto_tb = null;
function setTable(tb,data,url,type){
	if(data.length >0){
		data.forEach(function(item){
			var mtd = null
			if(type === 'oto'){
				mtd = "<tr class='cursur_p' onclick='location.href=\""+url+"?seq="+item.seq+"\"'>"
			}else{
				mtd = "<tr class='cursur_p' onclick='openPopup(\""+url+"?seq="+item.seq+"\")'>"
			}
			var el = mtd
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
		setTable(type,JSON.parse(data),url_param[type],type)
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
		if(type === "oto"){
			if(oto_tb == null){
				oto_tb = setDataTable(type)
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
	$("#popup1").css("display","initial")
	$("#field").load(url)
}
function closePopup(){
	$("#popup1").css("display","none")
	$("#field").empty()
}
</script>

<script>
let type = null
let board_seq = 0;	

</script>