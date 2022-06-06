<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
	<title>Hanon Systems Administrator Page
		<spring:message code="lnb.BATCH.BJH.BJD" text="Batch Job Details" />
	</title>
	<!-- (paging) -->
	<script type="text/javascript">
		var firstIn = true;
		var stNum = 0;
		var edNum = 10;
		var tempparam = {};
		$(document).ready(function () {
			init();
			$('#syncTypeSelect').on('change', function () {
				$(':input[name=content]').val('');
				$("select[name=title]").val('ALL').prop('selected', true);
				getBatchJobDetailsSearch(1);
			});
			$('#syncResultSelect').on('change', function () {
				$(':input[name=content]').val('');
				$("select[name=title]").val('ALL').prop('selected', true);
				getBatchJobDetailsSearch(1);
			});
			$("#content").on("focusout", function() {
            var x = $(this).val();
				if (x.length > 0) {
					if (x.match(/[^A-Z0-9a-z\ ]/gi)) {
						x = x.replace(/[^A-Z0-9a-z\ ]/gi, "");
					}
					$(this).val(x);
				}
			}).on("keyup", function() {
				$(this).val($(this).val().replace(/[^A-Z0-9a-z\ ]/gi, ""));
			});
		});

		function init() {
			//left_menu 펼쳐 놓기
			$(".Batch").addClass("on");
			$(".Batch").find(" > ul").show();
			$(".batchJobHistory > a").addClass("highlight");

			$(':input[name=content]').val('${content}');
			$("select[name=title]").val('${title}').prop('selected', true);
			$("select[name=syncResult]").val('${syncResult}').prop('selected', true);
			$("select[name=syncType]").val('${syncType}').prop('selected', true);

			if('${jobDetailPageNo}' == ''){
				getBatchJobDetailsSearch(1);
			}else{
				getBatchJobDetailsSearch('${jobDetailPageNo}');
			}

			//	getBatchJobHistory();
			//	drawBatchJobHistory(1);			// default: 기본 사용자 조회 없음
		}
		function enterkey() {
			if (window.event.keyCode == 13) {
				getBatchJobDetailsSearch(1);
			}
		}

		var batchJobDetails;
		var pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": 1, "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": 1} ');
		
		function getBatchJobDetailsSearch(no) {

			tempparam.syncType = $("select[name=syncType]").val();
			tempparam.syncResult = $("select[name=syncResult]").val();
			tempparam.title = $("select[name=title]").val();
			tempparam.content = $(':input[name=content]').val();
			getBatchJobDetails(no);
		}
		/**
		 * 배치 상세 조회
		 *
		 * @since 1.0, 2021-12-14
		 */
		function getBatchJobDetails(no) {

			var params = {};

			params.JobName = '${batchJobHistoryVO.jobName}';
			params.ExecuteSeq = '${batchJobHistoryVO.executeSeq}';
			params.ExecuteDate = '${batchJobHistoryVO.executeDate}';

			if(!isEmpty(tempparam.syncType)){
				params.syncType = tempparam.syncType;
			}else{params.syncType=''}
			if(!isEmpty(tempparam.syncResult)){
				params.syncResult = tempparam.syncResult;
			}else{params.syncType=''}
			if(!isEmpty(tempparam.title)){
				params.title = tempparam.title;
			}else{params.title=''}
			if(!isEmpty(tempparam.content)){
				params.content = tempparam.content;
			}else{params.content=''}

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
				url: '/admin/batch/getBatchJobDetails.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					//	console.log("SUCCESS");
					//	console.log(data);
					saveBatchJobDetails(data, no);
				}
				, error: function (data) {
					//	console.log("ERROR");
					//	console.log(data);
				}
			});
		}

		/**
		 * 배치 목록 저장 및 페이징 처리
		 * @param data		{@link ReturnBatchJobInfo} List of BatchJobInfo 
		 * @since 2.2, 2018-07-07
		 */
		function saveBatchJobDetails(data, no) {

			batchJobDetails = new Array();
			count = $('totalCnt', data).text();

			pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": ' + count + ', "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": ' + parseInt((count - 1) / 10 + 1) + '} ');
			paginavigation("paginationBatchJob", pageObj, "getBatchJobDetails");
			if (count > 0) {
				$("#batchJobDetailsCnt").val(count);
				$('batchJobDetails', data).each(function () {
					syncType = $('syncType', this).text();
					executeDate = $('executeDate', this).text();
					employeeStatus = $('employeeStatus', this).text();
					employeeNumber = $('employeeNumber', this).text();
					userId = $('userId', this).text();
					country = $('country', this).text();
					companyName = $('companyName', this).text();
					employeeType = $('employeeType', this).text();
					firstName = $('firstName', this).text();
					lastName = $('lastName', this).text();
					activationDate = $('activationDate', this).text();
					expirationDate = $('expirationDate', this).text();
					syncResult = $('syncResult', this).text();
					resultMessage =  $('resultMessage', this).text();
					jobName = $('jobName', this).text();
					executeSeq = $('executeSeq', this).text();
					executeStartDatetime = $('executeStartDatetime', this).text();

					itemObj = $.parseJSON('{"syncType": "' + syncType + '", "executeDate": "' + executeDate + '", "employeeStatus": "' + employeeStatus + '", "employeeNumber": "' + employeeNumber + '", "userId": "' + userId + '", "country": "' + country + '", "companyName": "' + companyName + '", "employeeType": "' + employeeType + '", "firstName": "' + firstName + '", "lastName": "' + lastName + '", "activationDate": "' + activationDate + '", "expirationDate": "' + expirationDate + '", "jobName": "' + jobName + '", "executeSeq": "' + executeSeq + '", "syncResult": "' + syncResult + '", "executeStartDatetime": "' + executeStartDatetime + '", "resultMessage": "' + resultMessage + '"} ');
					batchJobDetails.push(itemObj);
				});
			}
			drawBatchJobDetails(no);
		}

		/**
		 * 배치 목록 그리기
		 * @param no		(int) page number 
		 * @since 2.2, 2018-07-07
		 */
		function drawBatchJobDetails(no) {
			$('#batchJobDetailsDiv').html('');

			if ($.isEmptyObject(batchJobDetails)) {
				$('#batchJobDetailsDiv').append("<tr><td colspan='12' class='center' style='text-align:center  !important;'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
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

				paginavigation("paginationBatchJob", pageObj, "getBatchJobDetails");
				//
				for (var i = 0; i < (pageObj.endRow % 10 == 0 ? 10 : pageObj.endRow % 10); i++) {
					syncType = batchJobDetails[i].syncType;
					executeDate = batchJobDetails[i].executeDate;
					employeeStatus = batchJobDetails[i].employeeStatus;
					userId = batchJobDetails[i].userId;
					country = batchJobDetails[i].country;
					companyName = batchJobDetails[i].companyName;
					employeeType = batchJobDetails[i].employeeType;
					firstName = batchJobDetails[i].firstName;
					lastName = batchJobDetails[i].lastName;
					activationDate = batchJobDetails[i].activationDate;
					expirationDate = batchJobDetails[i].expirationDate;
					syncResult = batchJobDetails[i].syncResult;
					html = "<tr onclick='javascript:batchJobCompare(\"" + i + "\")'>";
					if('${batchJobHistoryVO.jobName}' == 'KoreaHREmpSyncJob'){
						if (syncType == 'C') {
							html += "<td class='center'>New</td>";
						} else if (syncType == 'U') {
							html += "<td class='center'>Update</td>";
						} else if (syncType == 'D') {
							html += "<td class='center'>Terminate</td>";
						} else if(syncType == 'R'){
							html += "<td class='center'>Rehire</td>";
						}else {
							html += "<td class='center'>" + syncType + "</td>";
						}
						if (syncResult == 'S' || syncResult.toUpperCase() == 'SUCCESS') {
							html += "<td class='center'>Success</td>";
						} else if (syncResult == 'F' || syncResult.toUpperCase() == 'FAIL') {
							html += "<td class='center'style='color:#FF5757;'>Fail</td>";
						} else {
							html += "<td class='center'>" + syncResult + "</td>";
						}
	
						html += "<td class='center'>" + executeDate + "</td>"
							+ "<td class='center'>" + userId + "</td>"
							+ "</tr>";
					}else{
						if (syncType == 'C') {
							html += "<td class='center'>New</td>";
						} else if (syncType == 'U') {
							html += "<td class='center'>Update</td>";
						} else if (syncType == 'D') {
							html += "<td class='center'>Terminate</td>";
						} else if(syncType == 'R'){
							html += "<td class='center'>Rehire</td>";
						}else {
							html += "<td class='center'>" + syncType + "</td>";
						}
						if (syncResult == 'S' || syncResult.toUpperCase() == 'SUCCESS') {
							html += "<td class='center'>Success</td>";
						} else if (syncResult == 'F' || syncResult.toUpperCase() == 'FAIL') {
							html += "<td class='center'style='color:#FF5757;'>Fail</td>";
						} else {
							html += "<td class='center'>" + syncResult + "</td>";
						}
	
						html += "<td class='center'>" + executeDate + "</td>"
							+ "<td class='center'>" + employeeStatus + "</td>"
							+ "<td class='center'>" + userId + "</td>"
							+ "<td class='center'>" + country + "</td>"
							+ "<td class='center'>" + companyName + "</td>"
							+ "<td class='center'>" + employeeType + "</td>"
							+ "<td class='center'>" + firstName + "</td>"
							+ "<td class='center'>" + lastName + "</td>"
							+ "<td class='center'>" + activationDate + "</td>"
							+ "<td class='center'>" + expirationDate + "</td>"
							+ "</tr>";
					}
					$('#batchJobDetailsDiv').append(html);
				}
			}
		}

		function goList() {
			var form = document.createElement('form');
			var obj1 = document.createElement('input');
			obj1.setAttribute("type", "hidden");
			obj1.setAttribute("name", "jobHistoryStDt");
			obj1.setAttribute("value", '${jobHistoryStDt}');

			var obj2 = document.createElement('input');
			obj2.setAttribute("type", "hidden");
			obj2.setAttribute("name", "jobHistoryEdDt");
			obj2.setAttribute("value", '${jobHistoryEdDt}');

			var obj3 = document.createElement('input');
			obj3.setAttribute("type", "hidden");
			obj3.setAttribute("name", "jobHistoryJobName");
			obj3.setAttribute("value", '${jobHistoryJobName}');
			
			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "jobHistoryPageNo");
			obj4.setAttribute("value", '${jobHistoryPageNo}');

			form.appendChild(obj1);
			form.appendChild(obj2);
			form.appendChild(obj3);
			form.appendChild(obj4);

			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/batch/batchJobHistory.do');

			document.body.appendChild(form);
			form.submit();
		}
		function batchJobCompare(no) {

			var form = document.createElement('form');
			var obj1 = document.createElement('input');
			obj1.setAttribute("type", "hidden");
			obj1.setAttribute("name", "batchJobDetails");
			obj1.setAttribute("value", JSON.stringify(batchJobDetails[no]));

			var obj2 = document.createElement('input');
			obj2.setAttribute("type", "hidden");
			obj2.setAttribute("name", "JobName");
			obj2.setAttribute("value", '${batchJobHistoryVO.jobName}');

			var obj3 = document.createElement('input');
			obj3.setAttribute("type", "hidden");
			obj3.setAttribute("name", "ExecuteDate");
			obj3.setAttribute("value", '${batchJobHistoryVO.executeDate}');

			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "ExecuteSeq");
			obj4.setAttribute("value", '${batchJobHistoryVO.executeSeq}');
			
			var obj5 = document.createElement('input');
			obj5.setAttribute("type", "hidden");
			obj5.setAttribute("name", "content");
			obj5.setAttribute("value", tempparam.content);
			
			var obj6 = document.createElement('input');
			obj6.setAttribute("type", "hidden");
			obj6.setAttribute("name", "title");
			obj6.setAttribute("value", tempparam.title);

			var obj7 = document.createElement('input');
			obj7.setAttribute("type", "hidden");
			obj7.setAttribute("name", "syncType");
			obj7.setAttribute("value", tempparam.syncType);

			var obj8 = document.createElement('input');
			obj8.setAttribute("type", "hidden");
			obj8.setAttribute("name", "syncResult");
			obj8.setAttribute("value", tempparam.syncResult);

			var obj9 = document.createElement('input');
			obj9.setAttribute("type", "hidden");
			obj9.setAttribute("name", "jobDetailPageNo");
			obj9.setAttribute("value", pageObj.nowPage);

			var obj10 = document.createElement('input');
			obj10.setAttribute("type", "hidden");
			obj10.setAttribute("name", "jobHistoryStDt");
			obj10.setAttribute("value", '${jobHistoryStDt}');

			var obj11 = document.createElement('input');
			obj11.setAttribute("type", "hidden");
			obj11.setAttribute("name", "jobHistoryEdDt");
			obj11.setAttribute("value", '${jobHistoryEdDt}');

			var obj12 = document.createElement('input');
			obj12.setAttribute("type", "hidden");
			obj12.setAttribute("name", "jobHistoryJobName");
			obj12.setAttribute("value", '${jobHistoryJobName}');
			
			var obj13 = document.createElement('input');
			obj13.setAttribute("type", "hidden");
			obj13.setAttribute("name", "jobHistoryPageNo");
			obj13.setAttribute("value", '${jobHistoryPageNo}');

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
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/batch/batchJobCompare.do');

			document.body.appendChild(form);
			form.submit();

		}
		function goValidationFailList() {
			var form = document.createElement('form');
			var obj1 = document.createElement('input');
			obj1.setAttribute("type", "hidden");
			obj1.setAttribute("name", "JobName");
			obj1.setAttribute("value", '${batchJobHistoryVO.jobName}');

			var obj2 = document.createElement('input');
			obj2.setAttribute("type", "hidden");
			obj2.setAttribute("name", "ExecuteDate");
			obj2.setAttribute("value", '${batchJobHistoryVO.executeDate}');

			var obj3 = document.createElement('input');
			obj3.setAttribute("type", "hidden");
			obj3.setAttribute("name", "ExecuteSeq");
			obj3.setAttribute("value", '${batchJobHistoryVO.executeSeq}');

			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "content");
			obj4.setAttribute("value", tempparam.content);
			
			var obj5 = document.createElement('input');
			obj5.setAttribute("type", "hidden");
			obj5.setAttribute("name", "title");
			obj5.setAttribute("value", tempparam.title);

			var obj6 = document.createElement('input');
			obj6.setAttribute("type", "hidden");
			obj6.setAttribute("name", "syncType");
			obj6.setAttribute("value", tempparam.syncType);

			var obj7 = document.createElement('input');
			obj7.setAttribute("type", "hidden");
			obj7.setAttribute("name", "syncResult");
			obj7.setAttribute("value", tempparam.syncResult);

			var obj8 = document.createElement('input');
			obj8.setAttribute("type", "hidden");
			obj8.setAttribute("name", "jobDetailPageNo");
			obj8.setAttribute("value", pageObj.nowPage);

			var obj9 = document.createElement('input');
			obj9.setAttribute("type", "hidden");
			obj9.setAttribute("name", "jobHistoryStDt");
			obj9.setAttribute("value", '${jobHistoryStDt}');

			var obj10 = document.createElement('input');
			obj10.setAttribute("type", "hidden");
			obj10.setAttribute("name", "jobHistoryEdDt");
			obj10.setAttribute("value", '${jobHistoryEdDt}');

			var obj11 = document.createElement('input');
			obj11.setAttribute("type", "hidden");
			obj11.setAttribute("name", "jobHistoryJobName");
			obj11.setAttribute("value", '${jobHistoryJobName}');
			
			var obj12 = document.createElement('input');
			obj12.setAttribute("type", "hidden");
			obj12.setAttribute("name", "jobHistoryPageNo");
			obj12.setAttribute("value", '${jobHistoryPageNo}');
			
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
						<spring:message code="lnb.BATCH.BJH.BJD" text="Batch Job Details" />
					</h3>

					<p class="page_navigation">
						<strong>
							<spring:message code="lnb.BATCH.BJH.BJD" text="Batch Job Details" />
						</strong> <span>
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
								<td scope="col">${batchJobHistoryVO.jobName}</td>
								<th scope="col">
									<spring:message code="label.executionNo" text="Execution No." />
								</th>
								<td scope="col">${batchJobHistoryVO.executeSeq}</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.excutionDateAndTime" text="Execution Date and Time" />
								</th>
								<td scope="col">${batchJobHistoryVO.executeStartDateTime}</td>
								<th scope="col">
									<spring:message code="label.endDateAndTime" text="End Date and Time" />
								</th>
								<td scope="col">${batchJobHistoryVO.executeEndDateTime}</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.excutionHost" text="Execution Host" />
								</th>
								<td colspan="3">${batchJobHistoryVO.executeHostName}</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.sourceCount" text="Source Count" />
								</th>
								<td scope="col">${batchJobHistoryVO.totalSourceCount}</td>
								<th scope="col">
									<spring:message code="label.total" text="Total" />
								</th>
								<td scope="col">
									${batchJobHistoryVO.newIdSuccessCount+batchJobHistoryVO.updateIdSuccessCount+batchJobHistoryVO.deleteIdSuccessCount}/${batchJobHistoryVO.newIdTotalCount+batchJobHistoryVO.updateIdTotalCount+batchJobHistoryVO.deleteIdTotalCount}(Success/Total)
									<c:if test="${batchJobHistoryVO.jobName eq 'GlobalHREmpSyncJob'}">
										<button name="back_list" class="indent"
											onclick="goValidationFailList()">Validation Fail List</button>
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.new" text="New" />
								</th>
								<td scope="col">
									${batchJobHistoryVO.newIdSuccessCount}/${batchJobHistoryVO.newIdTotalCount}(Success/Total)
								</td>
								<th scope="col">
									<spring:message code="label.update" text="Update" />
								</th>
								<td scope="col">
									${batchJobHistoryVO.updateIdSuccessCount}/${batchJobHistoryVO.updateIdTotalCount}(Success/Total)
								</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.terminate" text="Terminate" />
								</th>
								<td scope="col">
									${batchJobHistoryVO.deleteIdSuccessCount}/${batchJobHistoryVO.deleteIdTotalCount}(Success/Total)
								</td>
								<th scope="col">
									<spring:message code="label.error" text="Error" />
								</th>
								<td scope="col">
									${batchJobHistoryVO.newIdFailCount+batchJobHistoryVO.updateIdFailCount+batchJobHistoryVO.deleteIdFailCount}
								</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.jobResult" text="Job Result (Error Message)" />
								</th>
								<c:choose>
									<c:when test="${batchJobHistoryVO.jobResult eq 'S'}">
										<th colspan="3" style="background: #FFFFFF;">Success</th>
									</c:when>
									<c:when test="${batchJobHistoryVO.jobResult eq 'F'}">
										<th colspan="3" style="background: #FFFFFF;"><span style="color: #FF5757;"> Fail
												<br>
											</span> Error result : ${batchJobHistoryVO.jobResultMessage}</th>
									</c:when>
									<c:otherwise>
										<th colspan="3" style="background: #FFFFFF;">
											${batchJobHistoryVO.jobResult}</th>
									</c:otherwise>
								</c:choose>
							</tr>
						</thead>
						<!-- Batch Job 목록 가져오기 Display Start-->
						<tbody id="batchJobHistoryDiv"></tbody>
						<!-- Batch Job 목록 가져오기 Display End-->
					</table>

					<div class="clear mgb_10">
						<p class="fleft pdt_5">
						<div class="left" style="float: left; width: 70%">
							<div class="regionbox" style="float: left; ">
								<span class="region_txt"> Sync Type </span>
								<select id='syncTypeSelect' name=syncType title="Search Type" class="onclick">
									<option value="ALL" selected="selected">
										<spring:message code="label.ALL" text="ALL" />
									</option>
									<option value="C">
										<spring:message code="label.New" text="New" />
									</option>
									<option value="U">
										<spring:message code="label.Update" text="Update" />
									</option>
									<option value="D">
										<spring:message code="label.Terminate" text="Terminate" />
									</option>
									<option value="R">
										<spring:message code="label.Rehire" text="Rehire" />
									</option>
								</select>
							</div>
							<div class="regionbox" style="float: left; padding-left: 20px;">
								<span class="region_txt"> Sync Result </span>
								<select id='syncResultSelect' name=syncResult title="Search Result" class="onclick">
									<option value="ALL" selected="selected">
										<spring:message code="label.ALL" text="ALL" />
									</option>
									<option value="S">
										<spring:message code="label.Success" text="Success" />
									</option>
									<option value="F">
										<spring:message code="label.Fail" text="Fail" />
									</option>
								</select>
							</div>
						</div>
						<div class="right" id="searchbox">
							<!-- (searchbox) -->
							<div class="regionbox">
								<span class="region_txt">
									<spring:message code="button.search" text="Search" />
								</span>
								<select name="title" title="Search Type" class="onclick">
									<option value="CDSID" selected="selected">
										<spring:message code="page.cdsid" text="CDSID" />
									</option>
									<option value="managerId">
										<spring:message code="label.managerId" text="Manager ID" />
									</option>
									<option value="Name">
										<spring:message code="label.name" text="Name" />
									</option>
								</select>
								<input type="text" id="content" maxlength="30" class="indent" onkeyup="enterkey()" style="width: 35%; height: 17px;"
									name="content" /> <a href="javascript:getBatchJobDetailsSearch(1)"><img
										src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</div>
							<!-- //(searchbox) -->
						</div>
						</p>
					</div>
					<input type="hidden" name="batchJobDetailsCnt" id="batchJobDetailsCnt" value="">
					<c:choose>
						<c:when test="${batchJobHistoryVO.jobName eq 'KoreaHREmpSyncJob'}">
							<table class="board_01">
								<caption></caption>
								<colgroup>
									<col width="5%">
									<col width="5%">
									<col width="6%">
									<col width="7%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">
											<spring:message code="page.syncType" text="Sync Type" />
										</th>
										<th scope="col">
											<spring:message code="label.syncResult" text="Sync Result" />
										</th>
										<th scope="col">
											<spring:message code="label.executionDate" text="Execution Date" />
										</th>
										<th scope="col">
											<spring:message code="label.userid" text="USERID" />
										</th>
									</tr>
								</thead>
								<!-- Batch Job 목록 가져오기 Display Start-->
								<tbody id="batchJobDetailsDiv"></tbody>
								<!-- Batch Job 목록 가져오기 Display End-->
							</table>
						</c:when>
						<c:otherwise>
							<table class="board_01">
								<caption></caption>
								<colgroup>
									<col width="5%">
									<col width="5%">
									<col width="6%">
									<col width="5%">
									<col width="7%">
									<col width="6%">
									<col width="20%">
									<col width="8%">
									<col width="7%">
									<col width="7%">
									<col width="8%">
									<col width="12%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">
											<spring:message code="page.syncType" text="Sync Type" />
										</th>
										<th scope="col">
											<spring:message code="label.syncResult" text="Sync Result" />
										</th>
										<th scope="col">
											<spring:message code="label.executionDate" text="Execution Date" />
										</th>
										<th scope="col">
											<spring:message code="label.status" text="Status" />
										</th>
										<th scope="col">
											<spring:message code="label.userid" text="USERID" />
										</th>
										<th scope="col">
											<spring:message code="label.countryCode" text="Country Code" />
										</th>
										<th scope="col">
											<spring:message code="label.company" text="Company" />
										</th>
										<th scope="col">
											<spring:message code="label.employeeType" text="Employee Type" />
										</th>
										<th scope="col">
											<spring:message code="label.firstName" text="First Name" />
										</th>
										<th scope="col">
											<spring:message code="label.lastName" text="Last Name" />
										</th>
										<th scope="col">
											<spring:message code="label.hireDate" text="Hire Date" />
										</th>
										<th scope="col">
											<spring:message code="label.terminationDate" text="Termination Date" />
										</th>
									</tr>
								</thead>
								<!-- Batch Job 목록 가져오기 Display Start-->
								<tbody id="batchJobDetailsDiv"></tbody>
								<!-- Batch Job 목록 가져오기 Display End-->
							</table>
						</c:otherwise>
					</c:choose>

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