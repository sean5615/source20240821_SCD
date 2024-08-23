<%/*
----------------------------------------------------------------------------------
File Name		: scd201r_01v1
Author			: sRu
Description		: 列印學分證明書 - 顯示頁面
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
String	ASYS	=	(String)session.getAttribute("ASYS");		//學制

DBManager	dbManager	=	null;
Connection	conn		=	null;
DBResult	rs			=	null;

String AYEAR = "";
String SMS = "";
String GCD = "";

//中心別選項
StringBuffer	CC_option	=	null;

try
{
	dbManager	=	new DBManager(logger);
	com.nou.scd.bo.SCDGETSMSDATA sysgetsmsdata = new com.nou.scd.bo.SCDGETSMSDATA(dbManager);
	sysgetsmsdata.setSYS_DATE(DateUtil.getNowDate());
	sysgetsmsdata.setSMS_TYPE("1");
    GCD = Permision.processPermision(AUTGETRANGE);// 處理權限
    if (GCD == null){
       GCD = "";
    }
	int rtn = sysgetsmsdata.execute();
	AYEAR = sysgetsmsdata.getAYEAR();
	SMS = sysgetsmsdata.getSMS();
	/************中心別權限**************/
	String CENTER_CODE = null;
	String all="";
	Vector dep = null;
	StringBuffer sql = new StringBuffer();
	sql.append(" SELECT A.CODE AS SELECT_VALUE,A.CODE_NAME AS SELECT_TEXT ");
	sql.append(" FROM SYST001 A ");
	sql.append(" WHERE A.KIND = 'CENTER_CODE' AND A.CODE NOT IN('00')");
	/**中心別*/
    //權限別(PRVLG_TP[3.全校])、身份別(ID_TP[3.行政人員])
    dep = AUTGETRANGE.getDEP_CODE("4","3");   
    
	if(dep.size()>0){
		boolean flag = false;
        for(int i=0;i<dep.size();i++){
            //權限別(PRVLG_TP[4.中心])、身份別(ID_TP[3.行政人員])
            dep = AUTGETRANGE.getDEP_CODE("4","3");
            CENTER_CODE = getDepStr(dep);           
        }
		//取得中心別
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
		<p>您的瀏覽器不支援JavaScript語法，但是並不影響您獲取本網站的內容</p>
	</noscript>
</head>
<body background="<%=vr%>images/ap_index_bg.jpg" alt="背景圖" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 定義查詢的 Form 起始 -->
<form name="QUERY" method="post" onsubmit="doQuery();" style="margin:0,0,5,0;">
	<input type=hidden name="control_type">
	<input type=hidden name="ASYS">
	<input type=hidden name="SMS_NAME">
	<input type=hidden name="GCD">
	<input type=hidden name="CENTER_CODE">
	<input type=hidden name="BROWSER_TYPE">
	
	<!-- 查詢全畫面起始 -->
	<TABLE id="QUERY_DIV" width="96%" border="0" align="center" cellpadding="0" cellspacing="0" summary="排版用表格">
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_search_01.jpg" alt="排版用圖示" width="13" height="12"></td>
			<td width="100%"><img src="<%=vr%>images/ap_search_02.jpg" alt="排版用圖示" width="100%" height="12"></td>
			<td width="13"><img src="<%=vr%>images/ap_search_03.jpg" alt="排版用圖示" width="13" height="12"></td>
		</tr>
		<tr>
			<td width="13" background="<%=vr%>images/ap_search_04.jpg" alt="排版用圖示">&nbsp;</td>
			<td width="100%" valign="top" bgcolor="#C5E2C3">
				<!-- 按鈕畫面起始 -->
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="排版用表格">
					<tr class="mtbGreenBg">
						<td align=left>【列印畫面】</td>
						<td align=right>
							<div id="serach_btn">
								<input type=button class="btn" value='清  除' onclick='doReset();setDefault();' onkeypress='doReset();setDefault();'>
								<input type=submit class="btn" name="PRT_ALL_BTN" value='列  印' onclick="printBrowser('o');" onkeypress="printBrowser('o');">
								<input type=submit class="btn" name="PRT_BTN" value='列 印(IE11)' onclick="printBrowser('IE11');" onkeypress="printBrowser('IE11');">
							</div>
						</td>
					</tr>
				</table>			
				<table id="table1" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" summary="排版用表格">
					<tr>
						<td align='right'>學年期<font color=red>＊</font>：</td>
						<td>
							<input type=text name='AYEAR' >
							<select name='SMS' >
								<option value=''>請選擇</option>
								<script>Form.getSelectFromPhrase("SYST001_01_SELECT", "KIND", "SMS");</script>
							</select>
						</td>				
						<td align='right'>學號<font color=red>＊</font>：</td>
						<td colspan='1'><input type=text name='STNO'></td>
						<td align='right'>是否為補發<font color=red>＊</font>：</td>
						<td colspan='1'>
							<select name='BO'>
								<option value=''>請選擇</option>
								<option value='1'>是</option>
								<option value='2' selected>否</option>
							</select>
						</td>
					</tr>
					
				</table>
			</td>
			<td width="13" background="<%=vr%>images/ap_search_06.jpg" alt="排版用圖示">&nbsp;</td>
		</tr>
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_search_07.jpg" alt="排版用圖示" width="13" height="13"></td>
			<td width="100%"><img src="<%=vr%>images/ap_search_08.jpg" alt="排版用圖示" width="100%" height="13"></td>
			<td width="13"><img src="<%=vr%>images/ap_search_09.jpg" alt="排版用圖示" width="13" height="13"></td>
		</tr>
	</table>
	<!-- 查詢全畫面結束 -->
</form>
<!-- 定義查詢的 Form 結束 -->

<!-- 標題畫面起始 -->
<table width="96%" border="0" align="center" cellpadding="4" cellspacing="0" summary="排版用表格">
	<tr>
		<td>
			<table width="500" height="27" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td background="<%=vr%>images/ap_index_title.jpg" alt="排版用圖示">
						　　<span class="title">SCD201R_列印學分證明書</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 標題畫面結束 -->
		<td align=left nowrap>
			<div id="page">
				<font color=purple><b>　　程式說明：</b></font><br>
				<font color=purple><b>　　　　　一、旁聽生不開放查詢列印。</b></font><br>
				<font color=red><b>　　　　　二、本學期「成績單暨學分證明書」尚未正式製發前，不開放補發列印。</b></font>
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