<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<div style="" id="profile_div">
	<h2 style="text-align: center;">프로필 이미지</h2>
	<div class="line_01" style="height: 2px;"></div>
	<br>
	<div class="div_01">
		<aside class="aside_01 fl" style="width: 10%;">
			<p class="font_15">프로필
			<p>
		</aside>
		<div class="fl margin_left_10 div_01_01 sub_div" style="width: 80%;">
			<form action="/uploadProfile" enctype="multipart/form-data" method="post" id="profileForm">
				<input type="file" id="p_file" name="profile"
					class="form-control-file border" accept=".gif, .jpg, .png"><br>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="token" />
			</form>
		</div>
		<div class="clear"></div>
	</div>
	<div class="div_01" style="display: none;" id="img_div">
		<img
			style="width: 128px; height: 128px; border-radius: 70%; margin-left: 176px;"
			id="profile_img">
	</div>
	<div>
		<aside class="aside_01 fl" style="height: 1px;"></aside>
		<div class="fl margin_left_50 div_01_01 sub_div"
			style="text-align: right; width: 80%">
			<button class="btn_01_01 font_20" onclick="uploadProfile()">변경</button>
			<button class="btn_01_01 font_20 margin_left_10">취소</button>
		</div>
	</div>
	<div class="clear" style="margin-bottom: 30px"></div>
</div>

<script>
let reader = new FileReader();

$("#p_file").change(function(){
	if(this.files && this.files[0]){
		images = this.files;
		$("#img_div").css("display","initial") 
		index = 0;
		reader.readAsDataURL(images[index]);
	}
})
reader.onload = function(e){
	$("#profile_img").hide().attr("src",e.target.result).toggle();
}

function uploadProfile(){
	if($('#p_file') != null){
		var pro_data = new FormData($('#profileForm')[0]);
		/*
		$.ajax({
			type:"POST",
			url:"/uploadProfile",
			enctype: '',
			dataType:"text",
			processData: false,
			cache : false,
			contentType:false,
			data:{
				profile:pro_data,
				"${_csrf.parameterName}":"${_csrf.token}"
			},
			success:function(data){
				alert("프로필 변경 성공")
				location.reload();
			},error: function(){
				alert("데이터 전송 실패")
			}
		});*/
		$("#profileForm").submit()
	}

}
</script>