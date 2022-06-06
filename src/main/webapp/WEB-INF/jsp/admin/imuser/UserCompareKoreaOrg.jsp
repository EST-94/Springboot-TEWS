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
		function drawKoreaOrg(data) {
			$('batchJobDetailsVO', data).each(function () {
				lastName_After = $('lastName', this).text();
				fullName_After = $('fullName', this).text();
				printRank_After = $('printRank', this).text();
				organizationLevel_After = $('organizationLevel', this).text();
				organizationUseYn_After = $('organizationUseYn', this).text();
			//	departmentCode_After = $('departmentCode', this).text();
				departmentNameChina_After = $('departmentNameChina', this).text();
				parentDepartmentCode_After = $('parentDepartmentCode', this).text();
				organizationStartDate_After = $('organizationStartDate', this).text();
				organizationEndDate_After = $('organizationEndDate', this).text();
				koreaCostCode_After = $('koreaCostCode', this).text();
				departmentManagerId_After = $('departmentManagerId', this).text();
				koreaSectorDepartmentCode_After = $('koreaSectorDepartmentCode', this).text();
				koreaSectorYn_After = $('koreaSectorYn', this).text();
				classificationOfWorkPlace_After = $('classificationOfWorkPlace', this).text();
				documentCode_After = $('documentCode',this).text();
			//	krOrgGdid_After = $('krOrgGdid', this).text();
			});
			$('batchJobDetailsBeforeVO', data).each(function () {
				lastName_Before = $('lastName', this).text();
				fullName_Before = $('fullName', this).text();
				printRank_Before = $('printRank', this).text();
				organizationLevel_Before = $('organizationLevel', this).text();
				organizationUseYn_Before = $('organizationUseYn', this).text();
			//	departmentCode_Before = $('departmentCode', this).text();
				departmentNameChina_Before = $('departmentNameChina', this).text();
				parentDepartmentCode_Before = $('parentDepartmentCode', this).text();
				organizationStartDate_Before = $('organizationStartDate', this).text();
				organizationEndDate_Before = $('organizationEndDate', this).text();
				koreaCostCode_Before = $('koreaCostCode', this).text();
				departmentManagerId_Before = $('departmentManagerId', this).text();
				koreaSectorDepartmentCode_Before = $('koreaSectorDepartmentCode', this).text();
				koreaSectorYn_Before = $('koreaSectorYn', this).text();
				classificationOfWorkPlace_Before = $('classificationOfWorkPlace', this).text();
				documentCode_Before = $('documentCode',this).text();
			});
			$('#batchJobDetailsDiv').html('');
			html = "<tr>";
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
			html += "</tr>"
				+ "<tr>";
			if (fullName_Before.trim() == fullName_After.trim()) {
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
			if (printRank_Before.trim() == printRank_After.trim()) {
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
			if (organizationLevel_Before.trim() == organizationLevel_After.trim()) {
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
			if (organizationUseYn_Before.trim() == organizationUseYn_After.trim()) {
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
			/*html += "</tr>"
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
			}*/
			html += "</tr>"
				+ "<tr>";
			if (departmentNameChina_Before.trim() == departmentNameChina_After.trim()) {
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
			if (parentDepartmentCode_Before.trim() == parentDepartmentCode_After.trim()) {
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
			if (organizationStartDate_Before.trim() == organizationStartDate_After.trim()) {
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
			if (organizationEndDate_Before.trim() == organizationEndDate_After.trim()) {
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
			if (koreaCostCode_Before.trim() == koreaCostCode_After.trim()) {
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
			if (departmentManagerId_Before.trim() == departmentManagerId_After.trim()) {
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
			if (koreaSectorDepartmentCode_Before.trim() == koreaSectorDepartmentCode_After.trim()) {
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
			if (koreaSectorYn_Before.trim() == koreaSectorYn_After.trim()) {
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
			if (classificationOfWorkPlace_Before.trim() == classificationOfWorkPlace_After.trim()) {
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
			if (documentCode_Before.trim() == documentCode_After.trim()) {
				html += "<th>DOCUMENT_CODE</th>"
					+ "<td>" + documentCode_Before + "</td>"
					+ "<th>DOCUMENT_CODE</th>"
					+ "<td>" + documentCode_After + "</td>";
			} else {
				html += "<th>DOCUMENT_CODE</th>"
					+ "<td class='df'>" + documentCode_Before + "</td>"
					+ "<th>DOCUMENT_CODE</th>"
					+ "<td class='df'>" + documentCode_After + "</td>";
			}
			/*html += "</tr>"
				+ "<tr>";
			html += "<th>KR_ORG_GDID</th>"
				+ "<td class='non'></td>"
				+ "<th>KR_ORG_GDID</th>"
				+ "<td>" + krOrgGdid_After + "</td>";*/
			html += "</tr>"
			$('#batchJobDetailsDiv').append(html);

		}
	</script>