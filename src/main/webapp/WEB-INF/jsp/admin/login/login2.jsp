<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
</head>
<body class="main">
<script type="text/javascript" src="/js/jquery.min.js#1.7.1"></script>
<script type="text/javascript" src="/js/jquery.validate.min.js#1.12.0"></script>
<script>
function formSubmit(){
	
	// ID UpperCase
	$("input[name=USER]").val($("form[name=sso] input[name=USER]").val().toLocaleUpperCase());

	$.ajax({
		url: '${target }'
		, type: 'post'
		, dataType: 'xml'
		, data: $("form[name=sso]").serialize()
		, beforeSend: function() {
			
		}
		, success: function(data) {
			//alert("success forward : " + $(data).find("code").text());
			loginSuccess(data);
		}
		, error: function(data) {
			//alert("error forward : " + $(data).find("code").text());
			$('span.deem').css('display','none');
			$('div.loadingbar').css('display','none');
						
			showErrorMessage2('<spring:message code="Result.3" text="User ID and Password coincide with the e-mail ID (CDS ID) and its Password." />', 'USER');
		}
	});
}

function loginSuccess(data) {
	var code = $(data).find("code").text();
	
	if($(data).find("status").text() == '정상') {
		//alert($(data).find("status").text());
		window.location.href = '/admin/home.do';
	} else {	// 에러
		$('span.deem').css('display','none');
		$('div.loadingbar').css('display','none');
		
		var name = $(data).find("name").text();
		var message = $(data).find("message").text();
		
		showErrorMessage2('<spring:message code="'+code+'" text="'+ message +'" />', name);
		
	}
}

// Show Error message
function showErrorMessage(errorMessage, element) {
	if(0 < errorMessage.text().length) {
		// error enabled
		$('.error_txt_input dd').text(errorMessage.text());
		$('.error_txt_input').css('display','block');
		//$('.error_txt_input').addClass(element.attr('id') + '_Error');
	} else {
		//$('.error_txt_input').css('display','none');
	}
}

// Show Error message Dynamic
function showErrorMessage2(textErrorMessage, textInputName) {
	// error enabled
	$('.error_txt_input dd').text(textErrorMessage);
	$('.error_txt_input').css('display','block');
	$('.error_txt_input').addClass(textInputName + '_Error');
}

$(document).ready(function(){
	
	// Detect JRE intalled
	if(!navigator.javaEnabled()) {
		// no JRE. require JRE installed
		window.open("http://www.java.com/en/download/testjava.jsp");
	}
	
	$('#USER').focus();
	
	// <spring:message code="Login.12" text="Submit Validation" />
	$('form[name=sso]').validate ({
		debug: true,
		rules: {
			USER: { required: true},
			PASSWORD: { required: true},
		},
		messages: {
			USER: { required: '<spring:message code="Login.1201" text="User ID and Password coincide with the e-mail ID (CDS ID) and its Password." />'},
			PASSWORD: { required: '<spring:message code="Login.1202" text="User ID and Password coincide with the e-mail ID (CDS ID) and its Password." />'},
		},
		success: function(error, element) {
			//$('.error_txt_input').css('display','none');
		},
		errorPlacement: function(error, element) {
			showErrorMessage(error, element);
		},
		submitHandler: function (frm) {
			// remove caps lock key on error
			//$('.error_txt_input.capslock_on_Error').css('display','none');
			$('.error_txt_input').css('display','none');
			// Dim display
			$('span.deem').css('display', 'block');
			$('div.loadingbar').css('display', 'block');
			// submit
			formSubmit();
		},
	});
	
	// <spring:message code="Login.21" text="Dynamic Validation" />
	if("${name}" != "") {
		showErrorMessage2('<spring:message code="${code}" text="${message}" />' , name);
	}
	
	// Submit button
	$("a.btn_login").click(function(){
		$("form[name=sso]").submit();
	});
	
	$("p.login_link01").click(function(){
		// Reset Your Network Password
		window.open("/imsso/pin/auth.do",'_self');
	});
	
	// 엔터 치면, 다음 input 값으로.. 마지막 input이면 submit
	$("input.vertical").keypress(function(event){
		if(event.keyCode == 13) {
			targetIndex = $("input.vertical").index(this) + 1;
			if( targetIndex < $("input.vertical").length) {
				$("input.vertical").get(targetIndex).focus();
			} else {
				$("form[name=sso]").submit();
			}
		}
	});
	
	// 2014-07-04 detect caps lock key is on
	$("#PASSWORD").keypress(function(e) {
		var is_shift_pressed = false;
		if (e.shiftKey) {
			is_shift_pressed = e.shiftKey;
		} else if (e.modifiers) {
			is_shift_pressed = !!(e.modifiers & 4);
		}
		if (((e.which >= 65 && e.which <=  90) && !is_shift_pressed) || ((e.which >= 97 && e.which <= 122) && is_shift_pressed)) {
			showErrorMessage2('<spring:message code="Login.1203" text="Caps Lock Key is on." />', 'capslock_on');
		} else {
			$('.error_txt_input.capslock_on_Error').css('display','none');
			$('.error_txt_input.capslock_on_Error').removeClass('capslock_on_Error');
		}
	});
});
</script>
<!-- (wrapper) -->
<div id="wrapper">

	<!-- (header) -->
	<div id="header" style="height: 80px;">

		<!-- (top_section) -->
		<div class="top_section">
			<h1><a href="#"><img src="/images/skin/common/logo.png" alt="Hanon Systems HOME Hanon Systems APPS, TOOLS AND NEWS. FOR ALL EMPLOYEES" /></a></h1>
		</div>
		<!-- //(top_section) -->
        
	</div>
	<!-- //(header) -->


	<!-- (container) -->
	<div id="container">
		<%-- <div style="text-align: right; padding-bottom: 5px;">
			<a href="#"><img src="/images/skin/common/help_style_b.gif" alt="help" /></a>
		</div> --%>
		<div class="login_wrap_in">
			<p>
				<span class="login_txt_tit01">Welcome to the</span>
				<span class="login_txt_tit02">Hanon Systems COMMUNICATION <em>PORTAL<%=(request.getServerName().toLowerCase().contains("dev") ? " DEV" : "") %></em></span>
				<span class="login_txt_tit03">
All information and data acquired from Hanon Systems or developed or acquired for<br />
Hanon Systems shall be confidential and proprietary to Hanon Systems.<br />
Such information and data shall be used only in performing services for Hanon Systems<br />
and shall not be disclosed or caused to be disclosed to any third part without written<br />
authorization from Hanon Systems.
				</span>
				<span class="login_txt_tit04">
By supplying my CDS ID and Password below, l agree to read and adhere to Hanon Systems<br />
Global IT Policies before accessing information on the web.<br />
I understand my responsibility to protect Hanon Systems customer and supplier<br />
information per Hanon Systems Policies.
				</span>
			</p>

			<div class="login_txtbox">
				<!-- 로그인 -->
				<div class="login_form">
				<form name="loginSM" method="POST"  action="/siteminderagent/forms/login.fcc">
					<input type="hidden" name="GUID" value="0" />
					<input type="hidden" name="SMAUTHREASON" value="0" />
					<input type="hidden" name="TARGET" value='${target }' />
					<input type="hidden" name="BUFFER" value="endl" />
					<input type="hidden" name="USER" />
					<input type="hidden" id="previousPassword" name="PASSWORD" />
					<input type="hidden" name="SMAGENTNAME" value='${SMAGENTNAME }' />
				</form>
				<form name="sso" method="POST" action='${action }'>
					<input type="hidden" name="TARGET" value='${target }' />
					<input type="hidden" name="SMAGENTNAME" value='${SMAGENTNAME }' />
					<p>
						<label for="user_n">CDS ID</label>
						<span class="input_txt"><input type="text" id="USER" name="USER" class="vertical" value="${userId }" /></span>
					</p>
					<p>
						<label for="user_p">Password</label>
						<span class="input_txt"><input type="password" id="PASSWORD" name="PASSWORD" class="vertical" /></span>
					</p>
					<a href="#" class="btn_login">
						<span>LOGIN</span>
					</a>
				</form>
				</div>
				<!-- //로그인 -->
				<div>
					<div class="pass_txt">Passwords are case sensitive</div>

					<dl class="error_txt_input" style="display: none;">
						<dt><img src="/images/skin/icon/icon_warning.gif" alt="warning" /></dt>
						<dd>To reset your Portal account password, enter  your new password<br />
(Caution : If you are Hanon Systems domain users, then PC login password is also changed the same password within few minutes)</dd>
					</dl>

				</div>
			</div>
		</div>

	</div>
	<!-- //(container) -->
</div>

<span class="deem" style="display: none;"></span>
<div class="loadingbar"  style="display: none;">
	<div class="position_loading">
		<p><img src="/images/skin/login/loading.gif" alt="" /></p>
		<dl>
			<dt>Certification in progress</dt>
			<dd>Once authentication is complete, go to the Portal.</dd>
		</dl>
	</div>
</div>

</body>
</html>