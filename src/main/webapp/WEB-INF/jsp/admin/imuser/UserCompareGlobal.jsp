<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<script type="text/javascript">
		/**
		 * 배치 목록 저장 및 페이징 처리
		 * @param data		{@link ReturnBatchJobInfo} List of BatchJobInfo 
		 * @since 2.2, 2018-07-07
		 */
		function drawGlobal(data) {
			$('batchJobDetailsVO', data).each(function () {
				employeeNumber_After = $('employeeNumber', this).text();
				employeeStatus_After = $('employeeStatus', this).text();
				activationDate_After = $('activationDate', this).text();
				expirationDate_After = $('expirationDate', this).text();
				employeeType_After = $('employeeType', this).text();
				firstName_After = $('firstName', this).text();
				middleName_After = $('middleName', this).text();
				lastName_After = $('lastName', this).text();
			//	suffix_After = $('suffix', this).text();
			//	nickname_After = $('nickname', this).text();
				country_After = $('country', this).text();
				companyName_After = $('companyName', this).text();
				department_After = $('department', this).text();
				division_After = $('division', this).text();
				humanResource_After = $('humanResource', this).text();
				managerId_After = $('managerId', this).text();
				matrixManager_After = $('matrixManager', this).text();
				gender_After = $('gender', this).text();
				jMgrFlag_After = $('jMgrFlag', this).text();
				region_After = $('region', this).text();
			//	roleData_After = $('roleData', this).text();
				function_After = $('function', this).text();
				localEmpNo_After = $('localEmpNo', this).text();
				jobCode_After = $('jobCode', this).text();
				buldingCode_After = $('buldingCode', this).text();
				operatingLocationCode_After = $('operatingLocationCode', this).text();
				officePlantCode_After = $('officePlantCode', this).text();
				seatingChart_After = $('seatingChart', this).text();
				reviewFrequency_After = $('reviewFrequency', this).text();
				lastReviewDate_After = $('lastReviewDate', this).text();
				localDepartmentCode_After = $('localDepartmentCode', this).text();
				primaryEmail_After = $('primaryEmail', this).text();
				preferredLanguage_After = $('preferredLanguage', this).text();
				title_After = $('title', this).text();
				fax_After = $('fax', this).text();
				workPhone_After = $('workPhone', this).text();
				mobilePhone_After = $('mobilePhone', this).text();
				zip_After = $('zip', this).text();
				proxy_After = $('proxy', this).text();
				zipCode_After = $('zipCode', this).text();
				city_After = $('city', this).text();
			//	cityImstring14_After = $('cityImstring14', this).text();
				state_After = $('state', this).text();
				addressLine1_After = $('addressLine1', this).text();
				addressLine2_After = $('addressLine2', this).text();
				address_After = $('address', this).text();
				timeZone_After = $('timeZone', this).text();
			//	sfCdsidyn_After = $('sfCdsidyn', this).text();
			//	sfRoleAndResponsibility_After = $('sfRoleAndResponsibility', this).text();
			//	sfLoginMethod_After = $('sfLoginMethod', this).text();
			//	sfAssignment_id_After = $('sfAssignment_id', this).text();
			//	sfExportYn_After = $('sfExportYn', this).text();
			});
			$('batchJobDetailsBeforeVO', data).each(function () {
				employeeNumber_Before = $('employeeNumber', this).text();
				employeeStatus_Before = $('employeeStatus', this).text();
				activationDate_Before = $('activationDate', this).text();
				expirationDate_Before = $('expirationDate', this).text();
				employeeType_Before = $('employeeType', this).text();
				firstName_Before = $('firstName', this).text();
				middleName_Before = $('middleName', this).text();
				lastName_Before = $('lastName', this).text();
			//	suffix_Before = $('suffix', this).text();
			//	nickname_Before = $('nickname', this).text();
				country_Before = $('country', this).text();
				companyName_Before = $('companyName', this).text();
				department_Before = $('department', this).text();
				division_Before = $('division', this).text();
				humanResource_Before = $('humanResource', this).text();
				managerId_Before = $('managerId', this).text();
				matrixManager_Before = $('matrixManager', this).text();
				gender_Before = $('gender', this).text();
				jMgrFlag_Before = $('jMgrFlag', this).text();
				region_Before = $('region', this).text();
			//	roleData_Before = $('roleData', this).text();
				function_Before = $('function', this).text();
				localEmpNo_Before = $('localEmpNo', this).text();
				jobCode_Before = $('jobCode', this).text();
				buldingCode_Before = $('buldingCode', this).text();
				operatingLocationCode_Before = $('operatingLocationCode', this).text();
				officePlantCode_Before = $('officePlantCode', this).text();
				seatingChart_Before = $('seatingChart', this).text();
				reviewFrequency_Before = $('reviewFrequency', this).text();
				lastReviewDate_Before = $('lastReviewDate', this).text();
				localDepartmentCode_Before = $('localDepartmentCode', this).text();
				primaryEmail_Before = $('primaryEmail', this).text();
				preferredLanguage_Before = $('preferredLanguage', this).text();
				title_Before = $('title', this).text();
				fax_Before = $('fax', this).text();
				workPhone_Before = $('workPhone', this).text();
				mobilePhone_Before = $('mobilePhone', this).text();
				zip_Before = $('zip', this).text();
				proxy_Before = $('proxy', this).text();
				zipCode_Before = $('zipCode', this).text();
				city_Before = $('city', this).text();
			//	cityImstring14_Before = $('cityImstring14', this).text();
				state_Before = $('state', this).text();
				addressLine1_Before = $('addressLine1', this).text();
				addressLine2_Before = $('addressLine2', this).text();
				address_Before = $('address', this).text();
				timeZone_Before = $('timeZone', this).text();
			});
			$('#batchJobDetailsDiv').html('');
			html = "<tr>";
			if (employeeNumber_Before.trim() == employeeNumber_After.trim()) {
				html += "<th>EMPLOYEE_NUMBER</th>"
					+ "<td>" + employeeNumber_Before + "</td>"
					+ "<th>EMPLOYEE_NUMBER</th>"
					+ "<td>" + employeeNumber_After + "</td>";
			} else {
				html += "<th>EMPLOYEE_NUMBER</th>"
					+ "<td class='df'>" + employeeNumber_Before + "</td>"
					+ "<th>EMPLOYEE_NUMBER</th>"
					+ "<td class='df'>" + employeeNumber_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (employeeStatus_Before.trim() == employeeStatus_After.trim()) {
				html += "<th>EMPLOYEE_STATUS</th>"
					+ "<td>" + employeeStatus_Before + "</td>"
					+ "<th>EMPLOYEE_STATUS</th>"
					+ "<td>" + employeeStatus_After + "</td>";
			} else {
				html += "<th>EMPLOYEE_STATUS</th>"
					+ "<td class='df'>" + employeeStatus_Before + "</td>"
					+ "<th>EMPLOYEE_STATUS</th>"
					+ "<td class='df'>" + employeeStatus_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (activationDate_Before.trim() == activationDate_After.trim()) {
				html += "<th>ACTIVATION_DATE</th>"
					+ "<td>" + activationDate_Before + "</td>"
					+ "<th>ACTIVATION_DATE</th>"
					+ "<td>" + activationDate_After + "</td>";
			} else {
				html += "<th>ACTIVATION_DATE</th>"
					+ "<td class='df'>" + activationDate_Before + "</td>"
					+ "<th>ACTIVATION_DATE</th>"
					+ "<td class='df'>" + activationDate_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (expirationDate_Before.trim() == expirationDate_After.trim()) {
				html += "<th>EXPIRATION_DATE</th>"
					+ "<td>" + expirationDate_Before + "</td>"
					+ "<th>EXPIRATION_DATE</th>"
					+ "<td>" + expirationDate_After + "</td>";
			} else {
				html += "<th>EXPIRATION_DATE</th>"
					+ "<td class='df'>" + expirationDate_Before + "</td>"
					+ "<th>EXPIRATION_DATE</th>"
					+ "<td class='df'>" + expirationDate_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (employeeType_Before.trim() == employeeType_After.trim()) {
				html += "<th>EMPLOYEE_TYPE</th>"
					+ "<td>" + employeeType_Before + "</td>"
					+ "<th>EMPLOYEE_TYPE</th>"
					+ "<td>" + employeeType_After + "</td>";
			} else {
				html += "<th>EMPLOYEE_TYPE</th>"
					+ "<td class='df'>" + employeeType_Before + "</td>"
					+ "<th>EMPLOYEE_TYPE</th>"
					+ "<td class='df'>" + employeeType_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (firstName_Before.trim() == firstName_After.trim()) {
				html += "<th>FIRST_NAME</th>"
					+ "<td>" + firstName_Before + "</td>"
					+ "<th>FIRST_NAME</th>"
					+ "<td>" + firstName_After + "</td>";
			} else {
				html += "<th>FIRST_NAME</th>"
					+ "<td class='df'>" + firstName_Before + "</td>"
					+ "<th>FIRST_NAME</th>"
					+ "<td class='df'>" + firstName_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (middleName_Before.trim() == middleName_After.trim()) {
				html += "<th>MIDDLE_NAME</th>"
					+ "<td>" + middleName_Before + "</td>"
					+ "<th>MIDDLE_NAME</th>"
					+ "<td>" + middleName_After + "</td>";
			} else {
				html += "<th>MIDDLE_NAME</th>"
					+ "<td class='df'>" + middleName_Before + "</td>"
					+ "<th>MIDDLE_NAME</th>"
					+ "<td class='df'>" + middleName_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (lastName_Before.trim() == lastName_After.trim()) {
				html += "<th>LAST_NAME</th>"
					+ "<td>" + lastName_Before + "</td>"
					+ "<th>LAST_NAME</th>"
					+ "<td>" + lastName_After + "</td>";
			} else {
				html += "<th>LAST_NAME</th>"
					+ "<td class='df'>" + lastName_Before + "</td>"
					+ "<th>LAST_NAME</th>"
					+ "<td class='df'>" + lastName_After + "</td>";
			}
		/*	html += "</tr>"
				+ "<tr>";
			if (suffix_Before == suffix_After) {
				html += "<th>SUFFIX</th>"
					+ "<td>" + suffix_Before + "</td>"
					+ "<th>SUFFIX</th>"
					+ "<td>" + suffix_After + "</td>";
			} else {
				html += "<th>SUFFIX</th>"
					+ "<td class='df'>" + suffix_Before + "</td>"
					+ "<th>SUFFIX</th>"
					+ "<td class='df'>" + suffix_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (nickname_Before == nickname_After) {
				html += "<th>NICKNAME</th>"
					+ "<td>" + nickname_Before + "</td>"
					+ "<th>NICKNAME</th>"
					+ "<td>" + nickname_After + "</td>";
			} else {
				html += "<th>NICKNAME</th>"
					+ "<td class='df'>" + nickname_Before + "</td>"
					+ "<th>NICKNAME</th>"
					+ "<td class='df'>" + nickname_After + "</td>";
			} */
			html += "</tr>"
				+ "<tr>";
			if (country_Before.trim() == country_After.trim()) {
				html += "<th>COUNTRY</th>"
					+ "<td>" + country_Before + "</td>"
					+ "<th>COUNTRY</th>"
					+ "<td>" + country_After + "</td>";
			} else {
				html += "<th>COUNTRY</th>"
					+ "<td class='df'>" + country_Before + "</td>"
					+ "<th>COUNTRY</th>"
					+ "<td class='df'>" + country_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (companyName_Before.trim() == companyName_After.trim()) {
				html += "<th>COMPANY_NAME</th>"
					+ "<td>" + companyName_Before + "</td>"
					+ "<th>COMPANY_NAME</th>"
					+ "<td>" + companyName_After + "</td>";
			} else {
				html += "<th>COMPANY_NAME</th>"
					+ "<td class='df'>" + companyName_Before + "</td>"
					+ "<th>COMPANY_NAME</th>"
					+ "<td class='df'>" + companyName_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (department_Before.trim() == department_After.trim()) {
				html += "<th>DEPARTMENT</th>"
					+ "<td>" + department_Before + "</td>"
					+ "<th>DEPARTMENT</th>"
					+ "<td>" + department_After + "</td>";
			} else {
				html += "<th>DEPARTMENT</th>"
					+ "<td class='df'>" + department_Before + "</td>"
					+ "<th>DEPARTMENT</th>"
					+ "<td class='df'>" + department_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (division_Before.trim() == division_After.trim()) {
				html += "<th>DIVISION</th>"
					+ "<td>" + division_Before + "</td>"
					+ "<th>DIVISION</th>"
					+ "<td>" + division_After + "</td>";
			} else {
				html += "<th>DIVISION</th>"
					+ "<td class='df'>" + division_Before + "</td>"
					+ "<th>DIVISION</th>"
					+ "<td class='df'>" + division_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (humanResource_Before.trim() == humanResource_After.trim()) {
				html += "<th>HUMAN_RESOURCE</th>"
					+ "<td>" + humanResource_Before + "</td>"
					+ "<th>HUMAN_RESOURCE</th>"
					+ "<td>" + humanResource_After + "</td>";
			} else {
				html += "<th>HUMAN_RESOURCE</th>"
					+ "<td class='df'>" + humanResource_Before + "</td>"
					+ "<th>HUMAN_RESOURCE</th>"
					+ "<td class='df'>" + humanResource_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (managerId_Before.trim() == managerId_After.trim()) {
				html += "<th>MANAGER_ID</th>"
					+ "<td>" + managerId_Before + "</td>"
					+ "<th>MANAGER_ID</th>"
					+ "<td>" + managerId_After + "</td>";
			} else {
				html += "<th>MANAGER_ID</th>"
					+ "<td class='df'>" + managerId_Before + "</td>"
					+ "<th>MANAGER_ID</th>"
					+ "<td class='df'>" + managerId_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (matrixManager_Before.trim() == matrixManager_After.trim()) {
				html += "<th>MATRIX_MANAGER</th>"
					+ "<td>" + matrixManager_Before + "</td>"
					+ "<th>MATRIX_MANAGER</th>"
					+ "<td>" + matrixManager_After + "</td>";
			} else {
				html += "<th>MATRIX_MANAGER</th>"
					+ "<td class='df'>" + matrixManager_Before + "</td>"
					+ "<th>MATRIX_MANAGER</th>"
					+ "<td class='df'>" + matrixManager_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (gender_Before.trim() == gender_After.trim()) {
				html += "<th>GENDER</th>"
					+ "<td>" + gender_Before + "</td>"
					+ "<th>GENDER</th>"
					+ "<td>" + gender_After + "</td>";
			} else {
				html += "<th>GENDER</th>"
					+ "<td class='df'>" + gender_Before + "</td>"
					+ "<th>GENDER</th>"
					+ "<td class='df'>" + gender_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (jMgrFlag_Before.trim() == jMgrFlag_After.trim()) {
				html += "<th>J_MGR_FLAG</th>"
					+ "<td>" + jMgrFlag_Before + "</td>"
					+ "<th>J_MGR_FLAG</th>"
					+ "<td>" + jMgrFlag_After + "</td>";
			} else {
				html += "<th>J_MGR_FLAG</th>"
					+ "<td class='df'>" + jMgrFlag_Before + "</td>"
					+ "<th>J_MGR_FLAG</th>"
					+ "<td class='df'>" + jMgrFlag_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (region_Before.trim() == region_After.trim()) {
				html += "<th>REGION</th>"
					+ "<td>" + region_Before + "</td>"
					+ "<th>REGION</th>"
					+ "<td>" + region_After + "</td>";
			} else {
				html += "<th>REGION</th>"
					+ "<td class='df'>" + region_Before + "</td>"
					+ "<th>REGION</th>"
					+ "<td class='df'>" + region_After + "</td>";
			}
		/*	html += "</tr>"
				+ "<tr>";
			if (roleData_Before == roleData_After) {
				html += "<th>ROLE_DATA</th>"
					+ "<td>" + roleData_Before + "</td>"
					+ "<th>ROLE_DATA</th>"
					+ "<td>" + roleData_After + "</td>";
			} else {
				html += "<th>ROLE_DATA</th>"
					+ "<td class='df'>" + roleData_Before + "</td>"
					+ "<th>ROLE_DATA</th>"
					+ "<td class='df'>" + roleData_After + "</td>";
			}*/
			html += "</tr>"
				+ "<tr>";
			if (function_Before.trim() == function_After.trim()) {
				html += "<th>FUNCTION</th>"
					+ "<td>" + function_Before + "</td>"
					+ "<th>FUNCTION</th>"
					+ "<td>" + function_After + "</td>";
			} else {
				html += "<th>FUNCTION</th>"
					+ "<td class='df'>" + function_Before + "</td>"
					+ "<th>FUNCTION</th>"
					+ "<td class='df'>" + function_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (localEmpNo_Before.trim() == localEmpNo_After.trim()) {
				html += "<th>LOCAL_EMP_NO</th>"
					+ "<td>" + localEmpNo_Before + "</td>"
					+ "<th>LOCAL_EMP_NO</th>"
					+ "<td>" + localEmpNo_After + "</td>";
			} else {
				html += "<th>LOCAL_EMP_NO</th>"
					+ "<td class='df'>" + localEmpNo_Before + "</td>"
					+ "<th>LOCAL_EMP_NO</th>"
					+ "<td class='df'>" + localEmpNo_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (jobCode_Before.trim() == jobCode_After.trim()) {
				html += "<th>JOB_CODE</th>"
					+ "<td>" + jobCode_Before + "</td>"
					+ "<th>JOB_CODE</th>"
					+ "<td>" + jobCode_After + "</td>";
			} else {
				html += "<th>JOB_CODE</th>"
					+ "<td class='df'>" + jobCode_Before + "</td>"
					+ "<th>JOB_CODE</th>"
					+ "<td class='df'>" + jobCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (buldingCode_Before.trim() == buldingCode_After.trim()) {
				html += "<th>BULDING_CODE</th>"
					+ "<td>" + buldingCode_Before + "</td>"
					+ "<th>BULDING_CODE</th>"
					+ "<td>" + buldingCode_After + "</td>";
			} else {
				html += "<th>BULDING_CODE</th>"
					+ "<td class='df'>" + buldingCode_Before + "</td>"
					+ "<th>BULDING_CODE</th>"
					+ "<td class='df'>" + buldingCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (operatingLocationCode_Before.trim() == operatingLocationCode_After.trim()) {
				html += "<th>OPERATING_LOCATION_CODE</th>"
					+ "<td>" + operatingLocationCode_Before + "</td>"
					+ "<th>OPERATING_LOCATION_CODE</th>"
					+ "<td>" + operatingLocationCode_After + "</td>";
			} else {
				html += "<th>OPERATING_LOCATION_CODE</th>"
					+ "<td class='df'>" + operatingLocationCode_Before + "</td>"
					+ "<th>OPERATING_LOCATION_CODE</th>"
					+ "<td class='df'>" + operatingLocationCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (officePlantCode_Before.trim() == officePlantCode_After.trim()) {
				html += "<th>OFFICE_PLANT_CODE</th>"
					+ "<td>" + officePlantCode_Before + "</td>"
					+ "<th>OFFICE_PLANT_CODE</th>"
					+ "<td>" + officePlantCode_After + "</td>";
			} else {
				html += "<th>OFFICE_PLANT_CODE</th>"
					+ "<td class='df'>" + officePlantCode_Before + "</td>"
					+ "<th>OFFICE_PLANT_CODE</th>"
					+ "<td class='df'>" + officePlantCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (seatingChart_Before.trim() == seatingChart_After.trim()) {
				html += "<th>SEATING_CHART</th>"
					+ "<td>" + seatingChart_Before + "</td>"
					+ "<th>SEATING_CHART</th>"
					+ "<td>" + seatingChart_After + "</td>";
			} else {
				html += "<th>SEATING_CHART</th>"
					+ "<td class='df'>" + seatingChart_Before + "</td>"
					+ "<th>SEATING_CHART</th>"
					+ "<td class='df'>" + seatingChart_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (reviewFrequency_Before.trim() == reviewFrequency_After.trim()) {
				html += "<th>REVIEW_FREQUENCY</th>"
					+ "<td>" + reviewFrequency_Before + "</td>"
					+ "<th>REVIEW_FREQUENCY</th>"
					+ "<td>" + reviewFrequency_After + "</td>";
			} else {
				html += "<th>REVIEW_FREQUENCY</th>"
					+ "<td class='df'>" + reviewFrequency_Before + "</td>"
					+ "<th>REVIEW_FREQUENCY</th>"
					+ "<td class='df'>" + reviewFrequency_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (lastReviewDate_Before.trim() == lastReviewDate_After.trim()) {
				html += "<th>LAST_REVIEW_DATE</th>"
					+ "<td>" + lastReviewDate_Before + "</td>"
					+ "<th>LAST_REVIEW_DATE</th>"
					+ "<td>" + lastReviewDate_After + "</td>";
			} else {
				html += "<th>LAST_REVIEW_DATE</th>"
					+ "<td class='df'>" + lastReviewDate_Before + "</td>"
					+ "<th>LAST_REVIEW_DATE</th>"
					+ "<td class='df'>" + lastReviewDate_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (localDepartmentCode_Before.trim() == localDepartmentCode_After.trim()) {
				html += "<th>LOCAL_DEPARTMENT_CODE</th>"
					+ "<td>" + localDepartmentCode_Before + "</td>"
					+ "<th>LOCAL_DEPARTMENT_CODE</th>"
					+ "<td>" + localDepartmentCode_After + "</td>";
			} else {
				html += "<th>LOCAL_DEPARTMENT_CODE</th>"
					+ "<td class='df'>" + localDepartmentCode_Before + "</td>"
					+ "<th>LOCAL_DEPARTMENT_CODE</th>"
					+ "<td class='df'>" + localDepartmentCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (primaryEmail_Before.trim() == primaryEmail_After.trim()) {
				html += "<th>PRIMARY_EMAIL</th>"
					+ "<td>" + primaryEmail_Before + "</td>"
					+ "<th>PRIMARY_EMAIL</th>"
					+ "<td>" + primaryEmail_After + "</td>";
			} else {
				html += "<th>PRIMARY_EMAIL</th>"
					+ "<td class='df'>" + primaryEmail_Before + "</td>"
					+ "<th>PRIMARY_EMAIL</th>"
					+ "<td class='df'>" + primaryEmail_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (preferredLanguage_Before.trim() == preferredLanguage_After.trim()) {
				html += "<th>PREFERRED_LANGUAGE</th>"
					+ "<td>" + preferredLanguage_Before + "</td>"
					+ "<th>PREFERRED_LANGUAGE</th>"
					+ "<td>" + preferredLanguage_After + "</td>";
			} else {
				html += "<th>PREFERRED_LANGUAGE</th>"
					+ "<td class='df'>" + preferredLanguage_Before + "</td>"
					+ "<th>PREFERRED_LANGUAGE</th>"
					+ "<td class='df'>" + preferredLanguage_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (title_Before.trim() == title_After.trim()) {
				html += "<th>TITLE</th>"
					+ "<td>" + title_Before + "</td>"
					+ "<th>TITLE</th>"
					+ "<td>" + title_After + "</td>";
			} else {
				html += "<th>TITLE</th>"
					+ "<td class='df'>" + title_Before + "</td>"
					+ "<th>TITLE</th>"
					+ "<td class='df'>" + title_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (fax_Before.trim() == fax_After.trim()) {
				html += "<th>FAX</th>"
					+ "<td>" + fax_Before + "</td>"
					+ "<th>FAX</th>"
					+ "<td>" + fax_After + "</td>";
			} else {
				html += "<th>FAX</th>"
					+ "<td class='df'>" + fax_Before + "</td>"
					+ "<th>FAX</th>"
					+ "<td class='df'>" + fax_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (workPhone_Before.trim() == workPhone_After.trim()) {
				html += "<th>WORK_PHONE</th>"
					+ "<td>" + workPhone_Before + "</td>"
					+ "<th>WORK_PHONE</th>"
					+ "<td>" + workPhone_After + "</td>";
			} else {
				html += "<th>WORK_PHONE</th>"
					+ "<td class='df'>" + workPhone_Before + "</td>"
					+ "<th>WORK_PHONE</th>"
					+ "<td class='df'>" + workPhone_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (mobilePhone_Before.trim() == mobilePhone_After.trim()) {
				html += "<th>MOBILE_PHONE</th>"
					+ "<td>" + mobilePhone_Before + "</td>"
					+ "<th>MOBILE_PHONE</th>"
					+ "<td>" + mobilePhone_After + "</td>";
			} else {
				html += "<th>MOBILE_PHONE</th>"
					+ "<td class='df'>" + mobilePhone_Before + "</td>"
					+ "<th>MOBILE_PHONE</th>"
					+ "<td class='df'>" + mobilePhone_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (zip_Before.trim() == zip_After.trim()) {
				html += "<th>ZIP</th>"
					+ "<td>" + zip_Before + "</td>"
					+ "<th>ZIP</th>"
					+ "<td>" + zip_After + "</td>";
			} else {
				html += "<th>ZIP</th>"
					+ "<td class='df'>" + zip_Before + "</td>"
					+ "<th>ZIP</th>"
					+ "<td class='df'>" + zip_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (proxy_Before.trim() == proxy_After.trim()) {
				html += "<th>PROXY</th>"
					+ "<td>" + proxy_Before + "</td>"
					+ "<th>PROXY</th>"
					+ "<td>" + proxy_After + "</td>";
			} else {
				html += "<th>PROXY</th>"
					+ "<td class='df'>" + proxy_Before + "</td>"
					+ "<th>PROXY</th>"
					+ "<td class='df'>" + proxy_After + "</td>";
			}
		/*	html += "</tr>"
				+ "<tr>";
			if (zipCode_Before.trim() == zipCode_After.trim()) {
				html += "<th>ZIP_CODE</th>"
					+ "<td>" + zipCode_Before + "</td>"
					+ "<th>ZIP_CODE</th>"
					+ "<td>" + zipCode_After + "</td>";
			} else {
				html += "<th>ZIP_CODE</th>"
					+ "<td class='df'>" + zipCode_Before + "</td>"
					+ "<th>ZIP_CODE</th>"
					+ "<td class='df'>" + zipCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";*/
		/*	if (city_Before.trim() == city_After.trim()) {
				html += "<th>CITY</th>"
					+ "<td>" + city_Before + "</td>"
					+ "<th>CITY</th>"
					+ "<td>" + city_After + "</td>";
			} else {
				html += "<th>CITY</th>"
					+ "<td class='df'>" + city_Before + "</td>"
					+ "<th>CITY</th>"
					+ "<td class='df'>" + city_After + "</td>";
			}*/
		/*	html += "</tr>"
				+ "<tr>";
			if (cityImstring14_Before == cityImstring14_After) {
				html += "<th>CITY_IMSTRING14</th>"
					+ "<td>" + cityImstring14_Before + "</td>"
					+ "<th>CITY_IMSTRING14</th>"
					+ "<td>" + cityImstring14_After + "</td>";
			} else {
				html += "<th>CITY_IMSTRING14</th>"
					+ "<td class='df'>" + cityImstring14_Before + "</td>"
					+ "<th>CITY_IMSTRING14</th>"
					+ "<td class='df'>" + cityImstring14_After + "</td>";
			}	*/	
			html += "</tr>"
				+ "<tr>";
			if (state_Before.trim() == state_After.trim()) {
				html += "<th>STATE</th>"
					+ "<td>" + state_Before + "</td>"
					+ "<th>STATE</th>"
					+ "<td>" + state_After + "</td>";
			} else {
				html += "<th>STATE</th>"
					+ "<td class='df'>" + state_Before + "</td>"
					+ "<th>STATE</th>"
					+ "<td class='df'>" + state_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (addressLine1_Before.trim() == addressLine1_After.trim()) {
				html += "<th>ADDRESS_LINE_1</th>"
					+ "<td>" + addressLine1_Before + "</td>"
					+ "<th>ADDRESS_LINE_1</th>"
					+ "<td>" + addressLine1_After + "</td>";
			} else {
				html += "<th>ADDRESS_LINE_1</th>"
					+ "<td class='df'>" + addressLine1_Before + "</td>"
					+ "<th>ADDRESS_LINE_1</th>"
					+ "<td class='df'>" + addressLine1_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (addressLine2_Before.trim() == addressLine2_After.trim()) {
				html += "<th>ADDRESS_LINE_2</th>"
					+ "<td>" + addressLine2_Before + "</td>"
					+ "<th>ADDRESS_LINE_2</th>"
					+ "<td>" + addressLine2_After + "</td>";
			} else {
				html += "<th>ADDRESS_LINE_2</th>"
					+ "<td class='df'>" + addressLine2_Before + "</td>"
					+ "<th>ADDRESS_LINE_2</th>"
					+ "<td class='df'>" + addressLine2_After + "</td>";
			}
		/*	html += "</tr>"
				+ "<tr>";
			if (address_Before.trim() == address_After.trim()) {
				html += "<th>ADDRESS</th>"
					+ "<td>" + address_Before + "</td>"
					+ "<th>ADDRESS</th>"
					+ "<td>" + address_After + "</td>";
			} else {
				html += "<th>ADDRESS</th>"
					+ "<td class='df'>" + address_Before + "</td>"
					+ "<th>ADDRESS</th>"
					+ "<td class='df'>" + address_After + "</td>";
			}*/
			html += "</tr>"
				+ "<tr>";
			if (timeZone_Before.trim() == timeZone_After.trim()) {
				html += "<th>TIME_ZONE</th>"
					+ "<td>" + timeZone_Before + "</td>"
					+ "<th>TIME_ZONE</th>"
					+ "<td>" + timeZone_After + "</td>";
			} else {
				html += "<th>TIME_ZONE</th>"
					+ "<td class='df'>" + timeZone_Before + "</td>"
					+ "<th>TIME_ZONE</th>"
					+ "<td class='df'>" + timeZone_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
		/*	html += "<th>SF_CDSIDYN</th>"
				+ "<td class='non'></td>"
				+ "<th>SF_CDSIDYN</th>"
				+ "<td>" + sfCdsidyn_After + "</td>";
			html += "</tr>"
				+ "<tr>";
			html += "<th>SF_ROLE_AND_RESPONSIBILITY</th>"
				+ "<td class='non'></td>"
				+ "<th>SF_ROLE_AND_RESPONSIBILITY</th>"
				+ "<td>" + sfRoleAndResponsibility_After + "</td>";
			html += "</tr>"
				+ "<tr>";
			html += "<th>SF_LOGIN_METHOD</th>"
				+ "<td class='non'></td>"
				+ "<th>SF_LOGIN_METHOD</th>"
				+ "<td>" + sfLoginMethod_After + "</td>";
			html += "</tr>"
				+ "<tr>";
			html += "<th>SF_ASSIGNMENT_ID</th>"
				+ "<td class='non'></td>"
				+ "<th>SF_ASSIGNMENT_ID</th>"
				+ "<td>" + sfAssignment_id_After + "</td>";
			html += "</tr>"
				+ "<tr>";
			html += "<th>SF_EXPORT_YN</th>"
				+ "<td class='non'></td>"
				+ "<th>SF_EXPORT_YN</th>"
				+ "<td>" + sfExportYn_After + "</td>";
			html += "</tr>"; */
			$('#batchJobDetailsDiv').append(html);

		}
	</script>