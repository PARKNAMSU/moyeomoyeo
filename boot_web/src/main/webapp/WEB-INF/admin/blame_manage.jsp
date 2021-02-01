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
				<th scope="col" style="width: 10%;">모임 번호</th>
				<th scope="col" style="width: 40%;">모임 제목</th>
				<th scope="col" style="width: 30%;">모임 관리자</th>
				<th scope="col" style="width: 20%;">신고횟수</th>
			</tr>
		</thead>
		<tbody id="meeting_body">
		</tbody>
	</table>
</div>
<div class="blame_main1 fl">
	<p class="font_40">자주묻는 질문 관리</p>
	<table class="table table-info table-hover table-striped t_align_c"
		id="comment">
		<thead class="table-primary ">
			<tr style="font-size:12px;">
				<th scope="col" style="width: 10%;">댓글 번호</th>
				<th scope="col" style="width: 40%;">댓글 내용</th>
				<th scope="col" style="width: 30%;">댓글 작성자</th>
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
		</div>
	</div>
</div>
