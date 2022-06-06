<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<jsp:include page="/WEB-INF/jsp/include/head.jsp" flush="false" />
	<title>Hanon Systems Administrator Page
		<spring:message code="lnb.IU.VU.UD" text="User Details" />
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
		var IMUserStore;
		var IMUserInfo;
		var KRUserInfo;
		$(document).ready(function () {
			init();
		});

		function init() {
			//left_menu 펼쳐 놓기
			$(".IM-User").addClass("on");
			$(".IM-User").find(" > ul").show();
			$(".viewuser > a").addClass("highlight");
			// 사용자 목록 표시
		}

		function goList() {
			var form = document.createElement('form');
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

			form.appendChild(obj1);
			form.appendChild(obj2);
			form.appendChild(obj3);
			form.appendChild(obj4);
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/imuser/IMUserList.do');

			document.body.appendChild(form);
			form.submit();
		}
		function closeAlert() {
			$('#loadingbar').css('display', 'none');
			$('#M365Loadingbar').css('display', 'none');
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
						<spring:message code="lnb.IU.VU.UD" text="User Details" />
					</h3>

					<p class="page_navigation">
						<strong>
							<spring:message code="lnb.IU.VU.UD" text="User Details" />
						</strong>
						<span>
							<spring:message code="lnb.IU.VU" text="View User" />
						</span>
						<span>
							<spring:message code="lnb.IU" text="IM User Management" />
						</span>
						<img alt="home" src="/images/skin/common/icon_home.png">
					</p>
				</div>
				<!-- //(location) -->
				<div>
					<div class="clear mgb_10">
						<div id="searchbox">
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
						</div>
					</div>

					<div class="mgl_20" style="position: relative; width: 24%;">
						<jsp:include page="IMUserStore.jsp" />
					</div>

					<div class="mgl_20" style="width: 17%;">
						<jsp:include page="SuccessFactors.jsp" />
					</div>

					<div class="mgl_20" style="width: 17%;">
						<jsp:include page="KoreaHRIS.jsp" />
					</div>

					<div class="mgl_20" style="width: 17%;">
						<jsp:include page="HanonPortal.jsp" />
					</div>

					<div class="mgl_20" style="width: 17%;">
						<jsp:include page="Microsoft365.jsp" />
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

	<span class="deem" style="display: none;"></span> <!-- (반투명막) -->
	<div class="loadingbar" id="loadingbar" style="display: none;">
		<div class="position_loading">
			<p><img src="/images/common/loading.gif" alt="" /></p>
			<dl>
				<dt>Certification in progress</dt>
				<dd>Once authentication is complete, go to the Portal.</dd>
			</dl>
		</div>
	</div>
	<div class="loadingbar" id="M365Loadingbar" style="display: none;">
		<div class="position_loading">
			<p><img src="/images/common/loading.gif" alt="" /></p>
			<dl>
				<dt>Certification in progress</dt>
				<dd>It takes more than a 1 minute.</dd>
			</dl>
		</div>
	</div>
	<jsp:include page="UserInfoCompare.jsp" />
</body>

</html>

<style>
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

	.board_01 tbody tr td {
		background: #FFFFFF;
		text-align: left !important;
		color: #003a5d;
		border-top: 1px solid #e8e8e8;
		border-collapse: collapse;
		height: 13px;
		vertical-align: middle;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
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

	.board_01 {
		width: 100%;
		table-layout: fixed;
	}

	.non {
		background: #D9D9D9 !important;
	}

	.mgl_20 {
		width: 13%;
		float: left;
	}

	.UserStore th {
		background: #1451A4 !important;
		color: #FFFFFF !important;
	}

	.df {
		background: #F9D9D2 !important;
	}
</style>