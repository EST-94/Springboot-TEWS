/**
 * @since 2.1, 2014-08-08 
 */

var contextpath;
var loadingBarId = "loadingbar";

var gMenuGroupId = null;
var gMenuId = null;
var contentCharHTML;  //허용문자

var TOKEN_DELIMITER = ",";
var DEFAULT_DB_PROV    = "RTIM.DB.PROV";
var DEFAULT_LDAP_PROV  = "RTIM.LDAP.PROV";
var DEFAULT_AD_PROV    = "RTIM.AD.PROV";
var DEFAULT_DB_RECON   = "RTIM.DB.RECON";
var DEFAULT_LDAP_RECON = "RTIM.LDAP.RECON";

// 사용자 레벨
var USER_LEVEL_S = "S"; // 슈퍼관리자
var USER_LEVEL_A = "A"; // 부서관리자
var USER_LEVEL_U = "U"; // 일반사용자


//DATATYPE
var DATA_TYPE_U = "U"; // 사용자
var DATA_TYPE_O = "O"; // 조직

//RTSTATUS
var STATUS_0 = "0";	//사용
var STATUS_1 = "1";	//사용안함

//CONSOLE 오류방지
var console = window.console || { log: function() {} };

//오른쪽 마우스 사용 금지
//document.oncontextmenu=new Function('return false');
//본문 데이터 드래그 금지
//document.ondragstart=new Function('return false');
//본문 데이터 선택 금지
//document.onselectstart=new Function('return false');

//전화번호 숫자와 - 기호만 
function onlyNum() { 
	  var keycode = window.event.keyCode;
	 
	  if(keycode == 8 || keycode==189 || (keycode >= 35 && keycode <= 40) || (keycode >= 46 && keycode <= 57) || (keycode >= 96 && keycode <= 105) || keycode == 110 || keycode == 190) {
	    window.event.returnValue = true;
	    return;
	  } else {
	    window.event.returnValue = false;
	    return;
	  }
	}

/**
 * loading bar function
 */
function showLoadingBar() {
    loadingBar(true);
    $(document).ajaxStart(function(){                   
    	$("#"+loadingBarId).dialog({
  	      width: 220, height : 130,
  	      modal : true, closeOnEscape : false,
  	      draggable : false, resizable : false,
  	      open : function(){ $(this).prev().hide(); }
  	      });
	}).ajaxStop(function(){                   
    	  $("#"+loadingBarId).dialog("close");
	      loadingBar(false);
	});
    
//    $("#"+loadingBarId).ajaxStart(function(){                   
//        $(this).dialog({
//            width: 200, height : 120,
//            modal : true, closeOnEscape : false,
//            draggable : false, resizable : false,
//            open : function(){ $(this).prev().hide(); }
//        });
//    });
//    $("#"+loadingBarId).ajaxStop(function(){
//        $(this).dialog("close");
//        loadingBar(false);
//    });
}

/**
 * 
 * @param flag
 */
function loadingBar(flag) {
    if(flag){
        var loadingHtml  = "<div id='"+loadingBarId+"' class='loadingBar'>";
            loadingHtml += "<img src='/resources/images/common/loading.gif' align='center'/><div class='loadingBarText'>Progessing.</div>";
            loadingHtml += "</div>";
        $(loadingHtml).appendTo("body").hide();
    }else{
        $("#"+loadingBarId).remove();   
    }  
}

/**
 * 
 * @param targetDivId
 * @param pageJson
 * @param onclickFunction
 */
function paginavigation(targetDivId, pageJson, onclickFunction) {
    var nowPage = "";
    var startPage = "";
    var endPage = "";
    var totalPage = "";
    var blockPage = "";
    var rowTotal = "";
//    var isPrev = false;
//    var isNext = false;
    
    nowPage = pageJson["nowPage"];
    startPage = pageJson["startPage"];
    endPage = pageJson["endPage"];
    totalPage = pageJson["totalPage"];
    blockPage = pageJson["blockPage"];
    isPrev = pageJson["prevPage"];
    isNext = pageJson["nextPage"];
    rowTotal = pageJson["rowTotal"];
    
    var pageHTML = "<br />";
    pageHTML += " <div class='board_btm'>" ;
    pageHTML += " <div class='board_total'>" ;
    pageHTML += " <span class='txt1'>Total list </span><span class='txt2'>:"+rowTotal+"</span>";
    pageHTML += " </div>";
    pageHTML += " </div>";
    pageHTML += " <br />";
    if(totalPage <= 1) {
        $("#" + targetDivId).hide();
    } else {
        pageHTML += "<div class='paginate'>";
        pageHTML +="<a href='javascript:"+onclickFunction+"(1)' class='prev10'>";
        pageHTML +="<img src='/images/skin/btn/btn_prev10.gif' alt='First'>";
        pageHTML +="</a>";
        pageHTML +="<a href='javascript:"+onclickFunction+"(" + (nowPage - 1) + ")' class='prev'>";
        pageHTML +="<img src='/images/skin/btn/btn_prev.gif' alt='before' >";
        pageHTML +="</a>";
        
        if(startPage <= endPage) {
            for ( var i = startPage; i <= endPage; i++) {
                if(i == nowPage){
                    pageHTML += "<a href='#' class='on'>"+nowPage+"</a>";
                }else{
                    pageHTML += "<a href='javascript:"+onclickFunction+"(" + i + ")'>"+i+"</a>";
                }
            }//end for
        }//end if
        
        pageHTML += "<a href='javascript:"+onclickFunction+"(" + (nowPage + 1) + ")'  class='next'>";
        pageHTML += "<img src='/images/skin/btn/btn_next.gif' alt='next' >";
        pageHTML += "</a>";
        pageHTML += "<a href='javascript:"+onclickFunction+"(" + (endPage + blockPage) + ")' class='next10'>";
        pageHTML += "<img src='/images/skin/btn/btn_next10.gif' alt='last'>";
        pageHTML += "</a>";
        pageHTML += "</div>";
    }//end if-else
    
    $("#" + targetDivId).show().html(pageHTML);
}

/**
 * 정보 수정시, 이전 데이터와 비교하는 메소드
 * @param oldData
 * @param newDataForm
 * @returns {Boolean}
 */
function isExistModifyData(oldData, newDataForm){
    var result = false;
    $.each(oldData, function(key, oldValue){
        var type = $(newDataForm+" [name='"+key+"']").prop("type");
        var newValue;
        if(type=="radio"){
            newValue = $(newDataForm+" [name='"+key+"']:checked").val();
        } else if (type=="select-multiple"){
            newValue = $(newDataForm+" select[name='"+key+"'] option:selected").text();
        } else {
            newValue = $(newDataForm+" [name='"+key+"']").val();
        }
        //console.log( "key=" + key + " , oldValue=" + escape(oldValue) + ", newValue=" + escape(newValue));
        if(newValue != undefined){
            if (oldValue == null || oldValue == 'null') oldValue = "";
            if (newValue == null || newValue == 'null') newValue = "";
            paramA = convertNewLineToBr(oldValue);
            paramB = convertNewLineToBr(newValue);
            if( paramA != paramB){
                result = true;
                return false; //break동작
            }
        }
    });
    return result;
}



/**
 * all check 함수
 */
function allCheck(checkBaxName, formId){
  //코드 종류 리스트에 체크박스 전체 선택 / 전체 해지
    $("#allCheck").click(function() {
        if ($("input:checkbox[id='allCheck']").is(":checked")) {
            $("input:checkbox[id='"+checkBaxName+"']").each(function(){
//                this.checked = true;
                $(this).prop("checked", true);
                $(this).parent().parent().attr("class","active");
            });
        } else {
            $("input:checkbox[id='"+checkBaxName+"']:checked").each(function(){
                $(this).prop("checked", false);
                $(this).parent().parent().attr("class","");
            });
        }
    });
}

function allCheck2(tableId){
	var tbl = $("#"+tableId);
    
    // 테이블 헤더에 있는 checkbox 클릭시
    $(":checkbox:first", tbl).click(function(){
        // 클릭한 체크박스가 체크상태인지 체크해제상태인지 판단
        if( $(this).is(":checked") ){
            $(":checkbox", tbl).prop("checked", true);
        }
        else{
            $(":checkbox", tbl).prop("checked", false);
        }

        // 모든 체크박스에 change 이벤트 발생시키기                
        $(":checkbox", tbl).trigger("change");
    });
    // 헤더에 있는 체크박스외 다른 체크박스 클릭시
    $(":checkbox:not(:first)", tbl).click(function(){
        var allCnt = $(":checkbox:not(:first)", tbl).length;
        var checkedCnt = $(":checkbox:not(:first)", tbl).filter(":checked").length;
        // 전체 체크박스 갯수와 현재 체크된 체크박스 갯수를 비교해서 헤더에 있는 체크박스 체크할지 말지 판단
        if( allCnt==checkedCnt ){
            $(":checkbox:first", tbl).prop("checked", true);
        }
        else{
            $(":checkbox:first", tbl).prop("checked", false);
        }
    }).change(function(){
        if( $(this).is(":checked") ){
            // 체크박스의 부모 > 부모 니까 tr 이 되고 tr 에 selected 라는 class 를 추가한다.
            $(this).parent().parent().addClass("active");
        }
        else{
            $(this).parent().parent().removeClass("active");
        }
    });
}





/**
 * 
 * @param checkForm
 * @param msg
 * @returns {Boolean}
 */
function isNull(checkForm, msg) {
	var data = $(checkForm).val();
	
	if (data == undefined|| data == "") {
		alert(msg);
		$(checkForm).focus();
		return false;
	}
	return true;
}


/**
 * 빈값체크 후 메시지 처리 및 포커스
 * @param objId - Object Id
 * @param fieldText - 필드명
 */
function isEmpty(objId, fieldText){

	if($("#" + objId).val() == ""){
		if(typeof fieldText != "undefined"){
			alert(fieldText + "을(를) 입력하세요.");
			$("#" + objId).focus();
		}
		return true;
	}
	return false;
}
 
function isEmptyRadio(objId, fieldText) {
	if($("#" + objId + ':radio:checked').length == 0){
		alert(fieldText + "을(를) 선택하세요.");
		return true;
	}else{
		return false;
	}
}



/**
 * 값이 동일한지 비교
 * @param objId - Object Id
 * @param compareData - 비교할 값
 */
function isEqual(objId, compareData){
	if($("#" + objId).val() == compareData){
		return true;
	}
	return false;
}



/**
 * 값이 다른지 비교
 * @param objId - Object Id
 * @param compareData - 비교할 값
 */
function isNotEqual(objId, compareData){
	if($("#" + objId).val() == compareData){
		return false;
	}
	return true;
}


/**
 * 빈값체크 후 메시지 처리 
 * @param objId - Object Id
 * @param msgText - 빈값일 경우 출력할 메세지
 */
function isEmptyMsg(objId, msgText){

	if($("#" + objId).val() == ""){
		alert(msgText);
		$("#" + objId).focus();
		return true;
	}
	return false;

}







/**
 * 대문자로 변환, 한글입력 불가, 공백불가
 */
function keyUpAllowUpperAlphaNumeric( obj )
{
	//console.log( obj );
	//console.log( obj.val() );

	var strVal = obj.val();
	strVal = strVal.toUpperCase().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
	
	strVal = strVal.replace( ' ', '');
	
	obj.val(strVal);
}

/**
 * 숫자만 입력
 */
function keyUpAllowNumeric( obj )
{
	var strVal = obj.val();
	strVal = strVal.replace( /[^0-9]/g, '' );
	
	strVal = strVal.replace( ' ', '');
	
	obj.val( strVal );
}

/**
 * 한글입력 방지
 */
function keyUpNoKorean( obj )
{	
	var strVal = obj.val();
	strVal = strVal.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' );
	
	strVal = strVal.replace( ' ', '');
	
	obj.val( strVal );
}


/**
 * 
 * 숫자만 입력 & 길이 체크
 *
 */
function keyUpAllowNumericAndMaxLength( obj, maxLength )
{
	var strVal = obj.value;
	strVal = strVal.replace( /[^0-9]/g, '' );
	
	strVal = strVal.replace( ' ', '');
	
	obj.value = strVal;
	
	isMaxLength(obj, maxLength);
}




/**
 * element value의 최대 길이를 체크 한다.
 * @param obj
 * @param maxlength
 * @returns {Number}
 */
function isMaxLength(obj, maxlength){

    var st_len = 0;
    var nMaxLength = maxlength;
    
    if( obj.value == null) return 0;
    
    for( var i = 0; i < obj.value.length; i++ ) {
        var es_len = escape(obj.value.charAt(i));
        if( es_len.length == 1 ) st_len++;
        else if( es_len.indexOf("%u") != -1 ) st_len += 2;
        else if( es_len.indexOf("%") != -1 ) st_len += es_len.length/3;
    }
    
    if( st_len > nMaxLength ) {
        //alert("최대 " + maxlength + "자 입력가능합니다.");
        obj.value = obj.value.substring(0, nMaxLength);
        return;
     }
}


/**
 * 문자열의 최대길이를 체크한다.
 * 
 * @param value
 * @param maxlength
 * @returns {boolean}
 */
function checkMaxLength(value, maxlength, fieldText){

    var st_len = 0;
    var nMaxLength = maxlength;
    
    if( value == null) return true;
    
    for( var i = 0; i < value.length; i++ ) {
        var es_len = escape(value.charAt(i));
        if( es_len.length == 1 ) st_len++;
        else if( es_len.indexOf("%u") != -1 ) st_len += 2;
        else if( es_len.indexOf("%") != -1 ) st_len += es_len.length/3;
    }
    
    if( st_len > nMaxLength ) {
    	if(typeof fieldText != "undefined"){
    		alert(fieldText + "는(은) 최대 길이 " + maxlength + "를 초과할 수 없습니다.");
    	}
        return false;
    }
    
    return true;
}






/**
 * Keypress시 input에 입력 영문 대문자만 입력
 */
function keyUpperAlphabet()
{
	//console.log( "keyAlphabet event.keyCode = " + event.keyCode);
	if( event.keyCode >=65 && event.keyCode <= 90 ) {
		event.returnValue = true;
	} else {
		alert("영문 대문자만 입력 가능합니다.");
		event.returnValue = false;
	}

}

/**
 * 입력문자를 모두 대문자로 변환
 * @param obj
 */
function makeUppercase(obj) {
	obj.value = obj.value.toUpperCase();
}



/**
 * 입력문자를 모두 소문자로 변환
 */
function makeUppercase(obj) {
	obj.value = obj.value.toLowerCase();
}


/**
 * Keypress시 input에 입력 key 값이 숫자만 입력 할 수 있도록 하는 함수
 * @param event
 */
function keyNumeric()
{
	if((event.keyCode >= 48 && event.keyCode <= 57)  || (event.keyCode == 13)){
	    event.returnValue = true;
	}else{
	    event.returnValue = false;
	}
}




/**
 *  Keypress시 input에 입력 key 값이 숫자와 '-' 만 입력 할 수 있도록 하는 함수
 * @param event
 */
function keyNumericDash()
{
	if((event.keyCode >= 48 && event.keyCode <= 57)  ||
	   (event.keyCode == 13) ||
	   (event.keyCode == 45)){
	    event.returnValue = true;
	} else{
		alert("숫자와 '-'만 입력 가능합니다.");
	    event.returnValue = false;
	}
}

/**
 *  Keypress시 input에 입력 key 값이 숫자와 '-', '.' 만 입력 할 수 있도록 하는 함수
 * @param event
 */
function keyNumericDashPoint()
{
	//alert( "event.keyCode = " + event.keyCode);
	if((event.keyCode >= 48 && event.keyCode <= 57)  ||
	   (event.keyCode == 13) ||
	   (event.keyCode == 45) ||
	   (event.keyCode == 46) )
	{

	    event.returnValue = true;
	}else{

		alert("숫자와 '-', '.' 만 입력 가능합니다.");
	    event.returnValue = false;
	}
}


/**
 *  Keypress시 input에 입력 key 값이 숫자와 '-', backspace 만 입력 할 수 있도록 하는 함수
 * @param event
 */
function keyNumericBackspace()
{
	if((event.keyCode >= 48 && event.keyCode <= 57)  ||
	   (event.keyCode == 8) ||
	   (event.keyCode == 13) ||
	   (event.keyCode == 45)){
	    event.returnValue = true;
	}else{
		alert("숫자와 '-'만 입력 가능합니다.");
	    event.returnValue = false;
	}
}




/**
 * 이메일 유효성 검증
 * @param email - 이메일 Object ID
 */
function checkEmailValidate(objId){

	var email = $("#" + objId).val();
	var regExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if(!regExp.test(email)){
		alert('이메일 주소가 유효하지 않습니다');
		return false;
	}
	return true;

}

/**
 * 비밀번호 validation
 */
function checkPasswdValidate( passwd ) {

	// 특수문자, 문자, 숫자 포함 형태의 8~15자리 이내
	var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[`~!@\#$%<>^&*\(\)\-\=+_\|\[\]\{\};:\',<.>\\\/\?\"]).*$/;
	
	// 문자, 숫자 포함 형태의 6~12자리 이내
	//var regExp = /^[A-Za-z0-9]{6,12}$/;
	
	if(!regExp.test(passwd)){
		alert('비밀번호는 하나이상의 대문자, 소문자, 숫자, 특수문자를 포함하여 8~15자 이내여야 합니다');
		return false;
	}
	return true;
}




/**
 * null or "null" 값을 "" 로 변경함
 * 
 */
function setNullToString(val){

	if( val == null || val == "null" ) {
		return "";
	} 

	return val;
}


/**
 * null or "null" 값을 0 로 변경함
 * 
 * int로 return
 * 
 */
function setNullToNumber(val){

	if( val == null || val == "null" ) {
		return 0;
	} 

	return Number(val);
}

/**
 * null or "null" 값을 초기화함
 * 
 * @since 2014-08-11
 */
function nvl(val, init){

	if( val == null || val == "null" ) {
		return init;
	} 

	return val;
}

/**
 * "\r\n" or "\r" 값을 "<br />" 로 변경함
 * 
 * @since 2014-08-07
 */
function convertNewLineToBr(val){
	convertText = val.replace(/\r\n/g, "<br />");
	convertText = convertText.replace(/\r/g, "<br />");
	convertText = convertText.replace(/\n/g, "<br />"); 
	return convertText;
}




/**
 * Post 방식으로 submit
 *
 * @param url    submit할 주소
 * @param params Plain Object
 * @param target  url이 적용되는 target 이름(현재 페이지는 '_self'
 */
var fnPostGotoWithMenuId = function(url, params, target) {
    var strUrl = url +"?menuId=" + gMenuId + "&menuGroupId=" + gMenuGroupId;
    fnPostGoto(strUrl, params, target);
};


/**
 * Post 방식으로 submit
 *
 * @param url    submit할 주소
 * @param params Plain Object
 * @param target  url이 적용되는 target 이름(현재 페이지는 '_self'
 */
var fnPostGotoChangeMenu = function(url, params, target, menuId) {
    var strUrl = url +"?menuId=" + menuId;
    fnPostGoto(strUrl, params, target);
};



/**
 * Post 방식으로 submit
 *
 * @param url    submit할 주소
 * @param params Plain Object
 * @param target  url이 적용되는 target 이름(현재 페이지는 '_self'
 */
var fnPostGoto = function(url, params, target) {
    
    var f = document.createElement('form');
    var obj, value;
    for(var key in params) {
        value = params[key];
        obj = document.createElement('input');
        obj.setAttribute('type', 'hidden');
        obj.setAttribute('name', key);
        obj.setAttribute('value', value);
        f.appendChild(obj);
    }
    if(target) f.setAttribute('target', target);
    f.setAttribute('method', 'post');
    f.setAttribute('action', url);
    document.body.appendChild(f);
    f.submit();
};



/**
 * 팝업 윈도우 가운데로 띄울 위치 구하기
 * @param width - 창크기(width)
 * @param height - 창크기(height)
 *
 */
function centerWindow(width, height){

	var outx = screen.width;
	var outy = screen.height;
	var x = (outx - width)/2;
	var y = (outy - height)/2;
	dim = new Array(2);
	dim[0] = x;
	dim[1] = y;
	dim[2] = width;
	dim[3] = height;

	return  dim;
}

/**
 * Post 방식으로 Popup
 *
 * @param url    submit할 주소
 * @param params Plain Object
 * @param target  url이 적용되는 target 이름(현재 페이지는 '_self')
 * @param width 팝업창 넓이
 * @param width 팝업창 높이
 */
var fnPostPopup = function(url, params, target, width, height, scrollbar) {
    scrollbar = scrollbar || "no";
    var pos = centerWindow(width, height);
    //console.log( "hhohohooh");
    var popup = window.open("", target, "width=" + width + ",height=" + height + ",left=" + pos[0] + ",top=" + pos[1] + ",status=no, scrollbars=" + scrollbar);

    fnPostGoto(url, params, target);
    return popup;
};




/**
 * 콤보용 코드 목록 조회
 * @param strCodeIdList   ","을 구분자로 CODEID를 넣으면 됨( CODEID 는 대문자)
 * @param sucessCallBack
 */
function getCodeDetailListForCombo(strCodeIdList, sucessCallBack) {

    var params = {};
    params.SEARCH_CODE_LIST = strCodeIdList;
    
    ajaxJsonCall(contextPath + "/code/getCodeDetailListForCombo.do", params, function(data) {
        if (data) {
            sucessCallBack(data);
        }//end if
    }, "", false);
}



/**
 * 콤보를 생성
 * 
 * @param divId  html이 들어갈 div
 * @param idName  selectbox의 id
 * @param codeList option에 들어갈 코드 list
 * @param firstCode 제일 처음에 추가될 option의 value, null 이면 추가 되는 값 없음
 * @param firstValue 제일 처음에 추가될 option의 text
 * @param selectedValue 선택될 option
 */
function makeCodeCombo(divId, idName, codeList, firstCode, firstValue, selectedValue, keyCol, valueCol ) {

    $("#" + divId).html( makeCodeComboHtml(idName, codeList, firstCode, firstValue, selectedValue, keyCol, valueCol, true, null, null, null) );
}


function makeCodeCombo(divId, idName, codeList, firstCode, firstValue, selectedValue, keyCol, valueCol, width) {

    $("#" + divId).html( makeCodeComboHtml(idName, codeList, firstCode, firstValue, selectedValue, keyCol, valueCol, true, width, null, null) );
}



/**
 * 콤보를 생성
 * 
 * @param divId  html이 들어갈 div
 * @param idName  selectbox의 id
 * @param codeList option에 들어갈 코드 list
 * @param firstCode 제일 처음에 추가될 option의 value, null 이면 추가 되는 값 없음
 * @param firstValue 제일 처음에 추가될 option의 text
 * @param selectedValue 선택될 option
 */
function makeCodeComboHtml(idName, codeList, firstCode, firstValue, selectedValue, keyCol, valueCol, isEditable, width, columnId, divId) {
    var returnHTML = "";
    
    //console.log( JSON.stringify(codeList ));
    
    if (!$.isEmptyObject(codeList)) {
    	
    	var noneEditableText = ""; 
    	if( isEditable == false ) {
    		noneEditableText = " disabled='disabled' ";
    	}
    	
    	if ( columnId == null && columnId == undefined ) {
    		returnHTML += "<select id='" + idName + "' name='" + idName +"' " + noneEditableText;
    	} else {
    		returnHTML += "<input type='hidden' id='" + idName + "' name='" + idName + "' value='" +selectedValue+ "' />";
    		returnHTML += "<select id='" + columnId + "' name='" + columnId +"' onChange=\"javascript:setSlectedValue('"+idName+"', '"+divId+"', value)\" " + noneEditableText;
    	}
        
        if(width != null){
        	returnHTML +=" style='width:"+width+"%' >";
        }else{
        	returnHTML +=" >";
        }
        
        if( firstCode != null ) {
        	returnHTML += "<option value='" + firstCode + "' selected='selected' >" + firstValue + "</option>";
        }
        
        for ( var i = 0; i < codeList.length; i++) {
            var codeObj = codeList[i];
            
            var strKey = codeObj.VALUEID;
            var strVal = codeObj.VALUENAME;
            
            if( keyCol != null && keyCol != "") {
            	strKey = codeObj[keyCol];
            }
            
            if( valueCol != null && valueCol != "" ) {
            	strVal = codeObj[valueCol];
            }
            	
            if (strKey == selectedValue) {
                returnHTML += "<option value='" + strKey + "' selected='selected'>" + strVal + "</option>";
            } else {
                returnHTML += "<option value='" + strKey + "'>" + strVal + "</option>";

            }
        }
        returnHTML += "</select>";
//        returnHTML += " <input type='hidden' id='" + idName + "' name='" + idName + "' value='" + selectedValue + "' />";
        
    }
    //console.log( returnHTML);
    return returnHTML;
}


//dataType = "C"일때 코드값 저장
function setSlectedValue(idName, divId, value) {
	$("#" + divId + " input[name='" + idName + "']").val(value);
}



/**
 * 공통코드를 이용하여 radio 생성
 * 
 * 
 * @param divId  html이 들어갈 div
 * @param idName  radio id
 * @param codeList radio에 들어갈 코드 list
 * @param selectedValue 선택값
 */
function makeCodeRadio(divId, idName, codeList, selectedValue ) {

    $("#" + divId).html( makeCodeRadioHtml(idName, codeList, selectedValue) );
}



/**
 * 공통코드를 이용하여 radio 생성
 * 
 * 
 * @param divId  html이 들어갈 div
 * @param idName  radio id
 * @param codeList radio에 들어갈 코드 list
 * @param selectedValue 선택값
 */
function makeCodeRadioHtml(idName, codeList, selectedValue, isEditable ) {

    var returnHTML = "";
    
    if (!$.isEmptyObject(codeList)) {
    
    	var noneEditableText = ""; 
    	if( isEditable == false ) {
    		noneEditableText = " disabled='disabled' ";
    	}
    	
	    for ( var i = 0; i < codeList.length; i++) {
	        var codeObj = codeList[i];
	        returnHTML += "<input type='radio' id='" + idName + "' name='" + idName +"' class='input_none' " + noneEditableText + " value='" + codeObj.VALUEID;
	        //TO-BE 협의필요 라디오 버튼의 첫번째 값이 무조건 선택되게 하는부분
//	        if( selectedValue == null || selectedValue=="undefined" || selectedValue=="") {
//	        	if( i == '0') {
//	        		returnHTML += "' checked='checked'/>";
//	        	} else {
//	        		returnHTML += "'/>";
//	        	}
//	        	
//			} else {
				if (codeObj.VALUEID == selectedValue) {
		            returnHTML += "' checked='checked'/>";
		        } else {
		            returnHTML += "'/>";
		        }
//			}
	        
	        returnHTML += codeObj.VALUENAME + "&nbsp;&nbsp;";
	    }//end for
    }
    //console.log(returnHTML);
    return returnHTML;
}





/**
 * 공통코드를 이용하여 radio 생성
 * 
 * 
 * @param divId  html이 들어갈 div
 * @param idName  checkbox id
 * @param codeList checkbox에 들어갈 코드 list
 * @param selectedValue 선택값 목록( ','를 구분자로 사용
 */
function makeCodeCheckBoxHtml(divId, idName, codeList, selectedValue, isEditable ) {
    var returnHTML = "";
    
    
    if (!$.isEmptyObject(codeList)) {
    	returnHTML += "  <input type='hidden' id='" + idName + "' name='" + idName + "' value='" + setNullToString(selectedValue) + "' />";
    	
    	var arrVal = new Array();
    	
    	if( selectedValue != null && selectedValue != "") {
    		arrVal = selectedValue.split(TOKEN_DELIMITER);
    	}
    	
    	var noneEditableText = ""; 
    	if( isEditable == false ) {
    		noneEditableText = " disabled='disabled' ";
    	}
    	
    	
    	var nCnt = codeList.length;
	    for ( var i = 0; i < nCnt; i++) {
	        var codeObj = codeList[i];
	        returnHTML += "<input type='checkbox' id='" + idName+"_"+i + "' name='" + idName+"_"+i 
	                      + "' class='input_none' " + noneEditableText + " value='" + codeObj.VALUEID + "' onClick=\"javascript:setCheckValue(this, '" + divId + "','" + idName + "','" + nCnt + "' )\" ";
	        
	        var isSelected = false;
	        
	        for( var j = 0 ; j < arrVal.length; j++) {
	        	if (codeObj.VALUEID == arrVal[j]) {
	        		returnHTML += " checked='checked'/>";
	        		isSelected = true;
	        		continue;
	        	}
	        }
	        
	        if( isSelected == false ) {
	        	returnHTML += "/>";
	        }

	        returnHTML += codeObj.VALUENAME + "&nbsp;&nbsp;";
	    }//end for
    }
 
    //console.log(returnHTML);
    return returnHTML;
}

/**
 * multicheck box 값 설정
 * @param idName   checkbox id
 * @param cnt      checkbox 수
 * @param currObj  현재 evnet obj
 */
function setCheckValue( currObj, divId, idName, nCnt) {
	
	var strVal = "";
	//alert( divId);
	var isFirst = true;

	for( var i = 0 ; i < nCnt; i++ ) {
		
		//alert( $("#" + divId + " input[id='" + idName + "_" + i + "']").is(":checked") );
		if( $("#" + divId + " input[id='" + idName + "_" + i + "']").is(":checked") == true ) {
			if( isFirst == false ) {
				strVal += TOKEN_DELIMITER;
			}
			
			strVal += $("#" + divId + " input[id='" + idName + "_" + i + "']").val();
			isFirst = false;
		}
	}
	
	$("#" + divId + " :input[id='" + idName + "']" ).val( strVal);
	
	//alert( $("#" + divId + " input[id='" + idName + "']" ).val() );
	return;
}




//var num = "0-9";
//var smEn = "a-z";
//var bigEn = "A-Z";
//var kor = "ㄱ-ㅎ|ㅏ-ㅣ|가-힣";
//// var cha=/[~!@\#$%<>^&*\()\-=+_\']/gi;
//var char = "~!@\#$%<>^&*\()\-=+_\'";
//이메일 체크 정규식 /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
//휴대폰 번호 정규식 /^\d{3}-\d{3,4}-\d{4}$/;
//휴대폰 번호 정규식(앞자리 번호 검증 포함) /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
//일반 전화번호 정규식 /^\d{2,3}-\d{3,4}-\d{4}$/;
//아이디 정규식 (영문 소문자,숫자,_, 6~12 자리) /^[a-z0-9_]{6,12}$/;
function checkRegExp(checkForm, dataName, msg, regExp){
	var data = $(checkForm).val().trim();
	//data check
	for ( var i = 0; i < data.length; i++) {
		if (regExp.test(data.charAt(i)) == false) {
			alert(dataName + "에 "+data.charAt(i)+"값은 입력이 불가능합니다.");
			$(checkForm).val("").focus();
			return false;
		}
	}
}

/**
 * 입력데이터의 타입을 체크해주는 함수
 * @param data : check 할 데이터
 * @param dataName : check 할 데이터명
 * @param type :
 *            check타입 ex) 숫자만 = 001; 소문자만 = 002; 대문자만 = 003; 한글만=004; 영어만=005;
 *                        영어(대)+숫자 = 006; 영어(대)+기호 = 007; 영어(대)+숫자+기호 = 008;
 *                        영어(소)+숫자 = 009; 영어(소)+기호 = 010; 영어(소)+숫자+기호 = 011;
 *                        영어(소/대)+숫자 = 012; 영어(소/대)+기호 = 013; 영어(소/대)+숫자+기호 = 014;
 */ 
function checkRegExp(checkForm, dataName, type) {
	var data = $(checkForm).val().trim();
	var regExp = new RegExp();
	var msg = "";
	switch (type) {
	case "001":
		regExp = /[0-9]/;
		msg ="숫자만";
		break;
	case "002":
		regExp = /[a-z]/;
		msg="영어소문자만";
		break;
	case "003":
		regExp = /[A-Z]/;
		msg="영어대문자만";
		break;
	case "004":
		regExp = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		msg="한글만";
		break;
	case "005":
		regExp = /[a-z]/i;
		msg="영어만";
		break;
	case "006":
	    regExp = /[0-9A-Z]/;
	    msg="영어(대)와 숫자만";
	    break;
	case "007":
	    regExp =/[A-Z~!@\#$%<>^&*\()\-=+_\']/;
	    msg="영어(대)와 기호만";
	    break;
	case "008":
	    regExp =/[0-9A-Z~!@\#$%<>^&*\()\-=+_\']/;
	    msg="영어(대)와 숫자,기호만";
	    break;
	case "009":
        regExp = /[0-9a-z]/;
        msg="영어(소)와 숫자만";
        break;
    case "010":
        regExp =/[a-z~!@\#$%<>^&*\()\-=+_\']/;
        msg="영어(소)와 기호만";
        break;
    case "011":
        regExp =/[0-9a-z~!@\#$%<>^&*\()\-=+_\']/;
        msg="영어(소)와 숫자,기호만";
        break;
	case "012":
		regExp = /[0-9a-zA-Z]/;
		msg="영어(소/대)와 숫자만";
		break;
	case "013":
		regExp = /[^0-9ㄱ-ㅎㅏ-ㅣ가-힣]/;
		msg="영어(소/대)와 기호만";
		break;
	case "014":
		regExp = /[^ㄱ-ㅎㅏ-ㅣ가-힣]/;
		msg="한글을 제외한 문자만";
		break;
	default:
		break;
	}
    
    for ( var i = 0; i < data.length; i++) {
        if (regExp.test(data.charAt(i)) == false) {
            alert(dataName + "는 "+msg+" 입력가능합니다.");
            $(checkForm).val(data).focus();
            return true;
        }
    }
	return false;
}


/**
 * 트리 리스트 정보를 가져오는 메소드(메인화면,조직추가 팝업,조직수정 팝업)
 */
function selectOrgTree (current_tree, manageOuCode) {
	//alert( "selectOrgTree call ");
	selectOrgId_A = manageOuCode;
	var params = {};
	params.RTOUCODE = manageOuCode;
	
    if(current_tree==""){
        current_tree = "tree";
    }
    $("#"+current_tree).remove();
    $("#wrap_"+current_tree).html("<div id='" +current_tree+ "'style='height: 100%; margin-top: 10px;' ></div>");
    $("#"+current_tree).dynatree({
        initAjax : {
            dataKey : "jsondata",
            url : contextPath + '/org/orgTreeList.do',
            data : params
            
        },
        onActivate: function(node) {
            currentOrgId = (node.data.key);
            currentOrgName = (node.data.title);
            
            if(current_tree == "tree"){
            	selectOrgId = (node.data.key);
            	selectOrgName = (node.data.title);
            	selectOrgId_U = (node.data.key);
            	$("input[name='userSearchData']").val("");
            	userSearchData = "";
            	selectOrgUserList(1);
            }
        }
    });
    
}



/**
 * 조직트리 팝업
 */
function openOrgPopup(a, divId, codeColumn, valueColumn){
    $("#" + divId + "Tree").dialog ({
        width : 300,
        height : 500,
        modal : true,
        resize : false,
        open : function() {
            currentOrgId = null;
        },
        buttons :{
            "확인" : function(){
                if ( currentOrgId != null ) {
                	var textColumn = null;
                	if(valueColumn == null || valueColumn=="" || valueColumn == "undefined" ) {
                		var pos = codeColumn.lastIndexOf("CODE");
            			if( pos > 0 ) {
            				textColumn = codeColumn.substring(0, pos);
//            				alert( textColumn);
            			} 
                	} else {
                		textColumn = valueColumn;
                	}
                    $("#" + divId +" input[name='" +codeColumn+ "']").val(currentOrgId);
                    $("#" + divId +" input[name='" + textColumn+ "']").val(currentOrgName);
                    $("#" + divId + "Tree").dialog("close");
                    currentOrgId = null;
                } else {
                    $("#" + divId + "Tree").dialog("close");
                    alert("조직을 선택하지 않았습니다.");
                }
            },
            "취소" : function() {
                $("#" + divId + "Tree").dialog("close");
                currentOrgId = null;
            }
        }
    });
}


/**
 * 코드 목록 팝업
 */
function findCode(divId, codeColumn, codeId, columnId){
	if($(codeId).val() != null) {
		dynamicColumnCodeId = $(codeId).val();
	} else {
		dynamicColumnCodeId = codeId;
	}
    $("#findCode").dialog ({
    	width : 700,
		height : 500,
		modal : true,
		resize : false,
		open : function() {
			$("#findCode input[name='codeSearchData']").focus();
			$("#findCode input[name='codeSearchData']").val("");
			$("#findCode input:checkbox[name='checkCodeValue']").prop("checked", false);
			
			selectCodeValueList(1);
			
			var codeName = $("#" + divId +" input[name='" +columnId+ "']").val();
			$("#findCode input[name='VALUENAME']").val(codeName);
		},
		buttons : {
			"확인" : function () {
				var id = $("#findCode input:radio[name='code']:checked").val();
				var name = $("#findCode input[name='VALUENAME']").val();
				$("#" + divId +" input[name='" +codeColumn+ "']").val(id);
				$("#" + divId +" input[name='" +columnId+ "']").val(name);
				$("#findCode").dialog("close");
				codeSearchId = "";
				codeSearchData = "";
			},
			"취소" : function() {
				$("#findCode").dialog("close");
				codeSearchId = "";
				codeSearchData = "";
				
			}
		}
	});
}




//jQuery(function($){
//    $.datepicker.regional['ko'] = {
//        closeText: '닫기',
//        prevText: '이전달',
//        nextText: '다음달',
//        currentText: '오늘',
//        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
//        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
//        dayNames: ['일','월','화','수','목','금','토'],
//        dayNamesShort: ['일','월','화','수','목','금','토'],
//        dayNamesMin: ['일','월','화','수','목','금','토'],
//        dateFormat: 'yymmdd',
//        showAnim: 'fadeIn',
//        yearSuffix: '년',
//        changeMonth : true,
//        changeYear : true,
//        yearRange : 'c-20:c+20',
//        showMonthAfterYear: true,
//        showButtonPanel : true, 
//        showOn : 'button',
//        buttonImage : contextPath + '/images/btn_b_calendar.gif',
//        buttonImageOnly: true,
//        onSelect: function( selectedDate ) {
//            var option = this.id == "RTCUSTOMER01" ? "minDate" : "maxDate",
//            instance = $( this ).data( "datepicker" ),
//            date = $.datepicker.parseDate(
//            instance.settings.dateFormat ||
//            $.datepicker._defaults.dateFormat,
//            selectedDate, instance.settings );
//            jQuery( "#RTCUSTOMER01, #RTCUSTOMER02" ).not( this ).datepicker( "option", option, date );
//            }
//        };
//    $.datepicker.setDefaults($.datepicker.regional['ko']);
//});



/**
 * textbox에 calendar를 붙인다.
 * @param divId
 * @param colName
 */
function setCalendar( divId, colName) {

	var calendarOption = {
		closeText: '닫기',
		prevText: '이전달',
		nextText: '다음달',
		currentText: '오늘',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		dateFormat: 'yymmdd',
		autoSize : true,
		firstDay : 0,
		isRTL : false,
	    showAnim: 'fadeIn',
	    //yearSuffix: '년',
		changeMonth : true,
	    changeYear : true,
	    yearRange : 'c-20:c+20',
		showMonthAfterYear: true,
	    showButtonPanel : true, 
	    showOn : 'button',
	    buttonImage : contextPath + '/images/btn_b_calendar.gif',
	    buttonImageOnly: true,
		};
	
	
	//console.log( "setCalendar divId = " + divId + ", colName =" + colName);
	
//	$("#"+divId + " input[id='" + colName + "']").datepicker( {
//		dateFormat: "yymmdd",
//		changeMonth : true,
//		changeYear : true,
//		showOn : 'button',
//	    buttonImage : contextPath + '/images/btn_b_calendar.gif',
//	    buttonImageOnly: true
//	});
	$("#"+divId + " input[id='" + colName + "']").datepicker( calendarOption);
    $("img.ui-datepicker-trigger").attr("style", "margin-left: 1px; vertical-align: middle; cursor: pointer;");
    //$(".ui-datepicker").attr("style", "width:17em; padding:.2em.2em 0;font-size:68.5%;");
    
}


/*******************************************************************************
 *
 * 
 * 컬럼 동적 생성 관련  START
 * 
 * 
 * 
 ******************************************************************************/


/**
 * 관리자 여부
 */
function checkSubAdmin( userLevel ) {
	var isSubAdmin = false;
	if( userLevel != null ) {
		if( userLevel == USER_LEVEL_S ) {
			isSubAdmin = true;
		} else if ( userLevel == USER_LEVEL_A ) {
			isSubAdmin = true;
		} else {
			isSubAdmin = false;
		}
	} else {
		isSubAdmin = false;
	}
   	
	return isSubAdmin;
}


/**
 * 테이블의 Row를 동적으로 생성한다.
 */
function makeDynamicColumnRow( userLevel, divId, columnList, codeListMap, rowValue, readonlyColumn ) {
	
	//console.log("columnList=" + JSON.stringify(columnList));
	//console.log("codeListMap=" + JSON.stringify(codeListMap));
	//console.log("rowValue=" + JSON.stringify(rowValue));
	
	
	var isSubAdmin = checkSubAdmin( userLevel);
	
	var returnHTML = "";
	
	var rowCount = 0;
	
	var columnCnt = 0;
	if (columnList != null ) {
		columnCnt = columnList.length;
	}
	
	if( columnCnt <= 0 ) return returnHTML;

	var colCntInRow = 0;
	
	for ( var i = 0; i < columnCnt; i++) {
		
      	
       	var columnInfo = columnList[i];

    	var columnId         = setNullToString( columnInfo.COLUMNID        );
    	var columnName       = setNullToString( columnInfo.COLUMNNAME      );
    	var imColumnId       = setNullToString( columnInfo.IMCOLUMNID      );
    	//var sysCol           = setNullToString( columnInfo.SYSCOL          );
    	var pkYn             = setNullToString( columnInfo.PKYN            );
    	var dataType         = setNullToString( columnInfo.DATATYPE        );
    	var dataLen          = setNullToNumber( columnInfo.DATALEN         );
    	var mandatory        = setNullToString( columnInfo.MANDATORY       );
    	var codeId           = setNullToString( columnInfo.CODEID          );
    	//var displayOrder     = setNullToString( columnInfo.DISPLAYORDER    );
    	var userDisplay      = setNullToString( columnInfo.USERDISPLAY     );
    	var userEdit         = setNullToString( columnInfo.USEREDIT        );
    	var subAdminDisplay  = setNullToString( columnInfo.SUBADMINDISPLAY );
    	var subAdminEdit     = setNullToString( columnInfo.SUBADMINEDIT    );
    	//var encYn            = setNullToString( columnInfo.ENCYN           );
    	var displayYn        = setNullToString( columnInfo.DISPLAYYN       ); 
    	
    	if( displayYn != null && displayYn != "Y") {
    		continue;
    	}
    	
    	var columnValue = "";
    	if( rowValue != null) {
    		if( dataType == "S") {
    			if( columnId == "SERVICE") {
    				columnValue = rowValue[ columnId ];
    			} else {
    				columnValue = setNullToString( rowValue[ columnId ] );
    			}
    		} else if ( dataType == "p") {
    			columnValue = setNullToString( rowValue[ columnId ] );
    		} else {
    			columnValue = setNullToString( rowValue[ imColumnId ] );
    		}
    	} 

    	
    	
    	var isDisplay = false;
        var isEditable = false;
    	
        if( userLevel == USER_LEVEL_S ) {
   			isDisplay = true;
   			isEditable = true;
        } else {
	    	if( isSubAdmin == true ) {
	    		if( subAdminDisplay == "Y" ) {
	    			isDisplay = true;
	    		}
	    		
	    		if( subAdminEdit == "Y") {
	    			isEditable = true;
	    		}
	    	} else {
	    		if( userDisplay == "Y") {
	    			isDisplay = true;
	    		}
	    		
	    		if( userEdit == "Y") {
	    			isEditable = true;
	    		}    		
	    	}
        }
    	
    	if( isDisplay == false ) {
    		continue;
    	}
    	

    	if ( dataType == "N") { // 코드별칭일 경우 
    		returnHTML += "<input type='hidden' id='" + imColumnId + "' name='" + imColumnId + "' value='' />";
    		continue;
    	}	
       	
        var isColSpan = getIsColSpan( dataType, dataLen, codeListMap[codeId]);
        
        //alert( isColSpan );
        if ( rowCount > 0 ) {
        	colCntInRow = 1;
        	rowCount = rowCount-1;
        }
        if( isColSpan == true ) {
        	if ( colCntInRow == 1 ) { 
        		// colspan 처리히야 되고 현재 column이 1개 append 되어 있으면 
        		// 공백 td 추가 후 새로운 TR 생성
        		returnHTML += makeEmtpyColumn();
        		returnHTML += "</tr>";
        		returnHTML += "<tr>";
        	} else {
        		returnHTML += "<tr>";
        	}
        	colCntInRow = 2;
        } else {
        	if ( colCntInRow == 0 ) { 
        		returnHTML += "<tr>";
        		
        		colCntInRow = 1;
        	} else {
        		colCntInRow = 2;
        	}
        }
        
       	
    	// dataType : 항목값의 입력유형(T 텍스트, D 숫자, C 코드, N 코드별칭, G 달력, R 라디오, K 체크박스, F:TextArea O:조직팝업  S:   ,  공통코드를 참조)
        var colSpanText = "";
        var rowSpanText = "";
        if ( dataType == "P" ) {
        	rowSpanText = " rowspan='6' ";
        	colSpanText = " rowspan='6' ";
        	rowCount = 6;
        }
        if( isColSpan == true ) {
        	colSpanText = " colspan='3' ";
        }
        
        
        
        var mandatoryText = "";
        if( mandatory == "Y") {
        	mandatoryText = "<font color='red'>*</font>";
        }
        
        if( readonlyColumn != null && readonlyColumn != "undefined" && readonlyColumn =="PK" && pkYn == "Y") {
        	isEditable = false;
        }
        
        if( readonlyColumn != null && readonlyColumn != "undefined" && readonlyColumn =="ALL" ) {
        	isEditable = false;
        }
        
        var noneEditableText = " style='width:100%' ";
        if( isEditable == false) {
        	if( pkYn == "Y") {
        		noneEditableText = " style='width:100%;background:#ededed' readonly ";  // 
        	} else {
        		noneEditableText = " style='width:100%;background:#ededed' disabled='disabled' ";
        	}
        }
        
        var columnHTML = "";
    	columnHTML += "  <th " + rowSpanText + " class='left'>" + mandatoryText + columnName + "</th>";
    	
    	columnHTML += "  <td " + colSpanText + " class=" + getColumnAlign( dataType ) + ">";
    	
    	if ( dataType == "T") {
    		if( pkYn == "Y" && isEditable == true ) {
    			noneEditableText = "  style='width:67%' ";
    			columnHTML += "  <input type='text' id='" + imColumnId + "' name='" + imColumnId + "' " + noneEditableText + " value='" + columnValue + "' onkeyup=\"resetPkIdCheck('" + divId + "', '" + imColumnId + "');isMaxLength(this, " + dataLen + ");\" />";
    			columnHTML += "&nbsp;<a href=\"javascript:pkIdCheck('" + divId + "', '" + imColumnId + "')\" ><img src='" + contextPath + "/images/btn_b_jsearch.gif' width='68' height='20' class='vamid'></a>";
    			columnHTML += "<input type='hidden' id='idCheckYn_"+imColumnId +"' name='idCheckYn_"+imColumnId +"' value='N' />";
    			columnHTML += "<input type='hidden' id='isUsed_" +imColumnId +"' name='isUsed_" +imColumnId +"' value='N' />";
    		} else {
    			columnHTML += "  <input type='text' id='" + imColumnId + "' name='" + imColumnId + "' " + noneEditableText + " value='" + columnValue + "' onkeyup='javascript:isMaxLength(this, " + dataLen + ");' />";
    		}
    		//console.log( columnHTML );
    	} else if ( dataType == "P") {
    		var image = "";
    		var path =  contextPath + "/images/temp/";
    		path += columnValue;
    		if (columnValue == null || columnValue == "") {
    			image = "src='" + contextPath + "/images/nophoto.gif'";
    		} else {
    			image = "src='" + path + "'";
    		}
    		columnHTML += "  <img name='userPhoto' " + image + " class='vamid' width='130px' height='155px'><br />";
    		columnHTML += "  <input type='file' id='rtFileUpload' name='rtFileUpload' class='input_none' onChange=\"javascript:uploadPhoto('"+divId+"')\" style='width:180px; height:20px; ' />";
    		columnHTML += "  <input type='hidden' id='" + imColumnId + "' name='" + imColumnId + "' value='" + columnValue + "'  />";
    	} else if ( dataType == "D") {
    		columnHTML += "  <input type='text' id='" + imColumnId + "' name='" + imColumnId + "' " + noneEditableText + " value='" + columnValue + "' onkeyup='javascript:keyUpAllowNumericAndMaxLength(this, " + dataLen + ");' />";
    	} else if ( dataType == "C") {
    		columnHTML += makeCodeComboHtml( imColumnId, codeListMap[codeId], "", "", columnValue, null, null, isEditable, null, columnId, divId);
    	} else if ( dataType == "E") {
    		noneEditableText = "  style='width:77%' ";
    		if( isEditable == false) {
            	noneEditableText = " style='width:100%;background:#ededed' disabled='disabled' ";
            }
    		columnHTML += "  <input type='hidden' id='" + imColumnId + "' name='" + imColumnId + "' " + noneEditableText + " value='" + columnValue + "' isMaxLength(this, " + dataLen + ");\" />";
    		columnHTML += "  <input type='text' id='" + columnId + "' name='" + columnId + "' " + noneEditableText + " readonly='readonly' value='" + columnValue + "' isMaxLength(this, " + dataLen + ");\" />";
    		if( isEditable == true) {
    			columnHTML += "&nbsp;<a href=\"javascript:findCode('" + divId + "', '" + imColumnId + "', '"+ codeId +"', '"+ columnId +"')\" ><img src='" + contextPath + "/images/btn_b_search.gif'class='vamid'></a>";
    		}
    		
    	} else if ( dataType == "N") { // 
    		
    	} else if ( dataType == "G") {
    		noneEditableText = "  style='width:80%' ";
            if( isEditable == false) {
            	noneEditableText = " style='width:80%;background:#ededed' disabled='disabled' ";
            }
    		columnHTML += "  <input type='text' id='" + imColumnId + "' name='" + imColumnId + "' " + noneEditableText + " value='" + columnValue + "' readonly='readonly' />";
    	} else if ( dataType == "R") {
    		columnHTML += makeCodeRadioHtml(imColumnId, codeListMap[codeId], columnValue, isEditable);
    	} else if ( dataType == "K") {   
    		columnHTML += makeCodeCheckBoxHtml(divId, imColumnId, codeListMap[codeId], columnValue, isEditable);
    	} else if ( dataType == "O") { 
    		noneEditableText = "  style='width:90%' ";
            if( isEditable == false) {
            	noneEditableText = " style='width:90%;background:#ededed' ";
            }
    		
    		columnHTML += "  <input type='text' id='" + imColumnId + "' name='" + imColumnId + "' " + noneEditableText + " value='" + columnValue 
    						+ "' readonly='readonly' />";
    		if( isEditable == true) {
    			columnHTML += " <a href=\"javascript:openOrgPopup(this, '" + divId + "', '" + imColumnId + "')\" ><img src='" + contextPath + "/images/icon/find.png' width='16' height='15' class='vamid'></a>";
    		}
    		
    	} else if( dataType == "F") {
            columnHTML += "  <textarea id='" + imColumnId + "' name='" + imColumnId + "' rows='3' " + noneEditableText + " onkeyup='javascript:isMaxLength(this, " + dataLen + ");' >" + columnValue + "</textarea>";
    	} else if( dataType == "S") {
    		//console.log( JSON.stringify(columnValue));
    		if( columnId == "SERVICE") {
    			if( columnValue == null || columnValue=="undefined" || columnValue=="") {
    				columnHTML += columnValue;
    			} else {
    				var svcHtmlText = "";
    				for( var k = 0; k< columnValue.length; k ++ ) {
    					var serviceInfo = columnValue[k];
    					var serviceName = setNullToString(serviceInfo["SERVICENAME"]);
    					var syncYn = setNullToString(serviceInfo["SYNCYN"]);
    					if( k != 0) {
    						svcHtmlText += ", ";
    					} 

    					if( syncYn == "Y") {
    						svcHtmlText += serviceName; 
    					} else {
    						svcHtmlText += "<font color='red'>"+serviceName+"</font>";
    					}
    				}
    				
    				columnHTML += svcHtmlText;
    			}
    			
    		} else {
    			columnHTML += columnValue;
    		}

        } else { // 나머지는 T:테스트로 처리
    		columnHTML += "  <input type='text' id='" + imColumnId + "' name='" + imColumnId + "' " + noneEditableText + " value='" + columnValue + "' onkeyup='javascript:isMaxLength(this, " + dataLen + ");' />";
    	}
    	columnHTML += "  </td>";
    	
       	//console.log( columnHTML);

       	
       	returnHTML += columnHTML;
       	
       	if( colCntInRow == 2 ) {
       		returnHTML += "</tr>";
       		
       		colCntInRow = 0;
       		
       	}      

	}

	//console.log( returnHTML);
	return returnHTML;
    
}

/**
 * 사진
 */

//function uploadPhoto(divId) {
//	alert("Test");
////	alert(JSON.stringify(divId));
//	alert(divId);
//	$("#addUserForm").submit();
////	$("#"+divId).submit();
//	
//
//}



/**
 * 테이블의 Row를 동적으로 생성한다.
 */
function makeDynamicColumnRowTextOnly( userLevel, divId, columnList, codeListMap, rowValue, readonlyColumn ) {
	
	//console.log("columnList=" + JSON.stringify(columnList));
	//console.log("codeListMap=" + JSON.stringify(codeListMap));
	//console.log("rowValue=" + JSON.stringify(rowValue));
	
	
	var isSubAdmin = checkSubAdmin( userLevel);
	
	var returnHTML = "";
	
	var columnCnt = 0;
	if (columnList != null ) {
		columnCnt = columnList.length;
	}
	
	if( columnCnt <= 0 ) return returnHTML;

	var colCntInRow = 0;
	
	for ( var i = 0; i < columnCnt; i++) {
		
      	
       	var columnInfo = columnList[i];

    	var columnId         = setNullToString( columnInfo.COLUMNID        );
    	var columnName       = setNullToString( columnInfo.COLUMNNAME      );
    	var imColumnId       = setNullToString( columnInfo.IMCOLUMNID      );
    	//var sysCol           = setNullToString( columnInfo.SYSCOL          );
    	var pkYn             = setNullToString( columnInfo.PKYN            );
    	var dataType         = setNullToString( columnInfo.DATATYPE        );
    	var dataLen          = setNullToNumber( columnInfo.DATALEN         );
    	var mandatory        = setNullToString( columnInfo.MANDATORY       );
    	var codeId           = setNullToString( columnInfo.CODEID          );
    	//var displayOrder     = setNullToString( columnInfo.DISPLAYORDER    );
    	var userDisplay      = setNullToString( columnInfo.USERDISPLAY     );
    	var userEdit         = setNullToString( columnInfo.USEREDIT        );
    	var subAdminDisplay  = setNullToString( columnInfo.SUBADMINDISPLAY );
    	var subAdminEdit     = setNullToString( columnInfo.SUBADMINEDIT    );
    	//var encYn            = setNullToString( columnInfo.ENCYN           );
    	var displayYn        = setNullToString( columnInfo.DISPLAYYN       ); 
    	
    	if( displayYn != null && displayYn != "Y") {
    		continue;
    	}
    	
    	var columnValue = "";
    	if( rowValue != null) {
    		if( dataType == "S") {
    			if( columnId == "SERVICE") {
    				columnValue = rowValue[ columnId ];
    			} else {
    				columnValue = setNullToString( rowValue[ columnId ] );
    			}
    		} else {
    			columnValue = setNullToString( rowValue[ imColumnId ] );
    		}
    	} 
    	
    	// 
    	//if( columnValue == null || columnValue == "" ) columnValue = "&nbsp;"; // 값이 없으면 높이가 서로 틀려져서 추가
    	
    	var isDisplay = false;
        var isEditable = false;
    	
        if( userLevel == USER_LEVEL_S ) {
   			isDisplay = true;
   			isEditable = true;
        } else {
	    	if( isSubAdmin == true ) {
	    		if( subAdminDisplay == "Y" ) {
	    			isDisplay = true;
	    		}
	    		
	    		if( subAdminEdit == "Y") {
	    			isEditable = true;
	    		}
	    	} else {
	    		if( userDisplay == "Y") {
	    			isDisplay = true;
	    		}
	    		
	    		if( userEdit == "Y") {
	    			isEditable = true;
	    		}    		
	    	}
        }
    	
    	if( isDisplay == false ) {
    		continue;
    	}
    	

    	if ( dataType == "N") { // 코드별칭일 경우 
    		returnHTML += "<input type='hidden' id='" + imColumnId + "' name='" + imColumnId + "' value='' />";
    		continue;
    	}	
       	
        var isColSpan = getIsColSpan( dataType, dataLen, codeListMap[codeId]);
        
        //alert( isColSpan );
        if( isColSpan == true ) {
        	if ( colCntInRow == 1 ) { 
        		// colspan 처리히야 되고 현재 column이 1개 append 되어 있으면 
        		// 공백 td 추가 후 새로운 TR 생성
        		returnHTML += makeEmtpyColumn();
        		returnHTML += "</tr>";
        		returnHTML += "<tr>";
        	} else {
        		returnHTML += "<tr>";
        	}
        	colCntInRow = 2;
        } else {
        	if ( colCntInRow == 0 ) { 
        		returnHTML += "<tr>";
        		
        		colCntInRow = 1;
        	} else {
        		colCntInRow = 2;
        	}
        }
        
       	
    	// dataType : 항목값의 입력유형(T 텍스트, D 숫자, C 코드, N 코드별칭, G 달력, R 라디오, K 체크박스, F:TextArea O:조직팝업  S:   ,  공통코드를 참조)
        var colSpanText = "";
        if( isColSpan == true ) {
        	colSpanText = " colspan='3' ";
        }
        
        
        var mandatoryText = "";
        if( mandatory == "Y") {
        	mandatoryText = "<font color='red'>*</font>";
        }
        
        if( readonlyColumn != null && readonlyColumn != "undefined" && readonlyColumn =="PK" && pkYn == "Y") {
        	isEditable = false;
        }
        
        if( readonlyColumn != null && readonlyColumn != "undefined" && readonlyColumn =="ALL" ) {
        	isEditable = false;
        }
        /*
        var noneEditableText = " style='width:100%' ";
        if( isEditable == false) {
        	if( pkYn == "Y") {
        		noneEditableText = " style='width:100%;background:#ededed' readonly ";
        	} else {
        		noneEditableText = " style='width:100%;background:#ededed' disabled='disabled' ";
        	}
        }
        */
        var columnHTML = "";
    	columnHTML += "  <th class='left'>" + mandatoryText + columnName + "</th>";
    	
    	columnHTML += "  <td " + colSpanText + " class='" + getColumnAlign( dataType ) + "'>";
    	
    	if ( dataType == "T") {
    		columnHTML += columnValue;
    		//console.log( columnHTML );
    	} else if ( dataType == "D") {
    		columnHTML += columnValue;
    	} else if ( dataType == "C") {
    		columnHTML += makeCodeComboHtml( imColumnId, codeListMap[codeId], "", "", columnValue, null, null, isEditable, null, columnId, divId);
    	} else if ( dataType == "N") { // 
    		
    	} else if ( dataType == "G") {
    		columnHTML += columnValue;
    	} else if ( dataType == "R") {
    		columnHTML += makeCodeRadioHtml(imColumnId, codeListMap[codeId], columnValue, isEditable);
    	} else if ( dataType == "K") {   
    		columnHTML += makeCodeCheckBoxHtml(divId, imColumnId, codeListMap[codeId], columnValue, isEditable);
    	} else if ( dataType == "O") { 
    		columnHTML += columnValue; 
    	} else if( dataType == "F") {
            columnHTML += columnValue;
    	} else if( dataType == "S") {
    		if( columnId == "SERVICE") {
    			if( columnValue == null || columnValue=="undefined" || columnValue=="" ) {
    				columnHTML += columnValue;
    			} else {
    				var svcHtmlText = "";
    				for( var k = 0; k< columnValue.length; k ++ ) {
    					var serviceInfo = columnValue[k];
    					var serviceName = setNullToString(serviceInfo["SERVICENAME"]);
    					var syncYn = setNullToString(serviceInfo["SYNCYN"]);
    					if( k != 0) {
    						svcHtmlText += ", ";
    					} 
    					if( syncYn == "Y") {
    						svcHtmlText += serviceName; 
    					} else {
    						svcHtmlText += "<font color='red'>"+serviceName+"</font>";
    					}
    				}
    				
    				columnHTML += svcHtmlText;
    			}
    			
    			
    		} else {
    			columnHTML += columnValue;
    		}

        } else { // 나머지는 T:테스트로 처리
    		columnHTML += columnValue;
    	}
    	columnHTML += "  </td>";
    	
       	//console.log( columnHTML);

       	
       	returnHTML += columnHTML;
       	
       	if( colCntInRow == 2 ) {
       		returnHTML += "</tr>";
       		
       		colCntInRow = 0;
       		
       	}      

	}

	//console.log( returnHTML);
	return returnHTML;
    
}

function makeEmtpyColumn() {
	
	var columnHTML = "";
	columnHTML += "  <td>&nbsp;</td>";
	columnHTML += "  <td>&nbsp;</td>";
	return columnHTML;
	
}

/**
 * 컬럼의 colSpan여부를 return 한다.
 */
function getIsColSpan(dataType, dataLen, codeList) {
	
	if( dataType == "T") {
		if( dataLen >= 81 ) {
			return true;
		}
	} else if ( dataType == "K") {
		if( codeList != null && codeList.length >= 3 ) {
			return true;
		}
	} else if ( dataType == "R") {
		if( codeList != null && codeList.length >= 3 ) {
			return true;
		}
	} else if( dataType == "F") {
		return true;
	} else if( dataType == "S") {
		if( dataLen >= 81 ) {
			return true;
		}
	}
	
	return false;
}


/**
 * calendar 컬럼 event 설정
 */
function setCalendarColum( userLevel, divId, columnList) {

	//console.log( "columnList = " + JSON.stringify(columnList ));
	var isSubAdmin = checkSubAdmin( userLevel);
	
	//console.log( "isSubAdmin = " + isSubAdmin);
	if (columnList != null && columnList.length > 0) {
	
        for ( var i = 0; i < columnList.length; i++) {
        	var columnInfo = columnList[i];
        
        	var imColumnId       = setNullToString( columnInfo.IMCOLUMNID      );
        	var dataType         = setNullToString( columnInfo.DATATYPE        );
        	var userEdit         = setNullToString( columnInfo.USEREDIT        );
        	var subAdminEdit     = setNullToString( columnInfo.SUBADMINEDIT    );          	
        	var displayYn        = setNullToString( columnInfo.DISPLAYYN       ); 
        	
        	if( displayYn != null && displayYn != "Y") {
        		continue;
        	}
        	
            var isEditable = false;
        	if( userLevel == USER_LEVEL_S) {
        		isEditable = true;
        	} else {
	        	if( isSubAdmin == true ) {
	        		if( subAdminEdit == "Y") {
	        			isEditable = true;
	        		}
	        	} else {
	        		if( userEdit == "Y") {
	        			isEditable = true;
	        		}    		
	        	}
        	}
        	//console.log( "isEditable = " + isEditable);
        	
        	if( dataType == "G" && isEditable == true) {
        		setCalendar(divId, imColumnId);
        	}
        }
	}
}



/**
 * 조직 코드 명 readonly
 */
function setOrgNameColumnReadonly( userLevel, divId, columnList) {

	//console.log( "columnList = " + JSON.stringify(columnList ));
	var isSubAdmin = checkSubAdmin( userLevel);
	
	//console.log( "isSubAdmin = " + isSubAdmin);
	if (columnList != null && columnList.length > 0) {
	
        for ( var i = 0; i < columnList.length; i++) {
        	var columnInfo = columnList[i];
        
        	var imColumnId       = setNullToString( columnInfo.IMCOLUMNID      );
        	var dataType         = setNullToString( columnInfo.DATATYPE        );
        	var userEdit         = setNullToString( columnInfo.USEREDIT        );
        	var subAdminEdit     = setNullToString( columnInfo.SUBADMINEDIT    );          	
        	var displayYn        = setNullToString( columnInfo.DISPLAYYN       ); 
        	
        	if( displayYn != null && displayYn != "Y") {
        		continue;
        	}
        	
            var isEditable = false;
        	if( userLevel == USER_LEVEL_S) {
        		isEditable = true;
        	} else {
	        	if( isSubAdmin == true ) {
	        		if( subAdminEdit == "Y") {
	        			isEditable = true;
	        		}
	        	} else {
	        		if( userEdit == "Y") {
	        			isEditable = true;
	        		}    		
	        	}
        	}
        	//console.log( "isEditable = " + isEditable);
        	
        	if( dataType == "O" && isEditable == true) {
        		var pos = imColumnId.lastIndexOf("CODE");
        		
        		if( pos > 0 ) {
        			var orgNameColumn = imColumnId.substring(0, pos);
        			//alert( orgNameColumn);
        			$("#"+divId + " input[id='" + orgNameColumn + "']").attr("readonly", "readonly");
        			$("#"+divId + " input[id='" + orgNameColumn + "']").attr("class","readonly");
    			} 
        	}
        }
	}
}

/**
 * IM권한 readonly-문체부
 */
function setUserLevelColumn( userLevel, divId, columnList, rowValue) {

	//console.log( "columnList = " + JSON.stringify(columnList ));
	//var isSubAdmin = checkSubAdmin( userLevel);
	
	//console.log( "isSubAdmin = " + isSubAdmin);
	if (columnList != null && columnList.length > 0) {
	
        for ( var i = 0; i < columnList.length; i++) {
        	var columnInfo = columnList[i];
            
        	var columnId         = setNullToString( columnInfo.COLUMNID        );
        	var imColumnId       = setNullToString( columnInfo.IMCOLUMNID      );
        	var dataType         = setNullToString( columnInfo.DATATYPE        );
        	//var userEdit         = setNullToString( columnInfo.USEREDIT        );
        	//var subAdminEdit     = setNullToString( columnInfo.SUBADMINEDIT    );          	
        	var displayYn        = setNullToString( columnInfo.DISPLAYYN       ); 
        	
        	if( displayYn != null && displayYn != "Y") {
        		continue;
        	}
        	
        	var columnValue = "";
        	if( rowValue != null) {
        		if( dataType == "S") {
        			if( columnId == "SERVICE") {
        				columnValue = rowValue[ columnId ];
        			} else {
        				columnValue = setNullToString( rowValue[ columnId ] );
        			}
        		} else {
        			columnValue = setNullToString( rowValue[ imColumnId ] );
        		}
        	} 
        	
        	
        	if( imColumnId == "RTUSERLEVEL" ) {
	        	$("#"+divId + " input[id='" + imColumnId + "']").attr("readonly", "readonly");
	        	$("#"+divId + " input[id='" + imColumnId + "']").attr("disabled", "disabled");
	        	$("#"+divId + " input[id='" + imColumnId + "']").attr("class","readonly");
	        	
	        	var columnValueName = "";
	        	if (columnValue == "U") {
	        		columnValueName = "일반사용자";
	        		$("#"+divId + " input[id='" + imColumnId + "']").val(columnValueName);
	        	} else if (columnValue == "A") {
	        		columnValueName ="부서관리자";
	        		$("#"+divId + " input[id='" + imColumnId + "']").val(columnValueName);
	        	} else if (columnValue == "S") {
	        		columnValueName ="관리자";
	        		$("#"+divId + " input[id='" + imColumnId + "']").val(columnValueName);
	        	}
        	}
        }
	}
}



/**
 * 컬럼유형에 따른 정렬기준 return
 */
function getColumnAlign( columnType ) {
	// dataType : 항목값의 입력유형(T 텍스트, D 숫자, C 코드, N 코드별칭, G 달력, R 라디오, K 체크박스    공통코드를 참조)
	var alignValue="";
	if ( columnType == 'P') {
		alignValue = 'center';
	} else {
		alignValue = "left";
	}
	
	
	/*
	switch( columnType ) {
		case "T" : // 텍스트
			alignVal = "left";
			beak;
			
		case "D" ;  // 숫자
			alignVal = "right";
			beak;
			
		case "C" : // 코드
	
		case "G" : // 달력
		
		case "R" : // 라디오
			
		case "K" : // 체크박스
		
		case "N" : // 코드별칭
			alignVal = "center";
			break;
			
		default :
			alignVal = "left";
			break;
	}
	*/
	return alignValue;
}
 



/** 
 * 동적 컬럼 validation 처리
 * 
 */
function checkDynamicColumnValication(userLevel, divId, columnList, codeListMap) {
    //console.log("columnList=" + JSON.stringify(columnList));
    
	var isSubAdmin = checkSubAdmin( userLevel);
	
	
	var columnCnt = 0;
	if (columnList != null ) {
		columnCnt = columnList.length;
	}

	
	for ( var i = 0; i < columnCnt; i++) {
       	var columnInfo = columnList[i];
       	//console.log( JSON.stringify(columnInfo));
    	var columnId         = setNullToString( columnInfo.COLUMNID        );
    	var columnName       = setNullToString( columnInfo.COLUMNNAME      );
    	var imColumnId       = setNullToString( columnInfo.IMCOLUMNID      );
    	//var sysCol           = setNullToString( columnInfo.SYSCOL          );
    	//var pkYn             = setNullToString( columnInfo.PKYN            );
    	var dataType         = setNullToString( columnInfo.DATATYPE        );
    	var dataLen          = setNullToNumber( columnInfo.DATALEN         );
    	var mandatory        = setNullToString( columnInfo.MANDATORY       );
    	//var codeId           = setNullToString( columnInfo.CODEID          );
    	//var displayOrder     = setNullToString( columnInfo.DISPLAYORDER    );
    	var userDisplay      = setNullToString( columnInfo.USERDISPLAY     );
    	var userEdit         = setNullToString( columnInfo.USEREDIT        );
    	var subAdminDisplay  = setNullToString( columnInfo.SUBADMINDISPLAY );
    	var subAdminEdit     = setNullToString( columnInfo.SUBADMINEDIT    );       	
    	//var encYn            = setNullToString( columnInfo.ENCYN           );
    	var displayYn        = setNullToString( columnInfo.DISPLAYYN       ); 
    	
    	
    	if( displayYn != null && displayYn != "Y") {
    		continue;
    	}
    	
    	if( dataType != null && dataType == "S") {
    		continue;
    	}
    	
    	var isDisplay = false;
        //var isEditable = false;
        if( userLevel == USER_LEVEL_S) {
        	isDisplay = true;
    		//isEditable = true;
    	} else {
	    	if( isSubAdmin == true ) {
	    		if( subAdminDisplay == "Y" ) {
	    			isDisplay = true;
	    		}
	    		
	    		if( subAdminEdit == "Y") {
	    			//isEditable = true;
	    		}
	    	} else {
	    		if( userDisplay == "Y") {
	    			isDisplay = true;
	    		}
	    		
	    		if( userEdit == "Y") {
	    			//isEditable = true;
	    		}    		
	    	}
    	}
    	
    	if( isDisplay == false ) {
    		continue;
    	}    	
    	// dataType : 항목값의 입력유형(T 텍스트, D 숫자, C 코드, N 코드별칭, G 달력, R 라디오, K 체크박스, F:TextArea O:조직팝업   공통코드를 참조)

    	//
    	// 필수 입려 체크
    	//
    	
        if( mandatory == "Y") {
        	if( dataType == "T") {
        		//console.log( $("#"+divId + " input[name='" + imColumnId + "']").val() );
        		if (isEmpty(divId + " input[name='" + imColumnId + "']", columnName)) {
        			
        		    return false;
        		}

	    	} else if ( dataType == "D") {
	    		if (isEmpty(divId + " input[name='" + imColumnId + "']", columnName)) {
	    		    return false;
	    		}
	    	} else if ( dataType == "C") {
	    		if (isEmpty(divId + " select[name='" + imColumnId + "']", columnName)) {
	    		    return false;
	    		}
	    	} else if ( dataType == "N") {
	    		
	    	} else if ( dataType == "G") {
	    		if (isEmpty(divId + " input[name='" + imColumnId + "']", columnName)) {
	    		    return false;
	    		}
	    	} else if ( dataType == "R") {
	    		if (isEmptyRadio(divId + " input[name='" + imColumnId + "']", columnName)) {
	    		    return false;
	    		}
	    	} else if ( dataType == "K") {   
	    		if (isEmpty(divId + " input[name='" + imColumnId + "']", columnName)) {
	    		    return false;
	    		}
	    	} else if ( dataType == "O") {
        		if (isEmpty(divId + " input[name='" + imColumnId + "']", columnName)) {
        		    return false;
        		}
        	} else if ( dataType == "F") {
                if (isEmpty(divId + " textarea[name='" + imColumnId + "']", columnName)) {
                    return false;
                }
	    	} else { 
        		if (isEmpty(divId + " input[name='" + imColumnId + "']", columnName)) {
        		    return false;
        		}
	    	}
        }
        
	
        //
        // 데이터 길이 체크
        //
        // dataType : 항목값의 입력유형(T 텍스트, D 숫자, C 코드, N 코드별칭, G 달력, R 라디오, K 체크박스, F:TextArea O:조직팝업   공통코드를 참조)
        if( dataLen > 0 ) {
        	if( dataType == "T") {
        		if( checkMaxLength( $("#" + divId + " input[name='" + imColumnId + "']").val(), dataLen, columnName ) == false ) {
        			$("#" + divId + " input[name='" + imColumnId + "']").focus();
           		    return false;
        		}

	    	} else if ( dataType == "D") {
        		if( checkMaxLength( $("#" + divId + " input[name='" + imColumnId + "']").val(), dataLen, columnName ) == false ) {
        			$("#" + divId + " input[name='" + imColumnId + "']").focus();
           		    return false;
        		}
	    	} else if ( dataType == "C") {
        		if( checkMaxLength( $("#" + divId + " select[name='" + imColumnId + "']").val(), dataLen, columnName ) == false ) {
        			$("#" + divId + " select[name='" + imColumnId + "']").focus();
           		    return false;
        		}
	    	} else if ( dataType == "N") {
        		if( checkMaxLength( $("#" + divId + " input[name='" + imColumnId + "']").val(), dataLen, columnName ) == false ) {
        			$("#" + divId + " input[name='" + imColumnId + "']").focus();
           		    return false;
        		}
	    	} else if ( dataType == "G") {
        		if( checkMaxLength( $("#" + divId + " input[name='" + imColumnId + "']").val(), dataLen, columnName ) == false ) {
        			$("#" + divId + " input[name='" + imColumnId + "']").focus();
           		    return false;
        		}
	    	} else if ( dataType == "R") {
        		if( checkMaxLength( $("#" + divId + " input[name='" + imColumnId + "']").val(), dataLen, columnName ) == false ) {
        			$("#" + divId + " input[name='" + imColumnId + "']").focus();
           		    return false;
        		}
	    	} else if ( dataType == "K") {   
        		if( checkMaxLength( $("#" + divId + " input[name='" + imColumnId + "']").val(), dataLen, columnName ) == false ) {
        			$("#" + divId + " input[name='" + imColumnId + "']").focus();
           		    return false;
        		}
	    	} else if ( dataType == "O") {  
        		if( checkMaxLength( $("#" + divId + " input[name='" + imColumnId + "']").val(), dataLen, columnName ) == false ) {
        			$("#" + divId + " input[name='" + imColumnId + "']").focus();
           		    return false;
        		}
	    	} else if ( dataType == "F") {
        		if( checkMaxLength( $("#" + divId + " textarea[name='" + imColumnId + "']").val(), dataLen, columnName ) == false ) {
        			$("#" + divId + " textarea[name='" + imColumnId + "']").focus();
           		    return false;
        		}
	    	} else { 
        		if( checkMaxLength( $("#" + divId + " input[name='" + imColumnId + "']").val(), dataLen, columnName ) == false ) {
        			$("#" + divId + " input[name='" + imColumnId + "']").focus();
           		    return false;
        		}
	    	}
        }
        
        
        //
		// 코드별칠 값 설정
        //
		if ( dataType == "N") { 
			var pos = columnId.lastIndexOf("NAME");
			if( pos <= 0 ) {
				alert("코드별칭 컬럼이 아닙니다 ");
				return false;
			} else {
				var codeColumnName = columnId.substring(0, pos);
				
				var codeColumnText = $("#" +divId + " input[name='" + codeColumnName + "']").val();
				
				if (codeColumnText == "" || codeColumnText == undefined) {
					codeColumnName += "CODE";
					
					codeColumnText = $("#" +divId + " input[name='" + codeColumnName + "']").val();
					if (codeColumnText == "" || codeColumnText == undefined) {
						codeColumnText = $("#" +divId + " select[name='" + codeColumnName + "'] option:selected").text();
					}
				}
				
				$("#" + divId + " input[name='" + imColumnId + "']").val( codeColumnText);
				
			}
		}
	}
	
	return true;
}

function setValueName(userLevel, divId, columnList, codeListMap, rowValue) {
    
	//console.log( "columnList = " + JSON.stringify(columnList ));
	//var isSubAdmin = checkSubAdmin( userLevel);
	
	//console.log( "isSubAdmin = " + isSubAdmin);
	if (columnList != null && columnList.length > 0) {
	
        for ( var i = 0; i < columnList.length; i++) {
        	var columnInfo = columnList[i];
        	
        	var columnId         = setNullToString( columnInfo.COLUMNID        );
        	var imColumnId       = setNullToString( columnInfo.IMCOLUMNID      );
        	var dataType         = setNullToString( columnInfo.DATATYPE        );
        	//var userEdit         = setNullToString( columnInfo.USEREDIT        );
        	//var subAdminEdit     = setNullToString( columnInfo.SUBADMINEDIT    );          	
        	var displayYn        = setNullToString( columnInfo.DISPLAYYN       ); 
        	
        	var columnValue = "";
        	if( rowValue != null) {
        		if( dataType == "S") {
        			if( columnId == "SERVICE") {
        				columnValue = rowValue[ columnId ];
        			} else {
        				columnValue = setNullToString( rowValue[ columnId ] );
        			}
        		} else if ( dataType == "p") {
        			columnValue = setNullToString( rowValue[ columnId ] );
        		} else {
        			columnValue = setNullToString( rowValue[ imColumnId ] );
        		}
        	} 
        	
        	
        	if( displayYn != null && displayYn != "Y") {
        		continue;
        	}
        	/*
            var isEditable = false;
        	if( userLevel == USER_LEVEL_S) {
        		isEditable = true;
        	} else {
	        	if( isSubAdmin == true ) {
	        		if( subAdminEdit == "Y") {
	        			isEditable = true;
	        		}
	        	} else {
	        		if( userEdit == "Y") {
	        			isEditable = true;
	        		}    		
	        	}
        	}
        	*/
        	//console.log( "isEditable = " + isEditable);
        	
        	//
    		// 코드별칠 값 설정
            //
    		if ( dataType == "N") { 
    			var pos = columnId.lastIndexOf("NAME");
    			if( pos <= 0 ) {
    				alert("코드별칭 컬럼이 아닙니다 ");
    				return false;
    			} else {
    				var codeColumnName = columnId.substring(0, pos);
    				
    				$("#" +divId + " input[name='" + codeColumnName + "']").val(columnValue);
    				
    				var codeColumnText = $("#" +divId + " input[name='" + codeColumnName + "']").val();
    				
    				if (codeColumnText == "" || codeColumnText == undefined) {
    					codeColumnName += "CODE";
    					
    					$("#" +divId + " input[name='" + codeColumnName + "']").val(columnValue);
    					codeColumnText = $("#" +divId + " input[name='" + codeColumnName + "']").val();
    				}
    			}
    		}
        }
	}
}

/*******************************************************************************
*
* 
* 컬럼 동적 생성 관련 END
* 
* 
* 
******************************************************************************/

/**
 * json.title : 타이틀
 * json.target  : target div id
 * json.html : iframe tag
 * json.width : width size
 * json.height : height size
 */
$.modalPopup = function(json){
//	alert("####");
	$(json.target).html(json.html).dialog({
		title : json.title,
		modal : true, 
//		closeOnEscape : true,
		draggable : false, 
		resizable : false,
		width : (json.width == null || json.width == 'undifinded') ? 300 : json.width, 
		height: (json.height == null || json.height == 'undifinded') ? 200 : json.height,
		open : function(){
			$(json.id).attr("src",json.url);
		},
		buttons : json.buttons
	});
};





/**
 * 날짜가 맞는 날인지 확인
 * @param date
 */
function isDate(txtDate)
{
	var currVal = txtDate;

	//console.log( "isDate currVal = " + txtDate);
	
	if (currVal=='')
		return false;

	if (currVal.length==10) {
		currVal = currVal.replace(/-/g,"");
	}

	if(currVal.length < 8)
		return false;
/*
	var dtArray = currVal.match(/^[0-9]{4}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])/);

	if (dtArray == null)
		return false;

	//Checks for mm/dd/yyyy format. yyyymmdd
	dtYear = dtArray[3];
	dtMonth = dtArray[5];
	dtDay= dtArray[7];
*/
	var dtYear = Number(currVal.substring(0, 4));
	var dtMonth = Number(currVal.substring(4, 6));
	var dtDay = Number(currVal.substring(6, 8));

	//console.log( "dtYear=" + dtYear + ", dtMonth=" + dtMonth + ", dtDay=" + dtDay )
	if (dtMonth < 1 || dtMonth > 12)
		return false;
	else if (dtDay < 1 || dtDay> 31)
		return false;
	else if ((dtMonth==4 || dtMonth==6 || dtMonth==9 || dtMonth==11) && dtDay ==31)
		return false;
	else if (dtMonth == 2)
	{
	var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
	if (dtDay> 29 || (dtDay ==29 && !isleap))
		return false;
	}
	return true;
}



/**
 * 날짜 포멧 변경
 * @param date
 */
function formatDate(txtDate)
{
	// 공백인 경우는 정상으로 처리
	if(txtDate != ""){
		if (!isDate(txtDate)) {
			alert("날짜 형식이 맞지 않습니다.");
			return txtDate;
		}
		return txtDate.substring(0,4) + "-" + txtDate.substring(4,6) + "-" + txtDate.substring(6,8);
	} else {
		return txtDate;
	}
}


/**
 * 날짜 포멧 변경
 * @param date
 */
function formatDateTime(txtDate)
{
	// 공백인 경우는 정상으로 처리
	if(txtDate != ""){
		if(txtDate.length >= 14){
			return txtDate.substring(0,4) + "-" + txtDate.substring(4,6) + "-" + txtDate.substring(6,8) + " " + txtDate.substring(8,10) +":"+ txtDate.substring(10,12)+":"+ txtDate.substring(12,14);
		}else{
			return txtDate.substring(0,4) + "-" + txtDate.substring(4,6) + "-" + txtDate.substring(6,8) + " "+txtDate.substring(8,txtDate.length);
		}
	} else {
		return txtDate;
	}
}

/**
 * 날짜 포멧 변경
 * @param date
 */
function formatTime(txtDate)
{
	// 공백인 경우는 정상으로 처리
	if(txtDate != ""){
		if(txtDate.length >= 6){
			return txtDate.substring(0,2) +":"+ txtDate.substring(2,4)+":"+ txtDate.substring(4,6);
		}
	} else {
		return txtDate;
	}
}


/**
 * 날짜 포멧 변경
 * @param date
 */
function noneFormatDate(strFormatDate)
{
	// 공백인 경우는 정상으로 처리
	if(strFormatDate != ""){
		if (!isDate(strFormatDate)) {
			alert("날짜 형식이 맞지 않습니다.");
			return strFormatDate;
		}
		
		if( strFormatDate.length == 10 ) {

			return strFormatDate.replace(/-/g,"");
		} else {
			return strFormatDate;
		}
		
	} else {
		return strFormatDate;
	}
}




/**
 * From / To 날짜 비교
 * '-' 가 들어있는 날짜여야 함
 * @param date
 */
function betweenDate(fromDate, toDate)
{
	if (!isDate(fromDate) ) {
		alert("시작일자가 형식이 맞지 않습니다.");
		return false;
	}

	if (!isDate(toDate) ) {
		alert("종료일자가 날짜가 형식이 맞지 않습니다.");
		return false;
	}
	
	var fromArray = new Array();
	if( fromDate.length == 8 ) {
		fromArray[0] = fromDate.substring(0,4);
		fromArray[1] = fromDate.substring(4,6);
		fromArray[2] = fromDate.substring(6,8);
	} else {
		fromArray 	= fromDate.split("-");
	}
	
	var toArray = new Array();
	if( toDate.length == 8 ) {
		toArray[0] = toDate.substring(0,4);
		toArray[1] = toDate.substring(4,6);
		toArray[2] = toDate.substring(6,8);
	} else {
		toArray 	= toDate.split("-");
	}
	
	

	fromDate 	= new Date(fromArray[0], Number(fromArray[1])-1, fromArray[2]);
	toDate 		= new Date(toArray[0], Number(toArray[1])-1, toArray[2]);

	if ( ( toDate.getTime() - fromDate.getTime()) < 0 ) {
		alert( "종료일자가 시작일자보다 이전일 수 없습니다.");
		return false;
	} 
	return true;
}


/**
 * 좌측 0 문자 제거
 * 
 * @param strVal
 * @param padChar
 */
function removeLeftZero( strVal) {
	if( strVal == null || strVal == "") return strVal;
	
	var regExp = /^0*/;
	return strVal.replace( regExp, "");
}






/**
 * 
 * 비밀번호의 포함된 char Type 판단
 * 
 * 사용방법
 * <pre>
 *     var pwdContainCharType = new PwdContainCharType();
 *     pwdContainCharType.init( 비밀번호문자열 );
 *     var isResult = pwdContainCharType.checkContainCaseSensitive(true, true, true, true, false, 0);
 * 
 * @returns
 */
function PwdContainCharType() {
    
    this.isInsAlpha = false;
    this.isInsBigAlpha = false;
    this.isInsSmallAlpha = false;
    this.isInsNumeric = false;
    this.isInsSymbol = false;
//    this.isInsSpace = false;
    this.isInsSpecial = false;
    
    /**
     * 표준 아스키 코드값 참조 
     */    
    this.init = function(strVal) {
	    if (strVal != null && strVal.length > 0) {
	    	var nLength = strVal.length;
	        // 입력받은 문자에 대해 check
	        for (var i = 0; i < nLength; i++) {
	            var ch = strVal.charCodeAt(i);
	            if (ch >= 65 && ch <= 90) {
	                this.isInsAlpha = true;
	                this.isInsBigAlpha = true;
	            } else if (ch >= 97 && ch <= 122) {
	                this.isInsAlpha = true;
	            	this.isInsSmallAlpha = true;
	            } else if (ch >= 48 && ch <= 57) {
	            	this.isInsNumeric = true;
	            } else if (((ch >= 33 && ch <= 47) || (ch >= 58 && ch <= 64) || (ch >= 91 && ch <= 96) || (ch >= 123 && ch <= 126))) {
	            	this.isInsSymbol = true;
//	            } else if ( ch == 32 ) {
//	                this.isInsSpace = true;
                } else {
                    alert("haha"+ch);
	            	this.isInsSpecial = true;
	            }
	        }
	    }
    };
    

	/** 
	 * 포함 건수 만큼 charType 포함여부를 return 한다.
	 * 
	 * @param isIncludeAlpha       영문자
	 * @param isIncludeNumeric     숫자
	 * @param isIncludeSymbol      기호(특수문자)
	 * @param isIncludeSpecial     기타
	 * @param includeCount  포함건수   , null 이나 0 일경우 전체 포함
	 * @return  
	 */
//	this.checkContain = function(  isIncludeAlpha, isIncludeBigAlpha, isIncludeSmallAlpha, isIncludeNumeric,  isIncludeSymbol, isIncludeSpace, isIncludeSpecial, includeCount ) {
	this.checkContain = function(  isIncludeAlpha, isIncludeBigAlpha, isIncludeSmallAlpha, isIncludeNumeric,  isIncludeSymbol, isIncludeSpecial, includeCount ) {
	    
//	    alert(this.isInsAlpha);
//	    alert(isIncludeAlpha);
//	    alert(this.isInsBigAlpha);
//	    alert(isIncludeBigAlpha);
//	    alert(this.isInsSmallAlpha);
//	    alert(isIncludeSmallAlpha);
//	    alert(this.isInsNumeric);
//	    alert(isIncludeNumeric);
//	    alert(this.isInsSymbol);
//	    alert(isIncludeSymbol);
//	    alert(this.isInsSpecial);
//	    alert(isIncludeSpecial);
	    
	    
		if( includeCount == null || includeCount == 0 ) {
			if( this.isInsAlpha == isIncludeAlpha
		        && this.isInsBigAlpha == isIncludeBigAlpha 
                && this.isInsSmallAlpha == isIncludeSmallAlpha
                && this.isInsNumeric == isIncludeNumeric
                && this.isInsSymbol == isIncludeSymbol
//                && this.isInsSpace == isIncludeSpace
                && this.isInsSpecial == isIncludeSpecial) 
			{
				return true;
			}
			return false;
			
		} else {
			var nCnt = 0;
			
			var nNoneIncludeCnt = 0;
			
			if( isIncludeAlpha == true) {
                if( this.isInsAlpha == isIncludeAlpha ) nCnt++;
            } else {
                if( isIncludeBigAlpha == true) {
                    if( this.isInsBigAlpha == isIncludeBigAlpha ) nCnt++;
                } else {
                    if( this.isInsBigAlpha == true ) nNoneIncludeCnt++;
                }
                
                
                if( isIncludeSmallAlpha == true) {
                    if( this.isInsSmallAlpha == isIncludeSmallAlpha ) nCnt++;
                } else {
                    if( this.isInsSmallAlpha == true ) nNoneIncludeCnt++;
                }

            }
			
			if( isIncludeNumeric == true) {
                if( this.isInsNumeric == isIncludeNumeric ) nCnt++;
            } else {
                if( this.isInsNumeric == true ) nNoneIncludeCnt++;
            }
            
            
            if( isIncludeSymbol == true) {
                if( this.isInsSymbol == isIncludeSymbol ) nCnt++;
            } else {
                if( this.isInsSymbol == true ) nNoneIncludeCnt++;
            }
            
//            if( isIncludeSpace == true) {
//                if( this.isInsSpace == isIncludeSpace ) nCnt++;
//            } else {
//                if( this.isInsSpace == true ) nNoneIncludeCnt++;
//            }
            
            if( isIncludeSpecial == true) {
                if( this.isInsSpecial == isIncludeSpecial ) nCnt++;
            } else {
                if( this.isInsSpecial == true ) nNoneIncludeCnt++;
            }
            if( nCnt >= includeCount && nNoneIncludeCnt == 0 ) {
                return true;
            }
			return false;
		}
	};
}



/**
 * 비밀번호 길이의 유효성을 체크한다.
 *
 * @param pwd 비밀번호
 * @return true-사용가능, false-사용 불가능.
 */
function checkLength(pwd, minLength, maxLength) {
    if (pwd != null && pwd.length > 0 && maxLength > 0) {
        var txtlen = pwd.length;
        if (txtlen >= minLength && txtlen <= maxLength) return true;
    }
    alert("비밀번호는 최소 "+minLength+" 자리, 최대 "+maxLength+" 자리를 사용해야 합니다.");
    return false;
}

/**
 * 
 * @returns
 */
function passwordPolicy(pwd, isExistContentChar, contentCharArray, mixCount) {
    this.isAlpha = false;
    this.isBigAlpha = false;
    this.isSmallAlpha = false;
    this.isNumeric = false;
    this.isSymbol = false;
//    this.isSpace = false;
    this.isSpecial = false;
    this.isExistContentChar = false;
    
    var pwdContainCharType = new PwdContainCharType();
    pwdContainCharType.init( pwd );
    
    if( contentCharArray != null || contentCharArray != "") {
        for( var i = 0 ; i < contentCharArray.length; i++) {
             if( contentCharArray[i] == 1 ) this.isAlpha = true;
             else if( contentCharArray[i] == 2 ) this.isBigAlpha = true;
             else if( contentCharArray[i] == 3 ) this.isSmallAlpha = true;
             else if( contentCharArray[i] == 4 ) this.isNumeric = true;
             else if( contentCharArray[i] == 5 ) this.isSymbol = true;
//             else if( contentCharArray[i] == 6 ) this.isSpace = true;
             //기호는 항상 false
             else isSpecial = false;
         };
    } else {
        isExistContentChar = false;
    };
    
    if( isExistContentChar == false ) return true;
    
    
    if( mixCount == 0 ) {
        return pwdContainCharType.checkContain(this.isAlpha, this.isBigAlpha, this.isSmallAlpha, this.isNumeric, this.isSymbol, this.isSpecial);
//        return pwdContainCharType.checkContain(this.isAlpha, this.isBigAlpha, this.isSmallAlpha, this.isNumeric, this.isSymbol, this.isSpace, this.isSpecial);
    } else {
        return pwdContainCharType.checkContain(this.isAlpha, this.isBigAlpha, this.isSmallAlpha, this.isNumeric, this.isSymbol, this.isSpecial, mixCount);
//        return pwdContainCharType.checkContain(this.isAlpha, this.isBigAlpha, this.isSmallAlpha, this.isNumeric, this.isSymbol, this.isSpace, this.isSpecial, mixCount);
    };
    
    return true;
}

function passwordPolicyHtml(userPwd, isExistContentChar, contentCharArray, mixCount) {
    if (!passwordPolicy(userPwd, isExistContentChar, contentCharArray, mixCount)) {
        var contentCharHTML = drawContentChar(contentCharArray);
        if (contentCharArray.length == 1 ) {
            contentCharHTML += "만 사용해야 합니다.";
        } else {
            contentCharHTML += "를 "+mixCount+"개 혼합해서 사용해야 합니다.";
        }
        alert(contentCharHTML);
        contentCharHTML = "";
        return false;
    }
    return true;
}

/**
 * 허용문자 화면에 그려주는
 * @param contentCharArray
 * @returns {String}
 */
function drawContentChar(contentCharArray) {
    contentCharHTML = "";
    for(var i = 0; i < contentCharArray.length; i ++) {
        if (contentCharArray[i] == "1") contentCharHTML += "영문자";
        else if (contentCharArray[i] == "2") contentCharHTML += "대문자 ";
        else if (contentCharArray[i] == "3") contentCharHTML += "소문자 ";
        else if (contentCharArray[i] == "4") contentCharHTML += "숫자 ";
        else if (contentCharArray[i] == "5") contentCharHTML += "기호";
//        else if (contentCharArray[i] == "6") contentCharHTML += "공백";
        if (i < contentCharArray.length-1 ) {
            contentCharHTML += ", ";
        }
    }
    return contentCharHTML;
}

function contentTrimCheck (pwd ) {
    if (pwd != null && pwd.length > 0) {
        var nLength = pwd.length;
        // 입력받은 문자에 대해 check
        for (var i = 0; i < nLength; i++) {
            var ch = pwd.charCodeAt(i);
            if ( ch == 32 ) {
                alert("공백문자를 넣을 수 없습니다. 다시 입력해주세요");
                return false;
            } 
        }
        return true;
    }
}

/**
 * 비밀번호를 비교한다.
 *
 * @param pwd1
 * @param pwd2
 * @return true: 일치, false: 미 일치
 */
function validatePassword(pwd1, pwd2) {
    if ( pwd1 != pwd2 ) {
        alert("신규 비밀번호가 일치하지 않습니다. 다시 입력해주세요");
        return false;
    } else {
        return true;
    }
}

///**
// * pwd1이 pwd2에 몇 % 동일한지 확인한다.
// * @param pwd1
// * @param pwd2
// * @param percentDifferent
// * @returns {Boolean}
// */
//function percentDifferentCheck(pwd1, pwd2, percentDifferent) {
//    if (percentDifferent <= 0) return false;
//    if (pwd1 == null || pwd1.length <= 0 || pwd2 == null || pwd2.length <= 0) return false;
//
//    var dPercentDifferent = pwd2.length * ( percentDifferent / 100.0);
//    var diffchar = null;
//    for (var i = 0; dPercentDifferent > 0 && i <= pwd1.length - dPercentDifferent - 1; i++) {
//        diffchar = pwd1.substring(i, dPercentDifferent + i);
//        if (pwd2.indexOf(diffchar) >= 0) {
//            alert("이전 비밀번호와 "+percentDifferent+" % 이상 다른 비밀번호만 가능합니다.");
//            return true;
//        }
//    }
//
//    return false;
//}

/**
 * 반복문자를 확인한다.
 *
 * @param pwd
 * @return true-반복된문자, false-반복된 문자없음.
 */
function repeatingCharCheck(pwd, repeatingChar) {
    var prevdata = 0x00;
    var repcnt = 1;

    if (repeatingChar <= 0) return false;

    for (var i = 0; i < pwd.length; i++) {
        if (pwd.charAt(i) == prevdata) repcnt++;
        else repcnt = 1;

        if (repcnt >= repeatingChar) {
            alert("동일문자 연속 "+repeatingChar+" 회 이상 허용하지 않습니다. 다시 입력해주세요.");
            return true;
        }
        prevdata = pwd.charAt(i);
    }

    return false;
}


/**
 * 공백 제거
 * @param str
 * @returns
 */
function trim(str) {
    var strVal = "";
    strVal = str.replace(/\s/g, "");
    return strVal;
}

/**
 * 비밀번호 Text폼 set
 * @param formId
 * @param newPwd
 * @param pwdCheck
 */
function setFocus(formId, newPwd, pwdCheck) {
    $("#"+formId+" input[name='"+newPwd+"']").focus();
    $("#"+formId+" input[name='"+newPwd+"']").val("");
    $("#"+formId+" input[name='"+pwdCheck+"']").val("");
}








/**
 * 입력받은 날짜 'yyyyMMdd' 에 달을 더한다.
 * 
 * addMonth( "20131227", -2 )
 */
function addMonth( dateVal, addValue ) {
	
	var currVal = dateVal;
	if (currVal== null || currVal.lenghth < 8) {
		return null;
	}

/* 	if (currVal.length==10) {
		currVal = currVal.replace(/-/g,"");
	} */

	if(currVal.length < 8) {
		return null;
	}
	
	
	var dtYear = Number(currVal.substring(0, 4));
	var dtMonth = Number(currVal.substring(4, 6));
	var dtDay = Number(currVal.substring(6, 8));

	var objDate = new Date(dtYear, dtMonth-1, 1);
	objDate.setMonth( objDate.getMonth() + addValue);
	var lastDate = (new Date(objDate.getFullYear(), objDate.getMonth()+1, 0).getDate());
//	alert( "lastDdate = " + lastDate);
	objDate.setDate((parseInt(dtDay) > lastDate) ? lastDate : parseInt(dtDay));
	
	var retVal = "" + objDate.getFullYear() + lpad(objDate.getMonth()+1, 2 ,"0") + lpad(objDate.getDate(), 2 ,"0");
	
	return retVal;
	
}

/**
 * 
 *
 * @param str 
 * @param num  전체 길이
 * @param chr padding 문자
 */
function lpad(str, num, chr) {  
	

	if( str == null || chr == null) {
		return str;
	}
	

	var strVal = "" + str;
	
// 	if( typeof(str) == "number") {
// 		strVal = str.toString();
// 	} else {
// 		strVal = str;
// 	}
	
    if (strVal.length >= num) {
        return strVal;
    }
 
    var max = num - strVal.length;

    for (var i = 0; i < max; i++) {
    	strVal = chr + strVal;
    }
 

    return strVal;
}


/**
 * 
 *
 * @param str 
 * @param num  전체 길이
 * @param chr padding 문자
 */                  // txt000000
function rpad(str, num, chr) {  
	
	if( str == null || chr == null) {
		return str;
	}
	
	var strVal = "" + str;
// 	if( typeof(str) == "number") {
// 		strVal = str.toString();
// 	} else {
// 		strVal = str;
// 	}
	
    if (strVal.length >= num) {
        return strVal;
    }
    
    
    var max = num - strVal.length;
    for (var i = 0; i < max; i++) {
    	strVal += chr;
    }
 
    return strVal;
}





/**
 * 엔터키 입력 시 특정 함수 호출
 * @param width - 창크기(width)
 * @param height - 창크기(height)
 *
 */
function checkEnter(functionName){
    if(event.keyCode == 13){
        eval(functionName);
    }
}

/**
 * 
 *
 * 화면에 날짜 표시 형식
 * @param pdate  날짜
 * @param displayDate 날짜형식 
 */ 
function setDisplayDateFormat(pdate, displayDate)
{
//	var test = "#{rtimProperties['rtim.user.sms.sender.id']}";
//	alert(displayDate);
	var yy, mm, dd;
	var yymmdd = "";
	var delimeter;
	
	if (pdate == "" || pdate == null || pdate == undefined ) {
		return yymmdd;
	} else {
		if (displayDate.indexOf("/") > -1)
		{  // yyyy/mm/dd
			yy = pdate.substr(0,4);
			mm = pdate.substr(4,2);
			dd = pdate.substr(6,2);
			
			delimeter = "/";
			
			yymmdd += yy;
			yymmdd += delimeter;
			yymmdd += mm;
			yymmdd += delimeter;
			yymmdd += dd;
		}
		else if (displayDate.indexOf(".") > -1)
	    {// yyyy.mm.dd
	    	yy = pdate.substr(0,4);
			mm = pdate.substr(4,2);
			dd = pdate.substr(6,2);
			
			delimeter = ".";
			
			yymmdd += yy;
			yymmdd += delimeter;
			yymmdd += mm;
			yymmdd += delimeter;
			yymmdd += dd;
	    }
	    else if (displayDate.indexOf("-") > -1)
	    {// yyyy-mm-dd
	    	yy = pdate.substr(0,4);
			mm = pdate.substr(4,2);
			dd = pdate.substr(6,2);
			
			delimeter = "-";
			
			yymmdd += yy;
			yymmdd += delimeter;
			yymmdd += mm;
			yymmdd += delimeter;
			yymmdd += dd;
	    }
	    else if (displayDate.length == 8)
	    {
	        yy = pdate.substr(0,4);
	        mm = pdate.substr(4,2);
	        dd = pdate.substr(6,2);
	        yymmdd += yy;
			yymmdd += mm;
			yymmdd += dd;
	    } else {
	    	yymmdd += pdate;
	    }
	}
	return yymmdd;
}
/**
 * To delete readonly input value 
 * @param inputID  
 * @param  
 */ 
function deleteInputReadOnlyValue(inputID){
	$("#"+inputID).val("");
}

/**
 * To delete readonly input value and hidden value 
 * @param inputID  
 * @param  
 */ 
function deleteInputReadOnlyValueWithHidden(inputID){
	$("#"+inputID).val("");
	$("#"+inputID+"_label").val("");
}
//ENTER 안먹게 하는것 
function captureReturnKey(e) { 
    if(e.keyCode==13 && e.srcElement.type != 'textarea') 
    return false; 
} 

/**
 * open popup
 * @since 2.4, 2014-08-18
 */
function openPopup(popId, inputId) {
	$('.layer_popup2').remove();
	
	$.ajax({
		url: '/imsso/popup/' +popId+ '.do'
		, type: 'post'
		, dataType: 'xml'
		, data: 't=' + inputId
		, success: function(data) {
			//console.log(data);
			$('body').append(data.responseText);
		}
		, error: function(data) {
			//console.log("Error with /imsso/popup/' +popId+ '.do");
			//console.log(data.responseText);
			$('body').append(data.responseText);
			
		}
	});
}

/**
 * close Pop up
 * @since 2.4, 2014-08-18
 */
function closePopup(popId) {
	$('#'+popId).remove();
}

/**
 * close Pop up
 * @since 2.4, 2014-08-18
 */
function closePopup(popId) {
	$(".deem").fadeOut();
	$('#'+popId+'Root').remove();
}

/**
 * show search reportTo
 * @param codeId				(String) 검색결과 CDSID input tag ID
 * @since 2014-10-23
 */
function showReportToSearch(codeId, codeNameId) {
	$('.layer_popup2').remove();
	
	$.ajax({
		url: '/imsso/localUser/reportTo/view.do'
		, type: 'post'
		, dataType: 'xml'
		, data: 'codeId=' + codeId + '&codeNameId=' + codeNameId
		, success: function(data, status, error) {
			//console.log(error);
			$('body').append(error.responseText);
		}, error: function(data, status, error) {
			//console.log("error");
			//console.log(data.responseText);
			$('body').append(data.responseText);
		}
	});
}

/**
 * show seachCode
 * @param codeMstId 		(String) 검색할 코드그룹
 * @param codeId			(String) 검색결과 code input tag ID
 * @param codeNameId		(String) 검색결과 codeName input tag ID
 * @since 2014-10-23
 */
function showCodeSearch(codeMstId, codeId, codeNameId) {
	$('.layer_popup2').remove();
	
	$.ajax({
		url: '/imsso/localUser/code/view.do'
		, type: 'post'
		, dataType: 'xml'
		, data: 'codeId=' + codeId + '&codeNameId=' + codeNameId + '&codeMstId=' + codeMstId
		, success: function(data, status, error) {
			//console.log(error);
			$('body').append(error.responseText);
		}, error: function(data, status, error) {
			//console.log("error");
			//console.log(data.responseText);
			$('body').append(data.responseText);
		}
	});
}

/**
 * show seachCode
 * @param codeMstId         (String) 검색할 코드그룹
 * @param country           (String) 검색결과 country input tag ID
 * @param codeNameId        (String) 검색결과 codeName input tag ID
 * @since 2016-11-14
 */
function showCodeSearchForCountry(codeMstId, country, codeNameId) {
    $('.layer_popup2').remove();
    
    $.ajax({
        url: '/imsso/localUser/code/country.do'
        , type: 'post'
        , dataType: 'xml'
        , data: 'country=' + country + '&codeNameId=' + codeNameId + '&codeMstId=' + codeMstId
        , success: function(data, status, error) {
            $('body').append(error.responseText);
        }, error: function(data, status, error) {
            $('body').append(data.responseText);
        }
    });
}


/**
 * show seachCode
 * @param codeMstId         (String) 검색할 코드그룹
 * @param codeId            (String) 검색결과 code input tag ID
 * @param codeNameId        (String) 검색결과 codeName input tag ID
 * @param street            (String) 검색결과 street input tag ID
 * @param city              (String) 검색결과 city input tag ID
 * @param state             (String) 검색결과 state input tag ID
 * @param zip               (String) 검색결과 zip input tag ID
 * @param country           (String) 검색결과 country input tag ID
 * @param office            (String) 검색결과 office input tag ID
 * @param company           (String) 검색결과 company input tag ID
 * @param regionCode        (String) 검색결과 regionCode input tag ID
 * @param regionName        (String) 검색결과 regionName input tag ID
 * @param plantCode         (String) 검색결과 plantCode input tag ID
 * @param plantName         (String) 검색결과 plantName input tag ID
 * @param nationCode        (String) 검색결과 nationCode input tag ID
 * @param nationName        (String) 검색결과 nationName input tag ID
 * @since 2016-11-10
 */
function showCodeSearchForBLDG(codeMstId, codeId, codeNameId,street,
        city,state,zip,country,
        office,company,regionCode,regionName,
        plantCode,plantName,nationCode,nationName,
        entityCode,entityName) {
    $('.layer_popup2').remove();
    
    $.ajax({
        url: '/imsso/localUser/code/bldg.do'
        , type: 'post'
        , dataType: 'xml'
        , data: 'codeId=' + codeId + '&codeNameId=' + codeNameId + '&codeMstId=' + codeMstId +'&street=' + street + 
                '&city=' + city + '&state=' + state +'&zip=' + zip + '&country=' + country +
                '&office=' + office + '&company=' + company +'&regionCode=' + regionCode + '&regionName=' + regionName +
                '&plantCode=' + plantCode + '&plantName=' + plantName +'&nationCode=' + nationCode + '&nationName=' + nationName +
                '&entityCode=' + entityCode + '&entityName=' + entityName 
        , success: function(data, status, error) {
            $('body').append(error.responseText);
        }, error: function(data, status, error) {
            $('body').append(data.responseText);
        }
    });
}

/**
 * 최종 선택완료
 * @since 2.6, 2014-08-18
 */
function selected(inputId, popId) {
	
	$('#'+inputId).val($('#' + popId + ' :radio[name="code"]:checked').val());
	$('#' + inputId + '_label').val($('#' + popId + ' :radio[name="code"]:checked').attr('text'));
	
	closePopup(popId);
}