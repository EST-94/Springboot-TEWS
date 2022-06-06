/**
 * Ajax Default Function
 * @param url
 * @param param
 * @param successCallback
 * @param errorCallback
 * @param isLoadBar
 */
function ajaxCall(url, param, successCallback, errorCallback, isLoadBar) {
    if(isLoadBar) showLoadingBar();
    $.ajax({
        type : 'POST',
        url : url,
        //contentType : "application/x-www-form-urlencoded; charset=utf-8",
        data : param,
        dataType : 'json',
        success : function(data) {
            try {
                if(data) {
                    if(data["responseCode"] == "SUCCESS") {
                        //var message = data["message"];
                        successCallback(data);
                    } else {
                        alert(data["errMsg"]);
                    }
                }
            } catch (e) {
                alert(e.message);
            }
        },
        error : errorCallback
    });
}


/**
 * Ajax Default Function
 * @param url
 * @param param
 * @param successCallback
 * @param errorCallback
 * @param isLoadBar
 */
function ajaxJsonCall(url, param, successCallback, errorCallback, isLoadBar) {
	// $(".deem").fadeIn();
	// $(".deem").fadeOut();
    if(isLoadBar) showLoadingBar();
    $.ajax({
        type : 'POST',
        url : url,
        //contentType : "application/json; charset=utf-8",
        data : param,
        dataType : 'json',
        success : function(data) {
            try {
                if(data) {
                	
                	//console.log(JSON.stringify(data));
                    if(data["responseCode"] == "SUCCESS") {
                      //  var message = data["message"];   
                        successCallback(data);
                    } else {
                        alert(data["errMsg"]);
                    }
                }
            } catch (e) {
                alert(e.message);
            }
        },
        error : errorCallback
    });
}



/**
 * Form Ajax Function.
 * @param form
 * @param successCallback
 * @param errorCallback
 * @param isLoadBar
 */
function ajaxFormSubmit(url, form, successCallback, errorCallback, isLoadBar) {
	if(isLoadBar) showLoadingBar();
	
    $.ajax({
        type : 'POST',
        //contentType : "application/x-www-form-urlencoded; charset=utf-8",
        url : url,
        data : $(form).serialize(),
        dataType : 'json',
        success : function(data) {
            try {
                if(data) {
                    if(data["responseCode"] == "SUCCESS") {
                       // var message = data;
                        successCallback(data);
                    } else {
                        alert(data["errMsg"]);
                    }

                }
            } catch (e) {
                alert(e.message);
            }
        },
        error : errorCallback
    });
}



/**
 * ajax error callback;
 */
function errorCallback() {
    alert("The connection to the server has been terminated.");
}

