<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script>
var emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
var passwordRegExp = /^[a-zA-z0-9]{8,16}$/;
var nameRegExp = /^[a-zA-z가-힣]{2,12}$/;
var n_nameRegExp = /^[a-zA-z0-9]{3,15}$/;
var phoneRegExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;

function setActive(email,pass,pass_ck,yn){
	if(!emailRegExp.test(email)){
		alert("이메일 형식이 아닙니다.")
		return false;
	}
	if(!passwordRegExp.test(pass)){
		alert("비밀번호는 8~16자리입니다.")
		return false;
	}
	if(pass != pass_ck){
		alert("비밀번호가 일치하지 않습니다.")
		return false;
	}
	 $.ajax({
		 type:"POST",
		 url:"/active_account",
		 dataType:"text",
		 data:{
			 email:email,
			 password:pass,
			 active_yn:yn,
			 "${_csrf.parameterName}":"${_csrf.token}"
		 },
		 async : true,
		 success: function(data){
			 if(data === 'id_false'){
				 alert("존재하지 않는 이메일입니다.")
			 }else if(data === 'pass_false'){
				 alert("비밀번호가 일치하지 않습니다.")
			 }else{
				 if(data === 'inval'){
					 location.href='/logout'
				 }else{
					 location.href='/login_page'
				 }
				 alert("계정설정 완료")
			 }
		 },error: function(error){
			console.log(error)	 
		 }
	})
	
}

//null or '' 일시 return false
function strCheck(val){
	if(val == null || val == ''){
		return false;
	}
	return true;
}

function postForm(path, keys, values ,method) {
    method = method || 'post';
    var form = document.createElement('form');
    form.setAttribute('method', method);
    form.setAttribute('action', path);
    
    if(typeof keys === 'object'){
    	for(var i =0; i<keys.length; i++){
            var hiddenField = document.createElement('input');
            hiddenField.setAttribute('type', 'hidden');
            hiddenField.setAttribute('name', keys[i]);
            hiddenField.setAttribute('value', values[i]);
            form.appendChild(hiddenField);
    	}
    }else{
        var hiddenField = document.createElement('input');
        hiddenField.setAttribute('type', 'hidden');
        hiddenField.setAttribute('name', keys);
        hiddenField.setAttribute('value', values);
        form.appendChild(hiddenField);
    }
    document.body.appendChild(form);
    form.submit();
}
function returnConditionObj(obj,condition,rt_obj,otr_obj){
	if(obj === condition){
		return rt_obj;
	}else{
		return otr_obj
	}
}

function getImgUrl(img_url_val){
	if(img_url_val != null && img_url_val != ""){
		return "/img/"+img_url_val;
	}else{
		return "/resource/img/user.svg";
	}
}

function setOpacity(node,type){
	if(type === 'over'){
		node.css('opacity',0.2);
		return false;
	}
	node.css('opacity',1);
}

function openPopup(url){
	$("#popup1").css("display","initial")
	$("#field").load(url)		
}
function openPopupDis(){
	$("#popup1").css("display","initial")
}
function closePopup(){
	$("#popup1").css("display","none")
}

function stringToDate(str,split){
    var str_arr = str.split('-');
    var dateCompare = new Date(str_arr[0], parseInt(str_arr[1])-1, str_arr[2]);
    return dateCompare;
}
function dateToString(date,split){
	  var yyyy = date.getFullYear();
	  var mm = date.getMonth() < 9 ? "0" + (date.getMonth() + 1) : (date.getMonth() + 1); 
	  var dd  = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
	  return yyyy+split+mm+split+dd;
}
</script>