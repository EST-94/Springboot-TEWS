<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id='retireLocalUserRoot' class='layer_popup'>

<!-- (layerpop - Retire User) -->
<div class="layer_pop showpop" style="min-width:600px; margin-left: -360px; margin-top: -230px;" id="reg_div">
<form name="retireUserForm" id="retireUserForm">
	<input type="hidden" name="guid" value="${user.guid }" />
	<input type="hidden" name="cdsid" value="${user.cdsid }" />
	<div class="pop_wrap">
		<p class="tit"><spring:message code="label.retireUser" text="Retire User" /> </p>

		<div class="pop_contents">

			<div class="clear">
					<span class="region_txt"><spring:message code="page.cdsid" text="CDSID" /> &nbsp;&nbsp;</span>
					<b>${user.cdsid}</b>
			</div>

			<table class="board_view05 mgt_10" summary="">
				<caption></caption>
				<colgroup>
					<col width="25%" />
					<col width="25%" />
					<col width="25%" />
					<col width="25%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" class="vmiddle" ><span><spring:message code="page.firstNm" text="First Name" /></span></th>
						<td>${user.firstName}</td>
						<th scope="row" class="vmiddle"><span><spring:message code="page.localLastName" text="Local Last Name" /></span></th>
						<td>${user.lclLastName}</td>
					</tr>
					<tr>
						<th scope="row" class="vmiddle"><span><spring:message code="page.lastNm" text="Last Name" /></span></th>
						<td>${user.lastName}</td>
						<th scope="row" class="vmiddle"><span><spring:message code="page.localFirstName" text="Local First Name" /></span></th>
						<td>${user.lclFirstName}</td>
					</tr>
					<tr>
						<th scope="row" class="vmiddle"><span><spring:message code="page.middNm" text="Middle Name" /></span></th>
						<td>${user.glbMidName}</td>
						<th scope="row" class="vmiddle"><span><spring:message code="page.localMiddleName" text="Local Middle Name" /></span></th>
						<td>${user.lclMiddleName}</td>
					</tr>
					<tr>
						<th scope="row" class="vmiddle"><span><spring:message code="page.officePhone" text="Office Phone" /></span></th>
						<td>${user.officePhone}</td>
						<th scope="row" class="vmiddle"><span><spring:message code="page.fax" text="Fax" /></span></th>
						<td>${user.fax}</td>
					</tr>
					<tr>
						<th scope="row" class="vmiddle"><span><spring:message code="page.AlterEmail" text="Alternate E-mail" /></span></th>
						<td>${user.alterEmail}</td>
						<th scope="row" class="vmiddle">&nbsp;</th>
						<td>&nbsp;</td>
					</tr>
					<tr >
						<th scope="row" class="vmiddle"><span><spring:message code="page.entDate" text="Entrance Date" /></span></th>
						<td>${user.enterDate}</td>
						<th scope="row" class="vmiddle">&nbsp;</th>
						<td>&nbsp;</td>
					</tr>
				</tbody>
			</table>
			<table class="board_view05 mgt_10" summary="">
				<tbody>
					<tr>
						<td align="center" class="vmiddle" style="text-align:center !important;">
							<span ><spring:message code="label.changeSTATUS" text="Change STATUS" /> </span>
							<input type='checkbox' name='userStatus' value='2'> <spring:message code="label.retire" text="Retire" /> 
						</td>
					</tr>
				</tbody>
			</table>
			<div class="center">
				<a class="btn_blue3" href="javascript:updateRetireUser()"><span><spring:message code='label.retire' text='Retire' /></span></a>
				<a class="btn_gray4" href="javascript:closePopup('retireLocalUser')"><span><spring:message code="button.close" text="Close" /></span></a>
			</div>

		</div>
	</div>

	<a href="javascript:closePopup('retireLocalUser')" class="btn_pop_close"><img src="/images/skin/btn/btn_pop_close.gif" alt="close" /></a>
	</form>
</div>

<script type="text/javascript">
<!--
/**
 * 사용자 퇴사처리
 */
function updateRetireUser() {
	if ($("#retireUserForm input:checkbox[name='userStatus']:checked").length == 0) {
		alert("<spring:message code='localuser.alert20' text='Please Check the status of Retire!' />");            		
		$("#retireUserForm input:checkbox[name='userStatus']").focus();
	} else {
		// 퇴사처리
		$.ajax({
			url: '/admin/localUser/retire/update.do'
			, type: 'post'
			, dataType: 'xml'
			, data: $("#retireUserForm").serialize()
			, success: function(data) {
				//console.log(data);
				//console.log($('code', data).text());
				alert($('message', data).text());

				if('1' == $('code', data).text()) {
					// success
					closePopup('retireLocalUser');
				}
			}
			, error: function(data) {
				//console.log("Error with /admin/localUser/user/update.do");
				//console.log(data);
			}
		});
	}
}
//-->
</script>

<!-- //(layerpop - Retire User) -->
</div>