<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<script type="text/javascript">

		$(document).ready(function () {
			getIMUserStore();
		});

		function getIMUserStore() {
			$('span.deem').css('display', 'block');
			$('#loadingbar').css('display', 'block');
			var params = {};
			params.urid = '${urid}';
			// 사용자 조회 시작
			$.ajax({
				url: '/admin/imuser/getIMUserStore.do'
				, type: 'post'
				, dataType: 'xml'
				, data: params
				, success: function (data) {
					//	console.log(data)
					saveIMUserStore(data);
					$('span.deem').css('display', 'none');
					$('#loadingbar').css('display', 'none');
				}
				, error: function (data) {
					//	console.log("Error");
					//	console.log(data);
					$('div.position_loading').children('p').html("<a href='javascript:closeAlert();''><img align='right' style='padding-right: 20px;' src='/images/skin/btn/btn_pop_close.gif' alt=''/></a>");
					$('div.position_loading').children('dl').children('dt').html("Selected failed");
				}
			});
		}

		var pageObj;

		function saveIMUserStore(data) {
			IMUserStore = new Array();
			$('IMUserStore', data).each(function () {

				cn = $('cn', this).text();
				departmentNumber = $('departmentNumber', this).text();
				destinationIndicator = $('destinationIndicator', this).text();
				employeeNumber = $('employeeNumber', this).text();
				employeeType = $('employeeType', this).text();
				facsimileTelephoneNumber = $('facsimileTelephoneNumber', this).text();
				givenName = $('givenName', this).text();
				imActivationDate = $('imActivationDate', this).text();
				imCompanyName = $('imCompanyName', this).text();
				imDivision = $('imDivision', this).text();
				imEmployeeStatus = $('imEmployeeStatus', this).text();
				imEnabledState = $('imEnabledState', this).text();
				imExpirationDate = $('imExpirationDate', this).text();
				imManagerId = $('imManagerId', this).text();
				imNameAlias = $('imNameAlias', this).text();
				imNameSuffix = $('imNameSuffix', this).text();
				imString00 = $('imString00', this).text();
				imString02 = $('imString02', this).text();
				imString03 = $('imString03', this).text();
				imString04 = $('imString04', this).text();
				imString05 = $('imString05', this).text();
				imString06 = $('imString06', this).text();
				imString07 = $('imString07', this).text();
				imString08 = $('imString08', this).text();
				imString09 = $('imString09', this).text();
				imString10 = $('imString10', this).text();
				imString11 = $('imString11', this).text();
				imstring117 = $('imstring117',this).text();
				imString12 = $('imString12', this).text();
				imString13 = $('imString13', this).text();
				imString14 = $('imString14', this).text();
				imString145 = $('imString145', this).text();
				imString146 = $('imString146', this).text();
				imString15 = $('imString15', this).text();
				imString17 = $('imString17', this).text();
				imString18 = $('imString18', this).text();
				imString19 = $('imString19', this).text();
				imString24 = $('imString24', this).text();
				imString47 = $('imString47', this).text();
				imString48 = $('imString48', this).text();
				imString49 = $('imString49', this).text();
				imString50 = $('imString50', this).text();
				imString51 = $('imString51', this).text();
				imString52 = $('imString52', this).text();
				imString54 = $('imString54', this).text();
				imString55 = $('imString55', this).text();
				imString56 = $('imString56', this).text();
				imString69 = $('imString69', this).text();
				imString70 = $('imString70', this).text();
				imString72 = $('imString72', this).text();
				imString73 = $('imString73', this).text();
				imString74 = $('imString74', this).text();
				imString75 = $('imString75', this).text();
				imString76 = $('imString76', this).text();
				imString77 = $('imString77', this).text();
				imString78 = $('imString78', this).text();
				imString79 = $('imString79', this).text();
				imString80 = $('imString80', this).text();
				imString82 = $('imString82', this).text();
				imString83 = $('imString83', this).text();
				imString84 = $('imString84', this).text();
				imString85 = $('imString85', this).text();
				imString86 = $('imString86', this).text();
				imString87 = $('imString87', this).text();
				imString88 = $('imString88', this).text();
				imString89 = $('imString89', this).text();
				imString90 = $('imString90', this).text();
				imString91 = $('imString91', this).text();
				imString92 = $('imString92', this).text();
				imString93 = $('imString93', this).text();
				imString94 = $('imString94', this).text();
				imString95 = $('imString95', this).text();
				imString96 = $('imString96', this).text();
				imString97 = $('imString97', this).text();
				imString98 = $('imString98', this).text();
				imString99 = $('imString99', this).text();
				imTimeZone = $('imTimeZone', this).text();
				initials = $('initials', this).text();
				L = $('l', this).text();
				mail = $('mail', this).text();
				mobile = $('mobile', this).text();
				postalAddress = $('postalAddress', this).text();
				preferredLanguage = $('preferredLanguage', this).text();
				sn = $('sn', this).text();
				st = $('st', this).text();
				street = $('street', this).text();
				telephoneNumber = $('telephoneNumber', this).text();
				title = $('title', this).text();
				uid = $('uid', this).text();


				var jsonString = '{"cn": "' + cn + '", "departmentNumber": "' + departmentNumber + '", "imstring117": "' + imstring117 + '", "destinationIndicator": "' + destinationIndicator + '", "employeeNumber": "' + employeeNumber + '", "employeeType": "' + employeeType + '", "facsimileTelephoneNumber": "' + facsimileTelephoneNumber + '", "givenName": "' + givenName + '", "imActivationDate": "' + imActivationDate + '", "imCompanyName": "' + imCompanyName + '", "imDivision": "' + imDivision + '", "imEmployeeStatus": "' + imEmployeeStatus + '", "imEnabledState": "' + imEnabledState + '", "imExpirationDate": "' + imExpirationDate + '", "imManagerId": "' + imManagerId + '", "imNameAlias": "' + imNameAlias + '", "imNameSuffix": "' + imNameSuffix + '", "imString00": "' + imString00 + '", "imString02": "' + imString02 + '", "imString03": "' + imString03 + '", "imString04": "' + imString04 + '", "imString05": "' + imString05 + '", "imString06": "' + imString06 + '", "imString07": "' + imString07 + '", "imString08": "' + imString08 + '", "imString09": "' + imString09 + '", "imString10": "' + imString10 + '", "imString11": "' + imString11 + '", "imString12": "' + imString12 + '", "imString13": "' + imString13 + '", "imString14": "' + imString14 + '", "imString145": "' + imString145 + '", "imString146": "' + imString146 + '", "imString15": "' + imString15 + '", "imString17": "' + imString17 + '", "imString18": "' + imString18 + '", "imString19": "' + imString19 + '", "imString24": "' + imString24 + '", "imString47": "' + imString47 + '", "imString48": "' + imString48 + '", "imString49": "' + imString49 + '", "imString50": "' + imString50 + '", "imString51": "' + imString51 + '", "imString52": "' + imString52 + '", "imString54": "' + imString54 + '", "imString55": "' + imString55 + '", "imString56": "' + imString56 + '", "imString69": "' + imString69 + '", "imString70": "' + imString70 + '", "imString72": "' + imString72 + '", "imString73": "' + imString73 + '", "imString74": "' + imString74 + '", "imString75": "' + imString75 + '", "imString76": "' + imString76 + '", "imString77": "' + imString77 + '", "imString78": "' + imString78 + '", "imString79": "' + imString79 + '", "imString80": "' + imString80 + '", "imString82": "' + imString82 + '", "imString83": "' + imString83 + '", "imString84": "' + imString84 + '", "imString85": "' + imString85 + '", "imString86": "' + imString86 + '", "imString87": "' + imString87 + '", "imString88": "' + imString88 + '", "imString89": "' + imString89 + '", "imString90": "' + imString90 + '", "imString91": "' + imString91 + '", "imString92": "' + imString92 + '", "imString93": "' + imString93 + '", "imString94": "' + imString94 + '", "imString95": "' + imString95 + '", "imString96": "' + imString96 + '", "imString97": "' + imString97 + '", "imString98": "' + imString98 + '", "imString99": "' + imString99 + '", "imTimeZone": "' + imTimeZone + '", "initials": "' + initials + '", "L": "' + L + '", "mail": "' + mail + '", "mobile": "' + mobile + '", "postalAddress": "' + postalAddress + '", "preferredLanguage": "' + preferredLanguage + '", "sn": "' + sn + '", "st": "' + st + '", "street": "' + street + '", "telephoneNumber": "' + telephoneNumber + '", "title": "' + title + '", "uid": "' + uid + '"} '
				jsonString = jsonString.replace(/N\\A/gi, "N/A")
				IMUserInfo = { 'fullName': cn, "jEmptype":imstring117, "department": departmentNumber, "country": destinationIndicator, "employeeNumber": employeeNumber, "employeeType": employeeType, "fax": facsimileTelephoneNumber, "firstName": givenName, "activationDate": imActivationDate, "companyName": imCompanyName, "division": imDivision, "employeeStatus": imEmployeeStatus, "disabledState": imEnabledState, "expirationDate": imExpirationDate, "managerId": imManagerId, "nickname": imNameAlias, "suffix": imNameSuffix, "humanResource": imString00, "gender": imString02, "jobCode": imString03, "officePlantCode": imString04, "localEmpNo": imString05, "zip": imString06, "proxy": imString07, "matrixManager": imString08, "seatingChart": imString09, "reviewFrequency": imString10, "lastReviewDate": imString11, "buildingCode": imString12, "address": imString13, "city": imString14, "jMgrFlag": imString145, "operatingLocationCode": imString146, "zipCode": imString15, "function": imString17, "region": imString18, "roleData": imString19, "globalPostionNameK": imString24, "printRank": imString47, "organizationLevel": imString48, "organizationUseYn": imString49, "documentCode": imString50, "localLastName": imString51, "localFirstName": imString52, "localDepartmentCode": imString54, "localDepartmentName": imString55, "jobDescription": imString56, "employeeTypeK": imString69, "workTypeK": imString70, "workPlaceK": imString72, "workPlaceNameK": imString73, "sectionCodeK": imString74, "workCenterCodeK": imString75, "workProcessCodeK": imString76, "costCenterCodeK": imString77, "positionK": imString78, "positionNameK": imString79, "yearlyPositionK": imString80, "jobTitleK": imString82, "jobTitleNameK": imString83, "jobGroupK": imString84, "jobGroupNameK": imString85, "titleK": imString86, "extensionNumberK": imString87, "genderK": imString88, "statusDateK": imString89, "categoryCodeK": imString90, "departmentNameChina": imString91, "parentDepartmentCode": imString92, "organizationStartDate": imString93, "organizationEndDate": imString94, "koreaCostCode": imString95, "departmentManagerId": imString96, "koreaSectorDepartmentCode": imString97, "koreaSectorYn": imString98, "classificationOfWorkPlace": imString99, "timeZone": imTimeZone, "middleName": initials, "city": L, "primaryEmail": mail, "mobilePphone": mobile, "addressLine2": postalAddress, "preferredLanguage": preferredLanguage, "lastName": sn, "state": st, "addressLine1": street, "workPhone": telephoneNumber, "title": title, "userId": uid }
				itemObj = $.parseJSON(jsonString);
				IMUserStore.push(itemObj);
			});
			drawIMUserStore();
		}

		function drawIMUserStore() {
			$('#IMUserStoreDiv').html('');

			if ($.isEmptyObject(IMUserStore)) {
				$('#IMUserStoreDiv').append("<tr><td colspan='3' class='center'><spring:message code='alert.result.1' text='List does not exist.' /></td></tr>");
			} else {
				cn = IMUserStore[0].cn;
				departmentNumber = IMUserStore[0].departmentNumber;
				destinationIndicator = IMUserStore[0].destinationIndicator;
				employeeNumber = IMUserStore[0].employeeNumber;
				employeeType = IMUserStore[0].employeeType;
				facsimileTelephoneNumber = IMUserStore[0].facsimileTelephoneNumber;
				givenName = IMUserStore[0].givenName;
				imActivationDate = IMUserStore[0].imActivationDate;
				imCompanyName = IMUserStore[0].imCompanyName;
				imDivision = IMUserStore[0].imDivision;
				imEmployeeStatus = IMUserStore[0].imEmployeeStatus;
				imEnabledState = IMUserStore[0].imEnabledState;
				imExpirationDate = IMUserStore[0].imExpirationDate;
				imManagerId = IMUserStore[0].imManagerId;
				imNameAlias = IMUserStore[0].imNameAlias;
				imNameSuffix = IMUserStore[0].imNameSuffix;
				imString00 = IMUserStore[0].imString00;
				imString02 = IMUserStore[0].imString02;
				imString03 = IMUserStore[0].imString03;
				imString04 = IMUserStore[0].imString04;
				imString05 = IMUserStore[0].imString05;
				imString06 = IMUserStore[0].imString06;
				imString07 = IMUserStore[0].imString07;
				imString08 = IMUserStore[0].imString08;
				imString09 = IMUserStore[0].imString09;
				imString10 = IMUserStore[0].imString10;
				imString11 = IMUserStore[0].imString11;
				imstring117 = IMUserStore[0].imstring117;
				imString12 = IMUserStore[0].imString12;
				imString13 = IMUserStore[0].imString13;
				imString14 = IMUserStore[0].imString14;
				imString145 = IMUserStore[0].imString145;
				imString146 = IMUserStore[0].imString146;
				imString15 = IMUserStore[0].imString15;
				imString17 = IMUserStore[0].imString17;
				imString18 = IMUserStore[0].imString18;
				imString19 = IMUserStore[0].imString19;
				imString24 = IMUserStore[0].imString24;
				imString47 = IMUserStore[0].imString47;
				imString48 = IMUserStore[0].imString48;
				imString49 = IMUserStore[0].imString49;
				imString50 = IMUserStore[0].imString50;
				imString51 = IMUserStore[0].imString51;
				imString52 = IMUserStore[0].imString52;
				imString54 = IMUserStore[0].imString54;
				imString55 = IMUserStore[0].imString55;
				imString56 = IMUserStore[0].imString56;
				imString69 = IMUserStore[0].imString69;
				imString70 = IMUserStore[0].imString70;
				imString72 = IMUserStore[0].imString72;
				imString73 = IMUserStore[0].imString73;
				imString74 = IMUserStore[0].imString74;
				imString75 = IMUserStore[0].imString75;
				imString76 = IMUserStore[0].imString76;
				imString77 = IMUserStore[0].imString77;
				imString78 = IMUserStore[0].imString78;
				imString79 = IMUserStore[0].imString79;
				imString80 = IMUserStore[0].imString80;
				imString82 = IMUserStore[0].imString82;
				imString83 = IMUserStore[0].imString83;
				imString84 = IMUserStore[0].imString84;
				imString85 = IMUserStore[0].imString85;
				imString86 = IMUserStore[0].imString86;
				imString87 = IMUserStore[0].imString87;
				imString88 = IMUserStore[0].imString88;
				imString89 = IMUserStore[0].imString89;
				imString90 = IMUserStore[0].imString90;
				imString91 = IMUserStore[0].imString91;
				imString92 = IMUserStore[0].imString92;
				imString93 = IMUserStore[0].imString93;
				imString94 = IMUserStore[0].imString94;
				imString95 = IMUserStore[0].imString95;
				imString96 = IMUserStore[0].imString96;
				imString97 = IMUserStore[0].imString97;
				imString98 = IMUserStore[0].imString98;
				imString99 = IMUserStore[0].imString99;
				imTimeZone = IMUserStore[0].imTimeZone;
				initials = IMUserStore[0].initials;
				L = IMUserStore[0].L;
				mail = IMUserStore[0].mail;
				mobile = IMUserStore[0].mobile;
				postalAddress = IMUserStore[0].postalAddress;
				preferredLanguage = IMUserStore[0].preferredLanguage;
				sn = IMUserStore[0].sn;
				st = IMUserStore[0].st;
				street = IMUserStore[0].street;
				telephoneNumber = IMUserStore[0].telephoneNumber;
				title = IMUserStore[0].title;
				uid = IMUserStore[0].uid;
				html = "<tr>"
					+ "<td title='uid'>User ID</td>"
					+ "<td class='";
				if (UserStore['userId']) html += "center";
				else html += "df";
				html += "' title='" + uid + "'>" + uid + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td title='cn'>Full Name</td>"
					+ "<td class='";
				if (UserStore['fullName']) html += "center";
				else html += "df";
				html += "' title='" + cn + "'>" + cn + "</td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td title='departmentNumber'>Department</td>"
					+ "<td class='";
				if (UserStore['department']) html += "center";
				else html += "df";
				html += "' title='" + departmentNumber + "'>" + departmentNumber + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='destinationIndicator'>Country</td>"
					+ "<td class='";
				if (UserStore['country']) html += "center";
				else html += "df";
				html += "' title='" + destinationIndicator + "'>" + destinationIndicator + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='employeeNumber'>Employee Number</td>"
					+ "<td class='";
				if (UserStore['employeeNumber']) html += "center";
				else html += "df";
				html += "' title='" + employeeNumber + "'>" + employeeNumber + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='employeeType'>Employee Type</td>"
					+ "<td class='";
				if (UserStore['employeeType']) html += "center";
				else html += "df";
				html += "' title='" + employeeType + "'>" + employeeType + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imstring117'>J_EMPTYPE</td>"
					+ "<td class='";
				if (UserStore['jEmptype']) html += "center";
				else html += "df";
				html += "' title='" + imstring117 + "'>" + imstring117 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='facsimileTelephoneNumber'>Fax</td>"
					+ "<td class='";
				if (UserStore['fax']) html += "center";
				else html += "df";
				html += "' title='" + facsimileTelephoneNumber + "'>" + facsimileTelephoneNumber + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='givenName'>First Name</td>"
					+ "<td class='";
				if (UserStore['firstName']) html += "center";
				else html += "df";
				html += "' title='" + givenName + "'>" + givenName + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='initials'>Middle Name</td>"
					+ "<td class='";
				if (UserStore['middleName']) html += "center";
				else html += "df";
				html += "' title='" + initials + "'>" + initials + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='sn'>Last Name</td>"
					+ "<td class='";
				if (UserStore['lastName']) html += "center";
				else html += "df";
				html += "' title='" + sn + "'>" + sn + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imActivationDate'>Activation Date</td>"
					+ "<td class='";
				if (UserStore['activationDate']) html += "center";
				else html += "df";
				html += "' title='" + imActivationDate + "'>" + imActivationDate + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imCompanyName'>Company Name</td>"
					+ "<td class='";
				if (UserStore['companyName']) html += "center";
				else html += "df";
				html += "' title='" + imCompanyName + "'>" + imCompanyName + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imDivision'>Division</td>"
					+ "<td class='";
				if (UserStore['division']) html += "center";
				else html += "df";
				html += "' title='" + imDivision + "'>" + imDivision + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imEmployeeStatus'>Employee Status</td>"
					+ "<td class='";
				if (UserStore['employeeStatus']) html += "center";
				else html += "df";
				html += "' title='" + imEmployeeStatus + "'>" + imEmployeeStatus + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td title='imEnabledState'>Disabled State</td>"
					+ "<td class='";
				if (UserStore['disabledState']) html += "center";
				else html += "df";
				html += "' title='" + imEnabledState + "'>" + imEnabledState + "</td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td title='imExpirationDate'>Expiration Date</td>"
					+ "<td class='";
				if (UserStore['expirationDate']) html += "center";
				else html += "df";
				html += "' title='" + imExpirationDate + "'>" + imExpirationDate + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imManagerId'>Manager Id</td>"
					+ "<td class='";
				if (UserStore['managerId']) html += "center";
				else html += "df";
				html += "' title='" + imManagerId + "'>" + imManagerId + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imNameAlias'>Nickname</td>"
					+ "<td class='";
				if (UserStore['nickname']) html += "center";
				else html += "df";
				html += "' title='" + imNameAlias + "'>" + imNameAlias + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imNameSuffix'>Suffix</td>"
					+ "<td class='";
				if (UserStore['suffix']) html += "center";
				else html += "df";
				html += "' title='" + imNameSuffix + "'>" + imNameSuffix + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString00'>Human Resource</td>"
					+ "<td class='";
				if (UserStore['humanResource']) html += "center";
				else html += "df";
				html += "' title='" + imString00 + "'>" + imString00 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString02'>Gender</td>"
					+ "<td class='";
				if (UserStore['gender']) html += "center";
				else html += "df";
				html += "' title='" + imString02 + "'>" + imString02 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString03'>Job Code</td>"
					+ "<td class='";
				if (UserStore['jobCode']) html += "center";
				else html += "df";
				html += "' title='" + imString03 + "'>" + imString03 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString04'>Office Plant Code</td>"
					+ "<td class='";
				if (UserStore['officePlantCode']) html += "center";
				else html += "df";
				html += "' title='" + imString04 + "'>" + imString04 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString05'>Local Emp No</td>"
					+ "<td class='";
				if (UserStore['localEmpNo']) html += "center";
				else html += "df";
				html += "' title='" + imString05 + "'>" + imString05 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString06'>ZIP</td>"
					+ "<td class='";
				if (UserStore['zip']) html += "center";
				else html += "df";
				html += "' title='" + imString06 + "'>" + imString06 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString07'>Proxy</td>"
					+ "<td class='";
				if (UserStore['proxy']) html += "center";
				else html += "df";
				html += "' title='" + imString07 + "'>" + imString07 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString08'>Matrix Manager</td>"
					+ "<td class='";
				if (UserStore['matrixManager']) html += "center";
				else html += "df";
				html += "' title='" + imString08 + "'>" + imString08 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString09'>Seating Chart</td>"
					+ "<td class='";
				if (UserStore['seatingChart']) html += "center";
				else html += "df";
				html += "' title='" + imString09 + "'>" + imString09 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString10'>Review Frequency</td>"
					+ "<td class='";
				if (UserStore['reviewFrequency']) html += "center";
				else html += "df";
				html += "' title='" + imString10 + "'>" + imString10 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString11'>Last Review Date</td>"
					+ "<td class='";
				if (UserStore['lastReviewDate']) html += "center";
				else html += "df";
				html += "' title='" + imString11 + "'>" + imString11 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString12'>Building Code</td>"
					+ "<td class='";
				if (UserStore['buildingCode']) html += "center";
				else html += "df";
				html += "' title='" + imString12 + "'>" + imString12 + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td title='imString13'>Address</td>"
					+ "<td class='";
				if (UserStore['address']) html += "center";
				else html += "df";
				html += "' title='" + imString13 + "'>" + imString13 + "</td>"
					+ "</tr>"*/
				/*	+ "<tr>"
					+ "<td title='imString14'>City</td>"
					+ "<td class='";
				if (UserStore['city']) html += "center";
				else html += "df";
				html += "' title='" + imString14 + "'>" + imString14 + "</td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td title='imString145'>J_MGR_FLAG</td>"
					+ "<td class='";
				if (UserStore['jMgrFlag']) html += "center";
				else html += "df";
				html += "' title='" + imString145 + "'>" + imString145 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString146'>Operating Location Code</td>"
					+ "<td class='";
				if (UserStore['operatingLocationCode']) html += "center";
				else html += "df";
				html += "' title='" + imString146 + "'>" + imString146 + "</td>"
					+ "</tr>"
				/*	+ "<tr>"
					+ "<td title='imString15'>Zip Code</td>"
					+ "<td class='";
				if (UserStore['zipCode']) html += "center";
				else html += "df";
				html += "' title='" + imString15 + "'>" + imString15 + "</td>"
					+ "</tr>"*/
					+ "<tr>"
					+ "<td title='imString17'>Function</td>"
					+ "<td class='";
				if (UserStore['function']) html += "center";
				else html += "df";
				html += "' title='" + imString17 + "'>" + imString17 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString18'>Region</td>"
					+ "<td class='";
				if (UserStore['region']) html += "center";
				else html += "df";
				html += "' title='" + imString18 + "'>" + imString18 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString19'>Role Data</td>"
					+ "<td class='";
				if (UserStore['roleData']) html += "center";
				else html += "df";
				html += "' title='" + imString19 + "'>" + imString19 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString24'>Global Postion Name(K)</td>"
					+ "<td class='";
				if (UserStore['globalPostionNameK']) html += "center";
				else html += "df";
				html += "' title='" + imString24 + "'>" + imString24 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString47'>Print Rank</td>"
					+ "<td class='";
				if (UserStore['printRank']) html += "center";
				else html += "df";
				html += "' title='" + imString47 + "'>" + imString47 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString48'>Organization Level</td>"
					+ "<td class='";
				if (UserStore['organizationLevel']) html += "center";
				else html += "df";
				html += "' title='" + imString48 + "'>" + imString48 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString49'>Organization Use YN</td>"
					+ "<td class='";
				if (UserStore['organizationUseYn']) html += "center";
				else html += "df";
				html += "' title='" + imString49 + "'>" + imString49 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString50'>Document Code</td>"
					+ "<td class='";
				if (UserStore['documentCode']) html += "center";
				else html += "df";
				html += "' title='" + imString50 + "'>" + imString50 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString51'>Local Last Name</td>"
					+ "<td class='";
				if (UserStore['localLastName']) html += "center";
				else html += "df";
				html += "' title='" + imString51 + "'>" + imString51 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString52'>Local First Name</td>"
					+ "<td class='";
				if (UserStore['localFirstName']) html += "center";
				else html += "df";
				html += "' title='" + imString52 + "'>" + imString52 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString54'>Local Department Code</td>"
					+ "<td class='";
				if (UserStore['localDepartmentCode']) html += "center";
				else html += "df";
				html += "' title='" + imString54 + "'>" + imString54 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString55'>Local Department Name</td>"
					+ "<td class='";
				if (UserStore['localDepartmentName']) html += "center";
				else html += "df";
				html += "' title='" + imString55 + "'>" + imString55 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString56'>Job Description</td>"
					+ "<td class='";
				if (UserStore['jobDescription']) html += "center";
				else html += "df";
				html += "' title='" + imString56 + "'>" + imString56 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString69'>Employee Type(K)</td>"
					+ "<td class='";
				if (UserStore['employeeTypeK']) html += "center";
				else html += "df";
				html += "' title='" + imString69 + "'>" + imString69 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString70'>Work Type(K)</td>"
					+ "<td class='";
				if (UserStore['workTypeK']) html += "center";
				else html += "df";
				html += "' title='" + imString70 + "'>" + imString70 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString72'>Work Place(K)</td>"
					+ "<td class='";
				if (UserStore['workPlaceK']) html += "center";
				else html += "df";
				html += "' title='" + imString72 + "'>" + imString72 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString73'>Work Place Name(K)</td>"
					+ "<td class='";
				if (UserStore['workPlaceNameK']) html += "center";
				else html += "df";
				html += "' title='" + imString73 + "'>" + imString73 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString74'>Section Code(K)</td>"
					+ "<td class='";
				if (UserStore['sectionCodeK']) html += "center";
				else html += "df";
				html += "' title='" + imString74 + "'>" + imString74 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString75'>Work Center Code(K)</td>"
					+ "<td class='";
				if (UserStore['workCenterCodeK']) html += "center";
				else html += "df";
				html += "' title='" + imString75 + "'>" + imString75 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString76'>Work Process Code(K)</td>"
					+ "<td class='";
				if (UserStore['workProcessCodeK']) html += "center";
				else html += "df";
				html += "' title='" + imString76 + "'>" + imString76 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString77'>Cost Center Code(K)</td>"
					+ "<td class='";
				if (UserStore['costCenterCodeK']) html += "center";
				else html += "df";
				html += "' title='" + imString77 + "'>" + imString77 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString78'>Position(K)</td>"
					+ "<td class='";
				if (UserStore['positionK']) html += "center";
				else html += "df";
				html += "' title='" + imString78 + "'>" + imString78 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString79'>Position Name(K)</td>"
					+ "<td class='";
				if (UserStore['positionNameK']) html += "center";
				else html += "df";
				html += "' title='" + imString79 + "'>" + imString79 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString80'>Yearly Position(K)</td>"
					+ "<td class='";
				if (UserStore['yearlyPositionK']) html += "center";
				else html += "df";
				html += "' title='" + imString80 + "'>" + imString80 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString82'>Job Title(K)</td>"
					+ "<td class='";
				if (UserStore['jobTitleK']) html += "center";
				else html += "df";
				html += "' title='" + imString82 + "'>" + imString82 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString83'>Job Title Name(K)</td>"
					+ "<td class='";
				if (UserStore['jobTitleNameK']) html += "center";
				else html += "df";
				html += "' title='" + imString83 + "'>" + imString83 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString84'>Job Group(K)</td>"
					+ "<td class='";
				if (UserStore['jobGroupK']) html += "center";
				else html += "df";
				html += "' title='" + imString84 + "'>" + imString84 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString85'>Job Group Name(K)</td>"
					+ "<td class='";
				if (UserStore['jobGroupNameK']) html += "center";
				else html += "df";
				html += "' title='" + imString85 + "'>" + imString85 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString86'>Title(K)</td>"
					+ "<td class='";
				if (UserStore['titleK']) html += "center";
				else html += "df";
				html += "' title='" + imString86 + "'>" + imString86 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString87'>Extension Number(K)</td>"
					+ "<td class='";
				if (UserStore['extensionNumberK']) html += "center";
				else html += "df";
				html += "' title='" + imString87 + "'>" + imString87 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString88'>Gender(K)</td>"
					+ "<td class='";
				if (UserStore['genderK']) html += "center";
				else html += "df";
				html += "' title='" + imString88 + "'>" + imString88 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString89'>Status Date(K)</td>"
					+ "<td class='";
				if (UserStore['statusDateK']) html += "center";
				else html += "df";
				html += "' title='" + imString89 + "'>" + imString89 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString90'>Category Code(K)</td>"
					+ "<td class='";
				if (UserStore['categoryCodeK']) html += "center";
				else html += "df";
				html += "' title='" + imString90 + "'>" + imString90 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString91'>Department Name(China)</td>"
					+ "<td class='";
				if (UserStore['departmentNameChina']) html += "center";
				else html += "df";
				html += "' title='" + imString91 + "'>" + imString91 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString92'>Parent Department Code</td>"
					+ "<td class='";
				if (UserStore['parentDepartmentCode']) html += "center";
				else html += "df";
				html += "' title='" + imString92 + "'>" + imString92 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString93'>Organization Start Date</td>"
					+ "<td class='";
				if (UserStore['organizationStartDate']) html += "center";
				else html += "df";
				html += "' title='" + imString93 + "'>" + imString93 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString94'>Organization End Date</td>"
					+ "<td class='";
				if (UserStore['organizationEndDate']) html += "center";
				else html += "df";
				html += "' title='" + imString94 + "'>" + imString94 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString95'>Korea Cost Code</td>"
					+ "<td class='";
				if (UserStore['koreaCostCode']) html += "center";
				else html += "df";
				html += "' title='" + imString95 + "'>" + imString95 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString96'>Department Manager ID</td>"
					+ "<td class='";
				if (UserStore['departmentManagerId']) html += "center";
				else html += "df";
				html += "' title='" + imString96 + "'>" + imString96 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString97'>Korea Sector Department Code</td>"
					+ "<td class='";
				if (UserStore['koreaSectorDepartmentCode']) html += "center";
				else html += "df";
				html += "' title='" + imString97 + "'>" + imString97 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString98'>Korea Sector YN</td>"
					+ "<td class='";
				if (UserStore['koreaSectorYn']) html += "center";
				else html += "df";
				html += "' title='" + imString98 + "'>" + imString98 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imString99'>Classification of Work Place</td>"
					+ "<td class='";
				if (UserStore['classificationOfWorkPlace']) html += "center";
				else html += "df";
				html += "' title='" + imString99 + "'>" + imString99 + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='imTimeZone'>Time Zone</td>"
					+ "<td class='";
				if (UserStore['timeZone']) html += "center";
				else html += "df";
				html += "' title='" + imTimeZone + "'>" + imTimeZone + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='L'>City</td>"
					+ "<td class='";
				if (UserStore['city']) html += "center";
				else html += "df";
				html += "' title='" + L + "'>" + L + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='mail'>Primary email</td>"
					+ "<td class='";
				if (UserStore['primaryEmail']) html += "center";
				else html += "df";
				html += "' title='" + mail + "'>" + mail + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='mobile'>Mobile Phone</td>"
					+ "<td class='";
				if (UserStore['mobilePphone']) html += "center";
				else html += "df";
				html += "' title='" + mobile + "'>" + mobile + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='telephoneNumber'>Work Phone</td>"
					+ "<td class='";
				if (UserStore['workPhone']) html += "center";
				else html += "df";
				html += "' title='" + telephoneNumber + "'>" + telephoneNumber + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='preferredLanguage'>Preferred Language</td>"
					+ "<td class='";
				if (UserStore['preferredLanguage']) html += "center";
				else html += "df";
				html += "' title='" + preferredLanguage + "'>" + preferredLanguage + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='st'>State</td>"
					+ "<td class='";
				if (UserStore['state']) html += "center";
				else html += "df";
				html += "' title='" + st + "'>" + st + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='street'>Address line 1</td>"
					+ "<td class='";
				if (UserStore['addressLine1']) html += "center";
				else html += "df";
				html += "' title='" + street + "'>" + street + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='postalAddress'>Address line 2</td>"
					+ "<td class='";
				if (UserStore['addressLine2']) html += "center";
				else html += "df";
				html += "' title='" + postalAddress + "'>" + postalAddress + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td title='title'>Title</td>"
					+ "<td class='";
				if (UserStore['title']) html += "center";
				else html += "df";
				html += "' title='" + title + "'>" + title + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td class='non'></td>"
					+ "<td class='non'></td>"
					+ "</tr>";
				
				$('#IMUserStoreDiv').append(html);
				$('#IMStatus').html('');
				if (imEmployeeStatus.toUpperCase() == 'ACTIVE') {
					html = "<th scope='col' colspan='2'>"
						+ "Status:  Active"
						+ "</th>";
				} else {
					html = "<th scope='col' colspan='2'>"
						+ "Status:  <span style='color:#F73738;'>Inactive </span>"
						+ "</th>";
				}
				$('#IMStatus').append(html);
			}
		}
		/**
		 * 사용자 히스토리 페이지 이동
		 * @param 
		 * @since 1.0, 2021-12-14
		 */
		function showUserDetail(cdsid) {
			var form = document.createElement('form');
			var obj = document.createElement('input');
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "urid");
			obj.setAttribute("value", cdsid);

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

			form.appendChild(obj);
			form.appendChild(obj1);
			form.appendChild(obj2);
			form.appendChild(obj3);
			form.appendChild(obj4);
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/admin/imuser/UserSyncJobHistory.do');

			document.body.appendChild(form);
			form.submit();
		}
	</script>
</head>

<body class="main">
	<table class="board_01" summary="User Quick Menu">
		<caption></caption>
		<colgroup>
			<col width="30%">
			<col width="40%">
		</colgroup>
		<thead>

		</thead>

		<!-- Batch Job 목록 가져오기 Display Start-->
		<tbody>
			<tr class="UserStore">
				<th scope="col" style="white-space: nowrap !important;">IM User Store</th>
				<th scope="col" style="padding:3px 10px 4px 5px; text-align: right;">
					<button onclick="showUserDetail('${urid}')"> History </button>
					<button onclick="getIMUserStore()"> Reload </button>
				</th>
			</tr>
			<tr id="IMStatus">
				<th scope="col" colspan="2">Status:</th>
			</tr>
		</tbody>
		<!-- Batch Job 목록 가져오기 Display End-->
	</table>
	<table class="board_01">
		<caption></caption>
		<colgroup>
			<col width="50%">
			<col width="50%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col" title="Physical Name">Field Name</th>
				<th scope="col">Value</th>
			</tr>
		</thead>
		<tbody id="IMUserStoreDiv"></tbody>
	</table>
</body>

</html>