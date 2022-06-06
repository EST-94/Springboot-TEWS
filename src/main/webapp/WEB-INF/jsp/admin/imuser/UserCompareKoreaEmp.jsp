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
		function drawKoreaEmp(data) {
			$('batchJobDetailsVO', data).each(function () {
			//	lastName_After = $('lastName', this).text();
				localEmpNo_After = $('localEmpNo', this).text();
			//	localDepartmentCode_After = $('localDepartmentCode', this).text();
			//	globalPositionNameK_After = $('globalPositionNameK', this).text();
			//	localFirstName_After = $('localFirstName', this).text();
			//	localLastName_After = $('localLastName', this).text();
			//	localDepartmentName_After = $('localDepartmentName', this).text();
			//	jobDescription_After = $('jobDescription', this).text();
				employeeTypeK_After = $('employeeTypeK', this).text();
				workTypeK_After = $('workTypeK', this).text();
				workPlaceK_After = $('workPlaceK', this).text();
				workPlaceNameK_After = $('workPlaceNameK', this).text();
				sectionCodeK_After = $('sectionCodeK', this).text();
				workCenterCodeK_After = $('workCenterCodeK', this).text();
				workProcessCodeK_After = $('workProcessCodeK', this).text();
				costCenterCodeK_After = $('costCenterCodeK', this).text();
				positionK_After = $('positionK', this).text();
				positionNameK_After = $('positionNameK', this).text();
				yearlyPositionK_After = $('yearlyPositionK', this).text();
				jobTitleK_After = $('jobTitleK', this).text();
				jobTitleNameK_After = $('jobTitleNameK', this).text();
				jobGroupK_After = $('jobGroupK', this).text();
				jobGroupNameK_After = $('jobGroupNameK', this).text();
				titleK_After = $('titleK', this).text();
				extensionNumberK_After = $('extensionNumberK', this).text();
				genderK_After = $('genderK', this).text();
				statusDateK_After = $('statusDateK', this).text();
				categoryCodeK_After = $('categoryCodeK', this).text();
				fullName_After = $('fullName', this).text();
			//	printRank_After = $('printRank', this).text();
			//	organizationLevel_After = $('organizationLevel', this).text();
			//	organizationUseYn_After = $('organizationUseYn', this).text();
			//	departmentCode_After = $('departmentCode', this).text();
			//	departmentNameChina_After = $('departmentNameChina', this).text();
			//	parentDepartmentCode_After = $('parentDepartmentCode', this).text();
			//	organizationStartDate_After = $('organizationStartDate', this).text();
			//	organizationEndDate_After = $('organizationEndDate', this).text();
			//	koreaCostCode_After = $('koreaCostCode', this).text();
			//	departmentManagerId_After = $('departmentManagerId', this).text();
			//	koreaSectorDepartmentCode_After = $('koreaSectorDepartmentCode', this).text();
			//	koreaSectorYn_After = $('koreaSectorYn', this).text();
			//	classificationOfWorkPlace_After = $('classificationOfWorkPlace', this).text();
			//	krOrgGdid_After = $('krOrgGdid', this).text();
				kDeptCd_After = $('localDepartmentCode',this).text();
				kDeptNm_After = $('localDepartmentName',this).text();
			});
			$('batchJobDetailsBeforeVO', data).each(function () {
			//	lastName_Before = $('lastName', this).text();
				localEmpNo_Before = $('localEmpNo', this).text();
			//	localDepartmentCode_Before = $('localDepartmentCode', this).text();
			//	globalPositionNameK_Before = $('globalPositionNameK', this).text();
			//	localFirstName_Before = $('localFirstName', this).text();
			//	localLastName_Before = $('localLastName', this).text();
			//	localDepartmentName_Before = $('localDepartmentName', this).text();
			//	jobDescription_Before = $('jobDescription', this).text();
				employeeTypeK_Before = $('employeeTypeK', this).text();
				workTypeK_Before = $('workTypeK', this).text();
				workPlaceK_Before = $('workPlaceK', this).text();
				workPlaceNameK_Before = $('workPlaceNameK', this).text();
				sectionCodeK_Before = $('sectionCodeK', this).text();
				workCenterCodeK_Before = $('workCenterCodeK', this).text();
				workProcessCodeK_Before = $('workProcessCodeK', this).text();
				costCenterCodeK_Before = $('costCenterCodeK', this).text();
				positionK_Before = $('positionK', this).text();
				positionNameK_Before = $('positionNameK', this).text();
				yearlyPositionK_Before = $('yearlyPositionK', this).text();
				jobTitleK_Before = $('jobTitleK', this).text();
				jobTitleNameK_Before = $('jobTitleNameK', this).text();
				jobGroupK_Before = $('jobGroupK', this).text();
				jobGroupNameK_Before = $('jobGroupNameK', this).text();
				titleK_Before = $('titleK', this).text();
				extensionNumberK_Before = $('extensionNumberK', this).text();
				genderK_Before = $('genderK', this).text();
				statusDateK_Before = $('statusDateK', this).text();
				categoryCodeK_Before = $('categoryCodeK', this).text();
				fullName_Before = $('fullName', this).text();
			//	printRank_Before = $('printRank', this).text();
			//	organizationLevel_Before = $('organizationLevel', this).text();
			//	organizationUseYn_Before = $('organizationUseYn', this).text();
			//	departmentCode_Before = $('departmentCode', this).text();
			//	departmentNameChina_Before = $('departmentNameChina', this).text();
			//	parentDepartmentCode_Before = $('parentDepartmentCode', this).text();
			//	organizationStartDate_Before = $('organizationStartDate', this).text();
			//	organizationEndDate_Before = $('organizationEndDate', this).text();
			//	koreaCostCode_Before = $('koreaCostCode', this).text();
			//	departmentManagerId_Before = $('departmentManagerId', this).text();
			//	koreaSectorDepartmentCode_Before = $('koreaSectorDepartmentCode', this).text();
			//	koreaSectorYn_Before = $('koreaSectorYn', this).text();
			//	classificationOfWorkPlace_Before = $('classificationOfWorkPlace', this).text();
				kDeptCd_Before = $('localDepartmentCode',this).text();
				kDeptNm_Before = $('localDepartmentName',this).text();
			});
			$('#batchJobDetailsDiv').html('');
			html = "<tr>";
		/*	if (lastName_Before == lastName_After) {
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
			html += "</tr>"
				+ "<tr>";*/
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
				+ "<tr>";/*
			if (localDepartmentCode_Before == localDepartmentCode_After) {
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
			if (globalPositionNameK_Before == globalPositionNameK_After) {
				html += "<th>GLOBAL_POSITION_NAME_K</th>"
					+ "<td>" + globalPositionNameK_Before + "</td>"
					+ "<th>GLOBAL_POSITION_NAME_K</th>"
					+ "<td>" + globalPositionNameK_After + "</td>";
			} else {
				html += "<th>GLOBAL_POSITION_NAME_K</th>"
					+ "<td class='df'>" + globalPositionNameK_Before + "</td>"
					+ "<th>GLOBAL_POSITION_NAME_K</th>"
					+ "<td class='df'>" + globalPositionNameK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (localFirstName_Before == localFirstName_After) {
				html += "<th>LOCAL_FIRST_NAME</th>"
					+ "<td>" + localFirstName_Before + "</td>"
					+ "<th>LOCAL_FIRST_NAME</th>"
					+ "<td>" + localFirstName_After + "</td>";
			} else {
				html += "<th>LOCAL_FIRST_NAME</th>"
					+ "<td class='df'>" + localFirstName_Before + "</td>"
					+ "<th>LOCAL_FIRST_NAME</th>"
					+ "<td class='df'>" + localFirstName_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (localLastName_Before == localLastName_After) {
				html += "<th>LOCAL_LAST_NAME</th>"
					+ "<td>" + localLastName_Before + "</td>"
					+ "<th>LOCAL_LAST_NAME</th>"
					+ "<td>" + localLastName_After + "</td>";
			} else {
				html += "<th>LOCAL_LAST_NAME</th>"
					+ "<td class='df'>" + localLastName_Before + "</td>"
					+ "<th>LOCAL_LAST_NAME</th>"
					+ "<td class='df'>" + localLastName_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (localDepartmentName_Before == localDepartmentName_After) {
				html += "<th>LOCAL_DEPARTMENT_NAME</th>"
					+ "<td>" + localDepartmentName_Before + "</td>"
					+ "<th>LOCAL_DEPARTMENT_NAME</th>"
					+ "<td>" + localDepartmentName_After + "</td>";
			} else {
				html += "<th>LOCAL_DEPARTMENT_NAME</th>"
					+ "<td class='df'>" + localDepartmentName_Before + "</td>"
					+ "<th>LOCAL_DEPARTMENT_NAME</th>"
					+ "<td class='df'>" + localDepartmentName_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (jobDescription_Before == jobDescription_After) {
				html += "<th>JOB_DESCRIPTION</th>"
					+ "<td>" + jobDescription_Before + "</td>"
					+ "<th>JOB_DESCRIPTION</th>"
					+ "<td>" + jobDescription_After + "</td>";
			} else {
				html += "<th>JOB_DESCRIPTION</th>"
					+ "<td class='df'>" + jobDescription_Before + "</td>"
					+ "<th>JOB_DESCRIPTION</th>"
					+ "<td class='df'>" + jobDescription_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
		*/	if (employeeTypeK_Before.trim() == employeeTypeK_After.trim()) {
				html += "<th>EMPLOYEE_TYPE_K</th>"
					+ "<td>" + employeeTypeK_Before + "</td>"
					+ "<th>EMPLOYEE_TYPE_K</th>"
					+ "<td>" + employeeTypeK_After + "</td>";
			} else {
				html += "<th>EMPLOYEE_TYPE_K</th>"
					+ "<td class='df'>" + employeeTypeK_Before + "</td>"
					+ "<th>EMPLOYEE_TYPE_K</th>"
					+ "<td class='df'>" + employeeTypeK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (workTypeK_Before.trim() == workTypeK_After.trim()) {
				html += "<th>WORK_TYPE_K</th>"
					+ "<td>" + workTypeK_Before + "</td>"
					+ "<th>WORK_TYPE_K</th>"
					+ "<td>" + workTypeK_After + "</td>";
			} else {
				html += "<th>WORK_TYPE_K</th>"
					+ "<td class='df'>" + workTypeK_Before + "</td>"
					+ "<th>WORK_TYPE_K</th>"
					+ "<td class='df'>" + workTypeK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (workPlaceK_Before.trim() == workPlaceK_After.trim()) {
				html += "<th>WORK_PLACE_K</th>"
					+ "<td>" + workPlaceK_Before + "</td>"
					+ "<th>WORK_PLACE_K</th>"
					+ "<td>" + workPlaceK_After + "</td>";
			} else {
				html += "<th>WORK_PLACE_K</th>"
					+ "<td class='df'>" + workPlaceK_Before + "</td>"
					+ "<th>WORK_PLACE_K</th>"
					+ "<td class='df'>" + workPlaceK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (workPlaceNameK_Before.trim() == workPlaceNameK_After.trim()) {
				html += "<th>WORK_PLACE_NAME_K</th>"
					+ "<td>" + workPlaceNameK_Before + "</td>"
					+ "<th>WORK_PLACE_NAME_K</th>"
					+ "<td>" + workPlaceNameK_After + "</td>";
			} else {
				html += "<th>WORK_PLACE_NAME_K</th>"
					+ "<td class='df'>" + workPlaceNameK_Before + "</td>"
					+ "<th>WORK_PLACE_NAME_K</th>"
					+ "<td class='df'>" + workPlaceNameK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (sectionCodeK_Before.trim() == sectionCodeK_After.trim()) {
				html += "<th>SECTION_CODE_K</th>"
					+ "<td>" + sectionCodeK_Before + "</td>"
					+ "<th>SECTION_CODE_K</th>"
					+ "<td>" + sectionCodeK_After + "</td>";
			} else {
				html += "<th>SECTION_CODE_K</th>"
					+ "<td class='df'>" + sectionCodeK_Before + "</td>"
					+ "<th>SECTION_CODE_K</th>"
					+ "<td class='df'>" + sectionCodeK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (workCenterCodeK_Before.trim() == workCenterCodeK_After.trim()) {
				html += "<th>WORK_CENTER_CODE_K</th>"
					+ "<td>" + workCenterCodeK_Before + "</td>"
					+ "<th>WORK_CENTER_CODE_K</th>"
					+ "<td>" + workCenterCodeK_After + "</td>";
			} else {
				html += "<th>WORK_CENTER_CODE_K</th>"
					+ "<td class='df'>" + workCenterCodeK_Before + "</td>"
					+ "<th>WORK_CENTER_CODE_K</th>"
					+ "<td class='df'>" + workCenterCodeK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (workProcessCodeK_Before.trim() == workProcessCodeK_After.trim()) {
				html += "<th>WORK_PROCESS_CODE_K</th>"
					+ "<td>" + workProcessCodeK_Before + "</td>"
					+ "<th>WORK_PROCESS_CODE_K</th>"
					+ "<td>" + workProcessCodeK_After + "</td>";
			} else {
				html += "<th>WORK_PROCESS_CODE_K</th>"
					+ "<td class='df'>" + workProcessCodeK_Before + "</td>"
					+ "<th>WORK_PROCESS_CODE_K</th>"
					+ "<td class='df'>" + workProcessCodeK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (costCenterCodeK_Before.trim() == costCenterCodeK_After.trim()) {
				html += "<th>COST_CENTER_CODE_K</th>"
					+ "<td>" + costCenterCodeK_Before + "</td>"
					+ "<th>COST_CENTER_CODE_K</th>"
					+ "<td>" + costCenterCodeK_After + "</td>";
			} else {
				html += "<th>COST_CENTER_CODE_K</th>"
					+ "<td class='df'>" + costCenterCodeK_Before + "</td>"
					+ "<th>COST_CENTER_CODE_K</th>"
					+ "<td class='df'>" + costCenterCodeK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (positionK_Before.trim() == positionK_After.trim()) {
				html += "<th>POSITION_K</th>"
					+ "<td>" + positionK_Before + "</td>"
					+ "<th>POSITION_K</th>"
					+ "<td>" + positionK_After + "</td>";
			} else {
				html += "<th>POSITION_K</th>"
					+ "<td class='df'>" + positionK_Before + "</td>"
					+ "<th>POSITION_K</th>"
					+ "<td class='df'>" + positionK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (positionNameK_Before.trim() == positionNameK_After.trim()) {
				html += "<th>POSITION_NAME_K</th>"
					+ "<td>" + positionNameK_Before + "</td>"
					+ "<th>POSITION_NAME_K</th>"
					+ "<td>" + positionNameK_After + "</td>";
			} else {
				html += "<th>POSITION_NAME_K</th>"
					+ "<td class='df'>" + positionNameK_Before + "</td>"
					+ "<th>POSITION_NAME_K</th>"
					+ "<td class='df'>" + positionNameK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (yearlyPositionK_Before.trim() == yearlyPositionK_After.trim()) {
				html += "<th>YEARLY_POSITION_K</th>"
					+ "<td>" + yearlyPositionK_Before + "</td>"
					+ "<th>YEARLY_POSITION_K</th>"
					+ "<td>" + yearlyPositionK_After + "</td>";
			} else {
				html += "<th>YEARLY_POSITION_K</th>"
					+ "<td class='df'>" + yearlyPositionK_Before + "</td>"
					+ "<th>YEARLY_POSITION_K</th>"
					+ "<td class='df'>" + yearlyPositionK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (jobTitleK_Before.trim() == jobTitleK_After.trim()) {
				html += "<th>JOB_TITLE_K</th>"
					+ "<td>" + jobTitleK_Before + "</td>"
					+ "<th>JOB_TITLE_K</th>"
					+ "<td>" + jobTitleK_After + "</td>";
			} else {
				html += "<th>JOB_TITLE_K</th>"
					+ "<td class='df'>" + jobTitleK_Before + "</td>"
					+ "<th>JOB_TITLE_K</th>"
					+ "<td class='df'>" + jobTitleK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (jobTitleNameK_Before.trim() == jobTitleNameK_After.trim()) {
				html += "<th>JOB_TITLE_NAME_K</th>"
					+ "<td>" + jobTitleNameK_Before + "</td>"
					+ "<th>JOB_TITLE_NAME_K</th>"
					+ "<td>" + jobTitleNameK_After + "</td>";
			} else {
				html += "<th>JOB_TITLE_NAME_K</th>"
					+ "<td class='df'>" + jobTitleNameK_Before + "</td>"
					+ "<th>JOB_TITLE_NAME_K</th>"
					+ "<td class='df'>" + jobTitleNameK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (jobGroupK_Before.trim() == jobGroupK_After.trim()) {
				html += "<th>JOB_GROUP_K</th>"
					+ "<td>" + jobGroupK_Before + "</td>"
					+ "<th>JOB_GROUP_K</th>"
					+ "<td>" + jobGroupK_After + "</td>";
			} else {
				html += "<th>JOB_GROUP_K</th>"
					+ "<td class='df'>" + jobGroupK_Before + "</td>"
					+ "<th>JOB_GROUP_K</th>"
					+ "<td class='df'>" + jobGroupK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (jobGroupNameK_Before.trim() == jobGroupNameK_After.trim()) {
				html += "<th>JOB_GROUP_NAME_K</th>"
					+ "<td>" + jobGroupNameK_Before + "</td>"
					+ "<th>JOB_GROUP_NAME_K</th>"
					+ "<td>" + jobGroupNameK_After + "</td>";
			} else {
				html += "<th>JOB_GROUP_NAME_K</th>"
					+ "<td class='df'>" + jobGroupNameK_Before + "</td>"
					+ "<th>JOB_GROUP_NAME_K</th>"
					+ "<td class='df'>" + jobGroupNameK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (titleK_Before.trim() == titleK_After.trim()) {
				html += "<th>TITLE_K</th>"
					+ "<td>" + titleK_Before + "</td>"
					+ "<th>TITLE_K</th>"
					+ "<td>" + titleK_After + "</td>";
			} else {
				html += "<th>TITLE_K</th>"
					+ "<td class='df'>" + titleK_Before + "</td>"
					+ "<th>TITLE_K</th>"
					+ "<td class='df'>" + titleK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (extensionNumberK_Before.trim() == extensionNumberK_After.trim()) {
				html += "<th>EXTENSION_NUMBER_K</th>"
					+ "<td>" + extensionNumberK_Before + "</td>"
					+ "<th>EXTENSION_NUMBER_K</th>"
					+ "<td>" + extensionNumberK_After + "</td>";
			} else {
				html += "<th>EXTENSION_NUMBER_K</th>"
					+ "<td class='df'>" + extensionNumberK_Before + "</td>"
					+ "<th>EXTENSION_NUMBER_K</th>"
					+ "<td class='df'>" + extensionNumberK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (genderK_Before.trim() == genderK_After.trim()) {
				html += "<th>GENDER_K</th>"
					+ "<td>" + genderK_Before + "</td>"
					+ "<th>GENDER_K</th>"
					+ "<td>" + genderK_After + "</td>";
			} else {
				html += "<th>GENDER_K</th>"
					+ "<td class='df'>" + genderK_Before + "</td>"
					+ "<th>GENDER_K</th>"
					+ "<td class='df'>" + genderK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (statusDateK_Before.trim() == statusDateK_After.trim()) {
				html += "<th>STATUS_DATE_K</th>"
					+ "<td>" + statusDateK_Before + "</td>"
					+ "<th>STATUS_DATE_K</th>"
					+ "<td>" + statusDateK_After + "</td>";
			} else {
				html += "<th>STATUS_DATE_K</th>"
					+ "<td class='df'>" + statusDateK_Before + "</td>"
					+ "<th>STATUS_DATE_K</th>"
					+ "<td class='df'>" + statusDateK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (categoryCodeK_Before.trim() == categoryCodeK_After.trim()) {
				html += "<th>CATEGORY_CODE_K</th>"
					+ "<td>" + categoryCodeK_Before + "</td>"
					+ "<th>CATEGORY_CODE_K</th>"
					+ "<td>" + categoryCodeK_After + "</td>";
			} else {
				html += "<th>CATEGORY_CODE_K</th>"
					+ "<td class='df'>" + categoryCodeK_Before + "</td>"
					+ "<th>CATEGORY_CODE_K</th>"
					+ "<td class='df'>" + categoryCodeK_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
		/*	if (fullName_Before == fullName_After) {
				html += "<th>FULL_NAME</th>"
					+ "<td>" + fullName_Before + "</td>"
					+ "<th>FULL_NAME</th>"
					+ "<td>" + fullName_After + "</td>";
			} else {
				html += "<th>FULL_NAME</th>"
					+ "<td class='df'>" + fullName_Before + "</td>"
					+ "<th>FULL_NAME</th>"
					+ "<td class='df'>" + fullName_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (printRank_Before == printRank_After) {
				html += "<th>PRINT_RANK</th>"
					+ "<td>" + printRank_Before + "</td>"
					+ "<th>PRINT_RANK</th>"
					+ "<td>" + printRank_After + "</td>";
			} else {
				html += "<th>PRINT_RANK</th>"
					+ "<td class='df'>" + printRank_Before + "</td>"
					+ "<th>PRINT_RANK</th>"
					+ "<td class='df'>" + printRank_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (organizationLevel_Before == organizationLevel_After) {
				html += "<th>ORGANIZATION_LEVEL</th>"
					+ "<td>" + organizationLevel_Before + "</td>"
					+ "<th>ORGANIZATION_LEVEL</th>"
					+ "<td>" + organizationLevel_After + "</td>";
			} else {
				html += "<th>ORGANIZATION_LEVEL</th>"
					+ "<td class='df'>" + organizationLevel_Before + "</td>"
					+ "<th>ORGANIZATION_LEVEL</th>"
					+ "<td class='df'>" + organizationLevel_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (organizationUseYn_Before == organizationUseYn_After) {
				html += "<th>ORGANIZATION_USE_YN</th>"
					+ "<td>" + organizationUseYn_Before + "</td>"
					+ "<th>ORGANIZATION_USE_YN</th>"
					+ "<td>" + organizationUseYn_After + "</td>";
			} else {
				html += "<th>ORGANIZATION_USE_YN</th>"
					+ "<td class='df'>" + organizationUseYn_Before + "</td>"
					+ "<th>ORGANIZATION_USE_YN</th>"
					+ "<td class='df'>" + organizationUseYn_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (departmentCode_Before == departmentCode_After) {
				html += "<th>DEPARTMENT_CODE</th>"
					+ "<td>" + departmentCode_Before + "</td>"
					+ "<th>DEPARTMENT_CODE</th>"
					+ "<td>" + departmentCode_After + "</td>";
			} else {
				html += "<th>DEPARTMENT_CODE</th>"
					+ "<td class='df'>" + departmentCode_Before + "</td>"
					+ "<th>DEPARTMENT_CODE</th>"
					+ "<td class='df'>" + departmentCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (departmentNameChina_Before == departmentNameChina_After) {
				html += "<th>DEPARTMENT_NAME_CHINA</th>"
					+ "<td>" + departmentNameChina_Before + "</td>"
					+ "<th>DEPARTMENT_NAME_CHINA</th>"
					+ "<td>" + departmentNameChina_After + "</td>";
			} else {
				html += "<th>DEPARTMENT_NAME_CHINA</th>"
					+ "<td class='df'>" + departmentNameChina_Before + "</td>"
					+ "<th>DEPARTMENT_NAME_CHINA</th>"
					+ "<td class='df'>" + departmentNameChina_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (parentDepartmentCode_Before == parentDepartmentCode_After) {
				html += "<th>PARENT_DEPARTMENT_CODE</th>"
					+ "<td>" + parentDepartmentCode_Before + "</td>"
					+ "<th>PARENT_DEPARTMENT_CODE</th>"
					+ "<td>" + parentDepartmentCode_After + "</td>";
			} else {
				html += "<th>PARENT_DEPARTMENT_CODE</th>"
					+ "<td class='df'>" + parentDepartmentCode_Before + "</td>"
					+ "<th>PARENT_DEPARTMENT_CODE</th>"
					+ "<td class='df'>" + parentDepartmentCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (organizationStartDate_Before == organizationStartDate_After) {
				html += "<th>ORGANIZATION_START_DATE</th>"
					+ "<td>" + organizationStartDate_Before + "</td>"
					+ "<th>ORGANIZATION_START_DATE</th>"
					+ "<td>" + organizationStartDate_After + "</td>";
			} else {
				html += "<th>ORGANIZATION_START_DATE</th>"
					+ "<td class='df'>" + organizationStartDate_Before + "</td>"
					+ "<th>ORGANIZATION_START_DATE</th>"
					+ "<td class='df'>" + organizationStartDate_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (organizationEndDate_Before == organizationEndDate_After) {
				html += "<th>ORGANIZATION_END_DATE</th>"
					+ "<td>" + organizationEndDate_Before + "</td>"
					+ "<th>ORGANIZATION_END_DATE</th>"
					+ "<td>" + organizationEndDate_After + "</td>";
			} else {
				html += "<th>ORGANIZATION_END_DATE</th>"
					+ "<td class='df'>" + organizationEndDate_Before + "</td>"
					+ "<th>ORGANIZATION_END_DATE</th>"
					+ "<td class='df'>" + organizationEndDate_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (koreaCostCode_Before == koreaCostCode_After) {
				html += "<th>KOREA_COST_CODE</th>"
					+ "<td>" + koreaCostCode_Before + "</td>"
					+ "<th>KOREA_COST_CODE</th>"
					+ "<td>" + koreaCostCode_After + "</td>";
			} else {
				html += "<th>KOREA_COST_CODE</th>"
					+ "<td class='df'>" + koreaCostCode_Before + "</td>"
					+ "<th>KOREA_COST_CODE</th>"
					+ "<td class='df'>" + koreaCostCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (departmentManagerId_Before == departmentManagerId_After) {
				html += "<th>DEPARTMENT_MANAGER_ID</th>"
					+ "<td>" + departmentManagerId_Before + "</td>"
					+ "<th>DEPARTMENT_MANAGER_ID</th>"
					+ "<td>" + departmentManagerId_After + "</td>";
			} else {
				html += "<th>DEPARTMENT_MANAGER_ID</th>"
					+ "<td class='df'>" + departmentManagerId_Before + "</td>"
					+ "<th>DEPARTMENT_MANAGER_ID</th>"
					+ "<td class='df'>" + departmentManagerId_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (koreaSectorDepartmentCode_Before == koreaSectorDepartmentCode_After) {
				html += "<th>KOREA_SECTOR_DEPARTMENT_CODE</th>"
					+ "<td>" + koreaSectorDepartmentCode_Before + "</td>"
					+ "<th>KOREA_SECTOR_DEPARTMENT_CODE</th>"
					+ "<td>" + koreaSectorDepartmentCode_After + "</td>";
			} else {
				html += "<th>KOREA_SECTOR_DEPARTMENT_CODE</th>"
					+ "<td class='df'>" + koreaSectorDepartmentCode_Before + "</td>"
					+ "<th>KOREA_SECTOR_DEPARTMENT_CODE</th>"
					+ "<td class='df'>" + koreaSectorDepartmentCode_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (koreaSectorYn_Before == koreaSectorYn_After) {
				html += "<th>KOREA_SECTOR_YN</th>"
					+ "<td>" + koreaSectorYn_Before + "</td>"
					+ "<th>KOREA_SECTOR_YN</th>"
					+ "<td>" + koreaSectorYn_After + "</td>";
			} else {
				html += "<th>KOREA_SECTOR_YN</th>"
					+ "<td class='df'>" + koreaSectorYn_Before + "</td>"
					+ "<th>KOREA_SECTOR_YN</th>"
					+ "<td class='df'>" + koreaSectorYn_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (classificationOfWorkPlace_Before == classificationOfWorkPlace_After) {
				html += "<th>CLASSIFICATION_OF_WORK_PLACE</th>"
					+ "<td>" + classificationOfWorkPlace_Before + "</td>"
					+ "<th>CLASSIFICATION_OF_WORK_PLACE</th>"
					+ "<td>" + classificationOfWorkPlace_After + "</td>";
			} else {
				html += "<th>CLASSIFICATION_OF_WORK_PLACE</th>"
					+ "<td class='df'>" + classificationOfWorkPlace_Before + "</td>"
					+ "<th>CLASSIFICATION_OF_WORK_PLACE</th>"
					+ "<td class='df'>" + classificationOfWorkPlace_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			html += "<th>KR_ORG_GDID</th>"
				+ "<td class='non'></td>"
				+ "<th>KR_ORG_GDID</th>"
				+ "<td>" + krOrgGdid_After + "</td>";
			html += "</tr>"
				+ "<tr>";*/	
			if (kDeptCd_Before.trim() == kDeptCd_After.trim()) {
				html += "<th>K_DEPT_CD</th>"
					+ "<td>" + kDeptCd_Before + "</td>"
					+ "<th>K_DEPT_CD</th>"
					+ "<td>" + kDeptCd_After + "</td>";
			} else {
				html += "<th>K_DEPT_CD</th>"
					+ "<td class='df'>" + kDeptCd_Before + "</td>"
					+ "<th>K_DEPT_CD</th>"
					+ "<td class='df'>" + kDeptCd_After + "</td>";
			}
			html += "</tr>"
				+ "<tr>";
			if (kDeptNm_Before.trim() == kDeptNm_After.trim()) {
				html += "<th>K_DEPT_NM</th>"
					+ "<td>" + kDeptNm_Before + "</td>"
					+ "<th>K_DEPT_NM</th>"
					+ "<td>" + kDeptNm_After + "</td>";
			} else {
				html += "<th>K_DEPT_NM</th>"
					+ "<td class='df'>" + kDeptNm_Before + "</td>"
					+ "<th>K_DEPT_NM</th>"
					+ "<td class='df'>" + kDeptNm_After + "</td>";
			}
			html += "</tr>"
			$('#batchJobDetailsDiv').append(html);

		}
	</script>