<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id='viewLocalUserDetailRoot' class='layer_popup'>
	<!-- (layerpop - View User) -->
	<div class="layer_pop showpop" style="margin-left: -360px; margin-top: -230px; z-index:6;" id="reg_div">
		<div class="pop_wrap">
			<p class="tit"><spring:message code="label.viewUser" text="View User" /> </p>
	
			<div class="pop_contents">
	
				<div class="clear">
						<span class="region_txt"><spring:message code="page.cdsid" text="CDSID" /> &nbsp;&nbsp;</span>
						<b>${user.cdsid}</b>
				</div>
				<div><!--  style="overflow-y: scroll; -->
					<table class="board_view01 mgt_10" summary="" >
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
								<th scope="row" class="vmiddle"><span><spring:message code="page.nationCode" text="Nation Name" /></span></th>
								<td>${user.nationName}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.location" text="Location" /></span></th>
								<td>${user.workPlace}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.glbDeptCD" text="Global Dept Name" /></span></th>
								<td>${user.glbDeptName}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.lclDeptCD" text="Local Dept Name" /></span></th>
								<td>${user.lclDeptName}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.GLBEmpNum" text="Global Employee Number" /></span></th>
								<td>${user.glbEmpNo}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.LOLEmpNum" text="Local Employee Number" /></span></th>
								<td>${user.lclEmpNo}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.regionCode" text="Region Name" /></span></th>
								<td>${user.regionName}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.entityCode" text="Entity Name" /></span></th>
								<td>${user.entityName}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.plantCode" text="Plant Name" /></span></th>
								<td>${user.plantName}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.buildingCode" text="Building Name" /></span></th>
								<td>${user.bldgName}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.jobLevel" text="Job Level" /></span></th>
								<td>${user.jobLevel}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.empGroup" text="Employee Group" /></span></th>
								<td>${user.empGroupName}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.ReportTo" text="Report To" /></span></th>
								<td>${user.reportTo}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.dualReportTo" text="Dual Report To" /></span></th>
								<td>${user.dualReportTo}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.userStatus" text="User Status" /></span></th>
								<td>${user.userStatusName}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.grade" text="Grade" /></span></th>
								<td>${user.glbGradeName}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.cellPhone" text="Cell Phone" /></span></th>
								<td>${user.cellPhone}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.officePhone" text="Office Phone" /></span></th>
								<td>${user.officePhone}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.fax" text="Fax" /></span></th>
								<td>${user.fax}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.AlterEmail" text="Alternate E-mail" /></span></th>
								<td>${user.alterEmail}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.entDate" text="Entrance Date" /></span></th>
								<td>${user.enterDate}</td>
								<c:choose>
									<c:when test="${rank eq 'S'}">
										<th scope="row" class="vmiddle"><span><spring:message code="page.adminFlag" text="Role Type" /></span></th>
										<td>${user.admFlagName }</td>
									</c:when>
									<c:otherwise>
										<th scope="row" class="vmiddle">&nbsp;</th>
										<td>&nbsp;</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</tbody>
					</table>
				</div>
	
			</div>
		</div>
		<a href="javascript:closePopup('viewLocalUserDetail')" class="btn_pop_close"><img src="/images/skin/btn/btn_pop_close.gif" alt="close" /></a>
	</div>
	<!-- //(layerpop - View User) -->
</div>