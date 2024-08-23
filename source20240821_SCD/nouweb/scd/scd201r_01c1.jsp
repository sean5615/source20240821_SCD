<%/*
----------------------------------------------------------------------------------
File Name		: scd201r_01c1
Author			: sRu
Description		: 列印學分證明書 - 控制頁面 (javascript)
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		096/04/23	sRu    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/jspageinit.jsp"%>


/** 匯入 javqascript Class */
//doImport ("ErrorHandle.js, LoadingBar_0_2.js, Form.js");
doImport ("Query.js, ErrorHandle.js, LoadingBar_0_2.js, Form.js, Ajax_0_2.js, ArrayUtil.js, ReSize.js, SortTable.js");
/** 初始設定頁面資訊 */

var	printPage		=	"/scd/scd201r_01p1.jsp";	//列印頁面
var	_privateMessageTime	=	-1;				//訊息顯示時間(不自訂為 -1)
var	controlPage		=	"/scd/scd201r_01c2.jsp";
var	noPermissAry		=	new Array();			//沒有權限的陣列

/** 網頁初始化 */
function page_init()
{
	page_init_start();	
	/** 權限檢核 */
	securityCheck();

	/** === 初始欄位設定 === */
	/** 初始列印欄位 */
	Form.iniFormSet('QUERY', 'AYEAR', 'M',  3, 'A', 'N1', 'F',  3,'S', 3);
	Form.iniFormSet('QUERY', 'SMS', 'M', 2, 'A');
	Form.iniFormSet('QUERY', 'CENTER_CODE', 'M', 2, 'A');
	Form.iniFormSet('QUERY', 'STNO', 'M',  9, 'A','S', 9);
	
	_i('QUERY', 'BO').value = "1";	
	
	if (Form.getInput("QUERY", "GCD") != ""){
	    Form.iniFormSet("QUERY", "BO", "D", 1);	    
	}else{
	    Form.iniFormSet("QUERY", "BO", "D", 0);
	}
	
	
	

	/** ================ */

	/** === 設定檢核條件 === */
	/** 列印欄位 */
	Form.iniFormSet('QUERY', 'AYEAR', 'AA', 'chkForm', '學年');
	Form.iniFormSet('QUERY', 'SMS', 'AA', 'chkForm', '學期');
	//Form.iniFormSet('QUERY', 'CENTER_CODE', 'AA', 'chkForm', '中心別');
	Form.iniFormSet('QUERY', 'STNO', 'AA', 'chkForm', '學號');
	Form.iniFormSet('QUERY', 'BO', 'AA', 'chkForm', '是否為補發');
	/** ================ */
	
	page_init_end();
}

/** 判斷是按ie11或是舊版 */
function printBrowser(browserType) {

	if("o" == browserType) {
		_i('QUERY', 'BROWSER_TYPE').value = "o";	
	} else {
		_i('QUERY', 'BROWSER_TYPE').value = "IE11";	
	}
	
	doPrint();

}

/** 處理列印動作 */
function doPrint()
{
	var STNO = Form.getInput("QUERY", "STNO");	
	if(STNO.length==9){
		Form.setInput("QUERY", "ASYS","1");	
	}else{
		Form.setInput("QUERY", "ASYS","2");	
	}
	var SMS_NAME = _i('QUERY', 'SMS').options[_i('QUERY', 'SMS').selectedIndex].text
	Form.setInput("QUERY", "SMS_NAME",SMS_NAME);	
	doPrint_start();
	
	/** === 自定檢查 === */
	/* === LoadingBar === */
	/** 資料檢核及設定, 當有錯誤處理方式為 Form.errAppend(Message) 累計錯誤訊息 */
	//if (Form.getInput("QUERY", "SYS_CD") == "")
	//	Form.errAppend("系統編號不可空白!!");
	/** ================ */
	
	doPrint_end();
}

/** ============================= 欲修正程式放置區 ======================================= */
/** 設定功能權限 */
function securityCheck()
{
	try
	{
		/** 列印 */
		if (!<%=AUTICFM.securityCheck (session, "PRT")%>)
		{
			noPermissAry[noPermissAry.length]	=	"PRT";
			try{Form.iniFormSet("QUERY", "PRT_ALL_BTN", "D", 1);}catch(ex){}
		}
	}
	catch (ex)
	{
	}
}

/** 檢查權限 - 有權限/無權限(true/false) */
function chkSecure(secureType)
{
	if (noPermissAry.toString().indexOf(secureType) != -1)
		return false;
	else
		return true
}
