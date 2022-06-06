<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
<title>Hanon Systems Administrator Page <spring:message code="lnb.BATCH.MBJL" text="Modify Batch Job List" /></title>
<!-- (paging) -->
<style type="text/css">
	.layer_pop {position: absolute;}
	.nodeSel {font-weight: bold;}
</style>
<script type="text/javascript">
var userDetailList = new Array();
var batchJobInfo = new Object();
var dTreeArray = new Array();
var dTreeId = 0; 

var selectOrgId_U="";   //메인트리에서 선택한 조직코드 아이디
// var selectOrgName_U="";   //메인트리에서 선택한 조직이름

var userSearchType="";
var userSearchData="";

var codeSearchType="";
var codeSearchData="";
var orderBy="";
var ascDesc		= "ASC";
var currentCodeId="";
var reportSearchData="";
var reportUserSearchType="";
var reportOrderBy="";
var reportAscDesc="ASC";

var regist_gubun=""; //CDSID 신청 등록을 눌렀는지 Or 일반 Regist를 눌렀는지 구분

var block=10;

var batchJobList;
var hostNameList;
var checkResult = true;

var userColumnList;
var userCodeListMap;

var dynamicColumnCodeId; //등록, 수정 화면에서 검색하려는 코드 ID

var addJobSeqNo = '1';  //겸직관련 seqNo
$(document).ready(function(){

	init();
	
	// Calendar 적용
	$("#reg_EntranceDate").datepicker({ dateFormat: 'yymmdd' });
	//검색 EnterKey 적용
    $("#reportToName").on('keypress',function(e){
        if (e.which == 13) { reportSearch('search'); }
    }); 
    $('#contents input[name=content]').on('keypress',function(e){
        if (e.which == 13) { getBatchJobList(); }
    }); 
});

function init() {
	//left_menu 펼쳐 놓기
	$(".Batch").addClass("on");
    $(".Batch").find(" > ul").show();
    $(".batchJobList > a").addClass("highlight");
	// 사용자 목록 표시
	getBatchJobList();
	drawBatchJobList(1);			// default: 기본 사용자 조회 없음
}

/**
 * 배치 목록 조회
 *
 * @since 2.3, 2018-07-07
 */
function getBatchJobList(){
	
	var params = {};
	
	// 배치 조회 시작
	$.ajax({
		url: '/admin/batch/getBatchJobList.do'
		, type: 'post'
		, dataType: 'xml'
		, data: params
		, success: function(data) {
			
			console.log(data);
			saveBatchJobList(data);
		}
		, error: function(data) {
			//console.log(data);
		}
	});
}

var batchJobList;
var pageObj;
/**
 * 배치 목록 저장 및 페이징 처리
 * @param data		{@link ReturnBatchJobInfo} List of BatchJobInfo 
 * @since 2.2, 2018-07-07
 */
function saveBatchJobList(data) {
	 batchJobList = new Array();
	 hostNameList = new Array();
	 count = $('totalCount', data).text();

	 pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": ' + count + ', "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": ' + parseInt((count-1)/10 +1)  + '} ');
	 //console.log(pageObj);
	 paginavigation("paginationBatchJob", pageObj, "drawBatchJobList");
	
	if(count > 0) {
		$("#batchJobCnt").val(count);
		$('batchJobList', data).each(function() {
			batchJobId = $('batchJobId', this).text();
			batchJobName = $('batchJobName', this).text();
			batchJobDesc = $('batchJobDesc', this).text();
			cronExpression = $('cronExpression', this).text();
			previousFireTime = $('previousFireTime', this).text();
			nextFireTime = $('nextFireTime', this).text();
			executeHostName = $('executeHostName', this).text();
			useYn = $('useYn', this).text();
			itemObj = $.parseJSON('{"batchJobId": "' + batchJobId + '", "batchJobName": "' + batchJobName + '", "batchJobDesc": "' + batchJobDesc + '", "cronExpression": "' + cronExpression + '", "previousFireTime": "' + previousFireTime + '", "nextFireTime": "' + nextFireTime + '", "executeHostName": "' + executeHostName + '", "useYn": "' + useYn + '"} ');
			batchJobList.push(itemObj);
		});
		$('hostNameList', data).each(function(){
			hostNameList.push($.parseJSON('{"hostName": "' + $(this).text() + '"} '));
		});
	}
	drawBatchJobList(1);
}

 /**
  * 배치 목록 그리기
  * @param no		(int) page number 
  * @since 2.2, 2018-07-07
  */
function drawBatchJobList(no) {
	$('#batchJobListDiv').html('');
	
	if($.isEmptyObject(batchJobList)) {
		$('#batchJobListDiv').append("<tr><td colspan='7' class='center'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
		$('#paginationBatchJob').text('');
	} else {
		no = (1 < no) ? no : 1;		// check min-page
		no = (no < pageObj.totalPage) ? no : pageObj.totalPage;	// check Max-page
		pageObj.nowPage = no;
		pageObj.startPage = parseInt((no-1)/pageObj.blockPage)*pageObj.blockPage + 1;
		pageObj.prevPage = pageObj.blockList < pageObj.startPage;
		
		endPage = pageObj.startPage + pageObj.blockPage - 1;
		pageObj.endPage = (endPage < pageObj.totalPage) ? endPage : pageObj.totalPage;
		pageObj.nextPage = endPage < pageObj.totalPage;
		
		pageObj.startRow = (pageObj.nowPage - 1) * pageObj.blockList + 1;
		endRow = pageObj.nowPage * pageObj.blockList;
		pageObj.endRow = (pageObj.rowTotal < endRow) ? pageObj.rowTotal : endRow ;
		
		console.log(pageObj);
		paginavigation("paginationBatchJob", pageObj, "drawBatchJobList");
		
		for(var i = 0; i < pageObj.rowTotal; i++) {
			batchJobId = batchJobList[i].batchJobId;
			batchJobName = batchJobList[i].batchJobName;
			batchJobDesc = batchJobList[i].batchJobDesc;
			cronExpression = batchJobList[i].cronExpression;
			previousFireTime = batchJobList[i].previousFireTime;
			nextFireTime = batchJobList[i].nextFireTime;
			executeHostName = batchJobList[i].executeHostName;
			useYn = batchJobList[i].useYn;
			
			html = "<tr>"
				+ "<input type='hidden' name='batchJobId' value='" + batchJobId + "'/>"
				+ "<td class='center'>" + batchJobName + "</td>"
				+ "<td class='center'>" + batchJobName + "</td>"
				+ "<td class='center'>" + previousFireTime + "</td>"
				+ "<td class='center'>" + nextFireTime + "</td>"
				+ "<td class='center'>"
				+ "<select name='executeHostName" + batchJobId + "' id='executeHostName" + batchJobId + "'>";
				for(var j = 0 ; j < hostNameList.length ; j++) {
					if(executeHostName == hostNameList[j].hostName) {
						html += "<option value='" + hostNameList[j].hostName + "' selected='selected'>" + hostNameList[j].hostName + "</option>";	
					} else {
						html += "<option value='" + hostNameList[j].hostName + "'>" + hostNameList[j].hostName + "</option>";
					}
				}
			html += "</select>"
				+ "</td>";
			if(useYn == 'Y' && cronExpression != null && nextFireTime != null) {
				html += "<td class='center'><input type='text' name='cronExpression" + batchJobId + "' id='cronExpression" + batchJobId + "' style='width: 120px;' value='" + cronExpression + "'/></td>"
					+ "<td class='center'>"
					+ "<select name='useYn" + batchJobId + "' id='useYn" + batchJobId + "'>"
					+ "<option value='Y' selected='selected'>Y</option>"
					+ "<option value='N'>N</option>"
					+ "</select>"
					+ "</td>";
			} else {
				html += "<td class='center'><input type='text' name='cronExpression" + batchJobId + "' id='cronExpression" + batchJobId + "' style='width: 120px;' value='" + cronExpression + "'/></td>"
				+ "<td class='center'>"
				+ "<select name='useYn" + batchJobId + "' id='useYn" + batchJobId + "'>"
				+ "<option value='Y'>Y</option>"
				+ "<option value='N' selected='selected'>N</option>"
				+ "</select>"
				+ "</td>";
			}
			
			if('<c:out value="${serverHostName}"/>' == executeHostName && useYn == 'Y') {
				html += "<td class='center'><a id='btnRunBatchJob" + batchJobId + "' class='btn_white' onclick='javascript:runBatchJob(\""+ batchJobId +"\");'><span class='clickable'>Run Immediately</span></a></td>"
			} else {
				html += "<td class='center'></td>"
			} 
				html += "</tr>";

			$('#batchJobListDiv').append(html);
		}
	}
}
 
function saveBatchJob() {
	$('div.position_loading').children('p').html("<img src='/images/common/loading.gif' alt='' />");
	$('div.position_loading').children('dl').children('dt').html("Certification in progress");
	$('div.position_loading').children('dl').children('dd').html("Once authentication is complete, go to the Portal.");	
	
	$('span.deem').css('display', 'block');
	$('div.loadingbar').css('display', 'block');
	
	var batchJobCnt = $("#batchJobCnt").val();
	
	if(batchJobCnt > 1) {
		var batchJobId = new Array(batchJobCnt);
		for(var i=0;i<batchJobCnt;i++) {
			batchJobId[i] = $("input[name='batchJobId']")[i].value;
			
			if($("#useYn"+batchJobId[i]).val() == 'Y' && $("#cronExpression"+batchJobId[i]).val() == ''){
				$('span.deem').css('display','none');
				$('div.loadingbar').css('display','none');
				
				alert("Cron Expression is null");
				return;
			}
		}
	} else {
		var batchJobId = $("input[name='batchJobId']").value;
		
		if($("#useYn"+batchJobId).val() == 'Y' && $("#cronExpression"+batchJobId).val() == ''){
			$('span.deem').css('display','none');
			$('div.loadingbar').css('display','none');
			
			alert("Cron Expression is null");
			return;
		}
	}
	
	var params = $("#modifyForm").serialize();
	
	// Cron Expression Validation Check
	$.ajax({
		url: '/admin/batch/getCheckCronExpression.do'
		, type: 'post'
		, dataType: 'json'
		, data: params
		, success: function(data) {
			
			console.log(data);
			if(data.success == true) {
				var params = $("#modifyForm").serialize();
				
				// Cron Expression Validation Check
				$.ajax({
					url: '/admin/batch/saveCronExpression.do'
					, type: 'post'
					, dataType: 'json'
					, data: params
					, success: function(data) {
						$('span.deem').css('display','none');
						if(data.success == true) {
							$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
							$('div.position_loading').children('dl').children('dt').html("Update cron expression successfull");
							$('div.position_loading').children('dl').children('dd').html("");
						} else {
							$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
							$('div.position_loading').children('dl').children('dt').html("Update cron expression failed");
							$('div.position_loading').children('dl').children('dd').html("");
						}
						getBatchJobList();
					}
					, error: function(data) {
						//console.log(data);
							$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
							$('div.position_loading').children('dl').children('dt').html("Update cron expression failed");
							$('div.position_loading').children('dl').children('dd').html("");
						getBatchJobList();
					}
				});
			} else {
				$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
				$('div.position_loading').children('dl').children('dt').html(data.value);
				$('div.position_loading').children('dl').children('dd').html("");
			}
		}
		, error: function(data) {
			//console.log(data);
			$('span.deem').css('display','none');
			$('div.loadingbar').css('display','none');
		}
	});	
}

function closeAlert() {
	$('div.loadingbar').css('display', 'none');
}

function runBatchJob(batchJobId) {
	if(confirm("Run Immediately?")) {
		var params = {};
		params.batchJobId = batchJobId;
		
		// Run Batch Job Immediately
		$.ajax({
			url: '/admin/batch/runBatchJob.do'
			, type: 'post'
			, dataType: 'json'
			, data: params
			, success: function() {
				
			}
			, error: function(data) {

			}
		});
	}
}

var orderUserBy = 'batchJobId';
var toggleAsc = true;
/**
 * 목록 재정렬
 * @param key		(String) Order by KEY
 * @since 2.3, 2014-08-14
 */
function sortBy(key) {
	if(key == orderUserBy) {
		if(toggleAsc) {
			//console.log("A");
			toggleAsc = false;				// Next time : ASC
			batchJobList = batchJobList.sort(sortByDesc);	// This time : DESC
		} else {
			//console.log("B");
			toggleAsc = true;				// Next time : DESC
			batchJobList = batchJobList.sort(sortByAsc);	// This time : ASC
		}
	} else {
		//console.log("C");
		orderUserBy = key;					// Change key
		toggleAsc = true;					// Next time : DESC
		batchJobList = batchJobList.sort(sortByAsc);		// This time : ASC
	}
	drawBatchJobList(1);		// Draw list
}
/**
 * 정렬 함수 (Asc)
 * @since 2.3, 2014-08-14
 */
function sortByAsc(a, b) {
	var aValue = a[orderUserBy].toLowerCase();
	var bValue = b[orderUserBy].toLowerCase();
	return ((aValue < bValue) ? -1 : ((aValue > bValue) ? 1 : 0));
}
/**
 * 정렬 함수 (Desc)
 * @since 2.3, 2014-08-14
 */
function sortByDesc(b, a) {
	var aValue = a[orderUserBy].toLowerCase();
	var bValue = b[orderUserBy].toLowerCase();
	return ((aValue < bValue) ? -1 : ((aValue > bValue) ? 1 : 0));
}

//전화번호 숫자와 - 기호만 
 function onlyNum() { 
 	var keycode = window.event.keyCode;
 	
 	if(keycode == 8 || keycode==189 || (keycode >= 35 && keycode <= 40) || (keycode >= 46 && keycode <= 57) || (keycode >= 96 && keycode <= 105) || keycode == 110 || keycode == 190) {
	 	window.event.returnValue = true;
	 	return;
 	} else {
	 	window.event.returnValue = false;
	 	return;
 	}
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
			<h1><a href="/admin/home.do" title="Hanon Systems Administrator Page Home"><img src="/images/skin/common/logo.png" alt="HOME Hanon Systems" /></a></h1>
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
				<h3><spring:message code="lnb.BATCH.MBJL" text="Batch Job List" /></h3>
				
				<p class="page_navigation">
					<strong><spring:message code="lnb.BATCH.MBJL" text="Batch Job List" /></strong>
					<span><spring:message code="lnb.BATCH" text="Batch Job Management" /></span>
					<img alt="home" src="/images/skin/common/icon_home.png">
				</p>
			</div>
			<!-- //(location) -->

			<div class="mgl_20">
			<form name="modifyForm" id="modifyForm" method="post"> 
				<!-- (searchbox) -->
				<div class="clear mgb_10">
					<p class="fleft pdt_5">
<%-- 						<input type="radio" class="radio"  name="emp_status" value="1" checked="checked" /> 
						<span class="font11 co_666"><spring:message code="label.Active" text="Active"/></span> &nbsp;&nbsp;
						<input type="radio" class="radio"  name="emp_status" value="2" /> 
						<span class="font11 co_666"><spring:message code="label.InActive" text="InActive"/></span> --%>
						<span class="font11 co_666"><spring:message code="label.HostName" text="HostName"/> : <c:out value="${serverHostName}"/></span>
					</p>

				</div>
				<!-- //(searchbox) -->

				<!-- (board_01) -->
				<input type="hidden" name="batchJobCnt" id="batchJobCnt" value="">
				<table class="board_01" summary="User Quick Menu">
					<caption></caption>
					<colgroup>
						<col width="10%">
						<col width="30%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><a href="javascript:sortBy('batchJobName')"><spring:message code="page.batchJobName" text="Batch Job Name" /></a></th>
							<th scope="col"><a href="javascript:sortBy('batchJobDesc')"><spring:message code="label.batchJobDesc" text="Batch Job Desc" /></a></th>
							<th scope="col"><a href="javascript:sortBy('previousFireTime')"><spring:message code="label.previousFireTime" text="Previous Fire Time" /></a></th>
							<th scope="col"><a href="javascript:sortBy('nextFireTime')"><spring:message code="label.nextFireTime" text="Next Fire Time" /></a></th>
							<th scope="col"><a href="javascript:sortBy('executeHostName')"><spring:message code="label.executeHostName" text="Execute Host Name" /></a></th>
							<th scope="col"><a href="javascript:sortBy('cronExpression')"><spring:message code="label.cronExpression" text="Cron Expression" /></a></th>
							<th scope="col"><a href="javascript:sortBy('useYn')"><spring:message code="label.useYn" text="Use YN" /></a></th>
							<th scope="col"><spring:message code="label.runImmediately" text="Run Immediately" /></th>
						</tr>
					</thead>
					<!-- Batch Job 목록 가져오기 Display Start-->
					<tbody id="batchJobListDiv" ></tbody>
					<!-- Batch Job 목록 가져오기 Display End-->
				</table>
				<!-- //(board_01) -->
				<!-- <div id="paginationBatchJob" class="paging" ></div>			 -->	
			</form>
			</div>
			<div class="right">
				<a class="btn_blue3" id="btn_add" href="javascript:saveBatchJob();">
					<span><spring:message code="button.save" text="Save" /></span>
				</a>

				<!-- <a class="btn_gray5" href="#">
					<span>Cancel</span>
				</a> -->
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

<span class="deem" style="display: none;"></span> <!-- (반투명막) -->
<div class="loadingbar"  style="display: none;">
	<div class="position_loading">
		<p><img src="/images/common/loading.gif" alt="" /></p>
		<dl>
			<dt>Certification in progress</dt>
			<dd>Once authentication is complete, go to the Portal.</dd>
		</dl>
	</div>
</div>

</body>
</html>