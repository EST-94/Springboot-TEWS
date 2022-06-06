<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
	<title>Hanon Systems Administrator Page
		<spring:message code="lnb.BATCH.BJH" text="Batch Job History" />
	</title>
	<!-- (paging) -->
	<script type="text/javascript">
	var tempparam = {};
	var firstIn =true;
		$(document).ready(function () {

			var today = new Date();

			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);

			var dateString = year + '-' + month + '-' + day;
			$("input[name=ST_DT]").attr("placeholder", dateString);
			$("input[name=ED_DT]").attr("placeholder", dateString);

			init();
		});

		function init() {
			//left_menu 펼쳐 놓기
			$(".Batch").addClass("on");
			$(".Batch").find(" > ul").show();
			$(".batchJobHistory > a").addClass("highlight");
			// 사용자 목록 표시
			getJobList();

			//getBatchJobHistory(1);
			//drawBatchJobHistory(1);			// default: 기본 사용자 조회 없음
		}
		function dateFormat(el) {
			el.value = el.value.replace(/(\d\d\d\d)(\d\d)(\d\d)/g, '$1-$2-$3');
			if (window.event.keyCode == 13) {
				getBatchJobHistorySearch(1);
			}
		}
		/**
		 * 배치 목록 조회
		 *
		 * @since 1.0, 2021-12-10
		 */
		function getJobList() {
			var params = {};
			params.JobName = $("select[name=BatchJobList]").val();
			// 배치 조회 시작
			$.ajax({
				url: '/admin/batch/getBatchJobHistoryList.do'
				, type: 'post'
				, dataType: 'json'
				, data: params
				, success: function (data) {
					//	console.log(data)
					saveJobList(data);
				}
				, error: function (data) {
					//	console.log(data);
				}
			});
		}
		var batchJobHistory;
		var pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": 1, "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": 1} ');
		/**
		 * 배치 목록 조회
		 *
		 * @since 2.3, 2018-07-07
		 */
		function getBatchJobHistorySearch(no) {
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
			if(no != 1){
				getBatchJobHistory(no);	
			}else{
				getBatchJobHistory(1);
			}
		}
		/**
		 * 배치 목록 조회
		 *
		 * @since 2.3, 2018-07-07
		 */
		function getBatchJobHistory(no) {

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
			if(firstIn){
				params.no = no;
				firstIn=false;
			}else{
				if (pageObj.totalPage < no) {
					params.no = pageObj.totalPage;
				} else {
					params.no = no;
				}
			}
			// 배치 조회 시작
			$.ajax({
				url: '/admin/batch/getBatchJobHistory.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					saveBatchJobHistory(data, no);
				}
				, error: function (data) {
					//			console.log(data);
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
			if('${jobHistoryJobName}' != ''){
				$("select[name=BatchJobList]").val('${jobHistoryJobName}').prop('selected', true);
				$(':input[name=ST_DT]').val('${jobHistoryStDt}');
				$(':input[name=ED_DT]').val('${jobHistoryEdDt}');
				if('${jobHistoryPageNo}' == ''){
					getBatchJobHistorySearch(1);
					
				}else{
					getBatchJobHistorySearch('${jobHistoryPageNo}');
				}
			}else{
				getBatchJobHistorySearch(1);
			}
		}

		/**
		 * 배치 목록 저장 및 페이징 처리
		 * @param data		{@link ReturnBatchJobInfo} List of BatchJobInfo 
		 * @since 2.2, 2018-07-07
		 */
		function saveBatchJobHistory(data, no) {
			batchJobHistory = new Array();
			count = $('totalCnt', data).text();

			pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": ' + count + ', "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": ' + parseInt((count - 1) / 10 + 1) + '} ');
			paginavigation("paginationBatchJob", pageObj, "getBatchJobHistory");
			if (count > 0) {
				$("#batchJobHistoryCnt").val(count);
				$('batchJobHistory', data).each(function () {
					jobName = $('jobName', this).text().replace("\"","\'");
					executeDate = $('executeDate', this).text().replace("\"","\'");
					executeSeq = $('executeSeq', this).text().replace("\"","\'");
					executeHostName = $('executeHostName', this).text().replace("\"","\'");
					executeStartDateTime = $('executeStartDateTime', this).text().replace("\"","\'");
					executeEndDateTime = $('executeEndDateTime', this).text().replace("\"","\'");
					totalSourceCount = $('totalSourceCount', this).text().replace("\"","\'");
					validSourceCount = $('validSourceCount', this).text().replace("\"","\'");
					newIdTotalCount = $('newIdTotalCount', this).text().replace("\"","\'");
					newIdSuccessCount = $('newIdSuccessCount', this).text().replace("\"","\'");
					newIdFailCount = $('newIdFailCount', this).text().replace("\"","\'");
					updateIdTotalCount = $('updateIdTotalCount', this).text().replace("\"","\'");
					updateIdSuccessCount = $('updateIdSuccessCount', this).text().replace("\"","\'");
					updateIdFailCount = $('updateIdFailCount', this).text().replace("\"","\'");
					deleteIdTotalCount = $('deleteIdTotalCount', this).text().replace("\"","\'");
					deleteIdSuccessCount = $('deleteIdSuccessCount', this).text().replace("\"","\'");
					deleteIdFailCount = $('deleteIdFailCount', this).text().replace("\"","\'");
					jobResult = $('jobResult', this).text().replace("\"","\'");
					jobResultMessage = $('jobResultMessage', this).text().replace("\"","\'");
					itemObj = $.parseJSON('{"jobName": "' + jobName + '", "executeDate": "' + executeDate + '", "executeSeq": "' + executeSeq + '", "executeHostName": "' + executeHostName + '", "executeStartDateTime": "' + executeStartDateTime + '", "executeEndDateTime": "' + executeEndDateTime + '", "totalSourceCount": "' + totalSourceCount + '","validSourceCount": "' + validSourceCount + '", "newIdTotalCount": "' + newIdTotalCount + '", "newIdSuccessCount": "' + newIdSuccessCount + '", "newIdFailCount": "' + newIdFailCount + '", "updateIdTotalCount": "' + updateIdTotalCount + '", "updateIdSuccessCount": "' + updateIdSuccessCount + '", "updateIdFailCount": "' + updateIdFailCount + '", "deleteIdTotalCount": "' + deleteIdTotalCount + '", "deleteIdSuccessCount": "' + deleteIdSuccessCount + '", "deleteIdFailCount": "' + deleteIdFailCount + '", "jobResult": "' + jobResult + '", "jobResultMessage": "' + jobResultMessage + '"} ');
					batchJobHistory.push(itemObj);
				});
			}
			drawBatchJobHistory(no);
		}

		/**
		 * 배치 목록 그리기
		 * @param no		(int) page number 
		 * @since 2.2, 2018-07-07
		 */
		function drawBatchJobHistory(no) {
			$('#batchJobHistoryDiv').html('');

			if ($.isEmptyObject(batchJobHistory)) {
				$('#batchJobHistoryDiv').append("<tr><td colspan='13' class='center'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
				pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": 1, "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": 1} ');
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

				paginavigation("paginationBatchJob", pageObj, "getBatchJobHistory");

				for (var i = 0; i < (pageObj.endRow % 10 == 0 ? 10 : pageObj.endRow % 10); i++) {
					jobName = batchJobHistory[i].jobName;
					executeSeq = batchJobHistory[i].executeSeq;
					executeDate = batchJobHistory[i].executeDate;
					executeStartDateTime = batchJobHistory[i].executeStartDateTime;
					executeEndDateTime = batchJobHistory[i].executeEndDateTime;
					executeHostName = batchJobHistory[i].executeHostName;
					totalSourceCount = batchJobHistory[i].totalSourceCount;
					validSourceCount = batchJobHistory[i].validSourceCount;
					newIdTotalCount = batchJobHistory[i].newIdTotalCount;
					newIdSuccessCount = batchJobHistory[i].newIdSuccessCount;
					newIdFailCount = batchJobHistory[i].newIdFailCount;
					updateIdTotalCount = batchJobHistory[i].updateIdTotalCount;
					updateIdSuccessCount = batchJobHistory[i].updateIdSuccessCount;
					updateIdFailCount = batchJobHistory[i].updateIdFailCount;
					deleteIdTotalCount = batchJobHistory[i].deleteIdTotalCount;
					deleteIdSuccessCount = batchJobHistory[i].deleteIdSuccessCount;
					deleteIdFailCount = batchJobHistory[i].deleteIdFailCount;
					jobResult = batchJobHistory[i].jobResult;
					html = "<tr onclick='javascript:batchJobDetails(\"" + i + "\")'>"
						+ "<td class='center'style='text-align:left  !important;'>" + jobName + "</td>"
						+ "<td class='center'>" + executeDate + "</td>"
						+ "<td class='center'>" + executeSeq + "</td>"
						+ "<td class='center'>" + executeStartDateTime + "</td>"
						+ "<td class='center'>" + executeEndDateTime + "</td>"
						+ "<td class='center'style='text-align:left  !important;'>" + executeHostName + "</td>"
						+ "<td class='center'style='text-align:right  !important;'>" + totalSourceCount + "</td>"
						+ "<td class='center'style='text-align:right  !important;'>" + validSourceCount + "</td>"
						+ "<td class='center'style='text-align:right  !important;'>" + newIdSuccessCount + "/" + newIdTotalCount + "</td>"
						+ "<td class='center'style='text-align:right  !important;'>" + updateIdSuccessCount + "/" + updateIdTotalCount + "</td>"
						+ "<td class='center'style='text-align:right  !important;'>" + deleteIdSuccessCount + "/" + deleteIdTotalCount + "</td>"
						+ "<td class='center'style='text-align:right  !important;'>" + (parseInt(newIdFailCount) + parseInt(updateIdFailCount) + parseInt(deleteIdFailCount)) + "</td>";
						if(jobResult == 'S'){
							html += "<td class='center'> Success </td>";
						}else if(jobResult == 'F'){
							html += "<td class='center' style='color: #FF5757;' > Fail </td>";
						}else{
							html += "<td class='center'>" + jobResult + "</td>";
						}
						
						html += "</tr>";


					$('#batchJobHistoryDiv').append(html);
				}
			}
		}



		/**
		 * 배치 상세 보기 페이지 이동
		 * @param 
		 * @since 1.0, 2021-12-13
		 */
		function batchJobDetails(no) {
			var form = document.createElement('form');
			var obj1 = document.createElement('input');
			obj1.setAttribute("type", "hidden");
			obj1.setAttribute("name", "JobName");
			obj1.setAttribute("value", batchJobHistory[no].jobName);

			var obj2 = document.createElement('input');
			obj2.setAttribute("type", "hidden");
			obj2.setAttribute("name", "ExecuteDate");
			obj2.setAttribute("value", batchJobHistory[no].executeDate);

			var obj3 = document.createElement('input');
			obj3.setAttribute("type", "hidden");
			obj3.setAttribute("name", "ExecuteSeq");
			obj3.setAttribute("value", batchJobHistory[no].executeSeq);
			
			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "jobHistoryStDt");
			obj4.setAttribute("value", tempparam.executeStartDateTime);

			var obj5 = document.createElement('input');
			obj5.setAttribute("type", "hidden");
			obj5.setAttribute("name", "jobHistoryEdDt");
			obj5.setAttribute("value", tempparam.executeEndDateTime);
			
			var obj6 = document.createElement('input');
			obj6.setAttribute("type", "hidden");
			obj6.setAttribute("name", "jobHistoryJobName");
			obj6.setAttribute("value", tempparam.JobName);
			
			var obj7 = document.createElement('input');
			obj7.setAttribute("type", "hidden");
			obj7.setAttribute("name", "jobHistoryPageNo");
			obj7.setAttribute("value", pageObj.nowPage);
			
			form.appendChild(obj1);
			form.appendChild(obj2);
			form.appendChild(obj3);
			form.appendChild(obj4);
			form.appendChild(obj5);
			form.appendChild(obj6);
			form.appendChild(obj7);
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/batch/BatchJobDetails.do');

			document.body.appendChild(form);
			form.submit();
		}

		function SelectJob() {
			document.getElementById("ED_DT").value = '';
			document.getElementById("ST_DT").value = '';
			getBatchJobHistorySearch(1);
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
						<spring:message code="lnb.BATCH.BJH" text="Batch Job History" />
					</h3>

					<p class="page_navigation">
						<strong>
							<spring:message code="lnb.BATCH.BJH" text="Batch Job History" />
						</strong> <span>
							<spring:message code="lnb.BATCH" text="Batch Job Management" />
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
								<a href="javascript:getBatchJobHistorySearch(1)">
									<img src="/images/skin/btn/btn_allsearch.gif" alt="search" />
								</a>
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
							<col width="7%">
							<col width="6%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="7%">
							<col width="7%">
							<col width="7%">
							<col width="7%">
							<col width="7%">
							<col width="7%">
							<col width="7%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">
									<spring:message code="page.batchJob" text="Batch Job" />
								</th>
								<th scope="col">
									<spring:message code="label.executionDate" text="Execution Date" />
								</th>
								<th scope="col">
									<spring:message code="label.executionNo" text="Execution No." />
								</th>
								<th scope="col">
									<spring:message code="label.executionNo" text="Execution Start Date" />
								</th>
								<th scope="col">
									<spring:message code="label.executionNo" text="Execution End Date" />
								</th>
								<th scope="col">
									<spring:message code="label.executionHost" text="Execution Host" />
								</th>
								<th scope="col">
									<spring:message code="label.sourceCount" text="Source Count" />
								</th>
								<th scope="col">
									<spring:message code="label.total" text="Total" />
								</th>
								<th scope="col">
									<spring:message code="label.new" text="New" />
								</th>
								<th scope="col">
									<spring:message code="label.update" text="Update" />
								</th>
								<th scope="col">
									<spring:message code="label.terminate" text="Terminate" />
								</th>
								<th scope="col">
									<spring:message code="label.error" text="Error" />
								</th>
								<th scope="col">
									<spring:message code="label.result" text="Result" />
								</th>
							</tr>
						</thead>
						<!-- Batch Job 목록 가져오기 Display Start-->
						<tbody id="batchJobHistoryDiv"></tbody>
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
		text-align: left;
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