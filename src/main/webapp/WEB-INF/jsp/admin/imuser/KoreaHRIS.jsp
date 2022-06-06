<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<script type="text/javascript">

		$(document).ready(function () {

		});

		function getKRUserInfo() {
			$('span.deem').css('display', 'block');
			$('#loadingbar').css('display', 'block');
			var params = {};
			params.urid = '${urid}';
			// 사용자 조회 시작
			$.ajax({
				url: '/admin/imuser/getKoreaHRIS.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					//	console.log(data);
					saveKRUserInfo(data);
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


		function saveKRUserInfo(data) {
			$('#KRUserInfoDiv').html('');
			if ($(data).find('result').text() != '') {

				$('result', data).each(function () {
					ssoYn = $('ssoYn', this).text();
					guid = $('guid', this).text();
					nationCode = $('nationCode', this).text();
					nationName = $('nationName', this).text();
					entityCode = $('entityCode', this).text();
					entityName = $('entityName', this).text();
					userStatus = $('userStatus', this).text();
					lclEmpNo = $('lclEmpNo', this).text();
					glbFirstName = $('glbFirstName', this).text();
					glbLastName = $('glbLastName', this).text();
					lclFirstName = $('lclFirstName', this).text();
					lclLastName = $('lclLastName', this).text();
					kEmpGb = $('kEmpGb', this).text();
					kStatDt = $('kStatDt', this).text();
					kWorkGb = $('kWorkGb', this).text();
					kCompGb = $('kCompGb', this).text();
					kCompGbNm = $('kCompGbNm', this).text();
					enterDate = $('enterDate', this).text();
					retireDate = $('retireDate', this).text();
					kSectDeptCd = $('kSectDeptCd', this).text();
					kSectDeptNm = $('kSectDeptNm', this).text();
					kDeptCd = $('kDeptCd', this).text();
					kDeptNm = $('kDeptNm', this).text();
					kDeptEnm = $('kDeptEnm', this).text();
					kCostCd = $('kCostCd', this).text();
					kJgupCd = $('kJgupCd', this).text();
					kJgupNm = $('kJgupNm', this).text();
					kJgupOthr = $('kJgupOthr', this).text();
					kJgupCdLv = $('kJgupCdLv', this).text();
					kJgupCnt = $('kJgupCnt', this).text();
					kJgunCd = $('kJgunCd', this).text();
					kJgunNm = $('kJgunNm', this).text();
					kTtlCd = $('kTtlCd', this).text();
					kTtlCdNm = $('kTtlCdNm', this).text();
					kInTelno = $('kInTelno', this).text();
					kCarNo = $('kCarNo', this).text();
					kCarDtFr = $('kCarDtFr', this).text();
					kCarDtTo = $('kCarDtTo', this).text();
					kYrateCd = $('kYrateCd', this).text();
					cdsid = $('cdsid', this).text();
					kSex = $('kSex', this).text();
					vstnDiv = $('vstnDiv', this).text();
					vstnEmpType = $('vstnEmpType', this).text();
					bldg = $('bldg', this).text();
					kBojikCd = $('kBojikCd', this).text();
					kBojikNm = $('kBojikNm', this).text();
					kJobDesc = $('kJobDesc', this).text();
				});

				html = "<tr>"
					+ "<td class='center'>CDSID</td>"
					+ "<td title='" + cdsid + "' class='";
				if (UserinfoCompare(cdsid, "userId")) html += "center";
				else html += "df";
				html += "'>" + cdsid + "</td>"
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
					+ "<td class='center'>LCL_EMP_NO</td>"
					+ "<td title='" + lclEmpNo + "' class='";
				if (UserinfoCompare(lclEmpNo, "localEmpNo")) html += "center";
				else html += "df";
				html += "'>" + lclEmpNo + "</td>"
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
				/*	+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
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
				/*	+ "</tr>"
					+ "<tr>"
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
					+ "<td class='center'>LCL_LAST_NAME</td>"
					+ "<td title='" + lclLastName + "' class='";
				if (UserinfoCompare(lclLastName, "localLastName")) html += "center";
				else html += "df";
				html += "'>" + lclLastName + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>LCL_FIRST_NAME</td>"
					+ "<td title='" + lclFirstName + "' class='";
				if (UserinfoCompare(lclFirstName, "localFirstName")) html += "center";
				else html += "df";
				html += "'>" + lclFirstName + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>K_DEPT_CD</td>"
					+ "<td title='" + kDeptCd + "' class='";
				if (UserinfoCompare(kDeptCd, "localDepartmentCode")) html += "center";
				else html += "df";
				html += "'>" + kDeptCd + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>K_JOB_DESC</td>"
					+ "<td title='" + kJobDesc + "' class='";
				if (UserinfoCompare(kJobDesc, "jobDescription")) html += "center";
				else html += "df";
				html += "'>" + kJobDesc + "</td>"
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
					+ "<td class='center'>K_COMP_GB_NM</td>"
					+ "<td title='" + kCompGbNm + "' class='";
				if (UserinfoCompare(kCompGbNm, "workPlaceNameK")) html += "center";
				else html += "df";
				html += "'>" + kCompGbNm + "</td>"
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
					+ "<td class='center'>K_JGUP_NM</td>"
					+ "<td title='" + kJgupNm + "' class='";
				if (UserinfoCompare(kJgupNm, "positionNameK")) html += "center";
				else html += "df";
				html += "'>" + kJgupNm + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>K_JGUP_CNT</td>"
					+ "<td title='" + kJgupCnt + "' class='";
				if (UserinfoCompare(kJgupCnt, "yearlyPositionK")) html += "center";
				else html += "df";
				html += "'>" + kJgupCnt + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>K_BOJIK_CD</td>"
					+ "<td title='" + kBojikCd + "' class='";
				if (UserinfoCompare(kBojikCd, "jobTitleK")) html += "center";
				else html += "df";
				html += "'>" + kBojikCd + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='center'>K_BOJIK_NM</td>"
					+ "<td title='" + kBojikNm + "' class='";
				if (UserinfoCompare(kBojikNm, "jobTitleNameK")) html += "center";
				else html += "df";
				html += "'>" + kBojikNm + "</td>"
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
					+ "</tr>";


				$('#KRUserInfoDiv').append(html);
				$('#KRStatus').html('');
				if (userStatus == '2' || userStatus == '') {
					var today = new Date();
					if (retireDate <= today) {
						html = "<th scope='col' colspan='2'>"
							+ "Status:  <span style='color:#F73738;'>Inactive </span>"
							+ "</th>";
					}
				} else {
					html = "<th scope='col' colspan='2'>"
						+ "Status:  Active"
						+ "</th>";
				}
				$('#KRStatus').append(html);
				drawIMUserStore()
			} else {
				$('#KRStatus').html('');
				html = "<th scope='col' colspan='2'>"
					+ "Status:  <span style='color:#F73738;'>User not found </span>"
					+ "</th>";
				$('#KRStatus').append(html);
				$('#KRUserInfoDiv').append("<tr><td colspan='2' style='text-align:center !important;' class='center'><spring:message code='alert.result.1' text='User not found' /></td></tr>");
			}
			$("#btnKoreaHR").html('Reload');
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
				<th scope="col" style="white-space: nowrap !important;">Korea HRIS</th>
				<th scope="col" style="padding:3px 10px 4px 5px; width:15%; text-align:right;">
					<button id="btnKoreaHR" onclick="getKRUserInfo()"> View </button>
				</th>
			</tr>
			<tr id="KRStatus">
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
		<tbody id=KRUserInfoDiv></tbody>
	</table>
</body>

</html>