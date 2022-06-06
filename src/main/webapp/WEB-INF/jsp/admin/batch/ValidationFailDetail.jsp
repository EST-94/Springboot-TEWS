<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
	<title>Hanon Systems Administrator Page
		<spring:message code="lnb.BATCH.BJH.BJD.VFL.VFD" text="Validation Fail Detail" />
	</title>
	<!-- (paging) -->
	<script type="text/javascript">

		$(document).ready(function () {
			init();
			// Calendar 적용
			$("#reg_EntranceDate").datepicker({ dateFormat: 'yymmdd' });
			//검색 EnterKey 적용
			$("#reportToName").on('keypress', function (e) {
				if (e.which == 13) { reportSearch('search'); }
			});
			$('#contents input[name=content]').on('keypress', function (e) {
				if (e.which == 13) { getBatchJobHistory(); }
			});
		});

		function init() {
			//left_menu 펼쳐 놓기
			$(".Batch").addClass("on");
			$(".Batch").find(" > ul").show();
			$(".batchJobHistory > a").addClass("highlight");

			getValidationFailDetail();
			//   getBatchJobDetails();
			//	getBatchJobHistory();
			//	drawBatchJobHistory(1);			// default: 기본 사용자 조회 없음
		}

		/**
		 * 배치 상세 조회
		 *
		 * @since 1.0, 2021-12-14
		 */
		function getValidationFailDetail() {

			var params = {};

			params.JobName = '${ValidationFailList.jobName}';
			params.ExecuteSeq = '${ValidationFailList.executeSeq}';
			params.ExecuteDate = '${ValidationFailList.executeDate}';
			params.UserId = '${ValidationFailList.userid}';

			// 배치 조회 시작
			$.ajax({
				url: '/admin/batch/getValidationFailDetail.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					//	console.log("SUCCESS");
					//	console.log(data);
					saveValidationFailDetail(data);
				}
				, error: function (data) {
					//	console.log("ERROR");
					//	console.log(data);
				}
			});
		}


		var ValidationFailDetail;
		var pageObj;
		/**
		 * 배치 목록 저장 및 페이징 처리
		 * @param data		{@link ReturnBatchJobInfo} List of BatchJobInfo 
		 * @since 2.2, 2018-07-07
		 */
		function saveValidationFailDetail(data) {
			if ($('result', data) != null) {

				$('result', data).each(function () {
					odataSeq = $('odataSeq', this).text();
					createDatetime = $('createDatetime', this).text();
					status = $('status', this).text();
					userid = $('userid', this).text();
					username = $('username', this).text();
					firstname = $('firstname', this).text();
					nickname = $('nickname', this).text();
					mi = $('mi', this).text();
					lastname = $('lastname', this).text();
					suffix = $('suffix', this).text();
					title = $('title', this).text();
					gender = $('gender', this).text();
					email = $('email', this).text();
					manager = $('manager', this).text();
					hr = $('hr', this).text();
					department = $('department', this).text();
					jobcode = $('jobcode', this).text();
					division = $('division', this).text();
					timezone = $('timezone', this).text();
					hiredate = $('hiredate', this).text();
					empid = $('empid', this).text();
					bizPhone = $('bizPhone', this).text();
					fax = $('fax', this).text();
					addr1 = $('addr1', this).text();
					addr2 = $('addr2', this).text();
					city = $('city', this).text();
					state = $('state', this).text();
					zip = $('zip', this).text();
					country = $('country', this).text();
					matrixManager = $('matrixManager', this).text();
					defaultLocale = $('defaultLocale', this).text();
					proxy = $('proxy', this).text();
					seatingchart = $('seatingchart', this).text();
					reviewFreq = $('reviewFreq', this).text();
					lastReviewDate = $('lastReviewDate', this).text();
					custom01 = $('custom01', this).text();
					custom02 = $('custom02', this).text();
					custom03 = $('custom03', this).text();
					custom04 = $('custom04', this).text();
					custom05 = $('custom05', this).text();
					custom06 = $('custom06', this).text();
					custom07 = $('custom07', this).text();
					custom08 = $('custom08', this).text();
					custom09 = $('custom09', this).text();
					custom10 = $('custom10', this).text();
					custom11 = $('custom11', this).text();
					custom12 = $('custom12', this).text();
					custom13 = $('custom13', this).text();
					custom14 = $('custom14', this).text();
					custom15 = $('custom15', this).text();
					romFirstname = $('romFirstname', this).text();
					romLastname = $('romLastname', this).text();


					jobName = $('jobName', this).text();
					executeSeq = $('executeSeq', this).text();
					executeDate = $('executeDate', this).text();

				});
				$('#ValidationFailDetailDiv').html('');
				html = "<tr>"
					+ "<th>ODATA_SEQ</th>"
					+ "<td>" + odataSeq + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CREATE_DATETIME</th>"
					+ "<td>" + createDatetime + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>STATUS</th>"
					+ "<td>" + status + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>USERID</th>"
					+ "<td>" + userid + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>USERNAME</th>"
					+ "<td>" + username + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>FIRSTNAME</th>"
					+ "<td>" + firstname + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>NICKNAME</th>"
					+ "<td>" + nickname + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>MI</th>"
					+ "<td>" + mi + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>LASTNAME</th>"
					+ "<td>" + lastname + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>SUFFIX</th>"
					+ "<td>" + suffix + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>TITLE</th>"
					+ "<td>" + title + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>GENDER</th>"
					+ "<td>" + gender + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>EMAIL</th>"
					+ "<td>" + email + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>MANAGER</th>"
					+ "<td>" + manager + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>HR</th>"
					+ "<td>" + hr + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>DEPARTMENT</th>"
					+ "<td>" + department + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>JOBCODE</th>"
					+ "<td>" + jobcode + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>DIVISION</th>"
					+ "<td>" + division + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>TIMEZONE</th>"
					+ "<td>" + timezone + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>HIREDATE</th>"
					+ "<td>" + hiredate + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>EMPID</th>"
					+ "<td>" + empid + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>BIZ_PHONE</th>"
					+ "<td>" + bizPhone + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>FAX</th>"
					+ "<td>" + fax + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>ADDR1</th>"
					+ "<td>" + addr1 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>ADDR2</th>"
					+ "<td>" + addr2 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CITY</th>"
					+ "<td>" + city + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>STATE</th>"
					+ "<td>" + state + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>ZIP</th>"
					+ "<td>" + zip + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>COUNTRY</th>"
					+ "<td>" + country + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>MATRIX_MANAGER</th>"
					+ "<td>" + matrixManager + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>DEFAULT_LOCALE</th>"
					+ "<td>" + defaultLocale + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>PROXY</th>"
					+ "<td>" + proxy + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>SEATINGCHART</th>"
					+ "<td>" + seatingchart + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>REVIEW_FREQ</th>"
					+ "<td>" + reviewFreq + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>LAST_REVIEW_DATE</th>"
					+ "<td>" + lastReviewDate + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM01</th>"
					+ "<td>" + custom01 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM02</th>"
					+ "<td>" + custom02 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM03</th>"
					+ "<td>" + custom03 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM04</th>"
					+ "<td>" + custom04 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM05</th>"
					+ "<td>" + custom05 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM06</th>"
					+ "<td>" + custom06 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM07</th>"
					+ "<td>" + custom07 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM08</th>"
					+ "<td>" + custom08 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM09</th>"
					+ "<td>" + custom09 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM10</th>"
					+ "<td>" + custom10 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM11</th>"
					+ "<td>" + custom11 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM12</th>"
					+ "<td>" + custom12 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM13</th>"
					+ "<td>" + custom13 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM14</th>"
					+ "<td>" + custom14 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>CUSTOM15</th>"
					+ "<td>" + custom15 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>ROM_FIRSTNAME</th>"
					+ "<td>" + romFirstname + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<th>ROM_LASTNAME</th>"
					+ "<td>" + romLastname


				$('#ValidationFailDetailDiv').append(html);
			} else {
				$('#ValidationFailDetailDiv').append("<tr><td colspan='2' class='center'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
			}
		}

		function goList() {
			var form = document.createElement('form');
			var obj1 = document.createElement('input');
			obj1.setAttribute("type", "hidden");
			obj1.setAttribute("name", "JobName");
			obj1.setAttribute("value", '${ValidationFailList.jobName}');

			var obj2 = document.createElement('input');
			obj2.setAttribute("type", "hidden");
			obj2.setAttribute("name", "ExecuteDate");
			obj2.setAttribute("value", '${ValidationFailList.executeDate}');

			var obj3 = document.createElement('input');
			obj3.setAttribute("type", "hidden");
			obj3.setAttribute("name", "ExecuteSeq");
			obj3.setAttribute("value", '${ValidationFailList.executeSeq}');

			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "contentVali");
			obj4.setAttribute("value", '${contentVali}');
			
			var obj5 = document.createElement('input');
			obj5.setAttribute("type", "hidden");
			obj5.setAttribute("name", "titleVali");
			obj5.setAttribute("value", '${titleVali}');

			var obj6 = document.createElement('input');
			obj6.setAttribute("type", "hidden");
			obj6.setAttribute("name", "content");
			obj6.setAttribute("value", '${content}');

			var obj7 = document.createElement('input');
			obj7.setAttribute("type", "hidden");
			obj7.setAttribute("name", "title");
			obj7.setAttribute("value", '${title}');

			var obj8 = document.createElement('input');
			obj8.setAttribute("type", "hidden");
			obj8.setAttribute("name", "syncResult");
			obj8.setAttribute("value", '${syncResult}');

			var obj9 = document.createElement('input');
			obj9.setAttribute("type", "hidden");
			obj9.setAttribute("name", "syncType");
			obj9.setAttribute("value", '${syncType}');

			var obj10 = document.createElement('input');
			obj10.setAttribute("type", "hidden");
			obj10.setAttribute("name", "jobDetailPageNo");
			obj10.setAttribute("value", '${jobDetailPageNo}');

			var obj11 = document.createElement('input');
			obj11.setAttribute("type", "hidden");
			obj11.setAttribute("name", "FailListPageNo");
			obj11.setAttribute("value", '${FailListPageNo}');

			var obj12 = document.createElement('input');
			obj12.setAttribute("type", "hidden");
			obj12.setAttribute("name", "jobHistoryStDt");
			obj12.setAttribute("value", '${jobHistoryStDt}');

			var obj13 = document.createElement('input');
			obj13.setAttribute("type", "hidden");
			obj13.setAttribute("name", "jobHistoryEdDt");
			obj13.setAttribute("value", '${jobHistoryEdDt}');

			var obj14 = document.createElement('input');
			obj14.setAttribute("type", "hidden");
			obj14.setAttribute("name", "jobHistoryJobName");
			obj14.setAttribute("value", '${jobHistoryJobName}');
			
			var obj15 = document.createElement('input');
			obj15.setAttribute("type", "hidden");
			obj15.setAttribute("name", "jobHistoryPageNo");
			obj15.setAttribute("value", '${jobHistoryPageNo}');

			form.appendChild(obj1);
			form.appendChild(obj2);
			form.appendChild(obj3);
			form.appendChild(obj4);
			form.appendChild(obj5);
			form.appendChild(obj6);
			form.appendChild(obj7);
			form.appendChild(obj8);
			form.appendChild(obj9);
			form.appendChild(obj10);
			form.appendChild(obj11);
			form.appendChild(obj12);
			form.appendChild(obj13);
			form.appendChild(obj14);
			form.appendChild(obj15);
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/batch/ValidationFailList.do');

			document.body.appendChild(form);
			form.submit();
		}
	</script>
</head>

<body class="main">

	<!-- (wrapper) -->
	<div id="wrapper">

		<!-- (header) -->
		<div id="header">
			<!-- (top_section) -->
			<div class="top_section">
				<h1>
					<a href="/admin/home.do" title="Hanon Systems Administrator Page Home"><img
							src="/images/skin/common/logo.png" alt="HOME Hanon Systems" /></a>
				</h1>
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

				<!-- (location) -->
				<div id="location">
					<h3>
						<spring:message code="lnb.BATCH.BJH.BJD.VFL.VFD" text="Validation Fail Detail" />
					</h3>

					<p class="page_navigation">
						<strong>
							<spring:message code="lnb.BATCH.BJH.BJD.VFL.VFD" text="Validation Fail Detail" />
						</strong> <span>
							<spring:message code="lnb.BATCH.BJH.BJD.VFL" text="Validation Fail List" />
						</span> <span>
							<spring:message code="lnb.BATCH.BJH.BJD" text="Batch Job Details" />
						</span> <span>
							<spring:message code="lnb.BATCH.BJH" text="Batch Job History" />
						</span> <span>
							<spring:message code="lnb.BATCH" text="Batch Job Management" />
						</span> <img alt="home" src="/images/skin/common/icon_home.png">
					</p>
				</div>
				<!-- //(location) -->

				<div class="mgl_20">
					<!-- (searchbox) -->
					<div class="clear mgb_10">
						<p class="fleft pdt_5">
						<div class="right" id="searchbox">
							<button name="back_list" class="indent" onclick="goList()">
								<spring:message code="label.list" text="List" />
							</button>
						</div>
						</p>
					</div>
					<!-- //(searchbox) -->

					<!-- (board_01) -->
					<table class="board_01">
						<caption></caption>
						<colgroup>
							<col width="25%">
							<col width="25%">
							<col width="25%">
							<col width="25%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">
									<spring:message code="label.batchJob" text="batchJob" />
								</th>
								<td scope="col" style="background: #FFFFFF;">${ValidationFailList.jobName}</td>
								<th scope="col">
									<spring:message code="label.executionNo" text="Execution No." />
								</th>
								<td scope="col" style="background: #FFFFFF;">${ValidationFailList.executeSeq}</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.excutionDateAndTime" text="Execution Date and Time" />
								</th>
								<td scope="col" colspan="3" style="background: #FFFFFF;">
									${ValidationFailList.executeDate}</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.ValidationFailReason" text="Validation Fail Reason" />
								</th>
								<td colspan="3" style="background: #FFFFFF;">${ValidationFailList.invalidReason}</td>
							</tr>
						</thead>
						<!-- Batch Job 목록 가져오기 Display Start-->
						<tbody id="ValidationFailListDiv"></tbody>
						<!-- Batch Job 목록 가져오기 Display End-->
					</table>

					<input type="hidden" name="batchJobDetailsCnt" id="batchJobDetailsCnt" value="">
					<table class="board_01">
						<caption></caption>
						<colgroup>
							<col width="25%">
							<col width="75%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" colspan="2" style="background: #003a5d; color: #FFFFFF;">
									<spring:message code="page.UserDetail" text="User Detail" />
								</th>
							</tr>
						</thead>
						<!-- Batch Job 목록 가져오기 Display Start-->
						<tbody id="ValidationFailDetailDiv"></tbody>
						<!-- Batch Job 목록 가져오기 Display End-->
					</table>

					<!-- //(board_01) -->
					<div id="paginationBatchJob" class="paging"></div>

				</div>
				<!-- //(clear) -->

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

	<span class="deem" style="display: none;"></span>
	<!-- (반투명막) -->
	<div class="loadingbar" style="display: none;">
		<div class="position_loading">
			<p>
				<img src="/images/common/loading.gif" alt="" />
			</p>
			<dl>
				<dt>Certification in progress</dt>
				<dd>Once authentication is complete, go to the Portal.</dd>
			</dl>
		</div>
	</div>

</body>
<style type="text/css">
	.board_01 thead tr th {
		background: #dbeef4;
		color: #003a5d;
		padding: 3px 0px 4px 5px;
		font-weight: bold;
		text-align: left;
	}

	.board_01 thead tr td {
		background: #FFFFFF;
		color: #003a5d;
		padding: 3px 0px 4px 5px;
		text-align: left;
		border-top: 1px solid #BDC6D2;
		border-bottom: 1px solid #BDC6D2;
		border-collapse: collapse;
	}

	.board_01 tbody tr th {
		background: #dbeef4;
		text-align: left;
		color: #003a5d;
		border-top: 1px solid #e8e8e8;
		border-collapse: collapse;
		font-weight: bold;
		height: 13px;
		vertical-align: middle;
		padding: 3px 0px 4px 5px;
	}

	.board_01 tbody tr td {
		background: #FFFFFF;
		text-align: left !important;
		color: #003a5d;
		border-top: 1px solid #e8e8e8;
		border-collapse: collapse;
		height: 13px;
		vertical-align: middle;
	}

	.df {
		background: #fdeada !important;
	}

	.layer_pop {
		position: absolute;
	}

	.nodeSel {
		font-weight: bold;
	}
</style>

</html>