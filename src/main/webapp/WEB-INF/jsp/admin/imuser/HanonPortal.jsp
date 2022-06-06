<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<script type="text/javascript">

		$(document).ready(function () {

		});

		function getPotalUserInfo() {
			$('span.deem').css('display', 'block');
			$('#loadingbar').css('display', 'block');
			var params = {};
			params.urid = '${urid}';
			// 사용자 조회 시작
			$.ajax({
				url: '/admin/imuser/getPotalUserInfo.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					//	console.log(data);
					savePotalUserInfo(data);
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

		function savePotalUserInfo(data) {
			$('#PotalUserInfoDiv').html('');
			if ($(data).find('result').text() != '') {

				$('result', data).each(function () {
					userId = $('userId', this).text();
					firstNm = $('firstNm', this).text();
					lastNm = $('lastNm', this).text();
					middleNm = $('middleNm', this).text();
					localFstnm = $('localFstnm', this).text();
					localLstnm = $('localLstnm', this).text();
					localMidnm = $('localMidnm', this).text();
					email = $('email', this).text();
					glbEmpno = $('glbEmpno', this).text();
					lclEmpno = $('lclEmpno', this).text();
					countryCd = $('countryCd', this).text();
					plantCd = $('plantCd', this).text();
					buildingCd = $('buildingCd', this).text();
					glbDeptcd = $('glbDeptcd', this).text();
					lclDeptcd = $('lclDeptcd', this).text();
					lclPostitle = $('lclPostitle', this).text();
					lclPostitleNm = $('lclPostitleNm',this).text();
					iptPhone = $('iptPhone', this).text();
					moblPhone = $('moblPhone', this).text();
					officePhone = $('officePhone', this).text();
					funcGroup = $('funcGroup', this).text();
					glbPosition = $('glbPosition', this).text();
					glbPositionMm = $('glbPositionMm', this).text();
					lclPosition = $('lclPosition', this).text();
					lclPositionNm = $('lclPositionNm', this).text();
					empType = $('empType', this).text();
					jobDesc = $('jobDesc', this).text();
					workZipcode = $('workZipcode', this).text();
					workAdres = $('workAdres', this).text();
					reportto = $('reportto', this).text();
					dualReportto1 = $('dualReportto1', this).text();
					dualReportto2 = $('dualReportto2', this).text();
					fax = $('fax', this).text();
					photoImage = $('photoImage', this).text();
					ecnyDe = $('ecnyDe', this).text();
					retireDe = $('retireDe', this).text();
					mngrAt = $('mngrAt', this).text();
					useAt = $('useAt', this).text();
					rgsDe = $('rgsDe', this).text();
					rgsUsr = $('rgsUsr', this).text();
					updDe = $('updDe', this).text();
					updUsr = $('updUsr', this).text();
					regionCd = $('regionCd', this).text();
					regionNm = $('regionNm', this).text();
					countryNm = $('countryNm', this).text();
					cprCd = $('cprCd', this).text();
					cprNm = $('cprNm', this).text();
					plantNm = $('plantNm', this).text();
					jobLevel = $('jobLevel', this).text();
					guid = $('guid', this).text();
					kCostCd = $('kCostCd', this).text();
					glbPostitle = $('glbPostitle', this).text();
					kCompGb = $('kCompGb', this).text();
					kCompNm = $('kCompNm', this).text();
					jgup = $('jgup', this).text();
					kJgupCnt = $('kJgupCnt', this).text();
					kJgupCd = $('kJgupCd', this).text();
					kJgunCd = $('kJgunCd', this).text();
				});

				html = "<tr>"
					+ "<td class='center'>USER_ID</td>"
					+ "<td title='" + userId + "' class='";
				if (UserinfoCompare(userId, "userId")) html += "center";
				else html += "df";
				html += "'>" + userId + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td class='center'>GLB_DEPTCD</td>"
					+ "<td title='" + glbDeptcd + "' class='";
				if (UserinfoCompare(glbDeptcd, "department")) html += "center";
				else html += "df";
				html += "'>" + glbDeptcd + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>COUNTRY_CD</td>"
					+ "<td title='" + countryCd + "' class='";
				if (UserinfoCompare(countryCd, "country")) html += "center";
				else html += "df";
				html += "'>" + countryCd + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>GLB_EMPNO</td>"
					+ "<td title='" + glbEmpno + "' class='";
				if (UserinfoCompare(glbEmpno, "employeeNumber")) html += "center";
				else html += "df";
				html += "'>" + glbEmpno + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>EMP_TYPE</td>"
					+ "<td title='" + empType + "' class='";
				if (UserinfoCompare(empType, "employeeType")) html += "center";
				else html += "df";
				html += "'>" + empType + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>FAX</td>"
					+ "<td title='" + fax + "' class='";
				if (UserinfoCompare(fax, "fax")) html += "center";
				else html += "df";
				html += "'>" + fax + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>FIRST_NM</td>"
					+ "<td title='" + firstNm + "' class='";
				if (UserinfoCompare(firstNm, "firstName")) html += "center";
				else html += "df";
				html += "'>" + firstNm + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>MIDDLE_NM</td>"
					+ "<td title='" + middleNm + "' class='";
				if (UserinfoCompare(middleNm, "middleName")) html += "center";
				else html += "df";
				html += "'>" + middleNm + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>LAST_NM</td>"
					+ "<td title='" + lastNm + "' class='";
				if (UserinfoCompare(lastNm, "lastName")) html += "center";
				else html += "df";
				html += "'>" + lastNm + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>ECNY_DE</td>"
					+ "<td title='" + ecnyDe + "' class='";
				if (UserinfoCompare(ecnyDe, "activationDate")) html += "center";
				else html += "df";
				html += "'>" + ecnyDe + "</td>"
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
				/*	+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td class='center'>RETIRE_DE</td>"
					+ "<td title='" + retireDe + "' class='";
				if (UserinfoCompare(retireDe, "expirationDate")) html += "center";
				else html += "df";
				html += "'>" + retireDe + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>REPORTTO</td>"
					+ "<td title='" + reportto + "' class='";
				if (UserinfoCompare(reportto, "managerId")) html += "center";
				else html += "df";
				html += "'>" + reportto + "</td>"
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
					+ "<td class='center'>PLANT_CD</td>"
					+ "<td title='" + plantCd + "' class='";
				if (UserinfoCompare(plantCd, "officePlantCode")) html += "center";
				else html += "df";
				html += "'>" + plantCd + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>LCL_EMPNO</td>"
					+ "<td title='" + lclEmpno + "' class='";
				if (UserinfoCompare(lclEmpno, "localEmpNo")) html += "center";
				else html += "df";
				html += "'>" + lclEmpno + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>WORK_ZIPCODE</td>"
					+ "<td title='" + workZipcode + "' class='";
				if (UserinfoCompare(workZipcode, "zip")) html += "center";
				else html += "df";
				html += "'>" + workZipcode + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>DUAL_REPORTTO1</td>"
					+ "<td title='" + dualReportto1 + "' class='";
				if (UserinfoCompare(dualReportto1, "matrixManager")) html += "center";
				else html += "df";
				html += "'>" + dualReportto1 + "</td>"
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
					+ "<td class='center'>BUILDING_CD</td>"
					+ "<td title='" + buildingCd + "' class='";
				if (UserinfoCompare(buildingCd, "buildingCode")) html += "center";
				else html += "df";
				html += "'>" + buildingCd + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td class='center'>WORK_ADRES</td>"
					+ "<td title='" + workAdres + "' class='";
				if (UserinfoCompare(workAdres, "address")) html += "center";
				else html += "df";
				html += "'>" + workAdres + "</td>"
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
					+ "<td class='center'>REGION_NM</td>"
					+ "<td title='" + regionNm + "' class='";
				if (UserinfoCompare(regionNm, "region")) html += "center";
				else html += "df";
				html += "'>" + regionNm + "</td>"
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
					+ "<td class='center'>LOCAL_LSTNM</td>"
					+ "<td title='" + localLstnm + "' class='";
				if (UserinfoCompare(localLstnm, "localLastName")) html += "center";
				else html += "df";
				html += "'>" + localLstnm + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>LOCAL_FSTNM</td>"
					+ "<td title='" + localFstnm + "' class='";
				if (UserinfoCompare(localFstnm, "localFirstName")) html += "center";
				else html += "df";
				html += "'>" + localFstnm + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>LCL_DEPTCD</td>"
					+ "<td title='" + lclDeptcd + "' class='";
				if (UserinfoCompare(lclDeptcd, "localDepartmentCode")) html += "center";
				else html += "df";
				html += "'>" + lclDeptcd + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>JOB_DESC</td>"
					+ "<td title='" + jobDesc + "' class='";
				if (UserinfoCompare(jobDesc, "jobDescription")) html += "center";
				else html += "df";
				html += "'>" + jobDesc + "</td>"
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
					+ "<td class='center'>K_COMP_GB</td>"
					+ "<td title='" + kCompGb + "' class='";
				if (UserinfoCompare(kCompGb, "workPlaceK")) html += "center";
				else html += "df";
				html += "'>" + kCompGb + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>K_COMP_NM</td>"
					+ "<td title='" + kCompNm + "' class='";
				if (UserinfoCompare(kCompNm, "workPlaceNameK")) html += "center";
				else html += "df";
				html += "'>" + kCompNm + "</td>"
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
					+ "<td class='center'>K_COST_CD</td>"
					+ "<td title='" + kCostCd + "' class='";
				if (UserinfoCompare(kCostCd, "costCenterCodeK")) html += "center";
				else html += "df";
				html += "'>" + kCostCd + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>K_JGUP_CD</td>"
					+ "<td title='" + kJgupCd + "' class='";
				if (UserinfoCompare(kJgupCd, "positionK")) html += "center";
				else html += "df";
				html += "'>" + kJgupCd + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>JGUP</td>"
					+ "<td title='" + jgup + "' class='";
				if (UserinfoCompare(jgup, "positionNameK")) html += "center";
				else html += "df";
				html += "'>" + jgup + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>K_JGUP_CNT</td>"
					+ "<td title='" + kJgupCnt + "' class='";
				if (UserinfoCompare(kJgupCnt, "yearlyPositionK")) html += "center";
				else html += "df";
				html += "'>" + kJgupCnt + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>LCL_POSTITLE</td>"
					+ "<td title='" + lclPostitle + "' class='";
				if (UserinfoCompare(lclPostitle, "jobTitleK")) html += "center";
				else html += "df";
				html += "'>" + lclPostitle + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>LCL_POSTITLE_NM</td>"
					+ "<td title='" + lclPostitleNm + "' class='";
				if (UserinfoCompare(lclPostitleNm, "jobTitleNameK")) html += "center";
				else html += "df";
				html += "'>" + lclPostitleNm + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>K_JGUN_CD</td>"
					+ "<td title='" + kJgunCd + "' class='";
				if (UserinfoCompare(kJgunCd, "jobGroupK")) html += "center";
				else html += "df";
				html += "'>" + kJgunCd + "</td>"
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
					+ "<td class='center'>PLANT_NM</td>"
					+ "<td title='" + plantNm + "' class='";
				if (UserinfoCompare(plantNm, "city")) html += "center";
				else html += "df";
				html += "'>" + plantNm + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>EMAIL</td>"
					+ "<td title='" + email + "' class='";
				if (UserinfoCompare(email, "primaryEmail")) html += "center";
				else html += "df";
				html += "'>" + email + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>MOBL_PHONE</td>"
					+ "<td title='" + moblPhone + "' class='";
				if (UserinfoCompare(moblPhone, "mobilePphone")) html += "center";
				else html += "df";
				html += "'>" + moblPhone + "</td>"
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
					+ "</tr>";


				$('#PotalUserInfoDiv').append(html);
				$('#PotalStatus').html('');
				if (useAt.toUpperCase() == 'N' || useAt == '') {
					var today = new Date();
					if (retireDe <= today) {
						html = "<th scope='col' colspan='2'>"
							+ "Status:  <span style='color:#F73738;'>Inactive </span>"
							+ "</th>";
					}
				} else {
					html = "<th scope='col' colspan='2'>"
						+ "Status:  Active"
						+ "</th>";
				}
				$('#PotalStatus').append(html);
				drawIMUserStore()
			} else {
				$('#PotalStatus').html('');
				html = "<th scope='col' colspan='2'>"
					+ "Status:  <span style='color:#F73738;'>User not found </span>"
					+ "</th>";
				$('#PotalStatus').append(html);
				$('#PotalUserInfoDiv').append("<tr><td colspan='2' style='text-align:center !important;' class='center'><spring:message code='alert.result.1' text='User not found' /></td></tr>");
			}
			$("#btnHanonPortal").html('Reload');
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
				<th scope="col" style="white-space: nowrap !important;">Hanon Portal</th>
				<th scope="col" style="padding:3px 10px 4px 5px; width:15%;text-align:right;">
					<button id='btnHanonPortal' onclick="getPotalUserInfo()"> View </button>
				</th>
			</tr>
			<tr id="PotalStatus">
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
		<tbody id=PotalUserInfoDiv></tbody>
	</table>
</body>

</html>