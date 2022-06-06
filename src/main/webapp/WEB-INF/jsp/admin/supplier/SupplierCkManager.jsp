<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
	<title>Hanon Systems Administrator Page
		<spring:message code="lnb.SAM.SLCM" text="Supplier List (Check Manager)" />
	</title>
	<!-- (paging) -->
	<style type="text/css">
		.layer_pop {
			position: absolute;
		}

		.nodeSel {
			font-weight: bold;
		}
	</style>
	<script type="text/javascript">
		var tempparam = {};
		var popupTemp = "";
		$(document).ready(function () {

			init();

			$('#contents input[name=content]').on('keypress', function (e) {
				if (e.which == 13) { getSupplierList(); }
			});
		});

		function init() {
			//left_menu 펼쳐 놓기
			$(".Supplier").addClass("on");
			$(".Supplier").find(">ul").show();
			$(".supplierListCheckManager > a").addClass("highlight");

			$(':input[name=content]').val('${contentManager}');
			$(":radio[name=emp_status][value='${emp_status}']").prop('checked', true);
			$("select[name=title]").val('${titleManager}').prop('selected', true);
			if ('${contentManager}' == '') {
				var Data = "<result><totalCount>0</totalCount></result>"
				saveUserList(Data, 1);
			} else {
				getManagerListSearch('${contentManager}');
			}
		}
		function getManagerListSearch(num) {
			tempparam.title = $('#contents select[name=title]').val();
			tempparam.content = $('#contents input[name=content]').val();
			tempparam.status = $(':radio[name=emp_status]:checked').val();
			getSupplierList(num);
		}
		function getSupplierList(num) {
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
				url: '/admin/supplier/searchManagerList.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					//console.log(data);
					saveUserList(data, num);
					$('span.deem').css('display', 'none');
					$('div.loadingbar').css('display', 'none');
				}
				, error: function (data) {
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
		function saveUserList(data, num) {
			userInfoList = new Array();

			count = $('totalCount', data).text();

			pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": ' + count + ', "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": ' + parseInt((count - 1) / 10 + 1) + '} ');
			paginavigation("paginationUser", pageObj, "drawUserList");

			if (count > 0) {
				$('managerUserInfoList', data).each(function () {
					cdsid = $('userid', this).text();
					firstName = $('givenname', this).text();
					lastName = $('sn', this).text();
					employeenumber = $('employeenumber', this).text();
					localemployeenumber = $('imstring05', this).text();
					employeetype = $('employeetype', this).text();
					country = $('destinationindicator', this).text();
					department = $('departmentnumber', this).text();
					managerId = $('immanagerid', this).text();
					employeeStatus = $('imemployeestatus', this).text();

					var jsonString = '{"cdsid": "' + cdsid + '", "employeeStatus": "' + employeeStatus + '", "firstName": "' + firstName + '", "lastName": "' + lastName + '", "employeenumber": "' + employeenumber + '", "localemployeenumber": "' + localemployeenumber + '", "employeetype": "' + employeetype + '", "country": "' + country + '", "department": "' + department + '", "managerId": "' + managerId + '"} ';
					jsonString = jsonString.replace(/N\\A/gi, "N/A");
					jsonString = jsonString.replace(/\t/gi, " ");
					itemObj = $.parseJSON(jsonString);
					userInfoList.push(itemObj);
				});
			}
			drawUserList(num);
		}

		/**
		 * 사용자 목록 그리기
		 * @param no		(int) page number
		 * @since 2.2, 2014-08-13
		 */
		function drawUserList(no) {
			$('#userListDiv').html('');

			if ($.isEmptyObject(userInfoList)) {
				$('#userListDiv').append("<tr><td colspan='11' class='center' style='text-align:center  !important;'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
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

				for (var i = pageObj.startRow - 1; i < pageObj.endRow; i++) {
					cdsid = userInfoList[i].cdsid;
					firstName = userInfoList[i].firstName;
					lastName = userInfoList[i].lastName;
					employeenumber = userInfoList[i].employeenumber;
					localemployeenumber = userInfoList[i].localemployeenumber;
					employeetype = userInfoList[i].employeetype;
					country = userInfoList[i].country;
					department = userInfoList[i].department;
					managerId = userInfoList[i].managerId;
					employeeStatus = userInfoList[i].employeeStatus;
					html = "<tr>"
						+ "<td class='center'>" + employeeStatus + "</td>"
						+ "<td class='center'><a href='javascript:showUserDetails(\"" + cdsid + "\");'>" + cdsid + "</a></td>"
						+ "<td class='center'>" + firstName + "</td>"
						+ "<td class='left'>" + lastName + "</td>"
						+ "<td class='center'>" + employeenumber + "</td>"
						+ "<td class='center'>" + localemployeenumber + "</td>"
						+ "<td class='center'>" + employeetype + "</td>"
						+ "<td class='center'>" + country + "</td>"
						+ "<td class='center'>" + department + "</td>"
						+ "<td class='center' id = '" + cdsid + "_Manager'>" + managerId + "</td>"
						+ "<td class='center'> <button name='Edit' class='indent' onclick='goSelectManager(\""+cdsid+"\")'> Edit </button> </td>"
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
			if (key == orderUserBy) {
				if (toggleAsc) {
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
		function showUserDetails(guid) {
			$('.layer_popup').remove();
			$.ajax({
				url: '/admin/supplier/view.do'
				, type: 'post'
				, dataType: 'xml'
				, data: 'userid=' + guid
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
		/**
			* goSelectManager
			* @since 2022-05-06
			*/
		function goSelectManager(value) {
			$('.layer_popup').remove();
			popupTemp = value;
			var params = {};
			params.popup = 'SLCM';
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
		function SaveAction(value) {
			if (confirm("Do you want to save your changes?")) {
				//Tews 호출 뒤 페이지 새로고침 or 목록 재 검색 필요.( 재 검색 시 현재 변경한 항목 나오도록.) 임시로 Html만 변경 하도록 함.
				closePopup('selectManager');
				document.getElementById(popupTemp + "_Manager").innerHTML = value;
				popupTemp = "";
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
				<h1><a href="/admin/home.do" title="Hanon Systems Administrator Page Home"><img
							src="/images/skin/common/logo.png" alt="HOME Hanon Systems" /></a></h1>
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
						<spring:message code="lnb.SAM.SLCM" text="Supplier List (Check Manager)" />
					</h3>

					<p class="page_navigation">
						<strong>
							<spring:message code="lnb.SAM.SLCM" text="Supplier List (Check Manager)" />
						</strong>
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
						<div id="searchbox">
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
									<option value="name">
										<spring:message code="label.name" text="Name" />
									</option>
								</select>
								<input type="text" class="indent" style="width:35%; height:17px;"
									name="content" />
								<a href="javascript:getManagerListSearch()"><img
										src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</div>
							<!-- //(searchbox) -->
						</div>
					</div>
					<!-- //(searchbox) -->

					<!-- (board_01) -->
					<table class="board_01" summary="User Quick Menu">
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
								<th scope="col"><a href="javascript:sortBy('employeestatus')">
										<spring:message code="page.status" text="Status" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('cdsid')">
										<spring:message code="page.cdsid" text="CDSID" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('managerId')">
										<spring:message code="page.managerId" text="First Name" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('name')">
										<spring:message code="label.nameEngLocal" text="Last Name" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('employeeType')">
										<spring:message code="label.employeeType" text="Employee Number" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('companyName')">
										<spring:message code="label.companyName"
											text="Local Employee Number" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('companyName')">
										<spring:message code="label.companyName" text="Employee Type" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('companyName')">
										<spring:message code="label.companyName" text="Country" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('companyName')">
										<spring:message code="label.companyName" text="department" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('managerId')">
										<spring:message code="label.managerId" text="Manager ID" />
									</a></th>
								<th scope="col">
									<spring:message code="label.edit" text="Edit" />
								</th>
							</tr>
						</thead>
						<!-- User 목록 가져오기 Display Start-->
						<tbody id="userListDiv"></tbody>
						<!-- User 목록 가져오기 Display End-->
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

	<span class="deem" style="display: none;"></span> <!-- (반투명막) -->
	<div class="loadingbar" style="display: none;">
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
