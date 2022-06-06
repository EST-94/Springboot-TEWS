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
		<!-- (Contents lnb) -->
		<jsp:include page="/WEB-INF/jsp/include/lnb2.jsp" />
		<!-- //(Contents lnb) -->

		<!-- (contents) -->
		<div id="contents">
		<form name="modUserForm" id="modUserForm" method="post">
			<!-- (location) -->
			<div id="location">
				<h3><spring:message code="lnb.home.CMP" text="Change My profile" /></h3>

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
						<th scope="row"><spring:message code="page.nm" text="Name" /></th>
						<td>${user.displayName }</td>
						<th scope="row"><spring:message code="page.cdsid" text="CDSID" /></th>
						<td>${user.userid }</td>
					</tr>
					<tr class="type01">
						<th scope="row"><spring:message code="page.department" text="Department" /></th>
						<td>${user.lclDeptName }</td>
						<th scope="row"><spring:message code="page.Email" text="E-mail" /></th>
						<td>${user.mail }</td>
					</tr>
					<tr class="type01">
						<th scope="row"><spring:message code="page.plant" text="Plant" /> </th>
						<td>${user.plantCode }</td>
						<th scope="row"><spring:message code="page.region" text="Region" /></th>
						<td>${user.regionName }</td>
					</tr>
					<!-- Report To-->
<%-- 					<tr class="type01" style="border-top:2px solid #d6d7d6;">
						<th scope="row"><spring:message code="page.ReportTo" text="Report To" /></th>
						<td>
							<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="reportTo" id="reportTo" value="${user.reportTo }" /> 
							<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('reportTo');">
							<a href="javascript:showReportToSearch('reportTo', 'reportTo_label');"  class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
						</td>
						<th scope="row"><spring:message code="page.daulReportTo" text="Dual Report To" /></th>
						<td>
							<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="dualReportTo1" id="dualReportTo1" value="${user.dualReportTo }" />
							<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('dualReportTo1');">
							<a href="javascript:showReportToSearch('dualReportTo1', 'dualReportTo1_label');"  class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
						</td>
					</tr> --%>
<%-- 					<tr class="type01">
						<th scope="row" />
						<td>
							<input type="text" class="inputbox hasSearchbtn" readonly="readonly" id="reportTo_label" value="${user.reportToGlbName }"/>
							<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('reportTo');">
						</td>
						<th scope="row" />
						<td>
							<input type="text" class="inputbox hasSearchbtn" readonly="readonly" id="dualReportTo1_label" value="${user.dualReportToGlbName }" />
							<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('dualReportTo1');">
						</td>
					</tr> --%>
					<!--  추가 Display 만-->
					<tr class="type01" style="border-top:2px solid #d6d7d6;">
						<th scope="row" ><spring:message code="page.officePhone" text="Office Phone" /></th>
						<td>
							<input type="text" class="inputbox" name="officePhone"  value="${user.officePhone }" />
						</td>
						<th scope="row"><spring:message code="page.mobile" text="Mobile" /></th>
						<td>
							<input type="text" class="inputbox" name="cellPhone" value="${user.cellPhone }" />
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="page.officePost" text="Office Postal Code" /></th>
						<td>
							<input type="text" class="inputbox" name="workZipCode" value="${user.zip }" onkeydown="onlyNum();" />
						</td>
						<th scope="row"><spring:message code="page.alias" text="Alias" /></th>
						<td>
							<input type="text" class="inputbox" name="alias" value="${user.alias}" />			
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="page.officeAddr" text="Office Address" /></th>
						<td colspan="3">
							<input type="text" class="inputbox" name="workAddr"  value="" />
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="page.jobDesc" text="Job Description (Global)" /></th>
						<td>
							<input type="text" class="inputbox" name="jobDesc" value="" />
						</td>
                        <th scope="row"><spring:message code="page.kJobDesc" text="Job Description (Local)" /></th>
                        <td>
                            <input type="text" class="inputbox" name="koreaJobDesc" value="" />
                        </td>
					</tr>
                    <tr>
                        <th scope="row"><spring:message code="page.office" text="Office" /></th>
                        <td>
                            <input type="text" class="inputbox" name="office" value="" />
                        </td>
                        <th scope="row"><spring:message code="page.company" text="Company" /></th>
                        <td>
                            <input type="text" class="inputbox" name="company" value="" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><spring:message code="page.country" text="Country/Region" /></th>
                        <td class="type01" style="border-top:2px solid #d6d7d6;">
                            <input type="text" class="inputbox hasSearchbtn" id="country" name="country" readonly="readonly" value="" />
                            <img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('country');"/>
                            <a href="javascript:showCodeSearchForCountry('NATION','country_code', 'country')" class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
                        </td>
                         <th scope="row"><spring:message code="page.city" text="City" /></th>
                        <td>
                            <input type="text" class="inputbox" name="city" value="" />
                        </td>
                    </tr>
                    <tr class="last" >
                        <th scope="row"><spring:message code="page.state" text="State/Province" /></th>
                        <td colspan="3">
                            <input type="text" class="inputbox" name="state" value="" />
                        </td>
                    </tr>
				</tbody>
			</table>
			<!-- //(board_01) -->

			<div class="right">
 				<a class="btn_blue3" id="btn_add" href="javascript:setMyInfo();">
					<span><spring:message code="button.save" text="Save" /></span> 
				</a>

				<!-- <a class="btn_gray5" href="#">
					<span>Cancel</span>
				</a> -->
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
	$(".changeMyProfile > a").addClass("highlight");

	// event 추가
	$("#jobDesc").keyup(function(event) {
		// 방향키, backspace 등 예외처리 
		if( event.keyCode == 8 || event.keyCode == 9 || (event.keyCode >= 37 && event.keyCode <= 40) ) return;
		// 한글 입력방지
		if(!(event.keyCode >= 37 && event.keyCode <= 40)) {
			var before = $(this).val().length;
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/gi, ''));
			
			if(before > $(this).val().length) {
				alert('<spring:message code="myinfo.04" text="Alphanumeric characters only" />');
			}
		}
	});
});

/**
 * 내 정보 변경
 */
function setMyInfo() {
	alert('<spring:message code="myinfo.01" text="Your Account profile information update is in progress!" />');
	
	if( $('form[name=modUserForm] input[name=reportTo]').val() == '' ) {
		alert('<spring:message code="alert.empty.reportTo" text="Please select your REPORT TO" />');
		$("#reportTo").focus();
		return false;
	}
	if( $('form[name=modUserForm] input[name=jobDesc]').val() == '' ) {
    	alert('<spring:message code="page.jobDesc" text="Job Description (Global)" /> <spring:message code="myinfo.05" text="is required" />');
    	$("#jobDesc").focus();
    	return false;
    }
	
	$(".deem").fadeIn();
	
	$.ajax({
		url: '/admin/update.do'
		, type: 'post'
		, dataType: 'xml'
		, data: $("#modUserForm").serialize()
		, success: function(data, status, error) {
			//console.log(error);
			alert('<spring:message code="myinfo.03" text="Complete updating your account profile information" />');
			$(".deem").fadeOut();
		}, error: function(data, status, error) {
			//console.log("error");
			//console.log(data.responseText);
			alert(error.responseText);
			$(".deem").fadeOut();
		}
	});
}

/**
 * show search reportTo
 * @param codeId				(String) 검색결과 CDSID input tag ID
 * @param codeNameId		(String) 검색결과 사용자이름 input tag ID
 * @since 2014-10-23
 */
function showReportToSearch(codeId, codeNameId) {
	$('.layer_popup2').remove();
	
	$.ajax({
		url: '/admin/localUser/reportTo/view.do'
		, type: 'post'
		, dataType: 'xml'
		, data: 'codeId=' + codeId + '&codeNameId=' + codeNameId
		, success: function(data, status, error) {
			//console.log(error);
			$('body').append(error.responseText);
		}, error: function(data, status, error) {
			//console.log("error");
			//console.log(data.responseText);
			$('body').append(data.responseText);
		}
	});
}
</script>

</body>
</html>
