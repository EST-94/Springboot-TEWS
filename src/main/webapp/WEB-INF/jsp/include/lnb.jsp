<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <c:set var="roleType"><%=((String) session.getAttribute("rank")).charAt(0) %></c:set> --%>
<!-- (lnb) -->
        <div id="lnb" >
            
            <ul class="left_navigation">
                <li class="Self-Portal">
                	<a href="#"><spring:message code="lnb.SP" text="Self-Portal" /><span></span></a>
                	<ul>
                		<li class="passwordReset"><a href="/admin/user/passwordReset.do"><spring:message code="lnb.SP.PR" text="Password Reset" /></a></li>
                	</ul>
                </li>
            </ul>
        </div>
        <!-- //(lnb) -->