<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id='modifyLocalUserRoot' class='layer_popup'>

<!-- (layerpop - Modify User) -->
<div class="layer_pop showpop" style="margin-left: -360px; margin-top: -230px;" id="reg_div">
<form name="modUserForm" id="modUserForm" method="post" action="/admin/user/updateLocalUserInfo.do" enctype="multipart/form-data">
	<input type="hidden" id="cdsidCheckResult" name="cdsidCheckResult" value="N">
	<input type="hidden" name="guid" value="${user.guid }" />
	<div class="pop_wrap">
		<p class="tit"><spring:message code="label.modifyUser" text="Modify User" />  </p>

		<div class="pop_contents">

			<div class="clear">
				<!-- (CDSID) -->
				<div class="regionbox">
					<span class="region_txt"><spring:message code="page.cdsid" text="CDSID" /></span>
					<c:choose>
						<c:when test="${user.cdsid ne null}">
							<b>${user.cdsid }</b>
						</c:when>
						<c:otherwise>
							<input type="text"  class="inputbox" style="padding-left:7px;" id="cdsid" name="cdsid" style="width: 165px;text-transform: uppercase;ime-mode:disabled !important;" value="${user.cdsid }" />
							<a class="btn_blue3" href="javascript:checkCdsid()" id="btn_cdsCheck"><span><spring:message code="page.check" text="Check" /> </span></a><b id="checkCdsidMsg"></b>
						</c:otherwise>
					</c:choose>
				</div>
				<!-- //(CDSID) -->
			</div>
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
						<tr >
							<th scope="row" class="vmiddle"><span><spring:message code="page.firstNm" text="First Name" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="text" class="inputbox" name="firstName" value="${user.firstName}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.localLastName" text="Local Last Name" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="text" class="inputbox"  name="lclLastName" value="${user.lclLastName}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.lastNm" text="Last Name" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="text" class="inputbox"  name="lastName" value="${user.lastName}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.localFirstName" text="Local First Name" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="text" class="inputbox"  name="lclFirstName" value="${user.lclFirstName}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.middNm" text="Middle Name" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="glbMidName" value="${user.glbMidName}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.localMiddleName" text="Local Middle Name" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="lclMiddleName" value="${user.lclMiddleName}"/>
							</td>
						</tr>
                        <tr>
                            <th scope="row" class="vmiddle"><span><spring:message code="page.displayName" text="Display Name" /></span></th>
                            <td>
                                <input type="text" class="inputbox" name="displayName" id="displayName" value="${user.displayName}"/>                          
                            </td>
                            <th scope="row" class="vmiddle"><span><spring:message code="page.alias" text="Alias" /></span></th>
                            <td>
                                <input type="text" class="inputbox" name="alias" id="alias" value="${user.alias}"/>  
                            </td>
                        </tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.nationCode" text="Country Name" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="hidden" name="nationCode" id="NationalCode" value="${user.nationCode}"/><!-- Hidden -->
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="nationName" id="NationalCode_label" value="${user.nationName}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('NationalCode');"/>							
								<a href="javascript:showCodeSearch('NATION','NationalCode', 'NationalCode_label')" class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.location" text="Location" /></span></th>
							<td>
								<input type="hidden"  name="workPlace" id="workPlace" value="${user.workPlace}"/>
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="workPlaceName" id="workPlace_label" value="${user.workPlace}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('workPlace');"/>	
								<a href="javascript:showCodeSearch('PLANT','workPlace', 'workPlace_label')" class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.glbDeptCD" text="Global Dept Name" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="hidden" name="glbDeptCode" id="globalDeptCode" value="${user.glbDeptCode}" />
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="glbDeptName" id="globalDeptCode_label" value="${user.glbDeptName}" />
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('globalDeptCode');"> 
								<a href="javascript:openPopup('searchGlobalDept')"  class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.lclDeptCD" text="Local Dept Name" /></span></th>
							<td>
								<input type="hidden" name="lclDeptCode" id="localDeptCode" value="${user.lclDeptCode}"/>
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="lclDeptName" id="localDeptCode_label" value="${user.lclDeptName}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('localDeptCode');">
								<a href="javascript:openPopup('searchLocalDept')" class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.GLBEmpNum" text="Global Employee Number" /></span></th>
							<td>
								<input type="text" class="inputbox" name="glbEmpNo" value="${user.glbEmpNo}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.LOLEmpNum" text="Local Employee Number" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="lclEmpNo" value="${user.lclEmpNo}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.regionCode" text="Region Name" /></span></th>
							<td>
								<input type="hidden" name="regionCode" id="regionCode" value="${user.regionCode}"/>
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="regionName" id="regionCode_label" value="${user.regionName}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('regionCode');"/>
								<a href="javascript:showCodeSearch('REGION_GRP','regionCode', 'regionCode_label')" class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.entityCode" text="Entity Name" /></span></th>
							<td>
								<input type="hidden" id="entityCode"  name="entityCode" value="${user.entityCode}"/>
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="entityName" id="entityCode_label" value="${user.entityName}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('entityCode');"/>
								<a href="javascript:showCodeSearch('LEGAL_ENT','entityCode', 'entityCode_label')" class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.plantCode" text="Plant Name" /></span></th>
							<td>
								<input type="hidden" id="plantCode"  name="plantCode" value="${user.plantCode}"/>
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="plantName" id="plantCode_label" value="${user.plantName}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('plantCode');"/> 
								<a href="javascript:showCodeSearch('PLANT','plantCode', 'plantCode_label')" class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.buildingCode" text="Building Name" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="hidden" id="buildingCode"  name="bldg" value="${user.bldg}"/>
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="bldgName" id="buildingCode_label" value="${user.bldgName}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('buildingCode');"/> 
								<a href="javascript:showCodeSearchForBLDG('BLDG','buildingCode', 'buildingCode_label','street','city','state','zip','country','office','company','regionCode','regionCode_label','plantCode','plantCode_label','NationalCode','NationalCode_label','entityCode','entityCode_label')" class="">
                                <img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.jobLevel" text="Job Level" /></span></th>
							<td>
								<input type="text" class="inputbox"  name="jobLevel" value="${user.jobLevel}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.empGroup" text="Employee Group" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="hidden" id="employeeGroup"  name="empGroup" value="${user.empGroup}"/>
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="empGroupName" id="employeeGroup_label" value="${user.empGroupName}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('employeeGroup');"/>
								<a href="javascript:showCodeSearch('EMP_GROUP','employeeGroup', 'employeeGroup_label')" class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.ReportTo" text="Report To" /><img src='/images/skin/btn/btn_req.gif'></span></th>
							<td>
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="reportTo" id="reportTo" value="${user.reportTo}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValue('reportTo');"/>
								<a href="javascript:showReportToSearch('reportTo');" class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.dualReportTo" text="Dual Report To" /></span></th>
							<td>
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="dualReportTo" id="dualReportTo1" value="${user.dualReportTo}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValue('dualReportTo1');"/>
								<a href="javascript:showReportToSearch('dualReportTo1');" class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
						</tr>
                        <tr>
                            <th scope="row" class="vmiddle"><span><spring:message code="page.roleList" text="Role List" /><img src='/images/skin/btn/btn_req.gif'></span>
                            <br /><a href="javascript:showProvisionSearch('RoleList')"  class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
                            </th>
                            <td>
								<input type="hidden" name="roleList" id="RoleList" value="<c:forEach var="item" items="${user.codeList }"><c:if test="${item.owned eq 'Y' }">${item.sysCd },</c:if></c:forEach>" />
								<textarea class="inputbox hasSearchbtn" readonly="readonly" name="roleName" id="RoleName" style="resize: none; text-indent: 0; padding-left: 4px;"><c:forEach var="item" items="${user.codeList }"><c:if test="${item.owned eq 'Y' }">${item.sysNm }&#13;&#10;</c:if></c:forEach></textarea>
							</td>
                            <th scope="row" />
                            <td />
                        </tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.userStatus" text="User Status" /> </span></th>
							<td>
								<input type="hidden" name="userStatus" id="userStatus" value="${user.userStatus}"/>
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="userStatusName" id="userStatus_label" value="${user.userStatusName}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('userStatus');"/>
								<a href="javascript:showCodeSearch('USER_STATUS','userStatus', 'userStatus_label')"  class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.grade" text="Grade" /></span></th>
							<td>
								<input type="hidden" name="glbGrade" id="grade" value="${user.glbGrade}"/>
								<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="glbGradeName" id="grade_label" value="${user.glbGradeName}"/>
								<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('grade');"/>
								<a href="javascript:showCodeSearch('JOB_GRD','grade', 'grade_label')"  class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.cellPhone" text="Cell Phone" /></span></th>
							<td>
								<input type="text" class="inputbox"  id="cellPhone"  name="cellPhone" value="${user.cellPhone}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.officePhone" text="Office Phone" /></span></th>
							<td>
								<input type="text" class="inputbox"  id="OfficePhone"  name="officePhone" value="${user.officePhone}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.fax" text="Fax" /></span></th>
							<td>
								<input type="text"  onkeydown="onlyNum();" class="inputbox" id="fax" name="fax"  value="${user.fax}"/>
							</td>
							<th scope="row" class="vmiddle"><span><spring:message code="page.AlterEmail" text="Alternate E-mail" /> </span></th>
							<td>
								<input type="text" class="inputbox"  id="AlternateEmail"  name="alterEmail" value="${user.alterEmail}"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class="vmiddle"><span><spring:message code="page.entDate" text="Entrance Date" /></span></th>
							<td>
								<input type="text" class="inputbox" id="EntranceDate"  name="enterDate" value="${user.enterDate}"/>
							</td>
							<c:choose>
								<c:when test="${rank == 'S'}">
									<th scope="row" class="vmiddle"><span><spring:message code="page.adminFlag" text="Role Type" /></span></th>
									<td>
										<input type="hidden" name="admFlag" id="admFlag" value="${user.admFlag}"/>
										<input type="text" class="inputbox hasSearchbtn" readonly="readonly" name="admFlagName" id="admFlagName" value="${user.admFlagName}"/>
										<img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('grade');"/>
										<a href="javascript:showCodeSearch('ADM_FLAG','admFlag', 'admFlagName')"  class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
									</td>
								</c:when>
								<c:otherwise>
									<th scope="row" class="vmiddle">&nbsp;</th>
									<td>&nbsp;</td>
								</c:otherwise>
							</c:choose>
					    </tr>
                        <tr>
                            <th scope="row" class="vmiddle"><span><spring:message code="page.street" text="Street" /></span></th>
                            <td>
                                <input type="text"  class="inputbox" id="street" name="street"  value="${user.street}"/>
                            </td>
                            <th scope="row" class="vmiddle"><span><spring:message code="page.city" text="City" /> </span></th>
                            <td>
                                <input type="text" class="inputbox"  id="city"  name="city" value="${user.city}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="vmiddle"><span><spring:message code="page.state" text="State/Province" /></span></th>
                            <td>
                                <input type="text"  class="inputbox" id="state" name="state"  value="${user.state}"/>
                            </td>
                            <th scope="row" class="vmiddle"><span><spring:message code="page.zip" text="ZIP/Postal Code" /> </span></th>
                            <td>
                                <input type="text" class="inputbox"  id="zip"  name="zip" value="${user.zip}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="vmiddle"><span><spring:message code="page.country" text="Country/Region" /></span></th>
                            <td>
                                <input type="text"  class="inputbox hasSearchbtn" readonly="readonly" id="country" name="country"  value="${user.country}"/>
                                <img style=" margin-left:-14px;" src="/images/skin/btn/btn_reset.gif" onclick="javascript:deleteInputReadOnlyValueWithHidden('country');"/>
                                <a href="javascript:showCodeSearchForCountry('NATION','country_code', 'country')" class=""><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
                            </td>
                            <th scope="row" class="vmiddle"><span><spring:message code="page.office" text="Office" /> </span></th>
                            <td>
                                <input type="text" class="inputbox"  id="office"  name="office" value="${user.office}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="vmiddle"><span><spring:message code="page.company" text="Company" /></span></th>
                            <td>
                                <input type="text"  class="inputbox" id="company" name="company"  value="${user.company}"/>
                            </td>
                            <th scope="row" class="vmiddle"><span><spring:message code="" text="" /> </span></th>
                            <td>
                            </td>
                        </tr>
					</tbody>
				</table>
			</div>
			<div class="center">
				<a class="btn_blue3" href="javascript:modUserInfo()"><span>Modify</span></a>
				<a class="btn_gray4" href="javascript:closePopup('modifyLocalUser')"><span><spring:message code="button.close" text="Close" /></span></a>
			</div>

		</div>
	</div>

	<a href="javascript:closePopup('modifyLocalUser')" class="btn_pop_close"><img src="/images/skin/btn/btn_pop_close.gif" alt="close" /></a>
	</form>
</div>

<script type="text/javascript">
<!--
$(document).ready(function(){
	//Calendar 적용
	$("#EntranceDate").datepicker({ dateFormat: 'yymmdd' });
	
	//검색 EnterKey 적용
	$('form[name=modUserForm] input[name=cdsid]').keydown(function(e){
		var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
		if (key == 13) { checkCdsid(); }
    });
	
	// CDSID를 수정하면, cdsid 체크 다시해야함
	$('form[name=modUserForm] input[name=cdsid]').change(function(e){
		$("#cdsidCheckResult").val("N");
		$("#checkCdsidMsg").text("<spring:message code='localuser.alert13' text='Please press the CDSID check Button!' />");
    });
});

/**
 * 사용자 정보 수정 
 */
function modUserInfo() {
	if(checkRequiredModifyUser()){
		$.ajax({
			url: '/admin/localUser/user/update.do'
			, type: 'post'
			, dataType: 'xml'
			, data: $("#modUserForm").serialize()
			, success: function(data) {
				//console.log(data);
				//console.log($('code', data).text());
				alert($('message', data).text());

				if('1' == $('code', data).text()) {
					// success
					closePopup('modifyLocalUser');
				}
			}
			, error: function(data) {
				//console.log("Error with /admin/localUser/user/update.do");
				//console.log(data);
			}
		});
	}
}

/**
 * 필수 값 체크
 */
function checkRequiredModifyUser(){
	if("" == "${user.cdsid }"){
		// CDSID 입력했으면, 중복 체크는 했는지 확인
		if($("#cdsid").val() != "") {
			if($("#checkCdsidValue").val() == ("" + $("#cdsid").val()).toLocaleUpperCase()){
				if($("#checkCdsid").val() == "N"){
					alert("Please check for duplicates!");
					$("#checkCdsidMsg").text("<spring:message code='localuser.alert13' text='Please press the CDSID check Button!' />");
					return false;
				}else{ 
					$("#cdsid").val($("#cdsid").val().toLocaleUpperCase());
					ajaxFormSubmit('/admin/user/createLocalUserInfo.do', "#registUserForm", function(data) {
						alert("<spring:message code='localuser.alert14' text='Created users!' />");
						popupClose();
					}, errorCallback, true);
				}
			}else{
				alert("<spring:message code='alert.changed.cdsid' text='CDSID has been Changed!'/>");
				$("#checkCdsidMsg").text("<spring:message code='localuser.alert15' text='Please press the CDSID check Button again!' /> ");
				return false;
			}
		}
	} else if($("#firstName").val() == ""){
		alert("<spring:message code='localuser.alert7' text='Please enter your first name!' />");
		$("#firstName").focus();
		return false;
	}else if($("#lastName").val() == ""){
		alert("<spring:message code='localuser.alert5' text='Please enter your last name!' />");
		$("#lastName").focus();
		return false;
	}else if($("#localFirstName").val() == ""){
		alert("<spring:message code='localuser.alert8' text='Please enter your local first name!' />");
		$("#localFirstName").focus();
		return false;
	}else if($("#localLastName").val() == ""){
		alert("<spring:message code='localuser.alert6' text='Please enter your local last name!' />");
		$("#localLastName").focus();
		return false;
	}else if($("#NationalCode").val() == ""){
		alert("<spring:message code='localuser.alert4' text='Please enter your Nationalcode!' />");
		$("#NationalCode").focus();
		return false;
	}else if($("#globalDeptCode").val() == ""){
		alert("<spring:message code='localuser.alert22' text='Please enter your global dept name!' />");
		$("#globalDeptCode_label").focus();
		return false;
	}else if($("#reportTo").val() == ""){
		alert("<spring:message code='localuser.alert21' text='Please! Select your REPORT TO.' />");
		$("#reportTo").focus();
		return false;
	}else if($("#buildingCode").val() == ""){
		alert("<spring:message code='localuser.alert23' text='Please enter your building name!' />");
		$("#buildingCode_label").focus();
		return false;
	}
	
	return true;
}

/**
 * CDSID 중복체크
 */
function checkCdsid(){
	if("" != "${user.cdsid }") {
		// 기존 CDSID 값이 없어야 체크 가능
		return false;
	} else {
		if($("#cdsid").val() == ""){
			alert("Please put user's CDSID!");
			$("#cdsid").focus();
		}else{
			var params = {};
			params.regCdsId = $("#cdsid").val().toLocaleUpperCase(); //CDSID 체크시에는 대문자로 변환후 체크한다.
			ajaxJsonCall("/admin/user/searchRegCdsId.do", params, function(data) {
				if(data["count"]>0){
					alert("<spring:message code='localuser.alert9' text='This Id is not available!' />");	
					$("#cdsidCheckResult").val("N");
					$("#checkCdsidMsg").text("<spring:message code='localuser.alert11' text='**Already exist this Id!' />  ");
					$("#cdsid").focus();
				}else{
					$("#cdsidCheckResult").val("Y");
					$("#checkCdsidMsg").text("<spring:message code='localuser.alert3' text='This Id is available!' />");
				}
			}, errorCallback, false);
		}
	}

}

/**
 * show Provisioning Role List
 * @since 2017-01-23
 */
function showProvisionSearch() {
	$.ajax({
		url: '/admin/localUser/provision/view.do'
		, type: 'post'
		, dataType: 'xml'
		, data: 'cdsid=${user.cdsid }'
		, success: function(data, status, error) {
			$('body').append(error.responseText);
		}, error: function(data, status, error) {
			$('body').append(data.responseText);
		}
	});
}
//-->
</script>

<!-- //(layerpop - Modify User) -->
</div>