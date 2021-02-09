<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
	.blame_main1{
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
	#date_pop{
		width:400px;
		padding: 10px;
		margin-top:15%;
	}
</style>
<div style="margin-top:110px;"></div>
<div class="blame_main1 fl">
	<p class="font_40">유저신고</p>
	<table class="table table-info table-hover table-striped t_align_c"
		id="user">
		<thead class="table-primary ">
			<tr style="font-size:12px;">
				<th scope="col" style="width: 80%;">유저</th>
				<th scope="col" style="width: 20%;">신고횟수</th>
			</tr>
		</thead>
		<tbody id="user_body">
		</tbody>
	</table>
</div>
<div class="blame_main1 fl">
	<p class="font_40">모임 신고</p>
	<table class="table table-info table-hover table-striped t_align_c"
		id="meeting">
		<thead class="table-primary ">
			<tr style="font-size:12px;">
				<th scope="col" style="width: 50%;">모임 제목</th>
				<th scope="col" style="width: 30%;">모임 관리자</th>
				<th scope="col" style="width: 20%;">신고횟수</th>
			</tr>
		</thead>
		<tbody id="meeting_body">
		</tbody>
	</table>
</div>
<div class="blame_main1 fl">
	<p class="font_40">댓글 신고</p>
	<table class="table table-info table-hover table-striped t_align_c"
		id="comment">
		<thead class="table-primary ">
			<tr style="font-size:12px;">
				<th scope="col" style="width: 20%;">댓글 번호</th>
				<th scope="col" style="width: 40%;">댓글 내용</th>
				<th scope="col" style="width: 20%;">댓글 작성자</th>
				<th scope="col" style="width: 20%;">신고 횟수</th>
			</tr>
		</thead>
		<tbody id="comment_body">
		</tbody>
	</table>
</div>

<div id="popup1" class="overlay" style="">
	<div class="popup" id="manage_pop" style="">
		<a class="close" href="#" onclick="closePopup()">&times;</a>
		<br><br><br>
		<div id="field">
			<p class="font_30" id="pop_title"></p>
			<table class="table table-info table-hover table-striped t_align_c"
				id="pop_table">
				<thead class="table-primary " id="pop_thead">
				</thead>
				<tbody id="pop_tbody">
				</tbody>
			</table>
			<div id="pop_btn" style="text-align: right;"></div>
		</div>
	</div>
</div>

<div id="popup2" class="overlay" style="">
	<div class="popup" id="date_pop" style="">
		<a class="close" href="#" onclick='$("#popup2").css("display","none")'>&times;</a>
		<br><br><br>
		<div id="field">
			<p class="font_20">정지 날짜</p>
			<input type="text" id="blame_date" readonly="readonly" class="form-control fl" style="width:89%;">
			<div class="clear"></div>
			<br>
			<div style="text-align:right;width:100%;">
				<input type="button" value="선택" onclick="selectBlameDate()" class="margin_right_10 btn_01_01">
				<input type="button" value="취소" class="btn_01">
			</div>	
		</div>
	</div>
</div>

<script>
	let tables = ["user","meeting","comment"]
	
	setTableData(tables[0])
	setTableData(tables[1])
	setTableData(tables[2])
	let blame_date = null;
	let ck_date = 'n';
	let date_el = null
	var popTb = null
	
	function blameUser(email){
		if(ck_date === 'n'){
			$("#popup2").css("display","initial");
			setDatePicker($("#blame_date"))
			return false;
		}
		if(!confirm(email+"님 "+blame_date+" 까지 정지<br>정말로 정지하시겠습니까?")){
			return false;
		}
		$.ajax({
			type:"post",
			url:"/admin/block_user",
			dataType:"text",
			data:{
				email:email,
				date:blame_date,
				"${_csrf.parameterName}":"${_csrf.token}"
			},
			error:function(data){alert("error")}
		}).done(function(data){
			ck_date = 'n';
			blame_date = null;
			closePopup()
			alert("정지되었습니다.")
		})
	}
	function selectBlameDate(){
		if(!strCheck($("#blame_date").val())){
			alert("날짜를 선택하세요.");
			return false;
		}
		ck_date = 'y'
		blame_date = $("#blame_date").val()
		$("#popup2").css("display","none");
	}
	
	function setDatePicker(el){
		if(date_el == null){
			date_el = el.datepicker({
				dateFormat: 'yy-mm-dd',
				minDate: "+1D",
				showOn: "button",
				buttonText:"날짜",
				yearSuffix: "년",
			    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
			    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
			    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
			    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
			})
			$(".ui-datepicker-trigger").addClass("btn_01")
			$(".ui-datepicker-trigger").height("37px")
		}
		if(blame_date != null){
			$("#blame_date").val(blame_date)
		}
	}
		
	function setDataTable(type,size){

		$("#"+type).DataTable({
			"scrollY":        size+"px",
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
	
	function setTableData(type){
		$.ajax({
			type:"post",
			url:"/admin/all_blame",
			dataType:"text",
			data:{
				type:type,
				"${_csrf.parameterName}":"${_csrf.token}"
			},
			error:function(data){alert("error")}
		}).done(function(data){
			var data_obj = JSON.parse(data)
			data_obj.forEach(function(item){
				if(type === 'user'){
					userTableAppend(item)
				}else if(type === 'meeting'){
					meetingTableAppend(item)
				}else{
					commentTableAppend(item)
				}
				
			})
			setDataTable(type,500)
		})
	}
	
	function popupTableSet(type,data,name,content){
		$("#pop_title").empty()
		$("#pop_thead").empty()
		$("#pop_tbody").empty()
		$("#pop_btn").empty()
		if(type === 'user'){
			$("#pop_title").text(data[0].blamed_user+" 신고 목록")
			var th = '<tr style="font-size:15px;">'
				+'<th scope="col" style="width: 5%;">no.</th>'
				+'<th scope="col" style="width: 25%;">신고한 유저</th>'
				+'<th scope="col" style="width: 50%;">사유</th>'
				+'<th scope="col" style="width: 25%;">신고일</th>'
			+'</tr>'
			$("#pop_thead").append(th)
			data.forEach(function(item){
				var el = '<tr style="cursor:pointer;">'
					+'<td>'+item.blame_seq+'</td>'
					+'<td>'+item.blaming_user+'</td>'
					+'<td>'+item.blame_reason+'</td>'
					+'<td>'+item.date+'</td>'
				+'</tr>'
				$("#pop_tbody").append(el)
			})
			$("#pop_btn").append("<input type='button' value='유저 정지' onclick='blameUser(\""+data[0].blamed_user+"\")' class='btn_01_01 margin_right_10 font_20'>"
			+"<input class='btn_01_01 font_20' type='button' value='닫기' onclick='closePopup()'>")
		}
		if(type === 'meeting'){
			$("#pop_title").text(name+" 신고 목록")
			var th = '<tr style="font-size:15px;">'
				+'<th scope="col" style="width: 5%;">no.</th>'
				+'<th scope="col" style="width: 25%;">신고한 유저</th>'
				+'<th scope="col" style="width: 50%;">사유</th>'
				+'<th scope="col" style="width: 25%;">신고일</th>'
			+'</tr>'
			$("#pop_thead").append(th)
			data.forEach(function(item){
				var el = '<tr style="cursor:pointer;">'
					+'<td>'+item.blame_seq+'</td>'
					+'<td>'+item.blaming_user+'</td>'
					+'<td>'+item.blame_reason+'</td>'
					+'<td>'+item.date+'</td>'
				+'</tr>'
				$("#pop_tbody").append(el)
			})
			$("#pop_btn").append("<input type='button' value='해당 페이지 이동' onclick='' class='btn_01_01 margin_right_10 font_20'>"
			+"<input class='btn_01_01 font_20' type='button' value='닫기' onclick='closePopup()'>")
		}
		if(type === 'comment'){
			$("#pop_title").html(name+"님의 댓글 <br>'"+content+"' 신고 목록")
			var th = '<tr style="font-size:15px;">'
				+'<th scope="col" style="width: 5%;">no.</th>'
				+'<th scope="col" style="width: 25%;">신고한 유저</th>'
				+'<th scope="col" style="width: 50%;">사유</th>'
				+'<th scope="col" style="width: 25%;">신고일</th>'
			+'</tr>'
			$("#pop_thead").append(th)
			data.forEach(function(item){
				var el = '<tr style="cursor:pointer;">'
					+'<td>'+item.blame_seq+'</td>'
					+'<td>'+item.blaming_user+'</td>'
					+'<td>'+item.blame_reason+'</td>'
					+'<td>'+item.date+'</td>'
				+'</tr>'
				$("#pop_tbody").append(el)
			})
			$("#pop_btn").append("<input type='button' value='유저 정지' onclick='blameUser(\""+name+"\")' class='btn_01_01 margin_right_10 font_20'>"
			+"<input class='btn_01_01 font_20' type='button' value='닫기' onclick='closePopup()'>")
		}	
		if(popTb == null){
			popTb = setDataTable("pop_table",500)
		}	
	}
	
	
	function openBlameDetail(type,id,name,content){
		$.ajax({
			type:"post",
			url:"/admin/get_blame",
			dataType:"text",
			data:{
				type:type,
				id:id,
				"${_csrf.parameterName}":"${_csrf.token}"
			},
			error:function(data){alert("error")}
		}).done(function(data){
			var data_obj = JSON.parse(data)
			console.log(data_obj)
			openPopupDis();
			popupTableSet(type,data_obj,name,content)
		})
	}
	
	function userTableAppend(data){
		var el = '<tr style="cursor:pointer;" onclick="openBlameDetail(\'user\',\''+data.blamed_user+'\')">'
					+'<td>'+data.blamed_user+'</td>'
					+'<td>'+data.num+'</td>'
				+'</tr>'
		$("#"+tables[0]+"_body").append(el)
	}
	function meetingTableAppend(data){
		var el = '<tr style="cursor:pointer;" onclick="openBlameDetail(\'meeting\',\''+data.blamed_content_code+'\',\''+data.name+'\')">'
			+'<td>'+data.name+'</td>'
			+'<td>'+data.email+'</td>'
			+'<td>'+data.num+'</td>'
		+'</tr>'
		$("#"+tables[1]+"_body").append(el)
	}
	function commentTableAppend(data){
		var el = '<tr style="cursor:pointer;" onclick="openBlameDetail(\'comment\',\''+data.blamed_content_seq+'\',\''+data.email+'\',\''+data.content+'\')">'
			+'<td>'+data.blamed_content_seq+'</td>'
			+'<td>'+data.content+'</td>'
			+'<td>'+data.email+'</td>'
			+'<td>'+data.num+'</td>'
		+'</tr>'
		$("#"+tables[2]+"_body").append(el)
	}
</script>