<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
<title>Hanon Systems Administrator Page <spring:message code="lnb.EMU.EL" text="Employee List" /></title>
<script type="text/javascript" src="/js/dtree/dtree.js"></script>
<!-- (paging) -->
<style type="text/css">
	.layer_pop {position: absolute;}
	.nodeSel {font-weight: bold;}
</style>
<script type="text/javascript">
var userDetailList = new Array();
var userInfo = new Object();
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

var userColumnList;
var userCodeListMap;

var dynamicColumnCodeId; //등록, 수정 화면에서 검색하려는 코드 ID

var addJobSeqNo = '1';  //겸직관련 seqNo
$(document).ready(function(){

	init();
	
	// On job & Retire radio button click event
	$("input[name='emp_status'").on("click",function(){ getEmployeeList(); });
	// Calendar 적용
	$("#reg_EntranceDate").datepicker({ dateFormat: 'yymmdd' });
	//검색 EnterKey 적용
    $("#reportToName").on('keypress',function(e){
        if (e.which == 13) { reportSearch('search'); }
    }); 
    $('#contents input[name=content]').on('keypress',function(e){
        if (e.which == 13) { getEmployeeList(); }
    }); 
});

function init() {
	//left_menu 펼쳐 놓기
	$(".Employee").addClass("on");
    $(".Employee").find(">ul").show();
    $(".employeeList > a").addClass("highlight");
	// 사용자 목록 표시
	getEmployeeList();			// default: 기본 사용자 조회 없음
	//$("#btn_upStatus").hide();
}

function getEmployeeList() {
	$('span.deem').css('display', 'block');
	$('div.loadingbar').css('display', 'block');		
	var params = {};
	if ($('#contents input[name=content]').val().length > 0) {
		params.title = $('#contents select[name=title]').val();
		params.content = $('#contents input[name=content]').val();
	}
	params.status = $(':radio[name=emp_status]:checked').val();	
	
	// 사용자 조회 시작
	$.ajax({
		url: '/admin/employee/searchEmployeeList.do'
		, type: 'post'
		, dataType: 'xml'
		, data: params
		, success: function(data) {
			
			//console.log(data);
			saveUserList(data);
			$('span.deem').css('display','none');
			$('div.loadingbar').css('display', 'none');			
		}
		, error: function(data) {
			//console.log("Error with /imsso/localUser/user/deptCode/" + selectedDeptCode + ".do");
			//console.log(data);
		}
	});
}

var userInfoList;
var pageObj;
/**
 * 사용자 목록 저장 및 페이징 처리
 * @param data		{@link ReturnLocalUserInfo} List of LocalUserInfo 
 * @since 2.2, 2014-08-13
 */
function saveUserList(data) {
	userInfoList = new Array();
	
	count = $('totalCount', data).text();

	pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": ' + count + ', "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": ' + parseInt((count-1)/10 +1)  + '} ');
	//console.log(pageObj);
	paginavigation("paginationUser", pageObj, "drawUserList");
	
	if(count > 0) {
		$('employeeUserInfoList', data).each(function() {
			cdsid = $('userid', this).text();
			successFactorId = $('employeenumber', this).text();
			name = $('cn', this).text();
			employeeStatus = $('imemployeestatus', this).text();
			country = $('destinationindicator', this).text();
			department = $('departmentnumber', this).text();
			activationDate = $('imactivationdate', this).text();
			expirationDate = $('imexpirationdate', this).text();

			var jsonString = '{"cdsid": "' + cdsid + '", "successFactorId": "' + successFactorId + '", "name": "' + name + '", "employeeStatus": "' + employeeStatus + '", "country": "' + country + '", "department": "' + department + '", "activationDate": "' + activationDate + '", "expirationDate": "' + expirationDate + '"} ';
			jsonString = jsonString.replace(/N\\A/gi, "N/A");
			jsonString = jsonString.replace(/\t/gi, " ");
			itemObj = $.parseJSON(jsonString);
			userInfoList.push(itemObj);
		});
	}
	drawUserList(1);
}

 /**
  * 사용자 목록 그리기
  * @param no		(int) page number 
  * @since 2.2, 2014-08-13
  */
function drawUserList(no) {
	$('#userListDiv').html('');
	
	if($.isEmptyObject(userInfoList)) {
		$('#userListDiv').append("<tr><td colspan='11' class='center'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
		$('#paginationUser').text('');
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
		paginavigation("paginationUser", pageObj, "drawUserList");
		
		for(var i = pageObj.startRow - 1; i < pageObj.endRow; i++) {
			console.log(userInfoList[i]);
			cdsid = userInfoList[i].cdsid;
			name = userInfoList[i].name;
			country = userInfoList[i].country;
			department = userInfoList[i].department;
			successFactorId = userInfoList[i].successFactorId;
			employeeStatus = userInfoList[i].employeeStatus;
			activationDate = userInfoList[i].activationDate;
			expirationdate = userInfoList[i].expirationDate;
			
			html = "<tr>"
				+ "<td class='center'>" + employeeStatus + "</td>"
				+ "<td class='center'><a href='javascript:showUserDetail(\""+ cdsid +"\");'>" + cdsid + "</a></td>" 
				+ "<td class='center'>" + successFactorId + "</td>"
				+ "<td class='left'>" + name + "</td>"
				+ "<td class='center'>" + activationDate + "</td>"
				+ "<td class='center'>" + expirationdate + "</td>"
				+ "<td class='center'>" + country + "</td>"
				+ "<td class='center'>" + department + "</td>";
				if(employeeStatus.toLowerCase() == 'active'){
					html += "<td class='center'><a class='btn_red' onclick='javascript:selectUserRedButton(\""+ cdsid +"\");'><span class='clickable'>Red Button</span></a></td>";	
				} else {
					html += "<td class='center'></td>";
				}
				if(employeeStatus.toLowerCase() == 'inactive') {
					html += "<td class='center'><a class='btn_white' onclick='javascript:selectUserCDSIDAssign(\""+ cdsid +"\");'><span class='clickable'>CDSID Assign</span></a></td>";	
				} else {
					html += "<td class='center'></td>";
				}
				if(employeeStatus.toLowerCase() == 'active'){
					html += "<td class='center'><a class='btn_white' onclick='javascript:selectUserBlock(\""+ cdsid +"\");'><span class='clickable'>Block User</span></a></td>"	
				} else {
					html += "<td class='center'></td>";
				}
				html += "</tr>";

			$('#userListDiv').append(html);
		}
	}
}

var orderUserBy = 'userid';
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
			userInfoList = userInfoList.sort(sortByDesc);	// This time : DESC
		} else {
			//console.log("B");
			toggleAsc = true;				// Next time : DESC
			userInfoList = userInfoList.sort(sortByAsc);	// This time : ASC
		}
	} else {
		//console.log("C");
		orderUserBy = key;					// Change key
		toggleAsc = true;					// Next time : DESC
		userInfoList = userInfoList.sort(sortByAsc);		// This time : ASC
	}
	drawUserList(1);		// Draw list
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

/**
 * show user detail
 * @since 2014-10-23
 */
function showUserDetail(userid) {
	$('.layer_popup').remove();
	
	$.ajax({
		url: '/admin/employee/view.do'
		, type: 'post'
		, dataType: 'xml'
		, data: 'userid=' + userid
		, success: function(data, status, error) {
			console.log(data);
			$('body').append(error.responseText);
		}, error: function(data, status, error) {
			//console.log("error");
			console.log(data.responseText);
			$('body').append(data.responseText);
		}
	});
}

/**
 * User Red Button
 * @since 2018-07-11
 */
function selectUserRedButton(userid) {
	if(confirm(userid + " User Red button now?")) {
		$('span.deem').css('display', 'block');
		$('div.loadingbar').css('display', 'block');
		
		$.ajax({
			url: '/admin/employee/selectUserRedButton.do'
			, type: 'post'
			, dataType: 'json'
			, data: 'userid=' + userid
			, success: function(data, status, error) {
				$('span.deem').css('display','none');
				if(data.success == true) {
					$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
					$('div.position_loading').children('dl').children('dt').html("Red Button successfull");
					$('div.position_loading').children('dl').children('dd').html("");
				} else {
					$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
					$('div.position_loading').children('dl').children('dt').html("Red Button failed");
					$('div.position_loading').children('dl').children('dd').html(data.value);					
				}
			}, error: function(data, status, error) {
				//console.log("error");
				//console.log(data.responseText);
				$('body').append(data.responseText);
			}
		});	
	}
}

/**
 * User Block
 * @since 2018-07-11
 */
function selectUserBlock(userid) {
	if(confirm(userid + " User Block now?")) {
		$('span.deem').css('display', 'block');
		$('div.loadingbar').css('display', 'block');
		
		$.ajax({
			url: '/admin/employee/selectUserBlock.do'
			, type: 'post'
			, dataType: 'json'
			, data: 'userid=' + userid
			, success: function(data, status, error) {
				$('span.deem').css('display','none');
				if(data.success == true) {
					$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
					$('div.position_loading').children('dl').children('dt').html("Block User successfull");
					$('div.position_loading').children('dl').children('dd').html("");
				} else {
					$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
					$('div.position_loading').children('dl').children('dt').html("Block User failed");
					$('div.position_loading').children('dl').children('dd').html(data.value);					
				}
			}, error: function(data, status, error) {
				//console.log("error");
				//console.log(data.responseText);
				$('body').append(data.responseText);
			}
		});	
	}
}

function closeAlert() {
	$('div.loadingbar').css('display', 'none');
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
//이메일 체크
 function Check_Mail(pre) {
 	var str="";
 	str=$("#"+pre+"AlternateEmail").val();
 	if(str==""){
 		return true;
 	}else{
 		var emailEx1 = /[^@]+@[A-Za-z0-9_-]+.[A-Za-z]+/;
	 	var emailEx2 = /[^@]+@[A-Za-z0-9_-]+.[A-Za-z0-9_-]+.[A-Za-z]+/;
	 	var emailEx3 = /[^@]+@[A-Za-z0-9_-]+.[A-Za-z0-9_-]+.[A-Za-z0-9_-]+.[A-Za-z]+/;
	
	 	if (emailEx1.test(str)) return true;
	 	if (emailEx2.test(str)) return true;
	 	if (emailEx3.test(str)) return true;
	 }
	 return false;
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
				<h3><spring:message code="lnb.EMU.EL" text="Employee List" /></h3>
				
				<p class="page_navigation">
					<strong><spring:message code="lnb.EMU.EL" text="Employee List" /></strong>
					<span><spring:message code="lnb.EMU" text="Employee Management Users" /></span>
					<img alt="home" src="/images/skin/common/icon_home.png">
				</p>
			</div>
			<!-- //(location) -->

			<div class="mgl_20"> 
				<!-- (searchbox) -->
				<div class="clear mgb_10">
					<p class="fleft pdt_5">
						<input type="radio" class="radio"  name="emp_status" value="1" checked="checked" /> 
						<span class="font11 co_666"><spring:message code="label.active" text="Active"/></span> &nbsp;&nbsp;
						<input type="radio" class="radio"  name="emp_status" value="2" /> 
						<span class="font11 co_666"><spring:message code="label.inActive" text="InActive"/></span>
					</p>
					<div id="searchbox">
						<!-- (searchbox) -->
						<div class="regionbox">
							<span class="region_txt"><spring:message code="button.search" text="Search" /></span>
							<select name="title" title="Search Type" class="onclick" >
								<option value="name"><spring:message code="label.name" text="Name" /></option>
								<option value="successFactorId"><spring:message code="label.successFactorId" text="SuccessFactor ID" /></option>
								<option value="CDSID" selected="selected"><spring:message code="page.cdsid" text="CDSID" /></option>
							</select>  
							<input type="text" class="indent" style="width:35%; height:17px;" name="content"/>
							<a href="javascript:getEmployeeList()"><img src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
						</div>
						<!-- //(searchbox) -->				
					</div>					
				</div>

				<!-- (board_01) -->
				<table class="board_01" summary="User Quick Menu">
					<caption></caption>
					<colgroup>
						<col width="5%">
						<col width="10%">
						<col width="10%">
						<col width="15%">
						<col width="8%">
						<col width="8%">
						<col width="10%">
						<col width="10%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><a href="javascript:sortBy('employeestatus')"><spring:message code="page.status" text="Status" /></a></th>
							<th scope="col"><a href="javascript:sortBy('cdsid')"><spring:message code="page.cdsid" text="CDSID" /></a></th>
							<th scope="col"><a href="javascript:sortBy('successFactorId')"><spring:message code="page.successFactorId" text="SuccessFactor ID" /></a></th>
							<th scope="col"><a href="javascript:sortBy('name')"><spring:message code="label.nameEngLocal" text="Name" /></a></th>
							<th scope="col"><a href="javascript:sortBy('activationDate')"><spring:message code="label.activationDate" text="Activation Date" /></a></th>
							<th scope="col"><a href="javascript:sortBy('expirationDate')"><spring:message code="label.expirationDate" text="Expiration Date" /></a></th>
							<th scope="col"><a href="javascript:sortBy('country')"><spring:message code="label.country" text="Country" /></a></th>
							<th scope="col"><a href="javascript:sortBy('department')"><spring:message code="label.department" text="Department" /></a></th>
							<th scope="col"><spring:message code="button.redButton" text="Red Button" /></th>
							<th scope="col"><spring:message code="button.CDSIDAssign" text="CDSID Assign" /></th>
							<th scope="col"><spring:message code="button.blockUser" text="Block User" /></th>
						</tr>
					</thead>
					<!-- User 목록 가져오기 Display Start-->
					<tbody id="userListDiv" ></tbody>
					<!-- User 목록 가져오기 Display End-->
				</table>
				<!-- //(board_01) -->
				<div id="paginationUser" class="paging" ></div>

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