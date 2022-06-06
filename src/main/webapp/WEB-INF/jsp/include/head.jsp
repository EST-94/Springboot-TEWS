<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<link rel="stylesheet" href="/css/skin/common.css" />
<link rel="shortcut icon" href="/images/skin/common/favicon.ico" >
<link rel="shortcut icon" href="/images/skin/common/favicon.ico" type="image/x-icon">
<script type="text/javascript" src="/js/skin/jquery-1.10.2.min.js"></script>
<% if ( request.getHeader("User-Agent").indexOf("MSIE 8.") < 0 ) { 	%>
<script type="text/javascript" src="/js/skin/ui.js"></script>
<script type="text/javascript" src="/js/skin/mobilerange.min.js"></script>
<% } %>
<script type="text/javascript" src="/js/skin/bxslider.js"></script>
<script type="text/javascript" src="/js/skin/jquery.easing.min.1.3.js"></script>
<script type="text/javascript" src="/js/skin/jquery.jcontent.0.8.min.js"></script>
<!--[if lt IE 9]>
	<link rel="stylesheet" type="text/css" href="/skin/css/ie8.min.css" />
	<script type="text/javascript" src="/skin/js/ui8.js"></script>
<![endif]-->

<jsp:include page="/WEB-INF/jsp/include/cacheRemove.jsp" />
<script type="text/javascript" src="/js/jquery.min.js" charset="utf-8"></script> 
<script type="text/javascript" src="/js/jquery-ui-1.10.3.custom.min.js"></script>
<%-- <script type="text/javascript" src="/js/jquery-dynatree/js/jquery.dynatree.js" charset="utf-8"></script> --%>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/jquery.cookie.js"></script> 
<script type="text/javascript" src="/js/ajax.js"></script>
<script type="text/javascript" src="/js/common.js?version=2014080801"></script>

<script type="text/javascript">
	contextPath = '${pageContext.request.contextPath }';
	window.history.forward(1);
</script>

<%-- Library  CSS --%>
<link type="text/css" rel="stylesheet" href="/css/jquery-ui-1.10.3.custom.css"/>
<link type="text/css" rel="stylesheet" href="/js/jquery-dynatree/css/default/ui.dynatree.css"/>
<%-- CSS 보정 --%>
<link rel="stylesheet" href="/css/common.css" />
<% if ( request.getHeader("User-Agent").indexOf("MSIE 8.") < 0 ) { 	%>
<script type="text/javascript" src="/js/ui2.js"></script>
<% } %>
<!--[if lt IE 9]>
	<link rel="stylesheet" type="text/css" href="/css/ie8.css" />
<![endif]-->