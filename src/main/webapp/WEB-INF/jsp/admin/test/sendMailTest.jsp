<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
<title>Hanon Systems PORTAL :::: Self-Portal <spring:message code="lnb.home" text="HOME" /></title>
</head>
<body class="main">

<!-- (wrapper) -->
<div id="wrapper">

	<!-- (header) -->
	<div id="header">
		<!-- (top_section) -->
		<div class="top_section">
			<h1><a href="/admin/home.do" title="Hanon Systems PORTAL :::: Self-Portal Home"><img src="/images/skin/common/logo.png" alt="HOME Hanon Systems" /></a></h1>
		</div>
		<!-- //(top_section) -->
	</div>
	<!-- //(header) -->
	
	<!-- (container) -->
	<div id="container">

		<!-- (contents) -->
		<div id="contents">
		<form name="modUserForm" id="modUserForm" method="post">
			<!-- (location) -->
			<div id="location">
				<h3><spring:message code="lnb.home.CMP" text="Send Mail Test" /></h3>

				<p class="page_navigation">
					<strong><spring:message code="lnb.home.CMP" text="Change My profile" /></strong>
					<span><spring:message code="navi.home" text="Home" /></span>
					<img alt="home" src="/images/skin/common/icon_home.png">
				</p>
			</div>
			<!-- //(location) -->
			
			<!-- (board_01) -->
			<table class="board_view01" summary="BBS Article Control">
				<caption></caption>
				<colgroup>
					<col width="20%" />
					<col width="30%" />
					<col width="20%" />
					<col width="20%" />
				</colgroup>
				<tbody>
					<tr class="first2 type01">
						<th scope="row"><spring:message code="page.from" text="FROM" /></th>
						<td>
							<select name="from">
								<option value="ipharos@hanonsystems.com">ipharos@hanonsystems.com</option>
								<option value="hjw0228@pharosinfo.com">hjw0228@pharosinfo.com</option>
								<option value="hjw0228@gmail.com">hjw0228@gmail.com</option>
							</select>
						</td>
						<th scope="row"><spring:message code="page.to" text="TO" /></th>
						<td>
							<select name="to">
								<option value="ipharos@hanonsystems.com">ipharos@hanonsystems.com</option>
								<option value="hjw0228@pharosinfo.com">hjw0228@pharosinfo.com</option>
								<option value="hjw0228@gmail.com">hjw0228@gmail.com</option>
							</select>
						</td>
					</tr>
					<tr class="type01">
						<th scope="row"><spring:message code="page.subject" text="Subject" /></th>
						<td colspan="3">
							<input type="text" name="subject" style="width: 500px;" value="Send Mail Test Subject"/>
						</td>
					</tr>
					<tr class="type01">
						<th scope="row"><spring:message code="page.content" text="Content" /></th>
						<td colspan="3">
							<input type="text" name="subject" style="width: 500px;" value="Send Mail Test Content"/>
						</td>
					</tr>
					<tr class="type01">
						<th scope="row"><spring:message code="page.smtpHost" text="SMTP Host Name" /></th>
						<td colspan="3">
							<select name="smtpHost">
								<option value="hanonsystems-com.mail.protection.outlook.com">hanonsystems-com.mail.protection.outlook.com</option>
								<option value="smtp.hvccglobal.com">smtp.hvccglobal.com</option>
								<option value="smtp.hanonsystems.com.com">smtp.hanonsystems.com.com</option>
								<option value="smtp.hanonsystems.com">smtp.hanonsystems.com</option>
								<option value="HanonSMTP.Hanonsystems.com">HanonSMTP.Hanonsystems.com</option>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //(board_01) -->

			<div class="right">
 				<a class="btn_blue3" id="btn_add" href="javascript:sendMail();">
					<span><spring:message code="button.send" text="Send" /></span> 
				</a>
			</div>
		</form>
		</div>
		<!-- //(contents) -->

	</div>
	<!-- //(container) -->

</div>
<!-- //(wrapper) -->

<!-- (footer) -->
<div id="footer">
	<!-- (footer_address) -->
	<div class="footer_address">
		<div>
			<p>Copyright ©2015 Hanon Systems Corp. All rights reserved.</p>
		</div>
	</div>
	<!-- //(footer_address) -->
</div>
<!-- //(footer) -->

<script type="text/javascript">

$(document).ready(function(){
	// left_menu 펼쳐 놓기
	$(".home").addClass("on");
	$(".home").find(">ul").show();
});

/**
 * 내 정보 변경
 */
function sendMail() {
	$.ajax({
		url: '/admin/user/sendMail.do'
		, type: 'post'
		, dataType: 'xml'
		, data: $("#modUserForm").serialize()
		, success: function(data, status, error) {
			//console.log(error);
			alert('Send Mail');
		}, error: function(data, status, error) {
			//console.log("error");
			//console.log(data.responseText);
		}
	});
}

</script>

</body>
</html>
