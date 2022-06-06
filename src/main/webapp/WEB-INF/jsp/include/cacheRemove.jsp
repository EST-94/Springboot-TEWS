<%
/***********************************************************************************
    Program Description   : Cache 지우기 위한 공통 모듈
    Program ID            : cacheRemove.jsp 
    Logic Designer        : 

************************************************************************************/

/***********************************************************************************
 *  캐쉬제거 처리
 ***********************************************************************************/

    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    if(request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
    
%>