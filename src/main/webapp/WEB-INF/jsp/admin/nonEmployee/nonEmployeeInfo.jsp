<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<head>
<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
</head>
<script type="text/javascript">
var row = 0;
var idx = 1;
var idxList = new Array();

$(document).ready(function(){
	alert("test");	
	// Calendar 적용
	for(var i = 0; i < $(".date").length; i++){
		var thisId= $(".date").eq(i).attr("id");
		var thisIdEl = $("#"+thisId);
		thisIdEl.datepicker({ dateFormat: 'yymmdd' });
	}
});

function modifyNonEmployee(){
	if(confirm("Modify this User?")){
		$('span.deem').css('display', 'block');
		$('div.loadingbar').css('display', 'block');
		
		$.ajax({
			url: '/admin/nonEmployee/modifyNonEmployee.do'
			, type: 'post'
			, dataType: 'json'
			, data: params
			, success: function(data) {
				
				//console.log(data);
				$('span.deem').css('display','none');
				$('div.loadingbar').css('display', 'none');
				if(data.success == true) {
					saveUserList(data);
					alert("Modify Success!");
				} else {
					alert(data.value);
				}
			}
			, error: function(data) {
				//console.log("Error with /imsso/localUser/user/deptCode/" + selectedDeptCode + ".do");
				//console.log(data);
			}
		});	
	}
}

</script>

<div id='modifyNonEmployeeRoot' class='layer_popup'>

<!-- (layerpop - Modify User) -->
<div class="layer_pop showpop" style="margin-left: -360px; margin-top: -230px;" id="reg_div">
<form name="modifyForm" id="modifyForm" method="post" action="/admin/nonEmployee/modifyNonEmployeeInfo.do" enctype="multipart/form-data">
	<input type="hidden" name="userid" value="${userInfo.userid }" />
	<input type="hidden" name="imusertype" value="${userInfo.imusertype }" />
	<div class="pop_wrap">
		<p class="tit"><spring:message code="label.modifyNonEmployee" text="Modify Non Employee" />  </p>
		
		<div class="clear">
			<!-- (CDSID) -->
			<div class="regionbox">
				<span class="region_txt"><spring:message code="page.cdsid" text="CDSID" /></span>
				<b>${userInfo.userid }</b>
			</div>
			<!-- //(CDSID) -->
		</div>		
		
		<div class="pop_contents">
			<div>
			<table class="board_view05 mgt_10" style="border-" summary="">
				<caption></caption>
				<colgroup>
					<col width="20%" />
					<col width="30%" />
					<col width="20%" />
					<col width="30%" />
				</colgroup>
				<tbody>
					<c:if test="${userInfo.imusertype eq '20' || userInfo.imusertype eq '21'}">
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.firstNm" text="First Name" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="text" class="inputbox" name="firstName" value="${userInfo.givenname}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.lastName" text="Last Name" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="text" class="inputbox"  name="lastName" value="${userInfo.sn}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.middleName" text="Middle Name" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="middleName" value="${userInfo.initials}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.email" text="Email" /></span></th>
							<td>
								<input type="text" class="inputbox" name="email" value="${userInfo.mail}"/>
							</td>
	
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.managerId" text="Manager ID" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="text" class="inputbox" name="managerId" value="${userInfo.immanagerid}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.mobilePhone" text="Mobile Phone" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="mobilePhone" value="${userInfo.mobile}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.localFirstNm" text="Local First Name" /></span></th>
							<td>
								<input type="text" class="inputbox" name="localFirstName" value="${userInfo.imstring52}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.localLastName" text="Local Last Name" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="localLastName" value="${userInfo.imstring51}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.localMiddleNm" text="Local Middle Name" /></span></th>
							<td>
								<input type="text" class="inputbox" name="localMiddleName" value="${userInfo.imstring53}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.suffix" text="Suffix" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="suffix" value="${userInfo.imnamesuffix}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.jobDesc" text="Job Desc" /></span></th>
							<td>
								<input type="text" class="inputbox" name="jobDesc" value="${userInfo.imstring56}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.office" text="Office" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="office" value="${userInfo.roomnumber}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.expirationDate" text="Expiration Date" /></span></th>
							<td colspan="3">
								<input type="text" class="inputbox" name="expirationDate" id="expirationDate" value="${userInfo.imexpirationdate}" class="date"/>
							</td>
						</tr>
					</c:if>
					<c:if test="${userInfo.imusertype eq '40'}">
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.firstNm" text="First Name" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="text" class="inputbox" name="firstName" value="${userInfo.givenname}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.lastName" text="Last Name" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="text" class="inputbox"  name="lastName" value="${userInfo.sn}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.email" text="Email" /></span></th>
							<td>
								<input type="text" class="inputbox" name="email" value="${userInfo.mail}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.mobilePhone" text="Mobile Phone" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="mobilePhone" value="${userInfo.mobile}"/>
							</td>	
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.country" text="Country" /></span></th>
							<td>
								<input type="text" class="inputbox" name="country" value="${userInfo.country}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.company" text="Company" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="company" value="${userInfo.imcompanyname}"/>
							</td>	
						</tr>					
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.managerId" text="Manager ID" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="text" class="inputbox" name="managerId" value="${userInfo.immanagerid}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.title" text="Title" /></span></th>
							<td>
								<input type="text" class="inputbox" name="title" value="${userInfo.title}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.localFirstNm" text="Local First Name" /></span></th>
							<td>
								<input type="text" class="inputbox" name="localFirstName" value="${userInfo.imstring52}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.localLastName" text="Local Last Name" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="localLastName" value="${userInfo.imstring51}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.localMiddleNm" text="Local Middle Name" /></span></th>
							<td>
								<input type="text" class="inputbox" name="localMiddleName" value="${userInfo.imstring53}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.jobDesc" text="Job Desc" /></span></th>
							<td>
								<input type="text" class="inputbox" name="jobDesc" value="${userInfo.imstring56}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.office" text="Office" /></span></th>
							<td colspan="3">
								<input type="text" class="inputbox"  name="office" value="${userInfo.roomnumber}"/>
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			</div>	
			<div class="center">
				<a class="btn_blue3" href="javascript:modifyNonEmployee()"><span>Modify</span></a>
				<a class="btn_gray4" href="javascript:closePopup('modifyNonEmployee')"><span><spring:message code="button.close" text="Close" /></span></a>
			</div>					
					
		</div>
	</div>
	<a href="javascript:closePopup('modifyNonEmployee')" class="btn_pop_close"><img src="/images/skin/btn/btn_pop_close.gif" alt="close" /></a>	
</form>
</div>
</div>
		