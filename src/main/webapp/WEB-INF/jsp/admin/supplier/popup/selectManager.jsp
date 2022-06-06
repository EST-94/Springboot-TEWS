<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

	$(document).ready(function () {
		init();
	});

	function init() {
		var Data = "<result><totalCount>0</totalCount></result>"
		saveChangeManagerList(Data);
	}
	function getManagerList() {
		$('span.deem').css('display', 'block');
		$('div.loadingbar').css('display', 'block');
		var params = {};
		if ($('#pop_contents input[name=ChangeManagerContent]').val().length > 0) {
			params.title = $('#pop_contents select[name=ChangeManagerTitle]').val();
			params.content = $('#pop_contents input[name=ChangeManagerContent]').val();
		}
		// 사용자 조회 시작
		$.ajax({
			url: '/admin/supplier/searchManagerListPopup.do'
			, type: 'post'
			, dataType: 'xml'
			, data: params
			, success: function (data) {
				//console.log(data);
				saveChangeManagerList(data);
				$('span.deem').css('display', 'none');
				$('div.loadingbar').css('display', 'none');
			}
			, error: function (data) {
				//console.log(data);
			}
		});
	}
	/**
	 * 사용자 목록 저장 및 페이징 처리
	 * @param data		{@link ReturnLocalUserInfo} List of LocalUserInfo
	 * @since 2.2, 2014-08-13
	 */
	function saveChangeManagerList(data) {
		ChangeManagerInfoList = new Array();

		count = $('totalCount', data).text();

		pageObj = $.parseJSON('{"prevPage": false, "nextPage": true, "nowPage": 1, "rowTotal": ' + count + ', "blockList": 10, "blockPage": 10, "endPage": 10, "endRow": 10, "startPage": 1, "startRow": 1, "totalPage": ' + parseInt((count - 1) / 10 + 1) + '} ');
		paginavigation("paginationChangeManager", pageObj, "drawChangeManagerList");

		if (count > 0) {
			$('managerUserInfoList', data).each(function () {
				//console.log(data);
				cdsid = $('userid', this).text();
				name = $('cn', this).text();

				var jsonString = '{"cdsid": "' + cdsid + '", "name": "' + name + '"} ';
				jsonString = jsonString.replace(/N\\A/gi, "N/A");
				jsonString = jsonString.replace(/\t/gi, " ");
				itemObj = $.parseJSON(jsonString);
				//itemObj = $.parseJSON('{"cdsid": "' + cdsid + '", "managerId": "' + managerId + '", "name": "' + name + '", "employeeStatus": "' + employeeStatus + '", "employeType": "' + employeType + '", "companyName": "' + companyName + '", "activationDate": "' + activationDate + '", "expirationDate": "' + expirationDate + '"} ');
				ChangeManagerInfoList.push(itemObj);
			});
		}
		drawChangeManagerList(1);
	}
	/**
	 * 사용자 목록 그리기
	 * @param no		(int) page number
	 * @since 2.2, 2014-08-13
	 */
	function drawChangeManagerList(no) {
		$('#ChangeManagerListDiv').html('');

		if ($.isEmptyObject(ChangeManagerInfoList)) {
			$('#ChangeManagerListDiv').append("<tr><td colspan='3' class='center' style='text-align:center  !important;'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
			$('#paginationChangeManager').text('');
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

			paginavigation("paginationChangeManager", pageObj, "drawChangeManagerList");

			for (var i = pageObj.startRow - 1; i < pageObj.endRow; i++) {
				cdsid = ChangeManagerInfoList[i].cdsid;
				name = ChangeManagerInfoList[i].name;
				html = "<tr>"
					+ "<td class='center'><input type='radio' name='manager' id='" + cdsid + "' value='" + cdsid + "' ></input></td>"
					+ "<td class='center'><label for='" + cdsid + "'>" + cdsid + "</label></td>"
					+ "<td class='center'><label for='" + cdsid + "'>" + name + "</label></td>"
				html += "</tr>";

				$('#ChangeManagerListDiv').append(html);
			}
		}
	}
	function onSave() {
		SaveAction($('input[name=manager]:checked').val());
	}
	function onCancel() {
		closePopup('selectManager');
	}
</script>


<div id='selectManagerRoot' class='layer_popup'>
	<!-- (layerpop - View User) -->
	<div class="layer_pop showpop" id="reg_div">
		<div class="pop_wrap">
			<p class="tit">
				<spring:message code="label.selectManager" text="Select Manager" />
			</p>

			<div id="pop_contents" class="pop_contents">

				<div class="right" id="searchbox">
					<!-- (searchbox) -->
					<div class="regionbox">
						<span class="region_txt">
							<spring:message code="button.search" text="Search" />
						</span>
						<select name="ChangeManagerTitle" title="Search Type" class="onclick">
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
						<input type="text" id="ChangeManagerContent" maxlength="30" class="indent"
							onkeyup="enterkey()" style="width: 35%; height: 17px;"
							name="ChangeManagerContent" />
						<a href="javascript:getManagerList()"><img src="/images/skin/btn/btn_allsearch.gif"
								alt="search" /></a>
					</div>
					<!-- //(searchbox) -->
				</div>
				<div>
					<!--  style="overflow-y: scroll; -->
					<table class="board_01" summary="">
						<caption></caption>
						<colgroup>
							<col width="10%" />
							<col width="45%" />
							<col width="45%" />
						</colgroup>
						<thead>
							<th scope="col">
							</th>
							<th scope="col">
								<spring:message code="label.cdsid" text="CDSID" />
							</th>
							<th scope="col">
								<spring:message code="label.Name" text="Name" />
							</th>
						</thead>

						<tbody id="ChangeManagerListDiv"></tbody>

					</table>
					<div id="paginationChangeManager" class="paging"></div>

				</div>
				<c:choose>
					<c:when test="${popupType eq 'SD'}">
						<div class="right">
							<button onclick="onSave()">
								<spring:message code="label.save" text="Select" />
							</button>
							<button onclick="onCancel()">
								<spring:message code="label.cancel" text="Cancel" />
							</button>
						</div>
					</c:when>
					<c:otherwise>
						<div class="right">
							<button onclick="onSave()">
								<spring:message code="label.save" text="Save" />
							</button>
							<button onclick="onCancel()">
								<spring:message code="label.cancel" text="Cancel" />
							</button>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<a href="javascript:closePopup('selectManager')" class="btn_pop_close"><img
				src="/images/skin/btn/btn_pop_close.gif" alt="close" /></a>
	</div>
	<!-- //(layerpop - View User) -->
</div>
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
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	}

	.nodeSel {
		font-weight: bold;
	}
</style>
