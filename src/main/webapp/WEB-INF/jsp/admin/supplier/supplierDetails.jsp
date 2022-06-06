<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
	<title>Hanon Systems Administrator Page
		<spring:message code="lnb.SAM.ML.MD.SD" text="Supplier Details" />
	</title>
	<!-- (paging) -->
	<script type="text/javascript">
		var EditMode = false;
		var tempManagerId = '${userTempVO.immanagerid}';
		var popupManagerId = "";
		var tempparam = {};
		$(document).ready(function () {
			init();
		});
		function SaveAction(value) {
			popupManagerId = value;
			document.getElementById('managerCdsid').innerHTML=value;
			closePopup('selectManager');
		}
		function init() {
			//left_menu 펼쳐 놓기
			$(".Supplier").addClass("on");
			$(".Supplier").find(" > ul").show();
			$(".managerList > a").addClass("highlight");
		}
		/**
		* goSelectManager
		* @since 2022-05-06
		*/
		function goSelectManager() {
			var params = {};
			params.popup = 'SD';
			$('.layer_popup').remove();
			$.ajax({
				url: '/admin/supplier/selectManager.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data, status, error) {
					$('body').append(error.responseText);
				}, error: function (data, status, error) {
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
			obj3.setAttribute("name", "ManagerEmpStatus");
			obj3.setAttribute("value", '${ManagerEmpStatus}');

			var obj4 = document.createElement('input');
			obj4.setAttribute("type", "hidden");
			obj4.setAttribute("name", "ManagerPageNo");
			obj4.setAttribute("value", '${ManagerPageNo}');

			var obj5 = document.createElement('input');
			obj5.setAttribute("type", "hidden");
			obj5.setAttribute("name", "managerDetailContent");
			obj5.setAttribute("value", '${managerDetailContent}');

			var obj6 = document.createElement('input');
			obj6.setAttribute("type", "hidden");
			obj6.setAttribute("name", "managerDetailTitle");
			obj6.setAttribute("value", '${managerDetailTitle}');

			var obj7 = document.createElement('input');
			obj7.setAttribute("type", "hidden");
			obj7.setAttribute("name", "managerDetailStatus");
			obj7.setAttribute("value", '${managerDetailStatus}');

			var obj8 = document.createElement('input');
			obj8.setAttribute("type", "hidden");
			obj8.setAttribute("name", "managerDetailPageNo");
			obj8.setAttribute("value", '${managerDetailPageNo}');

			var obj9 = document.createElement('input');
			obj9.setAttribute("type", "hidden");
			obj9.setAttribute("name", "urid");
			obj9.setAttribute("value", '${userTempVO.immanagerid}');

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
			form.setAttribute('action', '/admin/supplier/managerDetails.do');

			document.body.appendChild(form);
			form.submit();
		}
		function goSave(){
			if(popupManagerId != tempManagerId && popupManagerId != ""){
				if(confirm("Do you want to save your changes?")){
					goList();
					// 저장 위한 Ajax 호출 필요 ( Tews 호출하여 update 후 , 페이지 이동 해야 합니다. 일단 임시로 goList호출함 )
				}
			}else{
				alert("There are no changes.");
			}

		}
		function goEdit(){
			EditMode = true;
			$('#changeManager').css('display','block');
			$('#editOff').css('display', 'none');
			$('#editOn').css('display', 'block');
		}
		function goCancel(){
			EditMode = false;
			popupManagerId = "";
			document.getElementById('managerCdsid').innerHTML = tempManagerId;
			$('#changeManager').css('display','none');
			$('#editOn').css('display', 'none');
			$('#editOff').css('display', 'block');
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
						<spring:message code="lnb.SAM.ML.MD.SD" text="Supplier Details" />
					</h3>

					<p class="page_navigation">
						<strong>
							<spring:message code="lnb.SAM.ML.MD.SD" text="Supplier Details" />
						</strong>
						<span>
							<spring:message code="lnb.SAM.ML.MD" text="Manager Details" />
						</span>
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
								<th scope="col" >
										<div class="left" style="width:22%; float:left;"><spring:message code="label.managerCdsid" text="Manager CDSID" /></div>
										<div id = "changeManager" class="right" style="width:30%; float: right; margin-right: 5px; display: none;">
											<button name="changeManager" class="indent" onclick="goSelectManager()" >
												<spring:message code="label.changeManager" text="Change Manager" />
											</button>
										</div>
								</th>
								<td scope="col" id="managerCdsid">${userTempVO.immanagerid}</td>
								<th scope="col">
									<spring:message code="label.status" text="Manager Status" />
								</th>
								<td scope="col">${userTempVO.managerStatus}</td>
							</tr>
							<tr>
								<th scope="col">
									<spring:message code="label.managerCdsid" text="Supplier CDSID" />
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
						<div class="right" id="searchbox">
							<div id="editOff" style="display: block;">
								<button name="back_list" class="indent" onclick="goEdit()">
									<spring:message code="label.edit" text="Edit" />
								</button>
							</div>
							<div id="editOn" style="display: none;">
								<button name="back_list" class="indent" onclick="goSave()">
									<spring:message code="label.save" text="Save" />
								</button>
								<button name="back_list" class="indent" onclick="goCancel()">
									<spring:message code="label.cancel" text="Cancel" />
								</button>
							</div>

						</div>
						</p>
					</div>
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
