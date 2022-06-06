<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
	<title>Hanon Systems Administrator Page
		<spring:message code="lnb.IU.VU" text="View User" />
	</title>
	<!-- (paging) -->
	<script type="text/javascript">
		var tempparam = {};
		var officeUsersList;
		var pageObj;

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
			$(".IM-User").addClass("on");
			$(".IM-User").find(" > ul").show();
			$(".viewuser > a").addClass("highlight");
			// 사용자 목록 표시
			//getUserList();

			$(':input[name=content]').val('${contentViewUser}');
			$(":radio[name=emp_status][value='${emp_status}']").prop('checked', true);
			$("select[name=title]").val('${titleViewUser}').prop('selected', true);
			if('${contentViewUser}' == ''){
				var Data = "<result><totalCount>0</totalCount></result>"
				saveUserList(Data,1);
			}else{
				getUserListSearch('${ViewUserPageNo}');
			}
		}

		function enterkey() {
			if (window.event.keyCode == 13) {
				getUserListSearch(1);
			}
		}
		function getUserListSearch(num) {
			tempparam.title = $("select[name=title]").val();
			tempparam.content = $(':input[name=content]').val();
			tempparam.status = $(':radio[name=emp_status]:checked').val();
			getUserList(num);
		}
		function getUserList(num) {
			$('span.deem').css('display', 'block');
			$('div.loadingbar').css('display', 'block');
			if ($(':input[name=content]').val() == '') {
				alert('Please enter a Search keyword.');
				$(':input[name=content]').focus();
				$('span.deem').css('display', 'none');
				$('div.loadingbar').css('display', 'none');
			} else {
				var params = {};
				if(!isEmpty(tempparam.status)){
				params.status = tempparam.status;
				}else{params.status='1'}
				if(!isEmpty(tempparam.title)){
					params.title = tempparam.title;
				}else{params.executeEndDateTime=''}
				if(!isEmpty(tempparam.content)){
					params.content = tempparam.content;
				}else{params.content=''}
				// 사용자 조회 시작
				$.ajax({
					url: '/admin/imuser/searchIMUserList.do'
					, type: 'post'
					, dataType: 'xml'
					, data: params
					, success: function (data) {
						//console.log(data)
						saveUserList(data,num);
						$('span.deem').css('display', 'none');
						$('div.loadingbar').css('display', 'none');
					}
					, error: function (data) {
						//console.log("Error");
						//console.log(data);
						$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
						$('div.position_loading').children('dl').children('dt').html("Selected failed");
					}
				});
			}
		}

		var userInfoList;
		var pageObj;

		function saveUserList(data,no) {
			userInfoList = new Array();
			count = $('totalCount', data).text();
			pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": ' + count + ', "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": ' + parseInt((count - 1) / 10 + 1) + '} ');
			paginavigation("paginationUser", pageObj, "drawUserList");

			if (count > 0) {
				$('iMUserInfoList', data).each(function () {

					cdsid = $('uid', this).text();
					employeestatus = $('imEmployeeStatus', this).text();
					firstname = $('givenName', this).text();
					lastname = $('sn', this).text();
					employeenumber = $('employeeNumber', this).text();
					localemployeenumber = $('imstring05', this).text();
					employeetype = $('employeeType', this).text();
					country = $('destinationIndicator', this).text();
					department = $('departmentNumber', this).text();
					manager = $('imManagerId', this).text();
					activationdate = $('imActivationDate', this).text();
					expirationdate = $('imExpirationDate', this).text();

					var jsonString = '{"cdsid": "' + cdsid + '", "employeeStatus": "' + employeestatus + '", "firstname": "' + firstname + '", "lastname": "' + lastname + '", "employeenumber": "' + employeenumber + '", "localemployeenumber": "' + localemployeenumber + '", "employeetype": "' + employeetype + '", "country": "' + country + '", "department": "' + department + '", "manager": "' + manager + '", "activationdate": "' + activationdate + '", "expirationdate": "' + expirationdate + '"} '
					jsonString = jsonString.replace(/N\\A/gi, "N/A")
					jsonString = jsonString.replace(/\t/gi, " ")
					itemObj = $.parseJSON(jsonString);
					userInfoList.push(itemObj);
				});
			}
			drawUserList(no);
		}

		/**
		 * 사용자 목록 그리기
		 * @param no		(int) page number 
		 * @since 2.2, 2014-08-13
		 */
		function drawUserList(no) {
			$('#userListDiv').html('');

			if ($.isEmptyObject(userInfoList)) {
				$('#userListDiv').append("<tr><td colspan='12' class='center'style='text-align:center  !important;'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
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
					employeeStatus = userInfoList[i].employeeStatus;
					firstname = userInfoList[i].firstname;
					lastname = userInfoList[i].lastname;
					employeenumber = userInfoList[i].employeenumber;
					localemployeenumber = userInfoList[i].localemployeenumber;
					employeetype = userInfoList[i].employeetype;
					country = userInfoList[i].country;
					department = userInfoList[i].department;
					manager = userInfoList[i].manager;
					activationdate = userInfoList[i].activationdate;
					expirationdate = userInfoList[i].expirationdate;

					html = "<tr onclick='javascript:showUserDetail(\"" + cdsid + "\")'>"
						+ "<td class='center'>" + employeeStatus + "</td>"
						+ "<td class='center'>" + cdsid + "</td>"
						+ "<td class='center'>" + firstname + "</td>"
						+ "<td class='left'>" + lastname + "</td>"
						+ "<td class='center'>" + employeenumber + "</td>"
						+ "<td class='center'>" + localemployeenumber + "</td>"
						+ "<td class='center'>" + employeetype + "</td>"
						+ "<td class='center'>" + country + "</td>"
						+ "<td class='center'>" + department + "</td>"
						+ "<td class='center'>" + manager + "</td>"
						+ "<td class='center'>" + activationdate + "</td>"
						+ "<td class='center'>" + expirationdate + "</td>"
						+ "</tr>";

					$('#userListDiv').append(html);
				}
			}
		}
		/**
		 * 사용자 상세 보기 페이지 이동
		 * @param 
		 * @since 1.0, 2021-12-14
		 */
		function showUserDetail(cdsid) {
			var form = document.createElement('form');
			var obj1 = document.createElement('input');
			obj1.setAttribute("type", "hidden");
			obj1.setAttribute("name", "urid");
			obj1.setAttribute("value", cdsid);

			var obj2 = document.createElement('input');
			obj2.setAttribute("type", "hidden");
			obj2.setAttribute("name", "contentViewUser");
			obj2.setAttribute("value", tempparam.content);

			var obj3 = document.createElement('input');
			obj3.setAttribute("type", "hidden");
			obj3.setAttribute("name", "titleViewUser");
			obj3.setAttribute("value", tempparam.title);
			
			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "emp_status");
			obj4.setAttribute("value", tempparam.status);

			var obj5 = document.createElement('input');
			obj5.setAttribute("type", "hidden");
			obj5.setAttribute("name", "ViewUserPageNo");
			obj5.setAttribute("value", pageObj.nowPage);

			form.appendChild(obj1);
			form.appendChild(obj2);
			form.appendChild(obj3);
			form.appendChild(obj4);
			form.appendChild(obj5);
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/imuser/ImUserDetails.do');

			document.body.appendChild(form);
			form.submit();
		}

		function closeAlert() {
			$('div.loadingbar').css('display', 'none');
			$('span.deem').css('display', 'none');
			$('div.position_loading').children('p').html("<img src='/images/common/loading.gif' alt='' />");
			$('div.position_loading').children('dl').children('dt').html("Certification in progress");
			$('div.position_loading').children('dl').children('dd').html("Once authentication is complete, go to the Portal.");
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
						<spring:message code="lnb.IU.VU" text="View User" />
					</h3>

					<p class="page_navigation">
						<strong>
							<spring:message code="lnb.IU.VU" text="View User" />
						</strong> <span>
							<spring:message code="lnb.IU" text="IM User Management" />
						</span> <img alt="home" src="/images/skin/common/icon_home.png">
					</p>
				</div>
				<!-- //(location) -->

				<div class="mgl_20">
					<!-- (searchbox) -->
					<div class="clear mgb_10">
						<p class="fleft pdt_5">
							<input type="radio" class="radio" name="emp_status" value="1" checked="checked" /> <span
								class="font11 co_666">
								<spring:message code="label.Active" text="Active" />
							</span> &nbsp;&nbsp; <input type="radio" class="radio" name="emp_status" value="2" /> <span
								class="font11 co_666">
								<spring:message code="label.InActive" text="InActive" />
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
									<option value="Name">
										<spring:message code="label.name" text="Name" />
									</option>
									<option value="managerId">
										<spring:message code="label.managerId" text="Manager ID" />
									</option>
								</select>
								<input type="text" class="indent" maxlength="30" id="content" onkeyup="enterkey()" style="width: 35%; height: 17px;"
									name="content" /> <a href="javascript:getUserListSearch(1)"><img
										src="/images/skin/btn/btn_allsearch.gif" alt="search" /></a>
							</div>
							<!-- //(searchbox) -->
						</div>
					</div>
					<!-- //(searchbox) -->

					<!-- (board_01) -->
					<input type="hidden" name="office365usersCnt" id="office365usersCnt" value="">
					<table class="board_01" summary="User Quick Menu">
						<caption></caption>
						<colgroup>
							<col width="6%">
							<col width="6%">
							<col width="6%">
							<col width="6%">
							<col width="9%">
							<col width="9%">
							<col width="9%">
							<col width="8%">
							<col width="12%">
							<col width="8%">
							<col width="8%">
							<col width="8%">
						</colgroup>
						<thead>
							<%-- <tr>
								<th scope="col"><a href="javascript:sortBy('userprincipalname')">
										<spring:message code="page.userprincipalname" text="USERPRINCIPALNAME" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('city')">
										<spring:message code="label.city" text="CITY" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('title')">
										<spring:message code="label.title" text="TITLE" />
									</a></th>
								<th scope="col"><a href="javascript:sortBy('fax')">
										<spring:message code="label.fax" text="FAX" />
									</a></th>
								</tr> --%>
								<tr>
									<th scope="col">Status</th>
									<th scope="col">CDSID</th>
									<th scope="col">First Name</th>
									<th scope="col">Last Name</th>
									<th scope="col">Employee Number</th>
									<th scope="col">Local Employee Number</th>
									<th scope="col">Employee Type</th>
									<th scope="col">Country</th>
									<th scope="col">Department</th>
									<th scope="col">Manager</th>
									<th scope="col">Activation Date</th>
									<th scope="col">Expiration Date</th>
								</tr>
						</thead>

						<!-- Batch Job 목록 가져오기 Display Start-->
						<tbody id="userListDiv"></tbody>
						<!-- Batch Job 목록 가져오기 Display End-->
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