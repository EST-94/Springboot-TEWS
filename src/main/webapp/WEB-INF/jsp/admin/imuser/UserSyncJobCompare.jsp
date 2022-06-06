<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
	<title>Hanon Systems Administrator Page
		<spring:message code="lnb.IU.VU.UD.USJH.USJD" text="User Sync Job Detail" />
	</title>
	<!-- (paging) -->
	<jsp:include page="UserCompareM365.jsp" flush="false" />
	<jsp:include page="UserCompareGlobal.jsp" flush="false" />
	<jsp:include page="UserCompareKoreaEmp.jsp" flush="false" />
	<jsp:include page="UserCompareKoreaOrg.jsp" flush="false" />
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
			$(".IM-User").addClass("on");
			$(".IM-User").find(" > ul").show();
			$(".viewuser > a").addClass("highlight");
			// 사용자 목록 표시

			getBatchJobCompare();
			//	getBatchJobHistory();
			//	drawBatchJobHistory(1);			// default: 기본 사용자 조회 없음
		}

		/**
		 * 배치 상세 조회
		 *
		 * @since 1.0, 2021-12-14
		 */
		function getBatchJobCompare() {

			var params = {};

			params.JobName = '${batchJobDetailsVO.jobName}';
			params.ExecuteSeq = '${batchJobDetailsVO.executeSeq}';
			params.ExecuteDate = '${batchJobDetailsVO.executeDate}';
			params.UserId = '${batchJobDetailsVO.userId}'

			// 배치 조회 시작
			$.ajax({
				url: '/admin/batch/getBatchJobCompare.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					//	console.log("SUCCESS");
					//	console.log(data);
					saveBatchJobDetails(data);
				}
				, error: function (data) {
					//	console.log("ERROR");
					//	console.log(data);
				}
			});
		}


		var batchJobDetailsAfter;
		var batchJobDetailsBefore;
		var pageObj;
		/**
		 * 배치 목록 저장 및 페이징 처리
		 * @param data		{@link ReturnBatchJobInfo} List of BatchJobInfo 
		 * @since 2.2, 2018-07-07
		 */
		function saveBatchJobDetails(data) {

			if ($('batchJobDetailsVO', data).length > 0 && $('batchJobDetailsBeforeVO', data).length > 0) {
				if ('${batchJobDetailsVO.jobName}' == 'Office365CustomAttrSyncJobNew') {
					drawM365(data);
				} else if ('${batchJobDetailsVO.jobName}' == 'GlobalHREmpSyncJob') {
					drawGlobal(data);
				} else if ('${batchJobDetailsVO.jobName}' == 'KoreaHREmpSyncJob') {
					drawKoreaEmp(data)
				} else if ('${batchJobDetailsVO.jobName}' == 'KoreaHROrgChartSyncJob') {
					drawKoreaOrg(data)
				}
			} else {
				$('#batchJobDetailsDiv').append("<tr><td colspan='4' class='center'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
			}


		}

		function goList() {
			var form = document.createElement('form');
			var obj = document.createElement('input');
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "urid");
			obj.setAttribute("value", "${batchJobDetailsVO.userId}");

			var obj1 = document.createElement('input');
			obj1.setAttribute("type", "hidden");
			obj1.setAttribute("name", "contentViewUser");
			obj1.setAttribute("value", '${contentViewUser}');

			var obj2 = document.createElement('input');
			obj2.setAttribute("type", "hidden");
			obj2.setAttribute("name", "titleViewUser");
			obj2.setAttribute("value", '${titleViewUser}');
			
			var obj3 = document.createElement('input');
			obj3.setAttribute("type", "hidden");
			obj3.setAttribute("name", "emp_status");
			obj3.setAttribute("value", '${emp_status}');

			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "ViewUserPageNo");
			obj4.setAttribute("value", '${ViewUserPageNo}');

			var obj5 = document.createElement('input');
			obj5.setAttribute("type", "hidden");
			obj5.setAttribute("name", "userSyncStDt");
			obj5.setAttribute("value", '${userSyncStDt}');

			var obj6 = document.createElement('input');
			obj6.setAttribute("type", "hidden");
			obj6.setAttribute("name", "userSyncEdDt");
			obj6.setAttribute("value", '${userSyncEdDt}');

			var obj7 = document.createElement('input');
			obj7.setAttribute("type", "hidden");
			obj7.setAttribute("name", "syncjobJobName");
			obj7.setAttribute("value", '${syncjobJobName}');
			
			var obj8 = document.createElement('input');
			obj8.setAttribute("type", "hidden");
			obj8.setAttribute("name", "syncjobPageNo");
			obj8.setAttribute("value", '${syncjobPageNo}');

			form.appendChild(obj);
			form.appendChild(obj1);
			form.appendChild(obj2);
			form.appendChild(obj3);
			form.appendChild(obj4);
			form.appendChild(obj5);
			form.appendChild(obj6);
			form.appendChild(obj7);
			form.appendChild(obj8);

			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/imuser/UserSyncJobHistory.do');

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
						<spring:message code="lnb.IU.VU.UD.USJH.USJD" text="User Sync Job Detail" />
					</h3>

					<p class="page_navigation">
						<strong>
							<spring:message code="lnb.IU.VU.UD.USJH.USJD" text="User Sync Job Detail" />
						</strong> <span>
							<spring:message code="lnb.IU.VU.UD.USJH" text="User Sync Job History" />
						</span> <span>
							<spring:message code="lnb.IU.VU.UD" text="User Details" />
						</span> <span>
							<spring:message code="lnb.IU.VU" text="View User" />
						</span> <span>
							<spring:message code="lnb.IU" text="IM User Management" />
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
								<td scope="col" style="background: #FFFFFF;">${batchJobDetailsVO.jobName}</td>
								<th scope="col">
									<spring:message code="label.executionNo" text="Execution No." />
								</th>
								<td scope="col" style="background: #FFFFFF;">${batchJobDetailsVO.executeSeq}</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.syncType" text="Sync Type" />
								</th>
								<td scope="col" style="background: #FFFFFF;">
									<c:choose>
										<c:when test="${batchJobDetailsVO.syncType eq 'C'}"> New </c:when>
										<c:when test="${batchJobDetailsVO.syncType eq 'U'}"> Update </c:when>
										<c:when test="${batchJobDetailsVO.syncType eq 'D'}"> Terminate </c:when>
										<c:when test="${batchJobDetailsVO.syncType eq 'R'}"> Rehire </c:when>
										<c:otherwise> ${batchJobDetailsVO.syncType} </c:otherwise>
									</c:choose>
								</td>
								<th scope="col">
									<spring:message code="label.excutionDateAndTime" text="Execution Date and Time" />
								</th>
								<td scope="col" style="background: #FFFFFF;">${batchJobDetailsVO.executeStartDatetime}
								</td>
							</tr>
							<tr>
								<th scope="col" style="vertical-align: middle;">
									<spring:message code="label.syncResult" text="Sync Result (Error Message)" />
								</th>

								<c:choose>
									<c:when test="${batchJobDetailsVO.syncResult eq 'S'}">
										<td colspan="3" style="background: #FFFFFF;">Success</td>
									</c:when>
									<c:when test="${batchJobDetailsVO.syncResult eq 'F'}">
										<td colspan="3" style="background: #FFFFFF;"><span style="color: #FF5757;"> Fail
												<br>
											</span> Error result : ${batchJobDetailsVO.resultMessage}</td>
									</c:when>
									<c:otherwise>
										<td colspan="3" style="background: #FFFFFF;">${batchJobDetailsVO.syncResult}
										</td>
									</c:otherwise>
								</c:choose>

							</tr>
						</thead>
						<!-- Batch Job 목록 가져오기 Display Start-->
						<tbody id="batchJobHistoryDiv"></tbody>
						<!-- Batch Job 목록 가져오기 Display End-->
					</table>

					<input type="hidden" name="batchJobDetailsCnt" id="batchJobDetailsCnt" value="">
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
								<th scope="col" colspan="2" style="background: #003a5d; color: #FFFFFF;">
									<spring:message code="page.Before" text="Before" />
								</th>
								<th scope="col" colspan="2" style="background: #003a5d; color: #FFFFFF;">
									<spring:message code="label.After" text="After" />
								</th>
							</tr>
						</thead>
						<!-- Batch Job 목록 가져오기 Display Start-->
						<tbody id="batchJobDetailsDiv"></tbody>
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
		text-align: left;
		color: #003a5d;
		padding: 3px 0px 4px 5px;
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
		border-top: 1px solid #BDC6D2;
		border-bottom: 1px solid #BDC6D2;
		border-collapse: collapse;
		font-weight: bold;
		height: 13px;
		vertical-align: middle;
		padding: 3px 0px 4px 5px;
	}

	.board_01 tbody tr td {
		background: #FFFFFF;
		text-align: left;
		color: #003a5d;
		border-top: 1px solid #BDC6D2;
		border-bottom: 1px solid #BDC6D2 !important;
		border-collapse: collapse;
		height: 13px;
		vertical-align: middle;
	}

	.df {
		background: #fdeada !important;
	}

	.non {
		background: #D9D9D9 !important;
	}

	.layer_pop {
		position: absolute;
	}

	.nodeSel {
		font-weight: bold;
	}
</style>

</html>