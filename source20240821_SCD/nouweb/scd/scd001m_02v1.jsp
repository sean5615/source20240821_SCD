<%/*
----------------------------------------------------------------------------------
File Name		: scd001m_02v1
Author			: matt
Description		: 設定成績參數 - 編輯顯示頁面
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		096/02/09	matt    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/viewpagedbinit.jsp"%>
<%@ page import="com.nou.sys.*"%>
<%
	String ayear = null;
	String sms = null;
	DBManager dbManager = null;
	Connection con = null;
	try {
		dbManager = new DBManager(logger);
		SYSGETSMSDATA sysgetsmsdata = new SYSGETSMSDATA(dbManager);
		sysgetsmsdata.setSYS_DATE(DateUtil.getNowDate());
		sysgetsmsdata.setSMS_TYPE("1");
		int rtn = sysgetsmsdata.execute();

		ayear = sysgetsmsdata.getAYEAR();
		sms = sysgetsmsdata.getSMS();

	} finally {

		if (dbManager != null) dbManager.close();
	}
%>
<html>
<head>
	<script src="<%=vr%>script/framework/query1_2_0_2.jsp"></script>
	<script src="scd001m_02c1.jsp"></script>
	<noscript>
		<p>您的瀏覽器不支援JavaScript語法，但是並不影響您獲取本網站的內容</p>
	</noscript>
</head>
<body background="<%=vr%>images/ap_index_bg.jpg" alt="背景圖" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 標題畫面起始 -->
<table width="96%" border="0" align="center" cellpadding="4" cellspacing="0" summary="排版用表格">
	<tr>
		<td>
			<table width="500" height="27" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td background="<%=vr%>images/ap_index_title.jpg" alt="排版用圖示">
						　　<span class="title">SCD001M_ 設定成績參數</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 標題畫面結束 -->

<!-- 定義編輯的 Form 起始 -->
<form name="EDIT" method="post" onsubmit="doSave();" style="margin:5,0,0,0;">
	<input type=hidden name="control_type">
	<input type=hidden name="ROWSTAMP">
	<input type=hidden name=CENTER_CODE>	
	<input type=hidden name="ASYS">

	<!-- 編輯全畫面起始 -->
	<TABLE id="EDIT_DIV" width="96%" border="0" align="center" cellpadding="0" cellspacing="0" summary="排版用表格">
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_index_mtb_01.gif" alt="排版用圖示" width="13" height="14"></td>
			<td width="100%"><img src="<%=vr%>images/ap_index_mtb_02.gif" alt="排版用圖示" width="100%" height="14"></td>
			<td width="13"><img src="<%=vr%>images/ap_index_mtb_03.gif" alt="排版用圖示" width="13" height="14"></td>
		</tr>
		<tr>
			<td width="13" background="<%=vr%>images/ap_index_mtb_04.gif" alt="排版用圖示">&nbsp;</td>
			<td width="100%" valign="top" bgcolor="#FFFFFF">
				<!-- 按鈕畫面起始 -->
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="排版用表格">
					<tr class="mtbGreenBg">
						<td align=left>【編輯畫面】- <span id='EditStatus'>新增</span></td>
						<td align=right>
							<div id="edit_btn">
								<input type=button class="btn" value='平時作業班級檢核更新' onkeypress='updClass();'onclick='updClass();'>
								<input type=button class="btn" value='回查詢頁' onkeypress='doBack();'onclick='doBack();'>

								<input type=button class="btn" value='清  除' onkeypress='doClear_();'onclick='doClear_();'>
								<input type=submit name="SAVE_BTN" class="btn" value='存  檔'>
							</div>
						</td>
					</tr>
				</table>
				<!-- 按鈕畫面結束 -->

				<!-- 編輯畫面起始 -->
				<table id="table2" width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="排版用表格">
					<tr>
						<td align='right' class='tdgl1'>學年期<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='AYEAR'>
							<select name='SMS'>
								<option value=''>請選擇</option>
								<script>Form.getSelectFromPhrase("SYST001_01_SELECT", "KIND", "SMS");</script>
							</select>
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>上下學期期中可二次考查成績<font color=red></font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='REMID_MARK'>分
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>教師平時成績登打起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='TCH_GMARK_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_GMARK_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_GMARK_SDATE"));'>　～　
							<input type=text name='TCH_GMARK_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_GMARK_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_GMARK_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td class=tdgl2 colspan=2 >隨班評量：</td>
					</tr>					
					<tr>
						<td align='right' class='tdgl2'>教師期中成績登打起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='TCH_MID_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_MID_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_MID_SDATE"));'>　～　
							<input type=text name='TCH_MID_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_MID_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_MID_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>教師期末成績登打起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='TCH_FNL_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_FNL_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_FNL_SDATE"));'>　～　
							<input type=text name='TCH_FNL_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_FNL_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_FNL_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>期中二次成績考查登打起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='REMID_REEXAM_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "REMID_REEXAM_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "REMID_REEXAM_SDATE"));'>　～　
							<input type=text name='REMID_REEXAM_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "REMID_REEXAM_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "REMID_REEXAM_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					<!--
					<tr>
						<td align='right' class='tdgl2'>中心平時成績登打起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='CENTER_GMARK_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_GMARK_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_GMARK_SDATE"));'>　～　
							<input type=text name='CENTER_GMARK_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_GMARK_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_GMARK_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>					
					<tr>
						<td align='right' class='tdgl1'>中心期中成績登打起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='CENTER_MID_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_MID_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_MID_SDATE"));'>　～　
							<input type=text name='CENTER_MID_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_MID_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_MID_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>中心期末成績登打起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='CENTER_FNL_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_FNL_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_FNL_SDATE"));'>　～　
							<input type=text name='CENTER_FNL_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_FNL_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_FNL_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					-->
					<tr><td class=tdgl1 colspan=2>集中評量：</td></tr>
					<tr>
						<td align='right' class='tdgl2'>期中成績登打起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='MID_KEYIN_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "MID_KEYIN_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "MID_KEYIN_SDATE"));'>　～　
							<input type=text name='MID_KEYIN_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "MID_KEYIN_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "MID_KEYIN_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>期末成績登打起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='FNL_KEYIN_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "FNL_KEYIN_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "FNL_KEYIN_SDATE"));'>　～　
							<input type=text name='FNL_KEYIN_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "FNL_KEYIN_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "FNL_KEYIN_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>中心期中二次成績考查登打起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='CENTER_REMID_REEXAM_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_REMID_REEXAM_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_REMID_REEXAM_SDATE"));'>　～　
							<input type=text name='CENTER_REMID_REEXAM_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_REMID_REEXAM_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_REMID_REEXAM_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					<tr><td class=tdgl2 colspan=2>其他相關設定：</td></tr>
					<tr>
						<td align='right' class='tdgl1'>期中成績公佈日期<font color=red>＊</font>：</td>
						<td class='tdGrayLight'><input type=text name='MID_ANNO_DATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "MID_ANNO_DATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "MID_ANNO_DATE"));'>日期格式(yyyyddmm)</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>期末成績公佈日期<font color=red>＊</font>：</td>
						<td class='tdGrayLight'><input type=text name='FNL_ANNO_DATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "FNL_ANNO_DATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "FNL_ANNO_DATE"));'>日期格式(yyyyddmm)</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>開放學生中英文成績單列印起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='STU_PNT_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "STU_PNT_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "STU_PNT_SDATE"));'>　～　
							<input type=text name='STU_PNT_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "STU_PNT_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "STU_PNT_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>					
					<tr>
						<td align='right' class='tdgl1'>設定成績評量比率<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							平時：<input type=text name='GMARK_RATE'> ％　&nbsp;
							期中：<input type=text name='MID_RATE'>％　&nbsp;
							期末：<input type=text name='FNL_RATE'>％
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>平時成績評量次數<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
						<!-- <input type=text name='GMARK_EVAL_TIMES'> -->
							<select name='GMARK_EVAL_TIMES' id='gmark_eval_times'>
								<option value='2'>2次評量</option>
								<option value='3'>3次評量</option>
						</td>
						
					</tr>
					<tr>
						<td align='right' class='tdgl1'>鎖定預警天數<font color=red>＊</font>：</td>
						<td class='tdGrayLight'><input type=text name='LOCK_WARN_DAYS'>天</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>平時成績複查起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='GMARK_REEXAM_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "GMARK_REEXAM_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "GMARK_REEXAM_SDATE"));'>　～　
							<input type=text name='GMARK_REEXAM_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "GMARK_REEXAM_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "GMARK_REEXAM_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>期中考成績複查起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='MID_REEXAM_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "MID_REEXAM_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "MID_REEXAM_SDATE"));'>　～　
							<input type=text name='MID_REEXAM_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "MID_REEXAM_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "MID_REEXAM_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>期末考成績複查起迄日<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='FNL_REEXAM_SDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "FNL_REEXAM_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "FNL_REEXAM_SDATE"));'>　～　
							<input type=text name='FNL_REEXAM_EDATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "FNL_REEXAM_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "FNL_REEXAM_EDATE"));'>
							日期格式(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>複查手續費(每科)<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<input type=text name='REEXAM_FEE'>
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>申請表說明<font color=red>＊</font>：</td>
						<td class='tdGrayLight'>
							<textarea rows=2 cols=50 name='REEXAM_APP_PRT_EXPL'></textarea>
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>開放列印補發當學期學分證明書日期<font color=red>＊</font>：</td>
						<td class='tdGrayLight'><input type=text name='PNT_SCD201R_DATE'><img src='/images/calendar.gif' alt='日曆圖示 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "PNT_SCD201R_DATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "PNT_SCD201R_DATE"));'>日期格式(yyyyddmm)</td>
					</tr>
				</table>
				<!-- 編輯畫面結束 -->
			</td>
			<td width="13" background="<%=vr%>images/ap_index_mtb_06.gif" alt="排版用圖示">&nbsp;</td>
		</tr>
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_index_mtb_07.gif" alt="排版用圖示" width="13" height="15"></td>
			<td width="100%"><img src="<%=vr%>images/ap_index_mtb_08.gif" alt="排版用圖示" width="100%" height="15"></td>
			<td width="13"><img src="<%=vr%>images/ap_index_mtb_09.gif" alt="排版用圖示" width="13" height="15"></td>
		</tr>
	</table>
	<!-- 編輯全畫面結束 -->
</form>
<!-- 定義編輯的 Form 結束 -->

<script>
	var ayear = "<%=ayear%>";
	var sms = "<%=sms%>";
	document.write ("<font color=\"white\">" + document.lastModified + "</font>");
	window.attachEvent("onload", page_init);
	window.attachEvent("onload", onloadEvent);
</script>
</body>
</html>