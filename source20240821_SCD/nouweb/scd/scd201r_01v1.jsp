<%/*
----------------------------------------------------------------------------------
File Name		: scd201r_01v1
Author			: sRu
Description		: �C�L�Ǥ��ҩ��� - ��ܭ���
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		096/04/23	sRu    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ page import="java.util.*"%>
<%@ include file="/utility/viewpagedbinit.jsp"%>
<%@ page import="com.nou.sys.*"%>
<%@ page import="com.nou.sys.dao.*"%>
<%@ page import="com.nou.sol.signup.tool.*"%>
<%@ page import="com.nou.UtilityX"%>
<jsp:useBean id="AUTGETRANGE" scope="session" class="com.nou.aut.AUTGETRANGE" />

<%!
	String getDepStr(Vector dep) {
		StringBuffer CENTER_CODE = new StringBuffer();
		for (int i=0;i<dep.size();i++) {
            if(CENTER_CODE.length() > 0) {
                CENTER_CODE.append(",");
            }
            CENTER_CODE.append("'" + dep.get(i) +"'");
		}
		if (CENTER_CODE.length() == 0) {
			CENTER_CODE.append("''");
		}
        return CENTER_CODE.toString();
    }
%>
<%
String	ASYS	=	(String)session.getAttribute("ASYS");		//�Ǩ�

DBManager	dbManager	=	null;
Connection	conn		=	null;
DBResult	rs			=	null;

String AYEAR = "";
String SMS = "";
String GCD = "";

//���ߧO�ﶵ
StringBuffer	CC_option	=	null;

try
{
	dbManager	=	new DBManager(logger);
	com.nou.scd.bo.SCDGETSMSDATA sysgetsmsdata = new com.nou.scd.bo.SCDGETSMSDATA(dbManager);
	sysgetsmsdata.setSYS_DATE(DateUtil.getNowDate());
	sysgetsmsdata.setSMS_TYPE("1");
    GCD = Permision.processPermision(AUTGETRANGE);// �B�z�v��
    if (GCD == null){
       GCD = "";
    }
	int rtn = sysgetsmsdata.execute();
	AYEAR = sysgetsmsdata.getAYEAR();
	SMS = sysgetsmsdata.getSMS();
	/************���ߧO�v��**************/
	String CENTER_CODE = null;
	String all="";
	Vector dep = null;
	StringBuffer sql = new StringBuffer();
	sql.append(" SELECT A.CODE AS SELECT_VALUE,A.CODE_NAME AS SELECT_TEXT ");
	sql.append(" FROM SYST001 A ");
	sql.append(" WHERE A.KIND = 'CENTER_CODE' AND A.CODE NOT IN('00')");
	/**���ߧO*/
    //�v���O(PRVLG_TP[3.����])�B�����O(ID_TP[3.��F�H��])
    dep = AUTGETRANGE.getDEP_CODE("4","3");   
    
	if(dep.size()>0){
		boolean flag = false;
        for(int i=0;i<dep.size();i++){
            //�v���O(PRVLG_TP[4.����])�B�����O(ID_TP[3.��F�H��])
            dep = AUTGETRANGE.getDEP_CODE("4","3");
            CENTER_CODE = getDepStr(dep);           
        }
		//���o���ߧO
		/*
		if (CENTER_CODE != null){
			sql.append(" AND A.CODE IN (").append(CENTER_CODE).append(")");
		}
		*/
		sql.append("  ORDER BY A.CODE");
		session.setAttribute("scd201r_SELECT","NOU#" + sql.toString());
    }else{
		sql.append("  ORDER BY A.CODE");
		session.setAttribute("scd201r_SELECT","NOU#" + sql.toString());
	}
}
catch(Exception e)
{
	throw e;
}
finally
{
	if (rs != null)
		rs.close();

	if (conn != null)
		conn.close();

	if (dbManager != null)
		dbManager.close();
}
%>
<%
	session.setAttribute("SYST001_01_SELECT", "NOU#SELECT CODE AS SELECT_VALUE, CODE_NAME AS SELECT_TEXT FROM SYST001 WHERE KIND='[KIND]' ORDER BY SELECT_VALUE, SELECT_TEXT ");
%>
<html>
<head>

	<script src="<%=vr%>script/framework/query3_1_0_2.jsp"></script>
	<script src="scd201r_01c1.jsp"></script>
	<noscript>
		<p>�z���s�������䴩JavaScript�y�k�A���O�ä��v�T�z��������������e</p>
	</noscript>
</head>
<body background="<%=vr%>images/ap_index_bg.jpg" alt="�I����" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- �w�q�d�ߪ� Form �_�l -->
<form name="QUERY" method="post" onsubmit="doQuery();" style="margin:0,0,5,0;">
	<input type=hidden name="control_type">
	<input type=hidden name="ASYS">
	<input type=hidden name="SMS_NAME">
	<input type=hidden name="GCD">
	<input type=hidden name="CENTER_CODE">
	<input type=hidden name="BROWSER_TYPE">
	
	<!-- �d�ߥ��e���_�l -->
	<TABLE id="QUERY_DIV" width="96%" border="0" align="center" cellpadding="0" cellspacing="0" summary="�ƪ��Ϊ��">
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_search_01.jpg" alt="�ƪ��ιϥ�" width="13" height="12"></td>
			<td width="100%"><img src="<%=vr%>images/ap_search_02.jpg" alt="�ƪ��ιϥ�" width="100%" height="12"></td>
			<td width="13"><img src="<%=vr%>images/ap_search_03.jpg" alt="�ƪ��ιϥ�" width="13" height="12"></td>
		</tr>
		<tr>
			<td width="13" background="<%=vr%>images/ap_search_04.jpg" alt="�ƪ��ιϥ�">&nbsp;</td>
			<td width="100%" valign="top" bgcolor="#C5E2C3">
				<!-- ���s�e���_�l -->
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="�ƪ��Ϊ��">
					<tr class="mtbGreenBg">
						<td align=left>�i�C�L�e���j</td>
						<td align=right>
							<div id="serach_btn">
								<input type=button class="btn" value='�M  ��' onclick='doReset();setDefault();' onkeypress='doReset();setDefault();'>
								<input type=submit class="btn" name="PRT_ALL_BTN" value='�C  �L' onclick="printBrowser('o');" onkeypress="printBrowser('o');">
								<input type=submit class="btn" name="PRT_BTN" value='�C �L(IE11)' onclick="printBrowser('IE11');" onkeypress="printBrowser('IE11');">
							</div>
						</td>
					</tr>
				</table>			
				<table id="table1" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" summary="�ƪ��Ϊ��">
					<tr>
						<td align='right'>�Ǧ~��<font color=red>��</font>�G</td>
						<td>
							<input type=text name='AYEAR' >
							<select name='SMS' >
								<option value=''>�п��</option>
								<script>Form.getSelectFromPhrase("SYST001_01_SELECT", "KIND", "SMS");</script>
							</select>
						</td>				
						<td align='right'>�Ǹ�<font color=red>��</font>�G</td>
						<td colspan='1'><input type=text name='STNO'></td>
						<td align='right'>�O�_���ɵo<font color=red>��</font>�G</td>
						<td colspan='1'>
							<select name='BO'>
								<option value=''>�п��</option>
								<option value='1'>�O</option>
								<option value='2' selected>�_</option>
							</select>
						</td>
					</tr>
					
				</table>
			</td>
			<td width="13" background="<%=vr%>images/ap_search_06.jpg" alt="�ƪ��ιϥ�">&nbsp;</td>
		</tr>
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_search_07.jpg" alt="�ƪ��ιϥ�" width="13" height="13"></td>
			<td width="100%"><img src="<%=vr%>images/ap_search_08.jpg" alt="�ƪ��ιϥ�" width="100%" height="13"></td>
			<td width="13"><img src="<%=vr%>images/ap_search_09.jpg" alt="�ƪ��ιϥ�" width="13" height="13"></td>
		</tr>
	</table>
	<!-- �d�ߥ��e������ -->
</form>
<!-- �w�q�d�ߪ� Form ���� -->

<!-- ���D�e���_�l -->
<table width="96%" border="0" align="center" cellpadding="4" cellspacing="0" summary="�ƪ��Ϊ��">
	<tr>
		<td>
			<table width="500" height="27" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td background="<%=vr%>images/ap_index_title.jpg" alt="�ƪ��ιϥ�">
						�@�@<span class="title">SCD201R_�C�L�Ǥ��ҩ���</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���D�e������ -->
		<td align=left nowrap>
			<div id="page">
				<font color=purple><b>�@�@�{�������G</b></font><br>
				<font color=purple><b>�@�@�@�@�@�@�B��ť�ͤ��}��d�ߦC�L�C</b></font><br>
				<font color=red><b>�@�@�@�@�@�G�B���Ǵ��u���Z��[�Ǥ��ҩ��ѡv�|�������s�o�e�A���}��ɵo�C�L�C</b></font>
			</div>
		</td>
<script>
	document.write ("<font color=\"white\">" + document.lastModified + "</font>");
	window.attachEvent("onload", page_init);
	window.attachEvent("onload", onloadEvent);
	window.attachEvent("onload",setDefault);

	function setDefault()
	{
		document.forms["QUERY"].AYEAR.value = "<%=AYEAR%>";
		document.forms["QUERY"].SMS.value = "<%=SMS%>";
		document.forms["QUERY"].GCD.value = "<%=GCD%>";
	}

</script>
</body>
</html>