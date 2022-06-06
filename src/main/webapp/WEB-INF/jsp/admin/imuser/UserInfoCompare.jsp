<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<script type="text/javascript">
		var UserStore = new Object()
		$(document).ready(function () {
			UserStore = { "fullName": "true","jEmptype":"true", "department": "true", "country": "true", "employeeNumber": "true", "employeeType": "true", "fax": "true", "firstName": "true", "activationDate": "true", "companyName": "true", "division": "true", "employeeStatus": "true", "disabledState": "true", "expirationDate": "true", "managerId": "true", "nickname": "true", "suffix": "true", "humanResource": "true", "gender": "true", "jobCode": "true", "officePlantCode": "true", "localEmpNo": "true", "zip": "true", "proxy": "true", "matrixManager": "true", "seatingChart": "true", "reviewFrequency": "true", "lastReviewDate": "true", "buildingCode": "true", "address": "true", "city": "true", "jMgrFlag": "true", "operatingLocationCode": "true", "zipCode": "true", "function": "true", "region": "true", "roleData": "true", "globalPostionNameK": "true", "printRank": "true", "organizationLevel": "true", "organizationUseYn": "true", "documentCode": "true", "localLastName": "true", "localFirstName": "true", "localDepartmentCode": "true", "localDepartmentName": "true", "jobDescription": "true", "employeeTypeK": "true", "workTypeK": "true", "workPlaceK": "true", "workPlaceNameK": "true", "sectionCodeK": "true", "workCenterCodeK": "true", "workProcessCodeK": "true", "costCenterCodeK": "true", "positionK": "true", "positionNameK": "true", "yearlyPositionK": "true", "jobTitleK": "true", "jobTitleNameK": "true", "jobGroupK": "true", "jobGroupNameK": "true", "titleK": "true", "extensionNumberK": "true", "genderK": "true", "statusDateK": "true", "categoryCodeK": "true", "departmentNameChina": "true", "parentDepartmentCode": "true", "organizationStartDate": "true", "organizationEndDate": "true", "koreaCostCode": "true", "departmentManagerId": "true", "koreaSectorDepartmentCode": "true", "koreaSectorYn": "true", "classificationOfWorkPlace": "true", "timeZone": "true", "middleName": "true", "city": "true", "primaryEmail": "true", "mobilePphone": "true", "addressLine2": "true", "preferredLanguage": "true", "lastName": "true", "state": "true", "addressLine1": "true", "workPhone": "true", "title": "true", "userId": "true" };
		});

		function UserinfoCompare(data, key) {
			if (data.toUpperCase().trim() == IMUserInfo[key].toUpperCase().trim()) {
				return true;
			} else {
				UserStore[key] = false;
				return false;
			}
		}

	</script>
</head>

<body>
</body>

</html>