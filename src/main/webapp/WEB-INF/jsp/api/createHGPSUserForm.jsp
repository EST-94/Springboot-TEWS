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
var row = 0;
var idx = 1;
var idxList = new Array();

$(document).ready(function(){

	init();
	
	// Calendar 적용
	for(var i = 0; i < $(".date").length; i++){
		var thisId= $(".date").eq(i).attr("id");
		var thisIdEl = $("#"+thisId);
		thisIdEl.datepicker({ dateFormat: 'yymmdd' });
	}
});

function init() {
	
}

function saveSupplierAccount() {
	if(confirm("Register Supplier Account?")){
		if(validationCheck()){
			$("#row").val(row);
			$("#idx").val(idx);
			$("#idxList").val(idxList);
			var params = $("#createHGPSForm").serialize();
			
 			$('span.deem').css('display', 'block');
			$('div.loadingbar').css('display', 'block');
			
			$.ajax({
				url: '/api/saveHGPSFormUserInfo.do'
				, type: 'post'
				, dataType: 'json'
				, data: params
				, success: function(data) {
					$('span.deem').css('display','none');
					$('div.loadingbar').css('display','none');
					console.log(data);
					if(data.success == true) {
						drawSaveResult(data);
						alert("HGPS Supplier Account Create Success!\nPassword send to E-mail");
					} else {
						alert(data.value);
					}
				}
				, error: function(data) {
					//console.log(data);
				}
			});	
		}
	}
}

function drawSaveResult(data) {
	$("#primaryUserId").val(data.userid);
	if(row > 0) {
		$.each(data, function(key, value){
			for(var i=0; i < idxList.length ; i++){ 
				if(key == "userid" + idxList[i]) { // Assign userid
					$("#secondaryUserId"+idxList[i]).val(value);
				}
			}
		});
		
		$(function(){
			$("#tbCreateForm > tbody > tr > td > a").each(function(){
				if($(this).attr("id") == "btn_remove") $(this).hide();
			});
		});
		
		$("#btn_add").hide();
		$("#btn_save").hide();
	}
}

function addSecondaryAccount() {
	row++;
	idxList.push(idx);
	var html = "<tr id='tr" + idx + "'>"
			+ "<input type='hidden' name='tbIdx" + idx + "' value='" + idx + "'/>"
			+ "<td colspan='8' align='center'>Secondary Supplier Account"
			+ "<a class='btn_white' id='btn_remove' href='javascript:removeSecondaryAccount(" + idx + ");'>"
			+ "<span><spring:message code='button.remove' text='Remove Row'/></span>"
			+ "</a>"
			+ "</td>"
			+ "</tr>"
			+ "<tr id='tr" + idx + "'>"
			+ "<th scope='row'><spring:message code='page.userid' text='User ID' /></th>"
			+ "<td colspan='8'>"
			+ "<input type='text' name='secondaryUserId" + idx + "' id='secondaryUserId" + idx + "' readonly='readonly' style='width: 265px;'>"
			+ "<span class='highlight_red'>＊ Create by IM (read only)</span>"
			+ "</td>"
			+ "</tr>"
			+ "<tr id='tr" + idx + "'>"
			+ "<th scope='row'><spring:message code='page.localFirstName' text='Local First Name' />&nbsp;<span class='highlight_red'>(Required)</span></th>"
			+ "<td><input type='text' title='Local First Name' name='secondaryLocalFirstName" + idx + "' id='secondaryLocalFirstName" + idx + "' style='width: 265px;' class='required'></td>"
			+ "<th scope='row'><spring:message code='page.localLastName' text='Local Last Name' />&nbsp;<span class='highlight_red'>(Required)</span></th>"
			+ "<td><input type='text' title='Local Last Name' name='secondaryLocalLastName" + idx + "' id='secondaryLocalLastName" + idx + "' style='width: 265px;' class='required'></td>"
			+ "<th scope='row'><spring:message code='page.firstName' text='Global First Name' />&nbsp;<span class='highlight_red'>(Required)</span></th>"
			+ "<td><input type='text' title='Global First Name' name='secondaryGlobalFirstName" + idx + "' id='secondaryGlobalFirstName" + idx + "' style='width: 265px;' class='required'></td>"
			+ "<th scope='row'><spring:message code='page.lastName' text='Global Last Name' />&nbsp;<span class='highlight_red'>(Required)</span></th>"
			+ "<td><input type='text' title='Global Last Name' name='secondaryGlobalLastName" + idx + "' id='secondaryGlobalLastName" + idx + "' style='width: 265px;' class='required'></td>"
			+ "</tr>"
			+ "<tr id='tr" + idx + "'>"
			+ "<th scope='row'><spring:message code='page.compCode' text='Company Code' />&nbsp;<span class='highlight_red'>(Required)</span></th>"
			+ "<td><input type='text' title='Company Codee' name='secondaryCompCode" + idx + "' id='secondaryCompCode" + idx + "' style='width: 265px;' class='required'></td>"
			+ "<th scope='row'><spring:message code='page.compName' text='Company Name' />&nbsp;<span class='highlight_red'>(Required)</span></th>"
			+ "<td><input type='text' title='Company Name' name='secondaryCompName" + idx + "' id='secondaryCompName" + idx + "' style='width: 265px;' class='required'></td>"
			+ "<th scope='row'><spring:message code='page.compEName' text='Company English Name' /></th>"
			+ "<td><input type='text' name='secondaryCompEName" + idx + "' id='secondaryCompEName" + idx + "' style='width: 265px;'></td>"
			+ "<th scope='row'><spring:message code='page.compType' text='Company Type' /></th>"
			+ "<td><input type='text' name='secondaryCompType" + idx + "' id='secondaryCompType" + idx + "' style='width: 265px;'></td>"
			+ "</tr>"
			+ "<tr id='tr" + idx + "'>"
			+ "<th scope='row'><spring:message code='page.compTel' text='Company Tel' /></th>"
			+ "<td><input type='text' name='secondaryCompTel" + idx + "' id='secondaryCompTel" + idx + "' style='width: 265px;' onkeydown='onlyNum();'></td>"
			+ "<th scope='row'><spring:message code='page.compFax' text='Company Fax' /></th>"
			+ "<td><input type='text' name='secondaryCompFax" + idx + "' id='secondaryCompFax" + idx + "' style='width: 265px;' onkeydown='onlyNum();'></td>"
			+ "<th scope='row'><spring:message code='page.compPostalCode' text='Company Postal Code' /></th>"
			+ "<td><input type='text' name='secondaryCompPost" + idx + "' id='secondaryCompPost" + idx + "' style='width: 265px;'></td>"
			+ "<th scope='row'><spring:message code='page.compAddress' text='Company Address' /></th>"
			+ "<td><input type='text' name='secondaryCompAddress" + idx + "' id='secondaryCompAddress" + idx + "' style='width: 265px;'></td>"
			+ "</tr>"
			+ "<tr id='tr" + idx + "'>"
			+ "<th scope='row'><spring:message code='page.erpCode' text='ERP Code' /></th>"
			+ "<td><input type='text' name='secondaryErpCode" + idx + "' id='secondaryErpCode" + idx + "' style='width: 265px;'></td>"
			+ "<th scope='row'><spring:message code='page.hgpsCode' text='HGPS Code' /></th>"
			+ "<td><input type='text' name='secondaryHgpsCode" + idx + "' id='secondaryHgpsCode" + idx + "' style='width: 265px;'></td>"
			+ "<th scope='row'><spring:message code='page.fax' text='Fax' /></th>"
			+ "<td><input type='text' name='secondaryFax" + idx + "' id='secondaryFax" + idx + "' style='width: 265px;' onkeydown='onlyNum();'></td>"
			+ "<th scope='row'><spring:message code='page.tel' text='Tel' /></th>"
			+ "<td><input type='text' name='secondaryTel" + idx + "' id='secondaryTel" + idx + "' style='width: 265px;' onkeydown='onlyNum();'></td>"
			+ "</tr>"
			+ "<tr id='tr" + idx + "'>"
			+ "<th scope='row'><spring:message code='page.mobile' text='Mobile' /></th>"
			+ "<td><input type='text' name='secondaryMobile" + idx + "' id='secondaryMobile" + idx + "' style='width: 265px;' onkeydown='onlyNum();'></td>"
			+ "<th scope='row'><spring:message code='page.postalCode' text='Postal Code' /></th>"
			+ "<td><input type='text' name='secondaryPost" + idx + "' id='secondaryPost" + idx + "' style='width: 265px;'></td>"
			+ "<th scope='row'><spring:message code='page.address' text='Address' /></th>"
			+ "<td><input type='text' name='secondaryAddress" + idx + "' id='secondaryAddress" + idx + "' style='width: 265px;'></td>"
			+ "<th scope='row'><spring:message code='page.email' text='Email' />&nbsp;<span class='highlight_red'>(Required)</span></th>"
			+ "<td><input type='text' name='secondaryEmail" + idx + "' id='secondaryEmail" + idx + "' style='width: 265px;' class='email_address required'></td>"
			+ "</tr>"
			+ "<tr id='tr" + idx + "'>"
			+ "<th scope='row'><spring:message code='page.startDate' text='Start Date' /></th>"
			+ "<td><input type='text' name='secondaryStartdate" + idx + "' id='secondaryStartdate" + idx + "' style='width: 265px;' class='date'></td>"
			+ "<th scope='row'><spring:message code='page.endDate' text='End Date' /></th>"
			+ "<td><input type='text' name='secondaryEnddate" + idx + "' id='secondaryEnddate" + idx + "' style='width: 265px;' class='date'></td>"
			+ "<th scope='row'><spring:message code='page.regionCode' text='Region Code' /></th>"
			+ "<td><input type='text' name='secondaryRegionCode" + idx + "' id='secondaryRegionCode" + idx + "' style='width: 265px;'></td>"
			+ "<th scope='row'><spring:message code='page.regionName' text='Region Name' /></th>"
			+ "<td><input type='text' name='secondaryRegionName" + idx + "' id='secondaryRegionName" + idx + "' style='width: 265px;'></td>"
			+ "</tr>"
			+ "<tr id='tr" + idx + "'>"
			+ "<th scope='row'><spring:message code='page.entityCode' text='Entity Code' /></th>"
			+ "<td><input type='text' name='secondaryEntityCode" + idx + "' id='secondaryEntityCode" + idx + "' style='width: 265px;'></td>"
			+ "<th scope='row'><spring:message code='page.entityName' text='Entity Name' /></th>"
			+ "<td><input type='text' name='secondaryEntityName" + idx + "' id='secondaryEntityName" + idx + "' style='width: 265px;'></td>"
			+ "<th scope='row'><spring:message code='page.jobDesc' text='Job Desc' /></th>"
			+ "<td colspan='3'><input type='text' name='secondaryJobDesc" + idx + "' id='secondaryJobDesc" + idx + "' style='width: 265px;'></td>"
			+ "</tr>";
			
	idx++;
	
	$("#tbCreateForm").append(html);
}

function removeSecondaryAccount(idx) {
	$(function(){
		$("#tbCreateForm > tbody > tr").each(function(){
			if($(this).attr("id") == "tr"+idx) $(this).remove();
		});
	});
	idxList = idxList.remove(idx);
	row--;
}

function validationCheck() {
	// Check for required value.	
	for(var i = 0; i < $(".required").length; i++){
		var thisId= $(".required").eq(i).attr("id");
		var thisIdEl = $("#"+thisId);
		
		// Test Function
/*   		var thisName = $(".required").eq(i).attr("name");
		thisIdEl.val(thisName);
		if(thisId.indexOf("Email") != -1) {
			thisIdEl.val(thisName + "@hanonsystems.com");
		} */		
		
		var thisVal = thisIdEl.val();
		if(thisVal == ""){
			var thisTitle = thisIdEl.attr("title");
			alert(thisTitle+" is required.");
			thisIdEl.focus();
			return false;
		}
		
		if(thisId == "reportTo"){ // Save Report To Upper Case
			thisIdEl.val(thisVal.toUpperCase());
		}
	}
	
	// Check for Email address Value.
 	for(var i = 0; i < $(".email_address").length; i++){
		var thisId= $(".email_address").eq(i).attr("id");
		var thisIdEl = $("#"+thisId);
		var thisVal = thisIdEl.val();
		
		if(thisVal != "") {
			return checkEmailValidate(thisId);	
		}
	} 
	
	return true;
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

Array.prototype.remove = function (target) {
    this.splice(this.indexOf(target), 1);
    return this;
};
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
	<form name="createHGPSForm" id="createHGPSForm" method="post">
		<input type="hidden" name="row" id="row" value="">
		<input type="hidden" name="idx" id="idx" value="">
		<input type="hidden" name="idxList" id="idxList" value="">
		<div id="container">
			<table class="board_view01" id="tbCreateForm">
				<caption></caption>
				<colgroup>
					<col width="10%" />
					<col width="15%" />
					<col width="10%" />
					<col width="15%" />
					<col width="10%" />
					<col width="15%" />
					<col width="10%" />
					<col width="15%" />					
				</colgroup>
				<tbody>
					<tr>
						<td colspan="8" align="center">Primary Supplier Account</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="page.userid" text="User ID" /></th>
						<td colspan="3">
							<input type="text" name="primaryUserId" id="primaryUserId" readonly="readonly" style="width: 265px;">
							<span class="highlight_red">＊ Create by IM (read only)</span>
						</td>
						<th scope="row"><spring:message code="page.appSeqNo" text="App Seq No" />&nbsp;<span class="highlight_red">(Required)</span></th>
						<td><input type="text" title="appSeqNo" name="appSeqNo" id="appSeqNo" style="width: 265px;" class="required"></td>
						<th scope="row"><spring:message code="page.reportTo" text="Report To" />&nbsp;<span class="highlight_red">(Required)</span></th>
						<td><input type="text" title="reportTo" name="reportTo" id="reportTo" style="width: 265px;" class="required"></td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="page.localFirstName" text="Local First Name" />&nbsp;<span class="highlight_red">(Required)</span></th>
						<td><input type="text" title="Local First Name" name="primaryLocalFirstName" id="primaryLocalFirstName" style="width: 265px;" class="required"></td>
						<th scope="row"><spring:message code="page.localLastName" text="Local Last Name" />&nbsp;<span class="highlight_red">(Required)</span></th>
						<td><input type="text" title="Local Last Name" name="primaryLocalLastName" id="primaryLocalLastName" style="width: 265px;" class="required"></td>
						<th scope="row"><spring:message code="page.firstName" text="Global First Name" />&nbsp;<span class="highlight_red">(Required)</span></th>
						<td><input type="text" title="Global First Name" name="primaryGlobalFirstName" id="primaryGlobalFirstName" style="width: 265px;" class="required"></td>
						<th scope="row"><spring:message code="page.lastName" text="Global Last Name" />&nbsp;<span class="highlight_red">(Required)</span></th>
						<td><input type="text" title="Global Last Name" name="primaryGlobalLastName" id="primaryGlobalLastName" style="width: 265px;" class="required"></td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="page.compCode" text="Company Code" />&nbsp;<span class="highlight_red">(Required)</span></th>
						<td><input type="text" title="Company Codee" name="primaryCompCode" id="primaryCompCode" style="width: 265px;" class="required"></td>
						<th scope="row"><spring:message code="page.compName" text="Company Name" />&nbsp;<span class="highlight_red">(Required)</span></th>
						<td><input type="text" title="Company Name" name="primaryCompName" id="primaryCompName" style="width: 265px;" class="required"></td>
						<th scope="row"><spring:message code="page.compEName" text="Company English Name" /></th>
						<td><input type="text" name="primaryCompEName" id="primaryCompEName" style="width: 265px;"></td>
						<th scope="row"><spring:message code="page.compType" text="Company Type" /></th>
						<td><input type="text" name="primaryCompType" id="primaryCompType" style="width: 265px;"></td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="page.compTel" text="Company Tel" /></th>
						<td><input type="text" name="primaryCompTel" id="primaryCompTel" style="width: 265px;" onkeydown="onlyNum();"></td>
						<th scope="row"><spring:message code="page.compFax" text="Company Fax" /></th>
						<td><input type="text" name="primaryCompFax" id="primaryCompFax" style="width: 265px;" onkeydown="onlyNum();"></td>
						<th scope="row"><spring:message code="page.compPostalCode" text="Company Postal Code" /></th>
						<td><input type="text" name="primaryCompPost" id="primaryCompPost" style="width: 265px;"></td>
						<th scope="row"><spring:message code="page.compAddress" text="Company Address" /></th>
						<td><input type="text" name="primaryCompAddress" id="primaryCompAddress" style="width: 265px;"></td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="page.erpCode" text="ERP Code" /></th>
						<td><input type="text" name="primaryErpCode" id="primaryErpCode" style="width: 265px;"></td>
						<th scope="row"><spring:message code="page.hgpsCode" text="HGPS Code" /></th>
						<td><input type="text" name="primaryHgpsCode" id="primaryHgpsCode" style="width: 265px;"></td>
						<th scope="row"><spring:message code="page.fax" text="Fax" /></th>
						<td><input type="text" name="primaryFax" id="primaryFax" style="width: 265px;" onkeydown="onlyNum();"></td>
						<th scope="row"><spring:message code="page.tel" text="Tel" /></th>
						<td><input type="text" name="primaryTel" id="primaryTel" style="width: 265px;" onkeydown="onlyNum();"></td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="page.mobile" text="Mobile" /></th>
						<td><input type="text" name="primaryMobile" id="primaryMobile" style="width: 265px;" onkeydown="onlyNum();"></td>
						<th scope="row"><spring:message code="page.postalCode" text="Postal Code" /></th>
						<td><input type="text" name="primaryPost" id="primaryPost" style="width: 265px;"></td>
						<th scope="row"><spring:message code="page.address" text="Address" /></th>
						<td><input type="text" name="primaryAddress" id="primaryAddress" style="width: 265px;"></td>
						<th scope="row"><spring:message code="page.email" text="Email" />&nbsp;<span class="highlight_red">(Required)</span></th>
						<td><input type="text" name="primaryEmail" id="primaryEmail" style="width: 265px;" class="email_address required"></td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="page.startDate" text="Start Date" /></th>
						<td><input type="text" name="primaryStartdate" id="primaryStartdate" style="width: 265px;" class="date"></td>
						<th scope="row"><spring:message code="page.endDate" text="End Date" /></th>
						<td><input type="text" name="primaryEnddate" id="primaryEnddate" style="width: 265px;" class="date"></td>
						<th scope="row"><spring:message code="page.regionCode" text="Region Code" /></th>
						<td><input type="text" name="primaryRegionCode" id="primaryRegionCode" style="width: 265px;"></td>
						<th scope="row"><spring:message code="page.regionName" text="Region Name" /></th>
						<td><input type="text" name="primaryRegionName" id="primaryRegionName" style="width: 265px;"></td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="page.entityCode" text="Entity Code" /></th>
						<td><input type="text" name="primaryEntityCode" id="primaryEntityCode" style="width: 265px;"></td>
						<th scope="row"><spring:message code="page.entityName" text="Entity Name" /></th>
						<td><input type="text" name="primaryEntityName" id="primaryEntityName" style="width: 265px;"></td>
						<th scope="row"><spring:message code="page.jobDesc" text="Job Desc" /></th>
						<td colspan="3"><input type="text" name="primaryJobDesc" id="primaryJobDesc" style="width: 265px;"></td>
					</tr>
				</tbody>
			</table>			
	
			<div class="right">
				<a class="btn_blue3" id="btn_add" href="javascript:addSecondaryAccount();">
					<span><spring:message code="button.add" text="Add Secondary Account" /></span>
				</a>
				<a class="btn_blue3" id="btn_save" href="javascript:saveSupplierAccount();">
					<span><spring:message code="button.save" text="Save" /></span>
				</a>
	
				<!-- <a class="btn_gray5" href="#">
					<span>Cancel</span>
				</a> -->
			</div>			
			<!-- //(clear) -->
		</div>
	</form>
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