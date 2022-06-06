<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <c:set var="roleType"><%=((String) session.getAttribute("rank")).charAt(0) %></c:set> --%>
<!-- (lnb) -->
        <div id="lnb" >

            <ul class="left_navigation">
<%--             <c:if test="${fn:contains('SAMUP', roleType)}"> --%>

				<!-- 2021-12-08 Kssim add  -->
				<li class="IM-User">
					<a href="#"><spring:message code="lnb.IU" text="IM User Management"/><span></span></a>
					<ul>
						<li class="viewuser"><a href="/admin/imuser/IMUserList.do"><spring:message code="lnb.IU.VU" text="View User"/></a></li>
					</ul>
				</li>


                <li class="Employee">
                    <a href="#"><spring:message code="lnb.EMU" text="Employee Management" /><span></span></a>
                    <ul>
                    	<li class="employeeList"><a href="/admin/employee/employeeList.do"><spring:message code="lnb.EMU.EL" text="Employee List" /></a></li>
<%--                         <li class="employeeOneButton"><a href="/admin/employee/employeeOneButton.do"><spring:message code="lnb.EMU.EOB" text="Employee One Button" /></a></li>
                        <li class="employeeCdsidAssign"><a href="/admin/employee/employeeCdsidAssign.do"><spring:message code="lnb.EMU.ECA" text="Employee CDSID Assign" /></a></li>
                        <li class="employeeBlockUser"><a href="/admin/employee/employeeBlockUser.do"><spring:message code="lnb.EMU.EBU" text="Employee Block User" /></a></li> --%>
                    </ul>
                </li>
                <li class="Supplier">
                    <a href="#"><spring:message code="lnb.SAM" text="Supplier Management" /><span></span></a>
                    <ul>
                    	<li class="supplierList"><a href="/admin/supplier/supplierList.do"><spring:message code="lnb.SAM.SL" text="Supplier List" /></a></li>
                    	<li class="managerList"><a href="/admin/supplier/managerList.do"><spring:message code="lnb.SAM.ML" text="Manager List" /></a></li>
                    	<li class="supplierListCheckManager"><a href="/admin/supplier/SupplierCkManager.do"><spring:message code="lnb.SAM.SLCM" text="Supplier List (Check Manager)" /></a></li>
<%--                         <li class="supplierOneButton"><a href="/admin/supplier/supplierOneButton.do"><spring:message code="lnb.SAM.SOB" text="Supplier One Button" /></a></li>
                        <li class="supplierReacivateUser"><a href="/admin/supplier/supplierReactivateUser.do"><spring:message code="lnb.SAM.CA" text="Supplier CDSID Assign" /></a></li>
                        <li class="supplierBlockUser"><a href="/admin/supplier/supplierBlockUser.do"><spring:message code="lnb.SAM.SBU" text="Supplier Block User" /></a></li> --%>
                    </ul>
                </li>
                <li class="Non-Employee">
                    <a href="#"><spring:message code="lnb.NAM" text="Non-Employee Management" /><span></span></a>
                    <ul>
                    	<li class="nonEmployeeList"><a href="/admin/nonEmployee/nonEmployeeList.do"><spring:message code="lnb.NAM.NEL" text="Non-Employee List" /></a></li>
<%--                         <li class="nonEmployeeCreate"><a href="/admin/nonEmployee/nonEmployeeCreate.do"><spring:message code="lnb.NAM.NEC" text="Non-Employee Create" /></a></li>
                        <li class="nonEmployeeDelete"><a href="/admin/nonEmployee/nonEmployeeDelete.do"><spring:message code="lnb.NAM.NED" text="Non-Employee Delete" /></a></li>
                        <li class="nonEmployeeModify"><a href="/admin/nonEmployee/nonEmployeeModify.do"><spring:message code="lnb.NAM.NEM" text="Non-Employee Modify" /></a></li> --%>
                    </ul>
                </li>
                <%-- 2021-12-08 kssim Comments due to disabling otp
                <li class="MFA">
                	<a href="#"><spring:message code="lnb.MFA" text="OTP Management" /><span></span></a>
                	<ul>
                		<li class="OTPUserManagement"><a href="/admin/MFA/OTPUserManagement.do"><spring:message code="lnb.MFA.OUM" text="OTP User Management" /></a></li>
                		<li class="authenticationHistoryList"><a href="/admin/MFA/authenticationHistoryList.do"><spring:message code="lnb.MFA.AHL" text="Authentication History List" /></a></li>
                		<li class="OTPActivationHistoryList"><a href="/admin/MFA/OTPActivationHistoryList.do"><spring:message code="lnb.MFA.OHL" text="OTP Activation History List" /></a></li>
                		<li class="OTPUserList"><a href="/admin/MFA/OTPUserList.do"><spring:message code="lnb.MFA.OUL" text="OTP User List" /></a></li>
                		<li class="userOTPActivation"><a href="/admin/MFA/userOTPActivation.do"><spring:message code="lnb.MFA.UOA" text="User OTP Activation" /></a></li>
                	</ul>
                </li>
                --%>
                <li class="Batch">
                	<a href="#"><spring:message code="lnb.BATCH" text="Batch Management" /><span></span></a>
                	<ul>
                		<li class="batchJobList"><a href="/admin/batch/batchJobList.do"><spring:message code="lnb.BATCH.MBJL" text="Modify Batch Job List" /></a></li>
                		<!-- 2021-12-08 kssim add   -->
                		<li class="batchJobHistory"><a href="/admin/batch/batchJobHistory.do"><spring:message code="lnb.BATCH.BJH" text="Batch Job History" /></a></li>
                	</ul>
                </li>
                <li class="Self-Portal">
                	<a href="#"><spring:message code="lnb.SP" text="Self-Portal" /><span></span></a>
                	<ul>
                		<li class="passwordReset"><a href="/admin/user/passwordReset.do"><spring:message code="lnb.SP.PR" text="Password Reset" /></a></li>
                	</ul>
                </li>

            </ul>
        </div>
        <!-- //(lnb) -->
