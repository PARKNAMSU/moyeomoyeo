<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
	.h_menu{
		float: left;
		font-size: 25px;
		padding-top: 23px;
		padding-bottom: 18px;
		width:129.13px;
		color:white;
		cursor: pointer;
		text-align: center;
		
	}
	.header{
		box-shadow: 2px 2px 2px 2px #013ADF;
		background-color: #3063C2;
		position: fixed;
	}
	.h_line{
		width:100%;
		height:2px;
		background-color:black;
		margin-top:15px;
		visibility: hidden;
	}
	.h_text{

	}
	.h_sub_menu{
		background-color:rgba(48,99,194);width:100%;border-radius:0 0 3% 3%;
		display:none;cursor:pointer;
	}

</style>
<div class="container-fluid header" style="top:0px;z-index:2;">
	<img src="/resource/img/logo.png" style="width:80px; height: 80px;margin-top:5px;cursor:pointer;" onclick="location.href='/admin/index'">
	<div style="left:1150px;position: absolute;top:0px;width:550px;" class="fl">
		<div class="h_menu" id="h_menu_1" style="" onmouseover="visibleEl(1,'line')" onmouseleave="hiddenEl(1,'line')" onclick="location.href='/admin/index'">
			<span class="h_text">통계</span><div class="h_line" id="h_line1"></div>
		</div>
		<div class="h_menu" id="h_menu_2" style="" onmouseover="visibleEl(2,'line')" onmouseleave="hiddenEl(2,'line')" onclick="location.href='/admin/board_main'" >
			<span class="h_text" onclick="visibleEl(2,'sub_menu')">관리</span><div class="h_line" id="h_line2"></div>
		</div>
		
		<div class="h_menu" id="h_menu_3" style="" onmouseover="visibleEl(3,'line')" onmouseleave="hiddenEl(3,'line')" >
			<span class="h_text" onclick="visibleEl(3,'sub_menu')">신고</span><div class="h_line" id="h_line3"></div>
			<div class="h_sub_menu" id="h_sub_menu_3">
				<div class="h_menu" style="float:none;padding-top: 10px;padding-bottom: 10px;text-align:center;"><span class="h_text" style="font-size:20px;margin-left:0;">모임신고</span></div>
				<div class="h_menu" style="float:none;padding-top: 10px;padding-bottom: 10px;text-align:center;border-top:solid 1px;"><span class="h_text" style="font-size:20px;margin-left:0;">유저신고</span></div>
				<div class="h_menu" style="float:none;padding-top: 10px;padding-bottom: 10px;text-align:center;border-top:solid 1px;"><span class="h_text" style="font-size:20px;margin-left:0;">댓글신고</span></div>
			</div>
		</div>
		
		<div class="h_menu" id="h_menu_4" style="" onmouseover="visibleEl(4,'line')" onmouseleave="hiddenEl(4,'line')" onclick="location.href='/logout'">
			<span class="h_text">로그아웃</span><div class="h_line" id="h_line4"></div>
		</div>
	</div>
	
</div>
<div class="clear"></div>
<script>

	function visibleEl(idx,type){
		if(type === 'line'){
			$("#h_line"+idx).css("visibility","visible");
		}else if(type === 'sub_menu'){
			var cssType = 'visible';
			if($("#h_sub_menu_"+idx).css("visibility") === "visible"){
				cssType = 'hidden'
			}
			$("#h_sub_menu_"+idx).slideToggle()
		}

	}
	function hiddenEl(idx,type){
		if(type === 'line'){
			$("#h_line"+idx).css("visibility","hidden");
		}
	}
</script>