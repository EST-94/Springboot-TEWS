<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id='viewEmployeeUserDetailRoot' class='layer_popup'>
	<!-- (layerpop - View User) -->
	<div class="layer_pop showpop" style="margin-left: -360px; margin-top: -230px; z-index:6;" id="reg_div">
		<div class="pop_wrap">
			<p class="tit"><spring:message code="label.viewUser" text="View User" /> </p>
	
			<div class="pop_contents">
	
				<div class="clear">
						<span class="region_txt"><spring:message code="page.cdsid" text="USERID" /> &nbsp;&nbsp;</span>
						<b>${user.userid}</b>
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
								<th scope="row" class="vmiddle" ><span><spring:message code="page.employeeNumber" text="Employee Number" /></span></th>
								<td>${user.employeenumber}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.employeeType" text="Employee Type" /></span></th>
								<td>${user.employeetype}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.firstName" text="First Name" /></span></th>
								<td>${user.givenname}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.lastName" text="Last Name" /></span></th>
								<td>${user.sn}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.middleName" text="Middle Name" /></span></th>
								<td>${user.initials}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.fullName" text="Full Name" /></span></th>
								<td>${user.cn}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.departmentNumber" text="Ddepartment" /></span></th>
								<td>${user.departmentnumber}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.country" text="Country" /></span></th>
								<td>${user.destinationindicator}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.state" text="State" /></span></th>
								<td>${user.st}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.city" text="City" /></span></th>
								<td>${user.l}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.address1" text="Address 1" /></span></th>
								<td>${user.street}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.address2" text="Address 2" /></span></th>
								<td>${user.postaladdress}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.postalCode" text="Postal Code" /></span></th>
								<td>${user.postalcode}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.email" text="E-Mail" /></span></th>
								<td>${user.mail}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.workPhone" text="Work Phone" /></span></th>
								<td>${user.telephonenumber}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.fax" text="Fax" /></span></th>
								<td>${user.facsimiletelephonenumber}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.homePhone" text="Home Phone" /></span></th>
								<td>${user.homephone}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.mobilePhone" text="Mobile Phone" /></span></th>
								<td>${user.mobile}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.office" text="Office" /></span></th>
								<td>${user.roomnumber}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.preferredLanguage" text="Preferred Language" /></span></th>
								<td>${user.preferredlanguage}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.userStatus" text="User Status" /></span></th>
								<td></td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.title" text="Title" /></span></th>
								<td>${user.title}</td>
							</tr>
							<tr>
								<th scope="row" class="vmiddle"><span><spring:message code="page.userCertificate00" text="User Certificate 00" /></span></th>
								<td>${user.usercertificate}</td>
								<th scope="row" class="vmiddle"><span><spring:message code="page.photo" text="Photo" /></span></th>
								<td>${user.jpegphoto}</td>
							</tr>
						</tbody>
					</table>
				</div>
	
			</div>
		</div>
		<a href="javascript:closePopup('viewEmployeeUserDetail')" class="btn_pop_close"><img src="/images/skin/btn/btn_pop_close.gif" alt="close" /></a>
	</div>
	<!-- //(layerpop - View User) -->
</div>