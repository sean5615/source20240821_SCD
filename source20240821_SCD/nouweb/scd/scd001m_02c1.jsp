
<%/*
----------------------------------------------------------------------------------
File Name		: scd001m_02c1
Author			: matt
Description		: �]�w���Z�Ѽ� - �s�豱��� (javascript)
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		096/02/09	matt    	Code Generate Create
0.0.2		096/10/05	poto            �������B�z
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/jspageinit.jsp"%>

/** �פJ javqascript Class */
doImport ("ErrorHandle.js, LoadingBar_0_2.js, Form.js, Ajax_0_2.js, ArrayUtil.js");

/** ��l�]�w������T */
var	currPage		=	"<%=request.getRequestURI()%>";
var	printPage		=	"/scd/scd001m_01p1.htm";	//�C�L����
var	editMode		=	"ADD";				//�s��Ҧ�, ADD - �s�W, MOD - �ק�
var	_privateMessageTime	=	-1;				//�T����ܮɶ�(���ۭq�� -1)
var	controlPage		=	"/scd/scd001m_01c2.jsp";	//�����
var	queryObj		=	new queryObj();			//�d�ߤ���

/** ������l�� */
function page_init()
{
	page_init_start_2();

	/** === ��l���]�w === */
	/** ��l�s����� */
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

	loadind_.showLoadingBar (15, "��l��짹��");
	/** ================ */

	/** === �]�w�ˮֱ��� === */
	/** �s����� */
	Form.iniFormSet('EDIT', 'AYEAR', 'AA', 'chkForm', '�Ǧ~');
	Form.iniFormSet('EDIT', 'SMS', 'AA', 'chkForm', '�Ǵ�');


	Form.iniFormSet('EDIT', 'MID_KEYIN_SDATE', 'AA', 'chkForm', '�������Z�n���_���');
	Form.iniFormSet('EDIT', 'MID_KEYIN_EDATE', 'AA', 'chkForm', '�������Z�n�������');
	Form.iniFormSet('EDIT', 'FNL_KEYIN_SDATE', 'AA', 'chkForm', '�������Z�n���_���');
	Form.iniFormSet('EDIT', 'FNL_KEYIN_EDATE', 'AA', 'chkForm', '�������Z�n�������');
	Form.iniFormSet('EDIT', 'REMID_REEXAM_SDATE', 'AA', 'chkForm', '�����G�����Z�Ҭd�n���_����');
	Form.iniFormSet('EDIT', 'REMID_REEXAM_EDATE', 'AA', 'chkForm', '�����G�����Z�Ҭd�n���_����');
	Form.iniFormSet('EDIT', 'CENTER_REMID_REEXAM_SDATE', 'AA', 'chkForm', '���ߴ����G�����Z�Ҭd�n���_����');
	Form.iniFormSet('EDIT', 'CENTER_REMID_REEXAM_EDATE', 'AA', 'chkForm', '���ߴ����G�����Z�Ҭd�n���_����');

	Form.iniFormSet('EDIT', 'MID_ANNO_DATE', 'AA', 'chkForm', '�������Z���G���');
	Form.iniFormSet('EDIT', 'FNL_ANNO_DATE', 'AA', 'chkForm', '�������Z���G���');
	Form.iniFormSet('EDIT', 'STU_PNT_SDATE', 'AA', 'chkForm', '�}��ǥͤ��^�妨�Z��C�L�_��');
	Form.iniFormSet('EDIT', 'STU_PNT_EDATE', 'AA', 'chkForm', '�}��ǥͤ��^�妨�Z��C�L����');
	Form.iniFormSet('EDIT', 'PNT_SCD201R_DATE', 'AA', 'chkForm', '�}��C�L�ɵo��Ǵ��Ǥ��ҩ��Ѥ��');
	Form.iniFormSet('EDIT', 'GMARK_RATE', 'AA', 'chkForm', '���ɦ��Z���q��v');
	Form.iniFormSet('EDIT', 'MID_RATE', 'AA', 'chkForm', '�������Z���q��v');
	Form.iniFormSet('EDIT', 'FNL_RATE', 'AA', 'chkForm', '�������Z���q��v');
	Form.iniFormSet('EDIT', 'GMARK_EVAL_TIMES', 'AA', 'chkForm', '���ɦ��Z���q����');
	Form.iniFormSet('EDIT', 'LOCK_WARN_DAYS', 'AA', 'chkForm', '��w�wĵ�Ѽ�');
	Form.iniFormSet('EDIT', 'GMARK_REEXAM_SDATE', 'AA', 'chkForm', '���ɦ��Z�Ƭd�_���');
	Form.iniFormSet('EDIT', 'GMARK_REEXAM_EDATE', 'AA', 'chkForm', '���ɦ��Z�Ƭd�����');
	Form.iniFormSet('EDIT', 'MID_REEXAM_SDATE', 'AA', 'chkForm', '�����Ҧ��Z�Ƭd�_���');
	Form.iniFormSet('EDIT', 'MID_REEXAM_EDATE', 'AA', 'chkForm', '�����Ҧ��Z�Ƭd�����');
	Form.iniFormSet('EDIT', 'FNL_REEXAM_SDATE', 'AA', 'chkForm', '�����Ҧ��Z�Ƭd�_���');
	Form.iniFormSet('EDIT', 'FNL_REEXAM_EDATE', 'AA', 'chkForm', '�����Ҧ��Z�Ƭd�����');
	Form.iniFormSet('EDIT', 'REEXAM_FEE', 'AA', 'chkForm', '�Ƭd����O');
	Form.iniFormSet('EDIT', 'REEXAM_APP_PRT_EXPL', 'AA', 'chkForm', '�ӽЪ���');
	Form.iniFormSet('EDIT', 'PNT_SCD201R_DATE', 'AA', 'chkForm', '�}��C�L�ɵo��Ǵ��Ǥ��ҩ��Ѥ��');
	loadind_.showLoadingBar (20, "�]�w�ˮֱ��󧹦�");
	/** ================ */

	page_init_end_2();
}

/** �s�W�\��ɩI�s */
function doAdd()
{	
	setSCDT002Visible(true);
	document.forms["EDIT"].SMS.disabled = false;
	doAdd_start();

	/** �M����Ū����(KEY)*/
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
	/** ��l�W�h�a�Ӫ� Key ��� */
	iniMasterKeyColumn();

	/** �]�w Focus */
	Form.iniFormSet('EDIT', 'AYEAR', 'FC');

	/** ��l�� Form �C�� */
	Form.iniFormColor();

	/** ����B�z */
	queryObj.endProcess ("�s�W���A����");
}

/** �ק�\��ɩI�s */
function doModify()
{
	setSCDT002Visible(false);
	document.forms["EDIT"].SMS.disabled = true;
	/** �]�w�ק�Ҧ� */
	editMode		=	"UPD";
	EditStatus.innerHTML	=	"�ק�";

	/** �M����Ū����(KEY)*/
	Form.iniFormSet('EDIT', 'AYEAR', 'R', 1);
	Form.iniFormSet('EDIT', 'SMS', 'R', 1);
	Form.iniFormSet('EDIT', 'CENTER_CODE', 'R', 1);
	/**/
	//by poto
	var obj = document.getElementById("table2");	
	for (i=1;i<=7;i++) {
		//obj.rows[i].style.display = "none";
	}
	/** ��l�� Form �C�� */
	Form.iniFormColor();

	/** �]�w Focus */
	Form.iniFormSet('EDIT', 'TCH_GMARK_SDATE', 'FC');

}

/** �s�ɥ\��ɩI�s */
function doSave()
{
	doSave_start();

	/** �P�_�s�W�L�v�����B�z */
	if (editMode == "NONE")
		return;

	/** ����ˮ֤γ]�w, �����~�B�z�覡�� Form.errAppend(Message) �֭p���~�T�� */
	//if (Form.getInput("EDIT", "SYS_CD") == "")
	//	Form.errAppend("�t�νs�����i�ť�!!");	
	checkDate();
	var GMARK_RATE = Form.getInput("EDIT","GMARK_RATE");
	var MID_RATE = Form.getInput("EDIT","MID_RATE");
	var FNL_RATE = Form.getInput("EDIT","FNL_RATE");
	if (GMARK_RATE != "" && MID_RATE != "" && FNL_RATE != "") {
		if (GMARK_RATE*1 + MID_RATE*1 + FNL_RATE*1 != 100) {
			Form.errAppend("���Z���q��v�`�M����100%");
		}
	}
	loadind_.showLoadingBar (10, "�۩w�ˮ֧���");
	/** ================ */

	doSave_end();
}

/** ============================= ���ץ��{����m�� ======================================= */
/** �]�w�\���v�� */
function securityCheck()
{
	try
	{
		/** �s�W */
		if (!<%=AUTICFM.securityCheck (session, "ADD")%>)
		{
			noPermissAry[noPermissAry.length]	=	"ADD";
			editMode	=	"NONE";
			try{Form.iniFormSet("EDIT", "ADD_BTN", "D", 1);}catch(ex){}
		}
		/** �ק� */
		if (!<%=AUTICFM.securityCheck (session, "UPD")%>)
		{
			noPermissAry[noPermissAry.length]	=	"UPD";
		}
		/** �s�W�έק� */
		if (!chkSecure("ADD") && !chkSecure("UPD"))
		{
			try{Form.iniFormSet("EDIT", "SAVE_BTN", "D", 1);}catch(ex){}
		}
		/** �R�� */
		if (!<%=AUTICFM.securityCheck (session, "DEL")%>)
		{
			noPermissAry[noPermissAry.length]	=	"DEL";
			try{Form.iniFormSet("RESULT", "DEL_BTN", "D", 1);}catch(ex){}
		}
		/** �ץX */
		if (<%=AUTICFM.securityCheck (session, "EXP")%>)
		{
			noPermissAry[noPermissAry.length]	=	"EXP";
			try{Form.iniFormSet("RESULT", "EXPORT_BTN", "D", 1);}catch(ex){}
			try{Form.iniFormSet("QUERY", "EXPORT_ALL_BTN", "D", 1);}catch(ex){}
		}
		/** �C�L */
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

/** �ˬd�v�� - ���v��/�L�v��(true/false) */
function chkSecure(secureType)
{
	if (noPermissAry.toString().indexOf(secureType) != -1)
		return false;
	else
		return true
}
/** ====================================================================================== */

function checkDate() {
	checkDateRange("TCH_GMARK",		"�Юv���ɦ��Z�n���_����");
	checkDateRange("TCH_MID",		"�Юv�������Z�n���_����");
	checkDateRange("TCH_FNL",		"�Юv�������Z�n���_����");
	/*
	checkDateRange("CENTER_GMARK",	"���ߥ��ɦ��Z�n���_����");
	checkDateRange("CENTER_MID",	"���ߴ������Z�n���_����");
	checkDateRange("CENTER_FNL",	"���ߴ������Z�n���_����");
	*/
	checkDateRange("MID_KEYIN",		"�������Z�n���_����");
	checkDateRange("FNL_KEYIN",		"�������Z�n���_����");
	checkDateRange("GMARK_REEXAM",	"���ɦ��Z�Ƭd�_����");
	checkDateRange("MID_REEXAM",	"�����Ҧ��Z�Ƭd�_����");
	checkDateRange("FNL_REEXAM",	"�����Ҧ��Z�Ƭd�_����");
	/*
	if (!checkDateRange1("TCH_MID","TCH_FNL")) {
		Form.errAppend("�Юv�������Z�n���_���饲���b�������Z�n���������!");
	}
	if (!checkDateRange1("CENTER_MID","CENTER_FNL")) {
		Form.errAppend("���ߴ������Z�n���_���饲���b�������Z�n���������!");
	}
	if (!checkDateRange1("MID_KEYIN","FNL_KEYIN")) {
		Form.errAppend("�������Z�n���_���饲���b�������Z�n���������!");
	}
	*///by poto
	var MID_ANNO_DATE = document.forms["EDIT"].MID_ANNO_DATE.value;
	var FNL_ANNO_DATE = document.forms["EDIT"].FNL_ANNO_DATE.value;
	/*
	if (MID_ANNO_DATE >= FNL_ANNO_DATE) {
		Form.errAppend("�������Z���G��������b�������Z���G�������!");
	}
	*///by poto
	if (MID_ANNO_DATE > FNL_ANNO_DATE) {
		Form.errAppend("�������Z���G��������b�������Z���G�������!");
	}
	if (!checkDateRange1("MID_REEXAM","FNL_REEXAM")) {
		Form.errAppend("�����Ҧ��Z�Ƭd�_���饲���b�����Ҧ��Z�Ƭd�������!");
	}
}

function checkDateRange(objnm,objdesc) {
	var stObj = document.getElementsByName(objnm + "_SDATE")[0];
	var edObj = document.getElementsByName(objnm + "_EDATE")[0];

	if (stObj.value == "" || edObj.value == "") return;
	if (stObj.value > edObj.value) {
		Form.errAppend("(" + objdesc + ")������϶����~");
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
		Form.iniFormSet('EDIT', 'TCH_GMARK_SDATE', 'AA', 'chkForm', '�Юv���ɦ��Z�n���_���');
		Form.iniFormSet('EDIT', 'TCH_GMARK_EDATE', 'AA', 'chkForm', '�Юv���ɦ��Z�n�������');		
		Form.iniFormSet('EDIT', 'TCH_MID_SDATE', 'AA', 'chkForm', '�Юv�������Z�n���_���');
		Form.iniFormSet('EDIT', 'TCH_MID_EDATE', 'AA', 'chkForm', '�Юv�������Z�n�������');
		Form.iniFormSet('EDIT', 'TCH_FNL_SDATE', 'AA', 'chkForm', '�Юv�������Z�n���_���');
		Form.iniFormSet('EDIT', 'TCH_FNL_EDATE', 'AA', 'chkForm', '�Юv�������Z�n�������');
		/*
		Form.iniFormSet('EDIT', 'CENTER_GMARK_SDATE', 'AA', 'chkForm', '���ߥ��ɦ��Z�n���_���');
		Form.iniFormSet('EDIT', 'CENTER_GMARK_EDATE', 'AA', 'chkForm', '���ߥ��ɦ��Z�n�������');
		Form.iniFormSet('EDIT', 'CENTER_MID_SDATE', 'AA', 'chkForm', '���ߴ������Z�n���_���');
		Form.iniFormSet('EDIT', 'CENTER_MID_EDATE', 'AA', 'chkForm', '���ߴ������Z�n�������');		
		Form.iniFormSet('EDIT', 'CENTER_FNL_SDATE', 'AA', 'chkForm', '���ߴ������Z�n���_���');
		Form.iniFormSet('EDIT', 'CENTER_FNL_EDATE', 'AA', 'chkForm', '���ߴ������Z�n�������');
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
	if(!confirm('�T�{��s�Z�Ÿ��')){
		return;
	}
	var	callBack	=	function updClass.callBack(ajaxData)
	{
		if (ajaxData == null){			
			return;
		}			
		alert("��s����");
	}
	sendFormData("EDIT", controlPage, "updClass", callBack,false);
}