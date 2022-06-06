<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
	<title>Hanon Systems Administrator Page
		<spring:message code="lnb.SAM.ML.MD" text="Manager Details" />
	</title>
	<!-- (paging) -->
	<script type="text/javascript">
		var tempparam = {};
		$(document).ready(function () {
			init();
			$("#content").on("focusout", function () {
				var x = $(this).val();
				if (x.length > 0) {
					if (x.match(/[^A-Z0-9a-z\ ]/gi)) {
						x = x.replace(/[^A-Z0-9a-z\ ]/gi, "");
					}
					$(this).val(x);
				}
			}).on("keyup", function () {
				$(this).val($(this).val().replace(/[^A-Z0-9a-z\ ]/gi, ""));
			});
		});
		function SaveAction(value) {
			alert(value);
		}
		function init() {
			//left_menu 펼쳐 놓기
			$(".Supplier").addClass("on");
			$(".Supplier").find(" > ul").show();
			$(".managerList > a").addClass("highlight");
			$(':input[name=content]').val('${managerDetailContent}');
			$("select[name=title]").val('${managerDetailTitle}').prop('selected', true);
			$(":radio[name=emp_status][value='${managerDetailStatus}']").prop('checked', true);


			if ('${managerDetailContent}' == '') {
				//KSSIM LDAP에서 가져오는 부분이라, 자동으로 긁어올지, 검색한 뒤 표기되게 할지 확인 필요.
				var Data = "<result><totalCount>0</totalCount></result>"
				saveSearchSuppliers(Data, 1);
			} else {
				getBatchJobDetailsSearch('${managerDetailPageNo}');
			}
		}
		function enterkey() {
			if (window.event.keyCode == 13) {
				getSuppliersSearch(1);
			}
		}

		var userInfoList;
		var pageObj;

		function getSuppliersSearch(no) {

			tempparam.title = $('#contents select[name=title]').val();
			tempparam.content = $('#contents input[name=content]').val();
			tempparam.status = $(':radio[name=emp_status]:checked').val();
			getSuppliersList(no);
		}
		/**
			* 배치 상세 조회
			*
			* @since 1.0, 2021-12-14
			*/
		function getSuppliersList(no) {

			var params = {};

			params.uid = '${userTempVO.userid}';

			if (!isEmpty(tempparam.title)) {
				params.title = tempparam.title;
			} else { params.title = '' }
			if (!isEmpty(tempparam.content)) {
				params.content = tempparam.content;
			} else { params.content = '' }
			if (!isEmpty(tempparam.status)) {
				params.status = tempparam.status;
			} else { params.status = '' }

			// 배치 조회 시작
			$.ajax({
				url: '/admin/supplier/searchSuppliers.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					//	console.log("SUCCESS");
					//	console.log(data);
					saveSearchSuppliers(data, no);
				}
				, error: function (data) {
					//	console.log("ERROR");
					//	console.log(data);
				}
			});
		}

		/**
			* Supplier 목록 저장 및 페이징 처리
			* @param data		{@link ReturnSupplierUserInfo} List of Supplier
			* @since 2.2, 2022-05-10
			*/
		function saveSearchSuppliers(data, no) {

			userInfoList = new Array();
			count = $('totalCount', data).text();

			pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": ' + count + ', "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": ' + parseInt((count - 1) / 10 + 1) + '} ');
			paginavigation("paginationUser", pageObj, "drawUserList");

			if (count > 0) {
				$('supplierUserInfoList', data).each(function () {
					cdsid = $('userid', this).text();
					firstName = $('givenname', this).text();
					lastName = $('sn', this).text();
					employeenumber = $('employeenumber', this).text();
					localemployeenumber = $('imstring05', this).text();
					employeetype = $('employeetype', this).text();
					country = $('destinationindicator', this).text();
					department = $('departmentnumber', this).text();
					activationDate = $('imactivationdate', this).text();
					expirationDate = $('imexpirationdate', this).text();
					employeeStatus = $('imemployeestatus', this).text();

					var jsonString = '{"cdsid": "' + cdsid + '", "employeeStatus": "' + employeeStatus + '", "firstName": "' + firstName + '", "lastName": "' + lastName + '", "employeenumber": "' + employeenumber + '", "localemployeenumber": "' + localemployeenumber + '", "employeetype": "' + employeetype + '", "country": "' + country + '", "department": "' + department + '", "activationDate": "' + activationDate + '", "expirationDate": "' + expirationDate + '"} ';
					jsonString = jsonString.replace(/N\\A/gi, "N/A");
					jsonString = jsonString.replace(/\t/gi, " ");
					itemObj = $.parseJSON(jsonString);
					//itemObj = $.parseJSON('{"cdsid": "' + cdsid + '", "managerId": "' + managerId + '", "name": "' + name + '", "employeeStatus": "' + employeeStatus + '", "employeType": "' + employeType + '", "companyName": "' + companyName + '", "activationDate": "' + activationDate + '", "expirationDate": "' + expirationDate + '"} ');
					userInfoList.push(itemObj);
				});
			}
			drawUserList(no);
		}

		/**
			* 배치 목록 그리기
			* @param no		(int) page number
			* @since 2.2, 2018-07-07
			*/
		function drawUserList(no) {

			$('#userListDiv').html('');

			if ($.isEmptyObject(userInfoList)) {
				$('#userListDiv').append("<tr><td colspan='11' class='center' style='text-align:center  !important;'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
				pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": 1, "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": 1} ');
				$('#paginationUser').text('');
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

				paginavigation("paginationUser", pageObj, "drawUserList");
				//
				for (var i = pageObj.startRow - 1; i < pageObj.endRow; i++) {
					cdsid = userInfoList[i].cdsid;
					firstName = userInfoList[i].firstName;
					lastName = userInfoList[i].lastName;
					employeenumber = userInfoList[i].employeenumber;
					localemployeenumber = userInfoList[i].localemployeenumber;
					employeetype = userInfoList[i].employeetype;
					country = userInfoList[i].country;
					department = userInfoList[i].department;
					activationDate = userInfoList[i].activationDate;
					expirationDate = userInfoList[i].expirationDate;
					employeeStatus = userInfoList[i].employeeStatus;
					html = "<tr onclick='javascript:goSupplierDetails(\"" + cdsid + "\")'>"
						+ "<td class='center'>" + employeeStatus + "</td>"
						+ "<td class='center'>" + cdsid + "</td>"
						+ "<td class='center'>" + firstName + "</td>"
						+ "<td class='left'>" + lastName + "</td>"
						+ "<td class='center'>" + employeenumber + "</td>"
						+ "<td class='center'>" + localemployeenumber + "</td>"
						+ "<td class='center'>" + employeetype + "</td>"
						+ "<td class='center'>" + country + "</td>"
						+ "<td class='center'>" + department + "</td>"
						+ "<td class='center'>" + activationDate + "</td>"
						+ "<td class='center'>" + expirationDate + "</td>"
					html += "</tr>";

					$('#userListDiv').append(html);
				}
			}
		}
		/**
			* goSelectManager
			* @since 2022-05-06
			*/
		function goSelectManager() {
			$('.layer_popup').remove();
			var params = {};
			params.popup = 'MD';
			$.ajax({
				url: '/admin/supplier/selectManager.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data, status, error) {
					//console.log(error);
					$('body').append(error.responseText);
				}, error: function (data, status, error) {
					//console.log("error");
					//console.log(data.responseText);
					$('body').append(data.responseText);
				}
			});
		}
		function goList() {
			var form = document.createElement('form');
			var obj1 = document.createElement('input');
			obj1.setAttribute("type", "hidden");
			obj1.setAttribute("name", "contentManager");
			obj1.setAttribute("value", '${contentManager}');

			var obj2 = document.createElement('input');
			obj2.setAttribute("type", "hidden");
			obj2.setAttribute("name", "titleManager");
			obj2.setAttribute("value", '${titleManager}');

			var obj3 = document.createElement('input');
			obj3.setAttribute("type", "hidden");
			obj3.setAttribute("name", "emp_status");
			obj3.setAttribute("value", '${ManagerEmpStatus}');

			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "ManagerPageNo");
			obj4.setAttribute("value", '${ManagerPageNo}');

			form.appendChild(obj1);
			form.appendChild(obj2);
			form.appendChild(obj3);
			form.appendChild(obj4);

			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/supplier/managerList.do');

			document.body.appendChild(form);
			form.submit();
		}
		function goSupplierDetails(cdsid) {

			var form = document.createElement('form');
			var obj1 = document.createElement('input');
			obj1.setAttribute("type", "hidden");
			obj1.setAttribute("name", "contentManager");
			obj1.setAttribute("value", '${contentManager}');

			var obj2 = document.createElement('input');
			obj2.setAttribute("type", "hidden");
			obj2.setAttribute("name", "titleManager");
			obj2.setAttribute("value", '${titleManager}');

			var obj3 = document.createElement('input');
			obj3.setAttribute("type", "hidden");
			obj3.setAttribute("name", "ManagerEmpStatus");
			obj3.setAttribute("value", '${ManagerEmpStatus}');

			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "ManagerPageNo");
			obj4.setAttribute("value", '${ManagerPageNo}');

			var obj5 = document.createElement('input');
			obj5.setAttribute("type", "hidden");
			obj5.setAttribute("name", "managerDetailContent");
			obj5.setAttribute("value", tempparam.content);

			var obj6 = document.createElement('input');
			obj6.setAttribute("type", "hidden");
			obj6.setAttribute("name", "managerDetailTitle");
			obj6.setAttribute("value", tempparam.title);

			var obj7 = document.createElement('input');
			obj7.setAttribute("type", "hidden");
			obj7.setAttribute("name", "managerDetailStatus");
			obj7.setAttribute("value", tempparam.status);

			var obj8 = document.createElement('input');
			obj8.setAttribute("type", "hidden");
			obj8.setAttribute("name", "managerDetailPageNo");
			obj8.setAttribute("value", pageObj.nowPage);

			var obj9 = document.createElement('input');
			obj9.setAttribute("type", "hidden");
			obj9.setAttribute("name", "supplierCdsid");
			obj9.setAttribute("value", cdsid);

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
			form.setAttribute('action', '/admin/supplier/supplierDetails.do');

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
						<spring:message code="lnb.SAM.ML.MD" text="Manager Details" />
					</h3>

					<p class="page_navigation">
						<strong>
							<spring:message code="lnb.SAM.ML.MD" text="Manager Details" />
						</strong>
						<span>
							<spring:message code="lnb.SAM.ML" text="Manager List" />
						</span>
						<span>
							<spring:message code="lnb.SAM" text="Supplier Management" />
						</span> <!-- 22.05.04 KSSIM 현재 메뉴명과 다른데 고쳐야 하는지?? -->
						<img alt="home" src="/images/skin/common/icon_home.png">
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
									<spring:message code="label.managerCdsid" text="Manager CDSID" />
									<button name="changeManager" class="indent" onclick="goSelectManager()">
										<spring:message code="label.changeManager" text="Change Manager" />
									</button>
								</th>
								<td scope="col">${userTempVO.userid}</td>
								<th scope="col">
									<spring:message code="label.status" text="Status" />
								</th>
								<td scope="col">${userTempVO.imemployeestatus}</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.firstName" text="First Name" />
								</th>
								<td scope="col">${userTempVO.givenname}</td>
								<th scope="col">
									<spring:message code="label.lastName" text="Last Name" />
								</th>
								<td scope="col">${userTempVO.sn}</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.eMail" text="E-mail" />
								</th>
								<td scope="col">${userTempVO.mail}</td>
								<th scope="col">
									<spring:message code="label.country" text="Country" />
								</th>
								<td scope="col">${userTempVO.destinationindicator}</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.city" text="City" />
								</th>
								<td scope="col">${userTempVO.l}</td>
								<th scope="col">
									<spring:message code="label.companyName" text="Company Name" />
								</th>
								<td scope="col">${userTempVO.imcompanyname}</td>
							</tr>
						</thead>
					</table>

					<div class="clear mgb_10">
						<p class="fleft pdt_5">
							<input type="radio" class="radio" name="emp_status" value="1"
								checked="checked" />
							<span class="font11 co_666">
								<spring:message code="label.active" text="Active" />
							</span> &nbsp;&nbsp;
							<input type="radio" class="radio" name="emp_status" value="2" />
							<span class="font11 co_666">
								<spring:message code="label.inActive" text="InActive" />
							</span>
						</p>
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
								<input type="text" id="content" maxlength="30" class="indent"
									onkeyup="enterkey()" style="width: 35%; height: 17px;" name="content" />
								<a href="javascript:getSuppliersSearch(1)"><img
										src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</div>
							<!-- //(searchbox) -->
						</div>
					</div>
					<table class="board_01">
						<caption></caption>
						<colgroup>
							<col width="7%">
							<col width="7%">
							<col width="7%">
							<col width="9%">
							<col width="9%">
							<col width="9%">
							<col width="9%">
							<col width="13%">
							<col width="9%">
							<col width="8%">
							<col width="8%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">
									<spring:message code="page.status" text="Status" />
								</th>
								<th scope="col">
									<spring:message code="label.cdsid" text="CDSID" />
								</th>
								<th scope="col">
									<spring:message code="label.firstName" text="First Name" />
								</th>
								<th scope="col">
									<spring:message code="label.lastName" text="Last Name" />
								</th>
								<th scope="col">
									<spring:message code="label.employeeNumber" text="Employee Number" />
								</th>
								<th scope="col">
									<spring:message code="label.localEmployeeNumber"
										text="Local Employee Number" />
								</th>
								<th scope="col">
									<spring:message code="label.employeeType" text="Employee Type" />
								</th>
								<th scope="col">
									<spring:message code="label.country" text="Country" />
								</th>
								<th scope="col">
									<spring:message code="label.departmentName" text="Department Name" />
								</th>
								<th scope="col">
									<spring:message code="label.activationDate" text="Activation Date" />
								</th>
								<th scope="col">
									<spring:message code="label.expirationDate" text="Expiration Date" />
								</th>
							</tr>
						</thead>
						<!-- Supplier  목록 가져오기 Display Start-->
						<tbody id="userListDiv"></tbody>
						<!-- Supplier Job 목록 가져오기 Display End-->
					</table>

					<!-- //(board_01) -->
					<div id="paginationUser" class="paging"></div>
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
