<%/*
----------------------------------------------------------------------------------
File Name		: scd201r_01c1
Author			: sRu
Description		: �C�L�Ǥ��ҩ��� - ����� (javascript)
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		096/04/23	sRu    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/jspageinit.jsp"%>


/** �פJ javqascript Class */
//doImport ("ErrorHandle.js, LoadingBar_0_2.js, Form.js");
doImport ("Query.js, ErrorHandle.js, LoadingBar_0_2.js, Form.js, Ajax_0_2.js, ArrayUtil.js, ReSize.js, SortTable.js");
/** ��l�]�w������T */

var	printPage		=	"/scd/scd201r_01p1.jsp";	//�C�L����
var	_privateMessageTime	=	-1;				//�T����ܮɶ�(���ۭq�� -1)
var	controlPage		=	"/scd/scd201r_01c2.jsp";
var	noPermissAry		=	new Array();			//�S���v�����}�C

/** ������l�� */
function page_init()
{
	page_init_start();	
	/** �v���ˮ� */
	securityCheck();

	/** === ��l���]�w === */
	/** ��l�C�L��� */
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

	/** === �]�w�ˮֱ��� === */
	/** �C�L��� */
	Form.iniFormSet('QUERY', 'AYEAR', 'AA', 'chkForm', '�Ǧ~');
	Form.iniFormSet('QUERY', 'SMS', 'AA', 'chkForm', '�Ǵ�');
	//Form.iniFormSet('QUERY', 'CENTER_CODE', 'AA', 'chkForm', '���ߧO');
	Form.iniFormSet('QUERY', 'STNO', 'AA', 'chkForm', '�Ǹ�');
	Form.iniFormSet('QUERY', 'BO', 'AA', 'chkForm', '�O�_���ɵo');
	/** ================ */
	
	page_init_end();
}

/** �P�_�O��ie11�άO�ª� */
function printBrowser(browserType) {

	if("o" == browserType) {
		_i('QUERY', 'BROWSER_TYPE').value = "o";	
	} else {
		_i('QUERY', 'BROWSER_TYPE').value = "IE11";	
	}
	
	doPrint();

}

/** �B�z�C�L�ʧ@ */
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
	
	/** === �۩w�ˬd === */
	/* === LoadingBar === */
	/** ����ˮ֤γ]�w, �����~�B�z�覡�� Form.errAppend(Message) �֭p���~�T�� */
	//if (Form.getInput("QUERY", "SYS_CD") == "")
	//	Form.errAppend("�t�νs�����i�ť�!!");
	/** ================ */
	
	doPrint_end();
}

/** ============================= ���ץ��{����m�� ======================================= */
/** �]�w�\���v�� */
function securityCheck()
{
	try
	{
		/** �C�L */
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

/** �ˬd�v�� - ���v��/�L�v��(true/false) */
function chkSecure(secureType)
{
	if (noPermissAry.toString().indexOf(secureType) != -1)
		return false;
	else
		return true
}
