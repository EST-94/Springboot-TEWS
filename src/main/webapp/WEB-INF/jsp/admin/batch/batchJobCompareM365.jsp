<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<script type="text/javascript">

		$(document).ready(function () {
		});

		/**
		 * 배치 목록 저장 및 페이징 처리
		 * @param data		{@link ReturnBatchJobInfo} List of BatchJobInfo 
		 * @since 2.2, 2018-07-07
		 */
		function drawM365(data) {
			$('batchJobDetailsVO', data).each(function () {
				userId_After = $('userId', this).text();
				createDatetime_After = $('createDatetime', this).text();
				employeeStatus_After = $('employeeStatus', this).text();
				firstName_After = $('firstName', this).text();
				lastName_After = $('lastName', this).text();
				country_After = $('country', this).text();
				companyName_After = $('companyName', this).text();
				department_After = $('department', this).text();
				managerId_After = $('managerId', this).text();
				//Function_After = $('Function', this).text();
				buldingCode_After = $('buldingCode', this).text();
				officePlantCode_After = $('officePlantCode', this).text();
				localDepartmentCode_After = $('localDepartmentCode', this).text();
				preferredLanguage_After = $('preferredLanguage', this).text();
				title_After = $('title', this).text();
				fax_After = $('fax', this).text();
				workPhone_After = $('workPhone', this).text();
				mobilePhone_After = $('mobilePhone', this).text();
				zip_After = $('zip', this).text();
				city_After = $('city', this).text();
				state_After = $('state', this).text();
				addressLine1_After = $('addressLine1', this).text();
				//costCenterCodeK_After = $('costCenterCodeK', this).text();
				JEmptype_After = $('JEmptype', this).text();
				supplierCompanyName_After = $('supplierCompanyName', this).text();
				//userType_After = $('userType', this).text();
				m365Entity_After = $('m365Entity', this).text();
				m365LastProvisioningDate_After = $('m365LastProvisioningDate', this).text();
				//m365LastProvisioningResult_After = $('m365LastProvisioningResult', this).text();
				m365ModifiedDate_After = $('m365ModifiedDate', this).text();
				//m365Event_After = $('m365Event', this).text();
				//m365ErrorMsg_After = $('m365ErrorMsg', this).text();
				m365CountryCode_After = $('m365CountryCode', this).text();
				m365RegionCode_After = $('m365RegionCode', this).text();
				m365EntityCode_After = $('m365EntityCode', this).text();
				m365PlantCode_After = $('m365PlantCode', this).text();
				//m365NationCode_After = $('m365NationCode', this).text();
				m365HiddenEnabled_After = $('m365HiddenEnabled', this).text();
				m365Type_After = $('m365Type', this).text();
				m365Customattribute8_After = $('m365Customattribute8',this).text();
			});
			$('batchJobDetailsBeforeVO', data).each(function () {
				userId_Before = $('userId', this).text();
				createDatetime_Before = $('createDatetime', this).text();
				employeeStatus_Before = $('employeeStatus', this).text();
				firstName_Before = $('firstName', this).text();
				lastName_Before = $('lastName', this).text();
				country_Before = $('country', this).text();
				companyName_Before = $('companyName', this).text();
				department_Before = $('department', this).text();
				managerId_Before = $('managerId', this).text();
				buldingCode_Before = $('buldingCode', this).text();
				officePlantCode_Before = $('officePlantCode', this).text();
				localDepartmentCode_Before = $('localDepartmentCode', this).text();
				preferredLanguage_Before = $('preferredLanguage', this).text();
				title_Before = $('title', this).text();
				fax_Before = $('fax', this).text();
				workPhone_Before = $('workPhone', this).text();
				mobilePhone_Before = $('mobilePhone', this).text();
				zip_Before = $('zip', this).text();
				city_Before = $('city', this).text();
				state_Before = $('state', this).text();
				addressLine1_Before = $('addressLine1', this).text();
				JEmptype_Before = $('JEmptype', this).text();
				supplierCompanyName_Before = $('supplierCompanyName', this).text();
				m365Entity_Before = $('m365Entity', this).text();
				m365LastProvisioningDate_Before = $('m365LastProvisioningDate', this).text();
				m365ModifiedDate_Before = $('m365ModifiedDate', this).text();
				m365CountryCode_Before = $('m365CountryCode', this).text();
				m365RegionCode_Before = $('m365RegionCode', this).text();
				m365EntityCode_Before = $('m365EntityCode', this).text();
				m365PlantCode_Before = $('m365PlantCode', this).text();
				//m365Blockcredential_Before = $('m365Blockcredential', this).text();
				m365HiddenEnabled_Before = $('m365HiddenEnabled', this).text();
				m365Type_Before = $('m365Type', this).text();
				m365Userprincipalname_Before = $('m365Userprincipalname', this).text();
				//m365Customattribute6_Before = $('m365Customattribute6', this).text();
				m365Customattribute8_Before = $('m365Customattribute8', this).text();
			});
			$('#batchJobDetailsDiv').html('');
			html = "<tr>";
			if (userId_Before.trim() == userId_After.trim()) {
				html += "<th>USERID</th>"
					+ "<td>" + userId_Before + "</td>"
					+ "<th>USERID</th>"
					+ "<td>" + userId_After + "</td>";
			} else {
				html += "<th>USERID</th>"
					+ "<td class='df'>" + userId_Before + "</td>"
					+ "<th>USERID</th>"
					+ "<td class='df'>" + userId_After + "</td>";
			}
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
			/*html += "</tr>"
				+ "<tr>";
			if (createDatetime_Before.trim() == createDatetime_After.trim()) {
				html += "<th>CREATE_DATETIME</th>"
					+ "<td>" + createDatetime_Before + "</td>"
					+ "<th>CREATE_DATETIME</th>"
					+ "<td>" + createDatetime_After + "</td>";
			} else {
				html += "<th>CREATE_DATETIME</th>"
					+ "<td class='df'>" + createDatetime_Before + "</td>"
					+ "<th>CREATE_DATETIME</th>"
					+ "<td class='df'>" + createDatetime_After + "</td>";
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
			if (firstName_Before.trim() == firstName_After.trim()) {
				html += "<th>First Name</th>"
					+ "<td>" + firstName_Before + "</td>"
					+ "<th>First Name</th>"
					+ "<td>" + firstName_After + "</td>";
			} else {
				html += "<th>First Name</th>"
					+ "<td class='df'>" + firstName_Before + "</td>"
					+ "<th>First Name</th>"
					+ "<td class='df'>" + firstName_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (lastName_Before.trim() == lastName_After.trim()) {
				html += "<th>Last Name</th>"
					+ "<td>" + lastName_Before + "</td>"
					+ "<th>Last Name</th>"
					+ "<td>" + lastName_After + "</td>";
			} else {
				html += "<th>Last Name</th>"
					+ "<td class='df'>" + lastName_Before + "</td>"
					+ "<th>Last Name</th>"
					+ "<td class='df'>" + lastName_After + "</td>";
			}*/
			/*html += "</tr>"
				+ "<tr>";
			html += "<th>FUNCTION</th>"
				+ "<td class='non'></td>"
				+ "<th>FUNCTION</th>"
				+ "<td>" + Function_After + "</td>";*/
			/*html += "</tr>"
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
			if (city_Before.trim() == city_After.trim()) {
				html += "<th>CITY</th>"
					+ "<td>" + city_Before + "</td>"
					+ "<th>CITY</th>"
					+ "<td>" + city_After + "</td>";
			} else {
				html += "<th>CITY</th>"
					+ "<td class='df'>" + city_Before + "</td>"
					+ "<th>CITY</th>"
					+ "<td class='df'>" + city_After + "</td>";
			}
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
			}*/
			/*html += "</tr>"
				+ "<tr>";
			html += "<th>COST_CENTER_CODE_K</th>"
				+ "<td class='non'></td>"
				+ "<th>COST_CENTER_CODE_K</th>"
				+ "<td>" + costCenterCodeK_After + "</td>";*/
			/*html += "</tr>"
				+ "<tr>";
			if (supplierCompanyName_Before.trim() == supplierCompanyName_After.trim()) {
				html += "<th>SUPPLIER_COMPANY_NAME</th>"
					+ "<td>" + supplierCompanyName_Before + "</td>"
					+ "<th>SUPPLIER_COMPANY_NAME</th>"
					+ "<td>" + supplierCompanyName_After + "</td>";
			} else {
				html += "<th>SUPPLIER_COMPANY_NAME</th>"
					+ "<td class='df'>" + supplierCompanyName_Before + "</td>"
					+ "<th>SUPPLIER_COMPANY_NAME</th>"
					+ "<td class='df'>" + supplierCompanyName_After + "</td>";
			}*/
			/*html += "</tr>"
				+ "<tr>";
			html += "<th>USER_TYPE</th>"
				+ "<td class='non'></td>"
				+ "<th>USER_TYPE</th>"
				+ "<td>" + userType_After + "</td>";*/
			/*html += "</tr>"
				+ "<tr>";
			if (m365Entity_Before.trim() == m365Entity_After.trim()) {
				html += "<th>M365_ENTITY</th>"
					+ "<td>" + m365Entity_Before + "</td>"
					+ "<th>M365_ENTITY</th>"
					+ "<td>" + m365Entity_After + "</td>";
			} else {
				html += "<th>M365_ENTITY</th>"
					+ "<td class='df'>" + m365Entity_Before + "</td>"
					+ "<th>M365_ENTITY</th>"
					+ "<td class='df'>" + m365Entity_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (m365LastProvisioningDate_Before.trim() == m365LastProvisioningDate_After.trim()) {
				html += "<th>M365_LAST_PROVISIONING_DATE</th>"
					+ "<td>" + m365LastProvisioningDate_Before + "</td>"
					+ "<th>M365_LAST_PROVISIONING_DATE</th>"
					+ "<td>" + m365LastProvisioningDate_After + "</td>";
			} else {
				html += "<th>M365_LAST_PROVISIONING_DATE</th>"
					+ "<td class='df'>" + m365LastProvisioningDate_Before + "</td>"
					+ "<th>M365_LAST_PROVISIONING_DATE</th>"
					+ "<td class='df'>" + m365LastProvisioningDate_After + "</td>";
			}*/
			/*html += "</tr>"
				+ "<tr>";
			html += "<th>M365_LAST_PROVISIONING_RESULT</th>"
				+ "<td class='non'></td>"
				+ "<th>M365_LAST_PROVISIONING_RESULT</th>"
				+ "<td>" + m365LastProvisioningResult_After + "</td>";*/
			/*html += "</tr>"
				+ "<tr>";
			if (m365ModifiedDate_Before.trim() == m365ModifiedDate_After.trim()) {
				html += "<th>M365_MODIFIED_DATE</th>"
					+ "<td>" + m365ModifiedDate_Before + "</td>"
					+ "<th>M365_MODIFIED_DATE</th>"
					+ "<td>" + m365ModifiedDate_After + "</td>";
			} else {
				html += "<th>M365_MODIFIED_DATE</th>"
					+ "<td class='df'>" + m365ModifiedDate_Before + "</td>"
					+ "<th>M365_MODIFIED_DATE</th>"
					+ "<td class='df'>" + m365ModifiedDate_After + "</td>";
			}*/
			/*html += "</tr>"
				+ "<tr>";
			html += "<th>M365_EVENT</th>"
				+ "<td class='non'></td>"
				+ "<th>M365_EVENT</th>"
				+ "<td>" + m365Event_After + "</td>";*/
			/*html += "</tr>"
				+ "<tr>";
			html += "<th>M365_ERROR_MSG</th>"
				+ "<td class='non'></td>"
				+ "<th>M365_ERROR_MSG</th>"
				+ "<td>" + m365ErrorMsg_After + "</td>";*/
			html += "</tr>"
				+ "<tr>";
			if (m365CountryCode_Before.trim() == m365CountryCode_After.trim()) {
				html += "<th>M365_COUNTRY_CODE</th>"
					+ "<td>" + m365CountryCode_Before + "</td>"
					+ "<th>M365_COUNTRY_CODE</th>"
					+ "<td>" + m365CountryCode_After + "</td>";
			} else {
				html += "<th>M365_COUNTRY_CODE</th>"
					+ "<td class='df'>" + m365CountryCode_Before + "</td>"
					+ "<th>M365_COUNTRY_CODE</th>"
					+ "<td class='df'>" + m365CountryCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (m365RegionCode_Before.trim() == m365RegionCode_After.trim()) {
				html += "<th>M365_REGION_CODE</th>"
					+ "<td>" + m365RegionCode_Before + "</td>"
					+ "<th>M365_REGION_CODE</th>"
					+ "<td>" + m365RegionCode_After + "</td>";
			} else {
				html += "<th>M365_REGION_CODE</th>"
					+ "<td class='df'>" + m365RegionCode_Before + "</td>"
					+ "<th>M365_REGION_CODE</th>"
					+ "<td class='df'>" + m365RegionCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (m365EntityCode_Before.trim() == m365EntityCode_After.trim()) {
				html += "<th>M365_ENTITY_CODE</th>"
					+ "<td>" + m365EntityCode_Before + "</td>"
					+ "<th>M365_ENTITY_CODE</th>"
					+ "<td>" + m365EntityCode_After + "</td>";
			} else {
				html += "<th>M365_ENTITY_CODE</th>"
					+ "<td class='df'>" + m365EntityCode_Before + "</td>"
					+ "<th>M365_ENTITY_CODE</th>"
					+ "<td class='df'>" + m365EntityCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (m365PlantCode_Before.trim() == m365PlantCode_After.trim()) {
				html += "<th>M365_PLANT_CODE</th>"
					+ "<td>" + m365PlantCode_Before + "</td>"
					+ "<th>M365_PLANT_CODE</th>"
					+ "<td>" + m365PlantCode_After + "</td>";
			} else {
				html += "<th>M365_PLANT_CODE</th>"
					+ "<td class='df'>" + m365PlantCode_Before + "</td>"
					+ "<th>M365_PLANT_CODE</th>"
					+ "<td class='df'>" + m365PlantCode_After + "</td>";
			}
			/*html += "</tr>"
				+ "<tr>";
			html += "<th>M365_NATION_CODE</th>"
				+ "<td class='non'></td>"
				+ "<th>M365_NATION_CODE</th>"
				+ "<td>" + m365NationCode_After + "</td>";*/
			/*html += "</tr>"
				+ "<tr>";
			html += "<th>M365_BLOCKCREDENTIAL</th>"
				+ "<td>" + m365Blockcredential_Before + "</td>"
				+ "<th>M365_BLOCKCREDENTIAL</th>"
				+ "<td class='non'></td>";*/
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
			if (JEmptype_Before.trim() == JEmptype_After.trim()) {
				html += "<th>J_EMPTYPE</th>"
					+ "<td>" + JEmptype_Before + "</td>"
					+ "<th>J_EMPTYPE</th>"
					+ "<td>" + JEmptype_After + "</td>";
			} else {
				html += "<th>J_EMPTYPE</th>"
					+ "<td class='df'>" + JEmptype_Before + "</td>"
					+ "<th>J_EMPTYPE</th>"
					+ "<td class='df'>" + JEmptype_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (department_Before.trim() == localDepartmentCode_After.trim()) {
				html += "<th>DEPARTMENT</th>"
					+ "<td>" + department_Before + "</td>"
					+ "<th>DEPARTMENT</th>"
					+ "<td>" + localDepartmentCode_After + "</td>";
			} else {
				html += "<th>DEPARTMENT</th>"
					+ "<td class='df'>" + department_Before + "</td>"
					+ "<th>DEPARTMENT</th>"
					+ "<td class='df'>" + localDepartmentCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
				if (m365Customattribute8_Before.trim() == m365Customattribute8_After.trim()) {
					html += "<th>M365_CUSTOMATTRIBUTE8</th>"
						+ "<td>" + m365Customattribute8_Before + "</td>"
						+ "<th>M365_CUSTOMATTRIBUTE8</th>"
						+ "<td>" + m365Customattribute8_After + "</td>";
				} else {
					html += "<th>M365_CUSTOMATTRIBUTE8</th>"
						+ "<td class='df'>" + m365Customattribute8_Before + "</td>"
						+ "<th>M365_CUSTOMATTRIBUTE8</th>"
						+ "<td class='df'>" + m365Customattribute8_After + "</td>";
				}
				html += "</tr>"
				+ "<tr>";
			if (m365Type_Before.trim() == m365Type_After.trim()) {
				html += "<th>M365_TYPE</th>"
					+ "<td>" + m365Type_Before + "</td>"
					+ "<th>M365_TYPE</th>"
					+ "<td>" + m365Type_After + "</td>";
			} else {
				html += "<th>M365_TYPE</th>"
					+ "<td class='df'>" + m365Type_Before + "</td>"
					+ "<th>M365_TYPE</th>"
					+ "<td class='df'>" + m365Type_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (m365HiddenEnabled_Before.trim() == m365HiddenEnabled_After.trim()) {
				html += "<th>M365_HIDDEN_ENABLED</th>"
					+ "<td>" + m365HiddenEnabled_Before + "</td>"
					+ "<th>M365_HIDDEN_ENABLED</th>"
					+ "<td>" + m365HiddenEnabled_After + "</td>";
			} else {
				html += "<th>M365_HIDDEN_ENABLED</th>"
					+ "<td class='df'>" + m365HiddenEnabled_Before + "</td>"
					+ "<th>M365_HIDDEN_ENABLED</th>"
					+ "<td class='df'>" + m365HiddenEnabled_After + "</td>";
			}
			/*html += "</tr>"
				+ "<tr>";
			html += "<th>M365_USERPRINCIPALNAME</th>"
				+ "<td>" + m365Userprincipalname_Before + "</td>"
				+ "<th>M365_USERPRINCIPALNAME</th>"
				+ "<td class='non'></td>";*/
			/*html += "</tr>"
				+ "<tr>";
			html += "<th>M365_CUSTOMATTRIBUTE6</th>"
				+ "<td>" + m365Customattribute6_Before + "</td>"
				+ "<th>M365_CUSTOMATTRIBUTE6</th>"
				+ "<td class='non'></td>";*/
			html += "</tr>";

			$('#batchJobDetailsDiv').append(html);

		}
	</script>
</head>

<body class="main">
</body>

</html>