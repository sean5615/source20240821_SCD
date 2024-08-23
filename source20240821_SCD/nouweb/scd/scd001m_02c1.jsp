
<%/*
----------------------------------------------------------------------------------
File Name		: scd001m_02c1
Author			: matt
Description		: 設定成績參數 - 編輯控制頁面 (javascript)
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		096/02/09	matt    	Code Generate Create
0.0.2		096/10/05	poto            日期條件處理
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/jspageinit.jsp"%>

/** 匯入 javqascript Class */
doImport ("ErrorHandle.js, LoadingBar_0_2.js, Form.js, Ajax_0_2.js, ArrayUtil.js");

/** 初始設定頁面資訊 */
var	currPage		=	"<%=request.getRequestURI()%>";
var	printPage		=	"/scd/scd001m_01p1.htm";	//列印頁面
var	editMode		=	"ADD";				//編輯模式, ADD - 新增, MOD - 修改
var	_privateMessageTime	=	-1;				//訊息顯示時間(不自訂為 -1)
var	controlPage		=	"/scd/scd001m_01c2.jsp";	//控制頁面
var	queryObj		=	new queryObj();			//查詢元件

/** 網頁初始化 */
function page_init()
{
	page_init_start_2();

	/** === 初始欄位設定 === */
	/** 初始編輯欄位 */
	Form.iniFormSet('EDIT', 'AYEAR', 'S', 3, 'N1', 'M',  3, 'A', 'F',  3);
	Form.iniFormSet('EDIT', 'SMS', 'M',  1, 'A');
	Form.iniFormSet('EDIT', 'REMID_MARK', 'S', 2, 'N1', 'M',  3, 'A');
	Form.iniFormSet('EDIT', 'TCH_GMARK_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'TCH_GMARK_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	/*
	Form.iniFormSet('EDIT', 'CENTER_GMARK_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'CENTER_GMARK_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'CENTER_MID_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'CENTER_MID_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'CENTER_FNL_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'CENTER_FNL_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	*/
	Form.iniFormSet('EDIT', 'TCH_MID_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'TCH_MID_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');	
	Form.iniFormSet('EDIT', 'TCH_FNL_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'TCH_FNL_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');	
	Form.iniFormSet('EDIT', 'MID_KEYIN_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'MID_KEYIN_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'FNL_KEYIN_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'FNL_KEYIN_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'MID_ANNO_DATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'FNL_ANNO_DATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'GMARK_RATE', 'S', 3, 'N1', 'M',  3, 'A');
	Form.iniFormSet('EDIT', 'MID_RATE', 'S', 3, 'N1', 'M',  3, 'A');
	Form.iniFormSet('EDIT', 'FNL_RATE', 'S', 3, 'N1', 'M',  3, 'A');
	Form.iniFormSet('EDIT', 'GMARK_EVAL_TIMES', 'S', 1, 'N1', 'M',  1, 'A');
	Form.iniFormSet('EDIT', 'LOCK_WARN_DAYS', 'S', 2, 'N1', 'M',  2, 'A');
	Form.iniFormSet('EDIT', 'GMARK_REEXAM_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'GMARK_REEXAM_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'MID_REEXAM_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'MID_REEXAM_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'REMID_REEXAM_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'REMID_REEXAM_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'CENTER_REMID_REEXAM_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'CENTER_REMID_REEXAM_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'FNL_REEXAM_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'FNL_REEXAM_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'REEXAM_FEE', 'S', 3, 'N1', 'M',  3, 'A');
	Form.iniFormSet('EDIT', 'STU_PNT_SDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'STU_PNT_EDATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'PNT_SCD201R_DATE', 'S', 8, 'N1', 'M',  8, 'A', 'DT');	

	loadind_.showLoadingBar (15, "初始欄位完成");
	/** ================ */

	/** === 設定檢核條件 === */
	/** 編輯欄位 */
	Form.iniFormSet('EDIT', 'AYEAR', 'AA', 'chkForm', '學年');
	Form.iniFormSet('EDIT', 'SMS', 'AA', 'chkForm', '學期');


	Form.iniFormSet('EDIT', 'MID_KEYIN_SDATE', 'AA', 'chkForm', '期中成績登打起日期');
	Form.iniFormSet('EDIT', 'MID_KEYIN_EDATE', 'AA', 'chkForm', '期中成績登打迄日期');
	Form.iniFormSet('EDIT', 'FNL_KEYIN_SDATE', 'AA', 'chkForm', '期末成績登打起日期');
	Form.iniFormSet('EDIT', 'FNL_KEYIN_EDATE', 'AA', 'chkForm', '期末成績登打迄日期');
	Form.iniFormSet('EDIT', 'REMID_REEXAM_SDATE', 'AA', 'chkForm', '期中二次成績考查登打起迄日');
	Form.iniFormSet('EDIT', 'REMID_REEXAM_EDATE', 'AA', 'chkForm', '期中二次成績考查登打起迄日');
	Form.iniFormSet('EDIT', 'CENTER_REMID_REEXAM_SDATE', 'AA', 'chkForm', '中心期中二次成績考查登打起迄日');
	Form.iniFormSet('EDIT', 'CENTER_REMID_REEXAM_EDATE', 'AA', 'chkForm', '中心期中二次成績考查登打起迄日');

	Form.iniFormSet('EDIT', 'MID_ANNO_DATE', 'AA', 'chkForm', '期中成績公佈日期');
	Form.iniFormSet('EDIT', 'FNL_ANNO_DATE', 'AA', 'chkForm', '期末成績公佈日期');
	Form.iniFormSet('EDIT', 'STU_PNT_SDATE', 'AA', 'chkForm', '開放學生中英文成績單列印起日');
	Form.iniFormSet('EDIT', 'STU_PNT_EDATE', 'AA', 'chkForm', '開放學生中英文成績單列印迄日');
	Form.iniFormSet('EDIT', 'PNT_SCD201R_DATE', 'AA', 'chkForm', '開放列印補發當學期學分證明書日期');
	Form.iniFormSet('EDIT', 'GMARK_RATE', 'AA', 'chkForm', '平時成績評量比率');
	Form.iniFormSet('EDIT', 'MID_RATE', 'AA', 'chkForm', '期中成績評量比率');
	Form.iniFormSet('EDIT', 'FNL_RATE', 'AA', 'chkForm', '期末成績評量比率');
	Form.iniFormSet('EDIT', 'GMARK_EVAL_TIMES', 'AA', 'chkForm', '平時成績評量次數');
	Form.iniFormSet('EDIT', 'LOCK_WARN_DAYS', 'AA', 'chkForm', '鎖定預警天數');
	Form.iniFormSet('EDIT', 'GMARK_REEXAM_SDATE', 'AA', 'chkForm', '平時成績複查起日期');
	Form.iniFormSet('EDIT', 'GMARK_REEXAM_EDATE', 'AA', 'chkForm', '平時成績複查迄日期');
	Form.iniFormSet('EDIT', 'MID_REEXAM_SDATE', 'AA', 'chkForm', '期中考成績複查起日期');
	Form.iniFormSet('EDIT', 'MID_REEXAM_EDATE', 'AA', 'chkForm', '期中考成績複查迄日期');
	Form.iniFormSet('EDIT', 'FNL_REEXAM_SDATE', 'AA', 'chkForm', '期末考成績複查起日期');
	Form.iniFormSet('EDIT', 'FNL_REEXAM_EDATE', 'AA', 'chkForm', '期末考成績複查迄日期');
	Form.iniFormSet('EDIT', 'REEXAM_FEE', 'AA', 'chkForm', '複查手續費');
	Form.iniFormSet('EDIT', 'REEXAM_APP_PRT_EXPL', 'AA', 'chkForm', '申請表說明');
	Form.iniFormSet('EDIT', 'PNT_SCD201R_DATE', 'AA', 'chkForm', '開放列印補發當學期學分證明書日期');
	loadind_.showLoadingBar (20, "設定檢核條件完成");
	/** ================ */

	page_init_end_2();
}

/** 新增功能時呼叫 */
function doAdd()
{	
	setSCDT002Visible(true);
	document.forms["EDIT"].SMS.disabled = false;
	doAdd_start();

	/** 清除唯讀項目(KEY)*/
	Form.iniFormSet('EDIT', 'AYEAR', 'R', 0);
	Form.iniFormSet('EDIT', 'SMS', 'R', 0);
	Form.iniFormSet('EDIT', 'CENTER_CODE', 'R', 0);

	document.forms["EDIT"].AYEAR.value = ayear;
	document.forms["EDIT"].SMS.value = sms;
	/**/
	//by poto
	/*
	var obj = document.getElementById("table2");	
	for (i=1;i<=4;i++) {
		obj.rows[i].style.display = "";
	}
	*/
	/** 初始上層帶來的 Key 資料 */
	iniMasterKeyColumn();

	/** 設定 Focus */
	Form.iniFormSet('EDIT', 'AYEAR', 'FC');

	/** 初始化 Form 顏色 */
	Form.iniFormColor();

	/** 停止處理 */
	queryObj.endProcess ("新增狀態完成");
}

/** 修改功能時呼叫 */
function doModify()
{
	setSCDT002Visible(false);
	document.forms["EDIT"].SMS.disabled = true;
	/** 設定修改模式 */
	editMode		=	"UPD";
	EditStatus.innerHTML	=	"修改";

	/** 清除唯讀項目(KEY)*/
	Form.iniFormSet('EDIT', 'AYEAR', 'R', 1);
	Form.iniFormSet('EDIT', 'SMS', 'R', 1);
	Form.iniFormSet('EDIT', 'CENTER_CODE', 'R', 1);
	/**/
	//by poto
	var obj = document.getElementById("table2");	
	for (i=1;i<=7;i++) {
		//obj.rows[i].style.display = "none";
	}
	/** 初始化 Form 顏色 */
	Form.iniFormColor();

	/** 設定 Focus */
	Form.iniFormSet('EDIT', 'TCH_GMARK_SDATE', 'FC');

}

/** 存檔功能時呼叫 */
function doSave()
{
	doSave_start();

	/** 判斷新增無權限不處理 */
	if (editMode == "NONE")
		return;

	/** 資料檢核及設定, 當有錯誤處理方式為 Form.errAppend(Message) 累計錯誤訊息 */
	//if (Form.getInput("EDIT", "SYS_CD") == "")
	//	Form.errAppend("系統編號不可空白!!");	
	checkDate();
	var GMARK_RATE = Form.getInput("EDIT","GMARK_RATE");
	var MID_RATE = Form.getInput("EDIT","MID_RATE");
	var FNL_RATE = Form.getInput("EDIT","FNL_RATE");
	if (GMARK_RATE != "" && MID_RATE != "" && FNL_RATE != "") {
		if (GMARK_RATE*1 + MID_RATE*1 + FNL_RATE*1 != 100) {
			Form.errAppend("成績評量比率總和須為100%");
		}
	}
	loadind_.showLoadingBar (10, "自定檢核完成");
	/** ================ */

	doSave_end();
}

/** ============================= 欲修正程式放置區 ======================================= */
/** 設定功能權限 */
function securityCheck()
{
	try
	{
		/** 新增 */
		if (!<%=AUTICFM.securityCheck (session, "ADD")%>)
		{
			noPermissAry[noPermissAry.length]	=	"ADD";
			editMode	=	"NONE";
			try{Form.iniFormSet("EDIT", "ADD_BTN", "D", 1);}catch(ex){}
		}
		/** 修改 */
		if (!<%=AUTICFM.securityCheck (session, "UPD")%>)
		{
			noPermissAry[noPermissAry.length]	=	"UPD";
		}
		/** 新增及修改 */
		if (!chkSecure("ADD") && !chkSecure("UPD"))
		{
			try{Form.iniFormSet("EDIT", "SAVE_BTN", "D", 1);}catch(ex){}
		}
		/** 刪除 */
		if (!<%=AUTICFM.securityCheck (session, "DEL")%>)
		{
			noPermissAry[noPermissAry.length]	=	"DEL";
			try{Form.iniFormSet("RESULT", "DEL_BTN", "D", 1);}catch(ex){}
		}
		/** 匯出 */
		if (<%=AUTICFM.securityCheck (session, "EXP")%>)
		{
			noPermissAry[noPermissAry.length]	=	"EXP";
			try{Form.iniFormSet("RESULT", "EXPORT_BTN", "D", 1);}catch(ex){}
			try{Form.iniFormSet("QUERY", "EXPORT_ALL_BTN", "D", 1);}catch(ex){}
		}
		/** 列印 */
		if (!<%=AUTICFM.securityCheck (session, "PRT")%>)
		{
			noPermissAry[noPermissAry.length]	=	"PRT";
			try{Form.iniFormSet("RESULT", "PRT_BTN", "D", 1);}catch(ex){}
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
/** ====================================================================================== */

function checkDate() {
	checkDateRange("TCH_GMARK",		"教師平時成績登打起迄日");
	checkDateRange("TCH_MID",		"教師期中成績登打起迄日");
	checkDateRange("TCH_FNL",		"教師期末成績登打起迄日");
	/*
	checkDateRange("CENTER_GMARK",	"中心平時成績登打起迄日");
	checkDateRange("CENTER_MID",	"中心期中成績登打起迄日");
	checkDateRange("CENTER_FNL",	"中心期末成績登打起迄日");
	*/
	checkDateRange("MID_KEYIN",		"期中成績登打起迄日");
	checkDateRange("FNL_KEYIN",		"期末成績登打起迄日");
	checkDateRange("GMARK_REEXAM",	"平時成績複查起迄日");
	checkDateRange("MID_REEXAM",	"期中考成績複查起迄日");
	checkDateRange("FNL_REEXAM",	"期末考成績複查起迄日");
	/*
	if (!checkDateRange1("TCH_MID","TCH_FNL")) {
		Form.errAppend("教師期末成績登打起迄日必須在期中成績登打日期之後!");
	}
	if (!checkDateRange1("CENTER_MID","CENTER_FNL")) {
		Form.errAppend("中心期末成績登打起迄日必須在期中成績登打日期之後!");
	}
	if (!checkDateRange1("MID_KEYIN","FNL_KEYIN")) {
		Form.errAppend("期末成績登打起迄日必須在期中成績登打日期之後!");
	}
	*///by poto
	var MID_ANNO_DATE = document.forms["EDIT"].MID_ANNO_DATE.value;
	var FNL_ANNO_DATE = document.forms["EDIT"].FNL_ANNO_DATE.value;
	/*
	if (MID_ANNO_DATE >= FNL_ANNO_DATE) {
		Form.errAppend("期末成績公佈日期必須在期中成績公佈日期之後!");
	}
	*///by poto
	if (MID_ANNO_DATE > FNL_ANNO_DATE) {
		Form.errAppend("期末成績公佈日期必須在期中成績公佈日期之後!");
	}
	if (!checkDateRange1("MID_REEXAM","FNL_REEXAM")) {
		Form.errAppend("期末考成績複查起迄日必須在期中考成績複查日期之後!");
	}
}

function checkDateRange(objnm,objdesc) {
	var stObj = document.getElementsByName(objnm + "_SDATE")[0];
	var edObj = document.getElementsByName(objnm + "_EDATE")[0];

	if (stObj.value == "" || edObj.value == "") return;
	if (stObj.value > edObj.value) {
		Form.errAppend("(" + objdesc + ")欄位日期區間錯誤");
	}
	return;
}
function checkDateRange1(objnm1,objnm2) {
	var obj1 = document.getElementsByName(objnm1 + "_EDATE")[0];
	var obj2 = document.getElementsByName(objnm2 + "_SDATE")[0];
	if (obj1.value == "" || obj2.value == "") return true;
	if (obj1.value > obj2.value) {
		return false;
	}
	return true;
}

function doClear_() {
	doClear();
	if (editMode == "ADD") {
		document.forms["EDIT"].AYEAR.value = ayear;
		document.forms["EDIT"].SMS.value = sms;
	}
}

function setSCDT002Visible(flag) {
	var disp = "";
	if (!flag) {
		disp = "none";
		document.forms["EDIT"].TCH_GMARK_SDATE.removeAttribute("chkForm");
		document.forms["EDIT"].TCH_GMARK_EDATE.removeAttribute("chkForm");		
		document.forms["EDIT"].TCH_MID_SDATE.removeAttribute("chkForm");
		document.forms["EDIT"].TCH_MID_EDATE.removeAttribute("chkForm");
		document.forms["EDIT"].TCH_FNL_SDATE.removeAttribute("chkForm");
		document.forms["EDIT"].TCH_FNL_EDATE.removeAttribute("chkForm");
		/*
		document.forms["EDIT"].CENTER_GMARK_SDATE.removeAttribute("chkForm");
		document.forms["EDIT"].CENTER_GMARK_EDATE.removeAttribute("chkForm");
		document.forms["EDIT"].CENTER_MID_SDATE.removeAttribute("chkForm");
		document.forms["EDIT"].CENTER_MID_EDATE.removeAttribute("chkForm");		
		document.forms["EDIT"].CENTER_FNL_SDATE.removeAttribute("chkForm");
		document.forms["EDIT"].CENTER_FNL_EDATE.removeAttribute("chkForm");
		*/
		
	} else {
		Form.iniFormSet('EDIT', 'TCH_GMARK_SDATE', 'AA', 'chkForm', '教師平時成績登打起日期');
		Form.iniFormSet('EDIT', 'TCH_GMARK_EDATE', 'AA', 'chkForm', '教師平時成績登打迄日期');		
		Form.iniFormSet('EDIT', 'TCH_MID_SDATE', 'AA', 'chkForm', '教師期中成績登打起日期');
		Form.iniFormSet('EDIT', 'TCH_MID_EDATE', 'AA', 'chkForm', '教師期中成績登打迄日期');
		Form.iniFormSet('EDIT', 'TCH_FNL_SDATE', 'AA', 'chkForm', '教師期末成績登打起日期');
		Form.iniFormSet('EDIT', 'TCH_FNL_EDATE', 'AA', 'chkForm', '教師期末成績登打迄日期');
		/*
		Form.iniFormSet('EDIT', 'CENTER_GMARK_SDATE', 'AA', 'chkForm', '中心平時成績登打起日期');
		Form.iniFormSet('EDIT', 'CENTER_GMARK_EDATE', 'AA', 'chkForm', '中心平時成績登打迄日期');
		Form.iniFormSet('EDIT', 'CENTER_MID_SDATE', 'AA', 'chkForm', '中心期中成績登打起日期');
		Form.iniFormSet('EDIT', 'CENTER_MID_EDATE', 'AA', 'chkForm', '中心期中成績登打迄日期');		
		Form.iniFormSet('EDIT', 'CENTER_FNL_SDATE', 'AA', 'chkForm', '中心期末成績登打起日期');
		Form.iniFormSet('EDIT', 'CENTER_FNL_EDATE', 'AA', 'chkForm', '中心期末成績登打迄日期');
		*/
	}

	var obj = document.getElementById("table2");
	/*
	for (i=1;i<=7;i++) {
		obj.rows[i].style.display = disp;
	}
	*/
	//by poto	
	/*
	obj.rows[5].style.display = "none";
	obj.rows[6].style.display = "none";
	obj.rows[7].style.display = "none";
	*/
}
function updClass(){
	if(!confirm('確認更新班級資料')){
		return;
	}
	var	callBack	=	function updClass.callBack(ajaxData)
	{
		if (ajaxData == null){			
			return;
		}			
		alert("更新完成");
	}
	sendFormData("EDIT", controlPage, "updClass", callBack,false);
}