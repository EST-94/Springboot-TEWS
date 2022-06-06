<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
	<title>Hanon Systems Administrator Page
		<spring:message code="lnb.BATCH.BJH.BJD.VFL" text="Validation Fail List" />
	</title>
	<!-- (paging) -->
	<script type="text/javascript">
	var tempparam = {};
	var firstIn =true;
		$(document).ready(function () {
			init();
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

			$(':input[name=content]').val('${contentVali}');
			$("select[name=title]").val('${titleVali}').prop('selected', true);

			if('${FailListPageNo}' == ''){
				getValidationFailListSearch(1);
			}else{
				getValidationFailListSearch('${FailListPageNo}');
			}
			
		}
		function enterkey() {
			if (window.event.keyCode == 13) {
				getValidationFailListSearch(1);
			}
		}
		var ValidationFailList;
		var pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": 1, "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": 1} ');
		
		function getValidationFailListSearch(no) {

			tempparam.title = $("select[name=title]").val();
			tempparam.content = $(':input[name=content]').val();
			getValidationFailList(no);
		}
		/**
		 * 배치 상세 조회
		 *
		 * @since 1.0, 2021-12-14
		 */
		function getValidationFailList(no) {

			var params = {};

			params.JobName = '${batchJobHistoryVO.jobName}';
			params.ExecuteSeq = '${batchJobHistoryVO.executeSeq}';
			params.ExecuteDate = '${batchJobHistoryVO.executeDate}';
			if(!isEmpty(tempparam.title)){
				params.title = tempparam.title;
			}else{params.title=''}
			if(!isEmpty(tempparam.content)){
				params.content = tempparam.content;
			}else{params.content=''}

			if(firstIn){
				params.no=no;
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
				url: '/admin/batch/getValidationFailList.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					saveValidationFailList(data, no);
				}
				, error: function (data) {
				}
			});
		}


		/**
		 * 배치 목록 저장 및 페이징 처리
		 * @param data		{@link ReturnBatchJobInfo} List of BatchJobInfo 
		 * @since 2.2, 2018-07-07
		 */
		function saveValidationFailList(data, no) {
			ValidationFailList = new Array();
			count = $('totalCnt', data).text();

			pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": ' + count + ', "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": ' + parseInt((count - 1) / 10 + 1) + '} ');
			paginavigation("paginationBatchJob", pageObj, "getValidationFailList");
			if (count > 0) {
				$("#ValidationFailListCnt").val(count);
				$('ValidationFailList', data).each(function () {
					status = $('status', this).text();
					userid = $('userid', this).text();
					username = $('username', this).text();
					country = $('country', this).text();
					custom05 = $('custom05', this).text();
					custom07 = $('custom07', this).text();
					firstname = $('firstname', this).text();
					lastname = $('lastname', this).text();
					hiredate = $('hiredate', this).text();
					custom12 = $('custom12', this).text();
					invalidReason = $('invalidReason', this).text().replace(/\n/gi, "");

					jobName = $('jobName', this).text();
					executeSeq = $('executeSeq', this).text();
					executeDate = $('executeDate', this).text();


					var jsonString = '{"status": "' + status + '", "userid": "' + userid + '", "username": "' + username + '", "country": "' + country + '", "custom05": "' + custom05 + '", "custom07": "' + custom07 + '", "firstname": "' + firstname + '", "lastname": "' + lastname + '", "hiredate": "' + hiredate + '", "custom12": "' + custom12 + '", "invalidReason": "' + invalidReason + '", "jobName": "' + jobName + '", "executeSeq": "' + executeSeq + '", "executeDate": "' + executeDate + '"} ';
					jsonString = jsonString.replace(/N\\A/gi, "N/A");
					jsonString = jsonString.replace(/\t/gi, " ");
					itemObj = $.parseJSON(jsonString);
					ValidationFailList.push(itemObj);
				});
			}
			drawValidationFailList(no);
		}

		/**
		 * 배치 목록 그리기
		 * @param no		(int) page number 
		 * @since 2.2, 2018-07-07
		 */
		function drawValidationFailList(no) {
			$('#ValidationFailListDiv').html('');
			if ($.isEmptyObject(ValidationFailList)) {
				$('#ValidationFailListDiv').append("<tr><td colspan='11' class='center' style='text-align:center !important;'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
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

				paginavigation("paginationBatchJob", pageObj, "getValidationFailList");

				for (var i = 0; i < (pageObj.endRow % 10 == 0 ? 10 : pageObj.endRow % 10); i++) {
					status = ValidationFailList[i].status;
					userid = ValidationFailList[i].userid;
					username = ValidationFailList[i].username;
					country = ValidationFailList[i].country;
					custom05 = ValidationFailList[i].custom05;
					custom07 = ValidationFailList[i].custom07;
					firstname = ValidationFailList[i].firstname;
					lastname = ValidationFailList[i].lastname;
					hiredate = ValidationFailList[i].hiredate;
					custom12 = ValidationFailList[i].custom12;
					invalidReason = ValidationFailList[i].invalidReason;
					html = "<tr onclick='javascript:goValidationFailDetail(\"" + i + "\")'>";
					html += "<td class='center'>" + status + "</td>"
						+ "<td title='" + userid + "' class='center'>" + userid + "</td>"
						+ "<td title='" + username + "' class='center'>" + username + "</td>"
						+ "<td title='" + country + "' class='center'>" + country + "</td>"
						+ "<td title='" + custom05 + "' class='center'>" + custom05 + "</td>"
						+ "<td title='" + custom07 + "' class='center'>" + custom07 + "</td>"
						+ "<td title='" + firstname + "' class='center'>" + firstname + "</td>"
						+ "<td title='" + lastname + "' class='center'>" + lastname + "</td>"
						+ "<td title='" + hiredate + "' class='center'>" + hiredate + "</td>"
						+ "<td title='" + custom12 + "' class='center'>" + custom12 + "</td>"
						+ "<td title='" + invalidReason + "' class='center'>" + invalidReason + "</td>"
						+ "</tr>";


					$('#ValidationFailListDiv').append(html);
				}
			}
		}

		function goList() {
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
			obj4.setAttribute("value", '${content}');

			var obj5 = document.createElement('input');
			obj5.setAttribute("type", "hidden");
			obj5.setAttribute("name", "title");
			obj5.setAttribute("value", '${title}');

			var obj6 = document.createElement('input');
			obj6.setAttribute("type", "hidden");
			obj6.setAttribute("name", "syncResult");
			obj6.setAttribute("value", '${syncResult}');

			var obj7 = document.createElement('input');
			obj7.setAttribute("type", "hidden");
			obj7.setAttribute("name", "syncType");
			obj7.setAttribute("value", '${syncType}');

			var obj8 = document.createElement('input');
			obj8.setAttribute("type", "hidden");
			obj8.setAttribute("name", "jobDetailPageNo");
			obj8.setAttribute("value", '${jobDetailPageNo}');

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
			form.setAttribute('action', '/admin/batch/BatchJobDetails.do');

			document.body.appendChild(form);
			form.submit();
		}
		function goValidationFailDetail(no) {
			var form = document.createElement('form');
			var obj1 = document.createElement('input');
			obj1.setAttribute("type", "hidden");
			obj1.setAttribute("name", "ValidationFailList");
			obj1.setAttribute("value", JSON.stringify(ValidationFailList[no]));

			var obj2 = document.createElement('input');
			obj2.setAttribute("type", "hidden");
			obj2.setAttribute("name", "batchJobHistory");
			obj2.setAttribute("value",  JSON.stringify("${batchJobHistoryVO}"));

			var obj3 = document.createElement('input');
			obj3.setAttribute("type", "hidden");
			obj3.setAttribute("name", "contentVali");
			obj3.setAttribute("value", tempparam.content);
			
			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "titleVali");
			obj4.setAttribute("value", tempparam.title);

			var obj5 = document.createElement('input');
			obj5.setAttribute("type", "hidden");
			obj5.setAttribute("name", "content");
			obj5.setAttribute("value", '${content}');

			var obj6 = document.createElement('input');
			obj6.setAttribute("type", "hidden");
			obj6.setAttribute("name", "title");
			obj6.setAttribute("value", '${title}');

			var obj7 = document.createElement('input');
			obj7.setAttribute("type", "hidden");
			obj7.setAttribute("name", "syncResult");
			obj7.setAttribute("value", '${syncResult}');

			var obj8 = document.createElement('input');
			obj8.setAttribute("type", "hidden");
			obj8.setAttribute("name", "syncType");
			obj8.setAttribute("value", '${syncType}');
			
			var obj9 = document.createElement('input');
			obj9.setAttribute("type", "hidden");
			obj9.setAttribute("name", "jobDetailPageNo");
			obj9.setAttribute("value", '${jobDetailPageNo}');

			var obj10 = document.createElement('input');
			obj10.setAttribute("type", "hidden");
			obj10.setAttribute("name", "FailListPageNo");
			obj10.setAttribute("value", pageObj.nowPage);

			var obj11 = document.createElement('input');
			obj11.setAttribute("type", "hidden");
			obj11.setAttribute("name", "jobHistoryStDt");
			obj11.setAttribute("value", '${jobHistoryStDt}');

			var obj12 = document.createElement('input');
			obj12.setAttribute("type", "hidden");
			obj12.setAttribute("name", "jobHistoryEdDt");
			obj12.setAttribute("value", '${jobHistoryEdDt}');

			var obj13 = document.createElement('input');
			obj13.setAttribute("type", "hidden");
			obj13.setAttribute("name", "jobHistoryJobName");
			obj13.setAttribute("value", '${jobHistoryJobName}');
			
			var obj14 = document.createElement('input');
			obj14.setAttribute("type", "hidden");
			obj14.setAttribute("name", "jobHistoryPageNo");
			obj14.setAttribute("value", '${jobHistoryPageNo}');

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
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/batch/ValidationFailDetail.do');

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
						<spring:message code="lnb.BATCH.BJH.BJD.VFL" text="Validation Fail List" />
					</h3>

					<p class="page_navigation">
						<strong>
							<spring:message code="lnb.BATCH.BJH.BJD.VFL" text="Validation Fail List" />
						</strong> <span>
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
							<!-- (searchbox) -->
							<div class="regionbox">
								<span class="region_txt">
									<spring:message code="button.search" text="Search" />
								</span>
								<select name="title" title="Search Type" class="onclick">
									<option value="CDSID" selected="selected">
										<spring:message code="page.cdsid" text="CDSID" />
									</option>
									<option value="Name">
										<spring:message code="label.name" text="Name" />
									</option>
									<option value="managerId">
										<spring:message code="label.managerId" text="Manager ID" />
									</option>
								</select>
								<input type="text" id="content" onkeyup="enterkey()" maxlength="30" class="indent" style="width: 35%; height: 17px;"
									name="content" /> <a href="javascript:getValidationFailListSearch(1)"><img
										src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
								<button name="back_list" class="indent" onclick="goList()">
									<spring:message code="label.list" text="List" />
								</button>
							</div>
							<!-- //(searchbox) -->
						</div>
						</p>
					</div>
					<input type="hidden" name="ValidationFailListCnt" id="ValidationFailListCnt" value="">
					<table class="board_01">
						<caption></caption>
						<colgroup>
							<col width="5%">
							<col width="7%">
							<col width="9%">
							<col width="7%">
							<col width="15%">
							<col width="7%">
							<col width="7%">
							<col width="7%">
							<col width="7%">
							<col width="6%">
							<col width="24%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">
									<spring:message code="page.status" text="Status" />
								</th>
								<th scope="col">
									<spring:message code="label.userid" text="USERID" />
								</th>
								<th scope="col">
									<spring:message code="label.userNM" text="USERNAME(CDSID)" />
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
								<th scope="col">
									<spring:message code="label.failReason" text="Fail Reason" />
								</th>
							</tr>
						</thead>
						<!-- Batch Job 목록 가져오기 Display Start-->
						<tbody id="ValidationFailListDiv"></tbody>
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
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
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