<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
	<title>Hanon Systems Administrator Page
		<spring:message code="lnb.IU.VU.UD.USJH" text="User Sync Job History" />
	</title>
	<!-- (paging) -->
	<script type="text/javascript">
		var firstIn = true;
		var tempparam = {};
		$(document).ready(function () {
			var today = new Date();

			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);

			var dateString = year + '-' + month + '-' + day;
			$("input[name=ST_DT]").attr("placeholder", dateString);
			$("input[name=ED_DT]").attr("placeholder", dateString);

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
			getJobList();
			//getUserSyncJobHistory(1);
			//drawUserSyncJobHistory(1);			// default: 기본 사용자 조회 없음
		}

		/**
		 * 배치 목록 조회
		 *
		 * @since 1.0, 2021-12-10
		 */
		function getJobList() {

			var params = {};

			// 배치 조회 시작
			$.ajax({
				url: '/admin/batch/getBatchJobHistoryList.do'
				, type: 'post'
				, dataType: 'json'
				, data: params
				, success: function (data) {
					//		console.log(data)
					saveJobList(data);
				}
				, error: function (data) {
					//			console.log(data);
				}
			});
		}

		function dateFormat(el) {
			el.value = el.value.replace(/(\d\d\d\d)(\d\d)(\d\d)/g, '$1-$2-$3');
			if (window.event.keyCode == 13) {
				getUserSyncJobHistorySearch(1);
			}
		}

		var UserSyncJobHistory;
		var pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": 1, "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": 1} ');
		function getUserSyncJobHistorySearch(no) {
			if ($(':input[name=ST_DT]').val() != '' || $(':input[name=ED_DT]').val() != '') {
				var datatimeRegexp = /[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])/;
				if (($(':input[name=ST_DT]').val() != '' && !datatimeRegexp.test($(':input[name=ST_DT]').val())) || ($(':input[name=ED_DT]').val() != '' && !datatimeRegexp.test($(':input[name=ED_DT]').val()))) {
					alert("Please enter it according to the date format.");
					return false;
				}
			}
			
			tempparam.executeStartDateTime = $(':input[name=ST_DT]').val();
			tempparam.executeEndDateTime = $(':input[name=ED_DT]').val();
			tempparam.JobName = $("select[name=BatchJobList]").val();
			getUserSyncJobHistory(no);
		}
		/**
		 * 배치 목록 조회
		 *
		 * @since 2.3, 2018-07-07
		 */
		function getUserSyncJobHistory(no) {
			
			var params = {};
			if(!isEmpty(tempparam.executeStartDateTime)){
				params.executeStartDateTime = tempparam.executeStartDateTime;
			}else{params.executeStartDateTime=''}
			if(!isEmpty(tempparam.executeEndDateTime)){
				params.executeEndDateTime = tempparam.executeEndDateTime;
			}else{params.executeEndDateTime=''}
			if(!isEmpty(tempparam.JobName)){
				params.JobName = tempparam.JobName;
			}else{params.JobName='ALL'}
			params.UserId = '${urid}'

			if (pageObj.totalPage < no) {
				if(firstIn){
					firstIn = false;
					params.no = no;	
				}else{
					params.no = pageObj.totalPage;
				}
			} else {
				params.no = no;
			}
			// 배치 조회 시작
			$.ajax({
				url: '/admin/batch/getBatchJobDetails.do'
				, type: 'post'
				, dataType: 'json'
				, data: params
				, success: function (data) {
					//		console.log("SUCCESS");
					//		console.log(data)
					saveUserSyncJobHistory(data, no);
				}
				, error: function (data) {
					//		console.log("error");
					//		console.log(data);
				}
			});
		}

		/**
		 * 배치 목록 Select Box 저장
		 * @param data		{@link ReturnBatchJobInfo} List of BatchJobInfo 
		 * @since 1.0, 2021-12-10
		 */
		function saveJobList(data) {
			$('#JobList').html('');
			html = "<select name = 'BatchJobList' id = 'BatchJobList' onchange='SelectJob()'>"
				+ "<option value='ALL' selected='selected'>ALL</option>";
			for (var i = 0; i < data.length; i++) {
				html += "<option value= '" + data[i].JOB_NAME + "'>" + data[i].JOB_NAME + "</option>";
			}
			$('#JobList').append(html);
			if('${syncjobJobName}' != ''){
				$("select[name=BatchJobList]").val('${syncjobJobName}').prop('selected', true);
				$(':input[name=ST_DT]').val('${userSyncStDt}');
				$(':input[name=ED_DT]').val('${userSyncEdDt}');
				if('${syncjobPageNo}' == ''){
					getUserSyncJobHistorySearch(1);
					
				}else{
					getUserSyncJobHistorySearch('${syncjobPageNo}');
				}
			}else{
				getUserSyncJobHistorySearch(1);
			}
		}

		/**
		 * 배치 목록 저장 및 페이징 처리
		 * @param data		{@link ReturnBatchJobInfo} List of BatchJobInfo 
		 * @since 2.2, 2018-07-07
		 */
		function saveUserSyncJobHistory(data, no) {
			UserSyncJobHistory = new Array();
			count = data.totalCnt;

			pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": ' + count + ', "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": ' + parseInt((count - 1) / 10 + 1) + '} ');
			paginavigation("paginationBatchJob", pageObj, "getUserSyncJobHistory");
			if (count > 0) {
				$("#UserSyncJobHistoryCnt").val(count);
				for (var i = 0; i < (no * 10 > count ? count % 10 : 10); i++) {
					jobName = setNullToString(data.batchJobDetails[i].jobName).trim().replace("\u0000", "");
					userId = setNullToString(data.batchJobDetails[i].userId).trim().replace("\u0000", "");
					syncType = setNullToString(data.batchJobDetails[i].syncType).trim().replace("\u0000", "");
					executeSeq = setNullToString(data.batchJobDetails[i].executeSeq).trim().replace("\u0000", "");
					executeDate = setNullToString(data.batchJobDetails[i].executeDate).trim().replace("\u0000", "");
					executeHostName = setNullToString(data.batchJobDetails[i].executeHostName).trim().replace("\u0000", "");
					syncResult = setNullToString(data.batchJobDetails[i].syncResult).trim().replace("\u0000", "");
					executeStartDatetime = setNullToString(data.batchJobDetails[i].executeStartDatetime).trim().replace("\u0000", "");
					resultMessage = setNullToString(data.batchJobDetails[i].resultMessage).trim().replace("\u0000", "");

					var JsonString = '{"syncType": "' + syncType + '", "executeDate": "' + executeDate + '", "executeSeq": "' + executeSeq + '", "executeHostName": "' + executeHostName + '", "jobName": "' + jobName + '", "syncResult": "' + syncResult + '", "userId": "' + userId + '", "executeStartDatetime": "' + executeStartDatetime + '", "resultMessage": "' + resultMessage + '"} ';
					JsonString = JsonString.replace(/\\/gi, "/");
					itemObj = $.parseJSON(JsonString);
					UserSyncJobHistory.push(itemObj);
				}
			}
			drawUserSyncJobHistory(no);
		}

		/**
		 * 배치 목록 그리기
		 * @param no		(int) page number 
		 * @since 2.2, 2018-07-07
		 */
		function drawUserSyncJobHistory(no) {
			$('#UserSyncJobHistoryDiv').html('');

			if ($.isEmptyObject(UserSyncJobHistory)) {
				pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": 1, "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": 1} ');
				$('#UserSyncJobHistoryDiv').append("<tr><td colspan='10' class='center' style='text-align:center !important;'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
				$('#paginationBatchJob').text('');
			} else {
				no = (1 < no) ? no : 1;		// check min-page
				no = (no < pageObj.totalPage) ? no : pageObj.totalPage;	// check Max-page
				pageObj.nowPage = no;
				pageObj.startPage = parseInt((no - 1) / pageObj.blockPage) * pageObj.blockPage + 1;
				pageObj.prevPage = pageObj.blockList < pageObj.startPage;

				endPage = pageObj.startPage + pageObj.blockPage - 1;
				pageObj.endPage = (endPage < pageObj.totalPage) ? endPage : pageObj.totalPage;
				pageObj.nextPage = endPage < pageObj.totalPage;

				pageObj.startRow = (pageObj.nowPage - 1) * pageObj.blockList + 1;
				endRow = pageObj.nowPage * pageObj.blockList;
				pageObj.endRow = (pageObj.rowTotal < endRow) ? pageObj.rowTotal : endRow;

				paginavigation("paginationBatchJob", pageObj, "getUserSyncJobHistory");

				for (var i = 0; i < (pageObj.endRow % 10 == 0 ? 10 : pageObj.endRow % 10); i++) {
					jobName = UserSyncJobHistory[i].jobName;
					executeSeq = UserSyncJobHistory[i].executeSeq;
					executeDate = UserSyncJobHistory[i].executeDate;
					executeHostName = UserSyncJobHistory[i].executeHostName;

					if (UserSyncJobHistory[i].syncType == "C") { syncType = "New"; }
					else if (UserSyncJobHistory[i].syncType == "U") { syncType = "Update" }
					else if (UserSyncJobHistory[i].syncType == "D") { syncType = "Terminate" }
					else if (UserSyncJobHistory[i].syncType == "R") { syncType = "Rehire" }
					else { syncType = UserSyncJobHistory[i].syncType; }

					if (UserSyncJobHistory[i].syncResult == "S") { syncResult = "Success"; }
					else if (UserSyncJobHistory[i].syncResult == "F") { syncResult = "Fail" }
					else { syncResult = UserSyncJobHistory[i].syncResult; }

					html = "<tr onclick='javascript:goUserSyncJobCompare(\"" + i + "\")'>"
						+ "<td class='center'>" + jobName + "</td>"
						+ "<td class='center' style='text-align:center !important;'>" + executeSeq + "</td>"
						+ "<td class='center' style='text-align:center !important;'>" + executeDate + "</td>"
						+ "<td class='center'>" + executeHostName + "</td>"
						+ "<td class='center'>" + syncType + "</td>";
					if (syncResult == 'S' || syncResult.toUpperCase() == 'SUCCESS') {
						html += "<td class='center'>Success</td>";
					} else if (syncResult == 'F' || syncResult.toUpperCase() == 'FAIL') {
						html += "<td class='center'style='color:#FF5757;'>Fail</td>";
					} else {
						html += "<td class='center'>" + syncResult + "</td>";
					}
					html += "</tr>";


					$('#UserSyncJobHistoryDiv').append(html);
				}
			}
		}

		/**
		 * 배치 상세 보기 페이지 이동
		 * @param 
		 * @since 1.0, 2021-12-13
		 */
		function goUserSyncJobCompare(no) {
			var form = document.createElement('form');
			var obj1 = document.createElement('input');
			obj1.setAttribute("type", "hidden");
			obj1.setAttribute("name", "UserSyncJobHistory");
			obj1.setAttribute("value", JSON.stringify(UserSyncJobHistory[no]));
			
			var obj2 = document.createElement('input');
			obj2.setAttribute("type", "hidden");
			obj2.setAttribute("name", "userSyncStDt");
			obj2.setAttribute("value", tempparam.executeStartDateTime);

			var obj3 = document.createElement('input');
			obj3.setAttribute("type", "hidden");
			obj3.setAttribute("name", "userSyncEdDt");
			obj3.setAttribute("value", tempparam.executeEndDateTime);

			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "syncjobJobName");
			obj4.setAttribute("value", tempparam.JobName);
			
			var obj5 = document.createElement('input');
			obj5.setAttribute("type", "hidden");
			obj5.setAttribute("name", "syncjobPageNo");
			obj5.setAttribute("value", pageObj.nowPage);

			var obj6 = document.createElement('input');
			obj6.setAttribute("type", "hidden");
			obj6.setAttribute("name", "contentViewUser");
			obj6.setAttribute("value", '${contentViewUser}');

			var obj7 = document.createElement('input');
			obj7.setAttribute("type", "hidden");
			obj7.setAttribute("name", "titleViewUser");
			obj7.setAttribute("value", '${titleViewUser}');
			
			var obj8 = document.createElement('input');
			obj8.setAttribute("type", "hidden");
			obj8.setAttribute("name", "emp_status");
			obj8.setAttribute("value", '${emp_status}');

			var obj9 = document.createElement('input');
			obj9.setAttribute("type", "hidden");
			obj9.setAttribute("name", "ViewUserPageNo");
			obj9.setAttribute("value", '${ViewUserPageNo}');

			form.appendChild(obj1);
			form.appendChild(obj2);
			form.appendChild(obj3);
			form.appendChild(obj4);
			form.appendChild(obj5);
			form.appendChild(obj6);
			form.appendChild(obj7);
			form.appendChild(obj8);
			form.appendChild(obj9);
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/imuser/UserSyncJobCompare.do');

			document.body.appendChild(form);
			form.submit();
		}
		function goList() {
			var form = document.createElement('form');
			var obj = document.createElement('input');
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "urid");
			obj.setAttribute("value", "${urid}");

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

			form.appendChild(obj);
			form.appendChild(obj1);
			form.appendChild(obj2);
			form.appendChild(obj3);
			form.appendChild(obj4);
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/imuser/ImUserDetails.do');

			document.body.appendChild(form);
			form.submit();
		}

		function SelectJob() {
			document.getElementById("ED_DT").value = '';
			document.getElementById("ST_DT").value = '';
			getUserSyncJobHistorySearch(1);
		}
	</script>
</head>

<body id="body" class="main">

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
						<spring:message code="lnb.IU.VU.UD.USJH" text="User Sync Job History" />
					</h3>

					<p class="page_navigation">
						<strong>
							<spring:message code="lnb.IU.VU.UD.USJH" text="User Sync Job History" />
						</strong> <span>
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
						<div class="left" style="float: left; width: 50%">
							<div class="regionbox">
								<span class="region_txt"> Batch Job </span> <span id="JobList"></span>
							</div>
						</div>
						<div class="right" id="searchbox">
							<div class="regionbox" style="float: right;">
								<span class="region_txt">Execution Date</span>
								<input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '');"
									onkeyup="dateFormat(this)" maxlength="8" id="ST_DT" name="ST_DT" class="indent"
									style="width: 25%; height: 17px;" />
								<input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '');"
									onkeyup="dateFormat(this)" maxlength="8" id="ED_DT" name="ED_DT" class="indent"
									style="width: 25%; height: 17px;" />
								<a href="javascript:getUserSyncJobHistorySearch(1)"><img
										src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
								<button name="back_list" class="indent" onclick="goList()">
									<spring:message code="label.list" text="List" />
								</button>
							</div>
						</div>
						<%-- <input type="radio" class="radio" name="emp_status" value="1" checked="checked" />
						<span class="font11 co_666">
							<spring:message code="label.Active" text="Active" />
						</span> &nbsp;&nbsp;
						<input type="radio" class="radio" name="emp_status" value="2" />
						<span class="font11 co_666">
							<spring:message code="label.InActive" text="InActive" />
						</span>
						<span class="font11 co_666">
							<spring:message code="label.HostName" text="HostName" /> :
							<c:out value="${serverHostName}" />
						</span>--%>
						</p>

					</div>
					<!-- //(searchbox) -->

					<!-- (board_01) -->
					<input type="hidden" name="batchJobHistoryCnt" id="batchJobHistoryCnt" value="">
					<table class="board_01" summary="User Quick Menu">
						<caption></caption>
						<colgroup>
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">
									<spring:message code="page.syncJob" text="Sync Job" />
								</th>
								<th scope="col">
									<spring:message code="label.executionNo" text="Execution No." />
								</th>
								<th scope="col">
									<spring:message code="label.executionDate" text="Execution Date" />
								</th>
								<th scope="col">
									<spring:message code="label.executionHost" text="Execution Host" />
								</th>
								<th scope="col">
									<spring:message code="label.syncType" text="Sync Type" />
								</th>
								<th scope="col">
									<spring:message code="label.result" text="Result" />
								</th>
							</tr>
						</thead>
						<!-- Batch Job 목록 가져오기 Display Start-->
						<tbody id="UserSyncJobHistoryDiv"></tbody>
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
		text-align: center;
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