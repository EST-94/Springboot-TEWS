<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<script type="text/javascript">

		$(document).ready(function () {
		});

		function getSFUserInfo() {

			$('span.deem').css('display', 'block');
			$('#loadingbar').css('display', 'block');
			var params = {};
			params.urid = '${urid}';
			// 사용자 조회 시작
			$.ajax({
				url: '/admin/imuser/getSuccessFactors.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					//	console.log(data);
					saveSFUserInfo(data);
					$('span.deem').css('display', 'none');
					$('#loadingbar').css('display', 'none');
				}
				, error: function (data) {
					//	console.log("Error");
					//	console.log(data);
					$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
					$('div.position_loading').children('dl').children('dt').html("Selected failed");
				}
			});
		}


		function saveSFUserInfo(data) {
			$('#SFUserInfoDiv').html('');
			if ($(data).find('username').text() != '') {

				$('result', data).each(function () {
					Location = $('location', this).text();
					department = $('department', this).text();
					country = $('country', this).text();
					userId = $('userId', this).text();
					custom07 = $('custom07', this).text();
					fax = $('fax', this).text();
					firstName = $('firstName', this).text();
					hireDate = $('hireDate', this).text();
					custom05 = $('custom05', this).text();
					division = $('division', this).text();
					status = $('status', this).text();
					custom12 = $('custom12', this).text();
					manager = $('manager', this).text();
					nickname = $('nickname', this).text();
					suffix = $('suffix', this).text();
					hr = $('hr', this).text();
					gender = $('gender', this).text();
					jobCode = $('jobCode', this).text();
					empId = $('empId', this).text();
					zip = $('zipCode', this).text();
					proxy = $('proxy', this).text();
					matrixManager = $('matrixManager', this).text();
					seatingChart = $('seatingChart', this).text();
					reviewFreq = $('reviewFreq', this).text();
					lastReviewDate = $('lastReviewDate', this).text();
					custom01 = $('custom01', this).text();
					custom02 = $('custom02', this).text();
					custom03 = $('custom03', this).text();
					custom06 = $('custom06', this).text();
					custom14 = $('custom14', this).text();
					custom04 = $('custom04', this).text();
					custom08 = $('custom08', this).text();
					custom09 = $('custom09', this).text();
					custom10 = $('custom10', this).text();
					custom15 = $('custom15', this).text();
					gender = $('gender', this).text();
					timeZone = $('timeZone', this).text();
					mi = $('mi', this).text();
					city = $('city', this).text();
					email = $('email', this).text();
					cellPhone = $('cellPhone', this).text();
					addressLine2 = $('addressLine2', this).text();
					defaultLocale = $('defaultLocale', this).text();
					lastName = $('lastName', this).text();
					state = $('state', this).text();
					addressLine1 = $('addressLine1', this).text();
					businessPhone = $('businessPhone', this).text();
					title = $('title', this).text();
					username = $('username', this).text();
					custom11 = $('custom11', this).text();
					custom13 = $('custom13', this).text();
				});

				html = "<tr>"
					+ "<td class='center'>USERNAME</td>"
					+ "<td title='" + username + "' class='";
				if (UserinfoCompare(username, "userId")) html += "center";
				else html += "df";
				html += "'>" + username + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td class='center'>Department</td>"
					+ "<td title='" + department + "' class='";
				if (UserinfoCompare(department, "department")) html += "center";
				else html += "df";
				html += "'>" + department + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Country</td>"
					+ "<td title='" + country + "' class='";
				if (UserinfoCompare(country, "country")) html += "center";
				else html += "df";
				html += "'>" + country + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>USERID</td>"
					+ "<td title='" + userId + "' class='";
				if (UserinfoCompare(userId, "employeeNumber")) html += "center";
				else html += "df";
				html += "'>" + userId + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>CUSTOM07</td>"
					+ "<td title='" + custom07 + "' class='";
				if (UserinfoCompare(custom07, "employeeType")) html += "center";
				else html += "df";
				html += "'>" + custom07 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Fax</td>"
					+ "<td title='" + fax + "' class='";
				if (UserinfoCompare(fax, "fax")) html += "center";
				else html += "df";
				html += "'>" + fax + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>First Name</td>"
					+ "<td title='" + firstName + "' class='";
				if (UserinfoCompare(firstName, "firstName")) html += "center";
				else html += "df";
				html += "'>" + firstName + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>MI</td>"
					+ "<td title='" + mi + "' class='";
				if (UserinfoCompare(mi, "middleName")) html += "center";
				else html += "df";
				html += "'>" + mi + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>LASTNAME</td>"
					+ "<td title='" + lastName + "' class='";
				if (UserinfoCompare(lastName, "lastName")) html += "center";
				else html += "df";
				html += "'>" + lastName + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>HireDate</td>"
					+ "<td title='" + hireDate + "' class='";
				if (UserinfoCompare(hireDate, "activationDate")) html += "center";
				else html += "df";
				html += "'>" + hireDate + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>CUSTOM05</td>"
					+ "<td title='" + custom05 + "' class='";
				if (UserinfoCompare(custom05, "companyName")) html += "center";
				else html += "df";
				html += "'>" + custom05 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Division</td>"
					+ "<td title='" + division + "' class='";
				if (UserinfoCompare(division, "division")) html += "center";
				else html += "df";
				html += "'>" + division + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>STATUS</td>"
					+ "<td title='" + status + "' class='";
				if (UserinfoCompare(status, "employeeStatus")) html += "center";
				else html += "df";
				html += "'>" + status + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td class='center'>CUSTOM12</td>"
					+ "<td title='" + custom12 + "' class='";
				if (UserinfoCompare(custom12, "expirationDate")) html += "center";
				else html += "df";
				html += "'>" + custom12 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Manager</td>"
					+ "<td title='" + manager + "' class='";
				if (UserinfoCompare(manager, "managerId")) html += "center";
				else html += "df";
				html += "'>" + manager + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Nickname</td>"
					+ "<td title='" + nickname + "' class='";
				if (UserinfoCompare(nickname, "nickname")) html += "center";
				else html += "df";
				html += "'>" + nickname + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Suffix</td>"
					+ "<td title='" + suffix + "' class='";
				if (UserinfoCompare(suffix, "suffix")) html += "center";
				else html += "df";
				html += "'>" + suffix + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>HR</td>"
					+ "<td title='" + hr + "' class='";
				if (UserinfoCompare(hr, "humanResource")) html += "center";
				else html += "df";
				html += "'>" + hr + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>Gender</td>"
					+ "<td title='" + gender + "' class='";
				if (UserinfoCompare(gender, "gender")) html += "center";
				else html += "df";
				html += "'>" + gender + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>JobCode</td>"
					+ "<td title='" + jobCode + "' class='";
				if (UserinfoCompare(jobCode, "jobCode")) html += "center";
				else html += "df";
				html += "'>" + jobCode + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>LOCATION</td>"
					+ "<td title='" + Location + "' class='";
				if (UserinfoCompare(Location, "officePlantCode")) html += "center";
				else html += "df";
				html += "'>" + Location + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>EMPID</td>"
					+ "<td title='" + empId + "' class='";
				if (UserinfoCompare(empId, "localEmpNo")) html += "center";
				else html += "df";
				html += "'>" + empId + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>ZIP</td>"
					+ "<td title='" + zip + "' class='";
				if (UserinfoCompare(zip, "zip")) html += "center";
				else html += "df";
				html += "'>" + zip + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>PROXY</td>"
					+ "<td title='" + proxy + "' class='";
				if (UserinfoCompare(proxy, "proxy")) html += "center";
				else html += "df";
				html += "'>" + proxy + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>MATRIX_MANAGER</td>"
					+ "<td title='" + matrixManager + "' class='";
				if (UserinfoCompare(matrixManager, "matrixManager")) html += "center";
				else html += "df";
				html += "'>" + matrixManager + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>SEATINGCHART</td>"
					+ "<td title='" + seatingChart + "' class='";
				if (UserinfoCompare(seatingChart, "seatingChart")) html += "center";
				else html += "df";
				html += "'>" + seatingChart + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>REVIEW_FREQ</td>"
					+ "<td title='" + reviewFreq + "' class='";
				if (UserinfoCompare(reviewFreq, "reviewFrequency")) html += "center";
				else html += "df";
				html += "'>" + reviewFreq + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>LAST_REVIEW_DATE</td>"
					+ "<td title='" + lastReviewDate + "' class='";
				if (UserinfoCompare(lastReviewDate, "lastReviewDate")) html += "center";
				else html += "df";
				html += "'>" + lastReviewDate + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>CUSTOM01</td>"
					+ "<td title='" + custom01 + "' class='";
				if (UserinfoCompare(custom01, "buildingCode")) html += "center";
				else html += "df";
				html += "'>" + custom01 + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td class='center'>CUSTOM02</td>"
					+ "<td title='" + custom02 + "' class='";
				if (UserinfoCompare(custom02, "address")) html += "center";
				else html += "df";
				html += "'>" + custom02 + "</td>"
					+ "</tr>"*/
				/*	+ "<tr>"
					+ "<td class='center'>CUSTOM03</td>"
					+ "<td title='" + custom03 + "' class='";
				if (UserinfoCompare(custom03, "city")) html += "center";
				else html += "df";
				html += "'>" + custom03 + "</td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td class='center'>CUSTOM06</td>"
					+ "<td title='" + custom06 + "' class='";
				if (UserinfoCompare(custom06, "jMgrFlag")) html += "center";
				else html += "df";
				html += "'>" + custom06 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>CUSTOM14</td>"
					+ "<td title='" + custom14 + "' class='";
				if (UserinfoCompare(custom14, "operatingLocationCode")) html += "center";
				else html += "df";
				html += "'>" + custom14 + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td class='center'>CUSTOM04</td>"
					+ "<td title='" + custom04 + "' class='";
				if (UserinfoCompare(custom04, "zipCode")) html += "center";
				else html += "df";
				html += "'>" + custom04 + "</td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td class='center'>CUSTOM08</td>"
					+ "<td title='" + custom08 + "' class='";
				if (UserinfoCompare(custom08, "function")) html += "center";
				else html += "df";
				html += "'>" + custom08 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>CUSTOM09</td>"
					+ "<td title='" + custom09 + "' class='";
				if (UserinfoCompare(custom09, "region")) html += "center";
				else html += "df";
				html += "'>" + custom09 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>CUSTOM10</td>"
					+ "<td title='" + custom10 + "' class='";
				if (UserinfoCompare(custom10, "roleData")) html += "center";
				else html += "df";
				html += "'>" + custom10 + "</td>"
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
					+ "<td class='center'>CUSTOM15</td>"
					+ "<td title='" + custom15 + "' class='";
				if (UserinfoCompare(custom15, "localDepartmentCode")) html += "center";
				else html += "df";
				html += "'>" + custom15 + "</td>"
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
					+ "<td class='center'>TIMEZONE</td>"
					+ "<td title='" + timeZone + "' class='";
				if (UserinfoCompare(timeZone, "timeZone")) html += "center";
				else html += "df";
				html += "'>" + timeZone + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>CITY</td>"
					+ "<td title='" + city + "' class='";
				if (UserinfoCompare(city, "city")) html += "center";
				else html += "df";
				html += "'>" + city + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>EMAIL</td>"
					+ "<td title='" + email + "' class='";
				if (UserinfoCompare(email, "primaryEmail")) html += "center";
				else html += "df";
				html += "'>" + email + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>CELL_PHONE</td>"
					+ "<td title='" + cellPhone + "' class='";
				if (UserinfoCompare(cellPhone, "mobilePphone")) html += "center";
				else html += "df";
				html += "'>" + cellPhone + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>BIZ_PHONE</td>"
					+ "<td title='" + businessPhone + "' class='";
				if (UserinfoCompare(businessPhone, "workPhone")) html += "center";
				else html += "df";
				html += "'>" + businessPhone + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>DEFAULT_LOCALE</td>"
					+ "<td title='" + defaultLocale + "' class='";
				if (UserinfoCompare(defaultLocale, "preferredLanguage")) html += "center";
				else html += "df";
				html += "'>" + defaultLocale + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>STATE</td>"
					+ "<td title='" + state + "' class='";
				if (UserinfoCompare(state, "state")) html += "center";
				else html += "df";
				html += "'>" + state + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>ADDR1</td>"
					+ "<td title='" + addressLine1 + "' class='";
				if (UserinfoCompare(addressLine1, "addressLine1")) html += "center";
				else html += "df";
				html += "'>" + addressLine1 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>ADDR2</td>"
					+ "<td title='" + addressLine2 + "' class='";
				if (UserinfoCompare(addressLine2, "addressLine2")) html += "center";
				else html += "df";
				html += "'>" + addressLine2 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>TITLE</td>"
					+ "<td title='" + title + "' class='";
				if (UserinfoCompare(title, "title")) html += "center";
				else html += "df";
				html += "'>" + title + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>";

				$('#SFUserInfoDiv').append(html);
				$('#SFStatus').html('');
				if (status.toUpperCase() == 'T' || status.toUpperCase() == 'ACTIVE') {
					html = "<th scope='col' colspan='2'>"
						+ "Status:  Active"
						+ "</th>";
				} else {
					html = "<th scope='col' colspan='2'>"
						+ "Status:  <span style='color:#F73738;'>Inactive </span>"
						+ "</th>";
				}
				$('#SFStatus').append(html);
				drawIMUserStore()
			} else {
				$('#SFStatus').html('');
				html = "<th scope='col' colspan='2'>"
					+ "Status:  <span style='color:#F73738;'>User not found </span>"
					+ "</th>";
				$('#SFStatus').append(html);
				$('#SFUserInfoDiv').append("<tr><td colspan='2' style='text-align:center !important;' class='center'><spring:message code='alert.result.1' text='User not found' /></td></tr>");
			}
			$("#btnSFUser").html('Reload');
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
				<th scope="col" style="white-space: nowrap !important;">SuccessFactors</th>
				<th scope="col" style="padding: 3px 10px 4px 5px; width: 15%; text-align: right;">
					<button id='btnSFUser' onclick="getSFUserInfo()">View</button>
				</th>
			</tr>
			<tr id="SFStatus">
				<th scope="col" colspan="2">Status:</th>
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
		<tbody id=SFUserInfoDiv></tbody>
	</table>
</body>

</html>