<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<script type="text/javascript">

		$(document).ready(function () {
		});

		function GetOffice365UserInfo() {
			$('span.deem').css('display', 'block');
			$('#M365Loadingbar').css('display', 'block');
			var params = {};
			if (mail != '') {
				params.urid = mail;
			} else {
				params.urid = '${urid}';
			}

			// 사용자 조회 시작
			$.ajax({
				url: '/admin/imuser/getOffice365.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					//console.log(data)
					saveOffice365UserInfo(data)
					$('span.deem').css('display', 'none');
					$('#M365Loadingbar').css('display', 'none');
				}
				, error: function (data) {
					//	console.log("Error");
					//	console.log(data);
					$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
					$('div.position_loading').children('dl').children('dt').html("Selected failed");
				}
			});
		}

		function saveOffice365UserInfo(data) {
			$('#Office365UserDiv').html('');
			if ($(data).find('isExchangeUser').text() == 'true') {

				$('result', data).each(function () {
					activeSyncEnabled = $('activeSyncEnabled', this).text();
					autoReplyState = $('autoReplyState', this).text();
					blockCredential = $('blockCredential', this).text();
					company = $('company', this).text();
					countryOrRegion = $('countryOrRegion', this).text();
					usageLocation = $('usageLocation', this).text();
					customAttribute1 = $('customAttribute1', this).text();
					customAttribute2 = $('customAttribute2', this).text();
					customAttribute3 = $('customAttribute3', this).text();
					customAttribute4 = $('customAttribute4', this).text();
					customAttribute5 = $('customAttribute5', this).text();
					customAttribute6 = $('customAttribute6', this).text();
					customAttribute7 = $('customAttribute7', this).text();
					customAttribute8 = $('customAttribute8', this).text();
					externalMessage = $('externalMessage', this).text();
					hiddenFromAddressListsEnabled = $('hiddenFromAddressListsEnabled', this).text();
					identity = $('identity', this).text();
					internalMessage = $('internalMessage', this).text();
					manager = $('manager', this).text();
					RemoveLicenses = $('RemoveLicenses', this).text();
					Type = $('Type', this).text();
					userPrincipalName = $('userPrincipalName', this).text();
					isShared = $('isShared', this).text();
					FaxNumber = $('fax', this).text();
					FirstName = $('firstName', this).text();
					office = $('office', this).text();
					if ($('zip', this).text() == '') {
						zip = $('zip', this).text();
					} else if ($('postalCode', this).text()) {
						zip = $('postalCode', this).text();
					} else {
						zip = '';
					}
					functionCode = $('FunctionCode', this).text();
					DeptCode = $('DeptCode', this).text();
					CostCenterCord = $('CostCenterCord', this).text();
					City = $('city', this).text();
					mobilePhone = $('mobilePhone', this).text();
					phone = $('phone',this).text();
					preferredLanguage = $('preferredLanguage', this).text();
					lastName = $('lastName', this).text();
					if ($('state', this).text() == '') {
						state = $('state', this).text();
					} else if ($('Province', this).text()) {
						state = $('state', this).text();
					} else {
						state = '';
					}
					streetAddress = $('streetAddress', this).text();
					title = $('title', this).text();
				});

				html = "<tr>"
					+ "<td class='center'>identity</td>"
					+ "<td title='" + identity + "' class='";
				if (UserinfoCompare(identity, "userId")) html += "center";
				else html += "df";
				html += "'>" + identity + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<tr>"
					+ "<td class='center'> countryOrRegion </td>"
					+ "<td title='" + countryOrRegion + "' class='";
				if (UserinfoCompare(countryOrRegion, "country")) html += "center";
				else html += "df";
				html += "'>" + countryOrRegion + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'> customAttribute6 </td>"
					+ "<td title='" + customAttribute6 + "' class='";
				if (UserinfoCompare(customAttribute6, "jEmptype")) html += "center";
				else html += "df";
				html += "'>" + customAttribute6 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'> Fax Number </td>"
					+ "<td title='" + FaxNumber + "' class='";
				if (UserinfoCompare(FaxNumber, "fax")) html += "center";
				else html += "df";
				html += "'>" + FaxNumber + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'> First Name </td>"
					+ "<td title='" + FirstName + "' class='";
				if (UserinfoCompare(FirstName, "firstName")) html += "center";
				else html += "df";
				html += "'>" + FirstName + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Last Name</td>"
					+ "<td title='" + lastName + "' class='";
				if (UserinfoCompare(lastName, "lastName")) html += "center";
				else html += "df";
				html += "'>" + lastName + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Company</td>"
					+ "<td title='" + company + "' class='";
				if (UserinfoCompare(company, "companyName")) html += "center";
				else html += "df";
				html += "'>" + company + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>customAttribute8</td>"
					+ "<td title='" + customAttribute8 + "' class='";
				if (UserinfoCompare(customAttribute8, "employeeStatus")) html += "center";
				else html += "df";
				html += "'>" + customAttribute8 + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Manager</td>"
					+ "<td title='" + manager + "' class='";
				if (UserinfoCompare(manager, "managerId")) html += "center";
				else html += "df";
				html += "'>" + manager + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'> Office </td>"
					+ "<td title='" + office + "' class='";
				if (UserinfoCompare(office, "officePlantCode")) html += "center";
				else html += "df";
				html += "'>" + office + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'> ZIP </td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>CustomAttribute5</td>"
					+ "<td title='" + customAttribute5 + "' class='";
				if (UserinfoCompare(customAttribute5, "buildingCode")) html += "center";
				else html += "df";
				html += "'>" + customAttribute5 + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"*/
				/*	+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>customAttribute7</td>"
					+ "<td title='" + customAttribute7 + "' class='";
				if (UserinfoCompare(customAttribute7, "localDepartmentCode")) html += "center";
				else html += "df";
				html += "'>" + customAttribute7 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>City</td>"
					+ "<td title='" + City + "' class='";
				if (UserinfoCompare(City, "city")) html += "center";
				else html += "df";
				html += "'>" + City + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>userPrincipalName</td>"
					+ "<td title='" + userPrincipalName + "' class='";
				if (UserinfoCompare(userPrincipalName, "primaryEmail")) html += "center";
				else html += "df";
				html += "'>" + userPrincipalName + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Mobile Phone</td>"
					+ "<td title='" + mobilePhone + "' class='";
				if (UserinfoCompare(mobilePhone, "mobilePphone")) html += "center";
				else html += "df";
				html += "'>" + mobilePhone + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>phone</td>"
					+ "<td title='" + phone + "' class='";
				if (UserinfoCompare(phone, "workPhone")) html += "center";
				else html += "df";
				html += "'>" + phone + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'> Preferred Language </td>"
					+ "<td title='" + preferredLanguage + "' class='";
				if (UserinfoCompare(preferredLanguage, "preferredLanguage")) html += "center";
				else html += "df";
				html += "'>" + preferredLanguage + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'> Street Address </td>"
					+ "<td title='" + streetAddress + "' class='";
				if (UserinfoCompare(streetAddress, "addressLine1")) html += "center";
				else html += "df";
				html += "'>" + streetAddress + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Job Title</td>"
					+ "<td title='" + title + "' class='";
				if (UserinfoCompare(title, "title")) html += "center";
				else html += "df";
				html += "'>" + title + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'> isShared </td>"
					+ "<td title='" + isShared + "' class='center'>"
					+ isShared
					+ "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center' title='hiddenFromAddressListsEnabled'> hiddenFromAddressListsEnabled </td>"
					+ "<td title='" + hiddenFromAddressListsEnabled + "' class='center'>" 
					+ hiddenFromAddressListsEnabled 
					+ "</td>"
					+ "</tr>";

				$('#Office365UserDiv').append(html);
				$('#M365Status').html('');
				if (isShared.toUpperCase() == 'FALSE') {
					html = "<th scope='col' colspan='2'>"
						+ "Status:  Active"
						+ "</th>";
				} else if (isShared.toUpperCase() == 'TRUE') {
					html = "<th scope='col' colspan='2'>"
						+ "Status:  <span style='color:#F73738;'>Inactive </span>"
						+ "</th>";
				} else {
					html = "<th scope='col' colspan='2'> Status:  - </th>"
				}
				$('#M365Status').append(html);
				drawIMUserStore()
			} else {
				$('#M365Status').html('');
				html = "<th scope='col' colspan='2'>"
					+ "Status:  <span style='color:#F73738;'>User not found </span>"
					+ "</th>";
				$('#M365Status').append(html);
				$('#Office365UserDiv').append("<tr><td colspan='2' style='text-align:center !important;' class='center'><spring:message code='alert.result.1' text='User not found' /></td></tr>");
			}
			$("#btnM365").html('Reload');
		}
	</script>
</head>

<body class="main">
	<table class="board_01" summary="User Quick Menu">
		<caption></caption>
		<colgroup>
			<col width="8%">
			<col width="8%">
		</colgroup>
		<thead>

		</thead>

		<!-- Batch Job 목록 가져오기 Display Start-->
		<tbody>
			<tr class="UserStore">
				<th scope="col" style="white-space: nowrap !important;">Microsoft 365</th>
				<th scope="col" style="padding:3px 10px 4px 5px; width:15%;text-align:right;">
					<button id='btnM365' onclick="GetOffice365UserInfo()"> View </button>
				</th>
			</tr>
			<tr id="M365Status">
				<th scope='col' colspan='2'>Status: </th>
			</tr>
		</tbody>
		<!-- Batch Job 목록 가져오기 Display End-->
	</table>
	<!-- //(board_01) -->
	<table class="board_01">
		<caption></caption>
		<colgroup>
			<col width="8%">
			<col width="8%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">Field Name</th>
				<th scope="col">Value</th>
			</tr>
		</thead>
		<tbody id=Office365UserDiv></tbody>
	</table>
</body>

</html>