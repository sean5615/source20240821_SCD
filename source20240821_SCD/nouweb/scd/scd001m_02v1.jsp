<%/*
----------------------------------------------------------------------------------
File Name		: scd001m_02v1
Author			: matt
Description		: �]�w���Z�Ѽ� - �s����ܭ���
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
		<p>�z���s�������䴩JavaScript�y�k�A���O�ä��v�T�z��������������e</p>
	</noscript>
</head>
<body background="<%=vr%>images/ap_index_bg.jpg" alt="�I����" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- ���D�e���_�l -->
<table width="96%" border="0" align="center" cellpadding="4" cellspacing="0" summary="�ƪ��Ϊ��">
	<tr>
		<td>
			<table width="500" height="27" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td background="<%=vr%>images/ap_index_title.jpg" alt="�ƪ��ιϥ�">
						�@�@<span class="title">SCD001M_ �]�w���Z�Ѽ�</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���D�e������ -->

<!-- �w�q�s�誺 Form �_�l -->
<form name="EDIT" method="post" onsubmit="doSave();" style="margin:5,0,0,0;">
	<input type=hidden name="control_type">
	<input type=hidden name="ROWSTAMP">
	<input type=hidden name=CENTER_CODE>	
	<input type=hidden name="ASYS">

	<!-- �s����e���_�l -->
	<TABLE id="EDIT_DIV" width="96%" border="0" align="center" cellpadding="0" cellspacing="0" summary="�ƪ��Ϊ��">
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_index_mtb_01.gif" alt="�ƪ��ιϥ�" width="13" height="14"></td>
			<td width="100%"><img src="<%=vr%>images/ap_index_mtb_02.gif" alt="�ƪ��ιϥ�" width="100%" height="14"></td>
			<td width="13"><img src="<%=vr%>images/ap_index_mtb_03.gif" alt="�ƪ��ιϥ�" width="13" height="14"></td>
		</tr>
		<tr>
			<td width="13" background="<%=vr%>images/ap_index_mtb_04.gif" alt="�ƪ��ιϥ�">&nbsp;</td>
			<td width="100%" valign="top" bgcolor="#FFFFFF">
				<!-- ���s�e���_�l -->
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="�ƪ��Ϊ��">
					<tr class="mtbGreenBg">
						<td align=left>�i�s��e���j- <span id='EditStatus'>�s�W</span></td>
						<td align=right>
							<div id="edit_btn">
								<input type=button class="btn" value='���ɧ@�~�Z���ˮ֧�s' onkeypress='updClass();'onclick='updClass();'>
								<input type=button class="btn" value='�^�d�߭�' onkeypress='doBack();'onclick='doBack();'>

								<input type=button class="btn" value='�M  ��' onkeypress='doClear_();'onclick='doClear_();'>
								<input type=submit name="SAVE_BTN" class="btn" value='�s  ��'>
							</div>
						</td>
					</tr>
				</table>
				<!-- ���s�e������ -->

				<!-- �s��e���_�l -->
				<table id="table2" width="100%" border="0" align="center" cellpadding="2" cellspacing="0" summary="�ƪ��Ϊ��">
					<tr>
						<td align='right' class='tdgl1'>�Ǧ~��<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='AYEAR'>
							<select name='SMS'>
								<option value=''>�п��</option>
								<script>Form.getSelectFromPhrase("SYST001_01_SELECT", "KIND", "SMS");</script>
							</select>
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>�W�U�Ǵ������i�G���Ҭd���Z<font color=red></font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='REMID_MARK'>��
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>�Юv���ɦ��Z�n���_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='TCH_GMARK_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_GMARK_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_GMARK_SDATE"));'>�@��@
							<input type=text name='TCH_GMARK_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_GMARK_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_GMARK_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td class=tdgl2 colspan=2 >�H�Z���q�G</td>
					</tr>					
					<tr>
						<td align='right' class='tdgl2'>�Юv�������Z�n���_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='TCH_MID_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_MID_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_MID_SDATE"));'>�@��@
							<input type=text name='TCH_MID_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_MID_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_MID_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>�Юv�������Z�n���_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='TCH_FNL_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_FNL_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_FNL_SDATE"));'>�@��@
							<input type=text name='TCH_FNL_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "TCH_FNL_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "TCH_FNL_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>�����G�����Z�Ҭd�n���_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='REMID_REEXAM_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "REMID_REEXAM_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "REMID_REEXAM_SDATE"));'>�@��@
							<input type=text name='REMID_REEXAM_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "REMID_REEXAM_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "REMID_REEXAM_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					<!--
					<tr>
						<td align='right' class='tdgl2'>���ߥ��ɦ��Z�n���_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='CENTER_GMARK_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_GMARK_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_GMARK_SDATE"));'>�@��@
							<input type=text name='CENTER_GMARK_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_GMARK_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_GMARK_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>					
					<tr>
						<td align='right' class='tdgl1'>���ߴ������Z�n���_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='CENTER_MID_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_MID_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_MID_SDATE"));'>�@��@
							<input type=text name='CENTER_MID_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_MID_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_MID_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>���ߴ������Z�n���_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='CENTER_FNL_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_FNL_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_FNL_SDATE"));'>�@��@
							<input type=text name='CENTER_FNL_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_FNL_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_FNL_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					-->
					<tr><td class=tdgl1 colspan=2>�������q�G</td></tr>
					<tr>
						<td align='right' class='tdgl2'>�������Z�n���_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='MID_KEYIN_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "MID_KEYIN_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "MID_KEYIN_SDATE"));'>�@��@
							<input type=text name='MID_KEYIN_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "MID_KEYIN_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "MID_KEYIN_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>�������Z�n���_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='FNL_KEYIN_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "FNL_KEYIN_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "FNL_KEYIN_SDATE"));'>�@��@
							<input type=text name='FNL_KEYIN_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "FNL_KEYIN_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "FNL_KEYIN_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>���ߴ����G�����Z�Ҭd�n���_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='CENTER_REMID_REEXAM_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_REMID_REEXAM_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_REMID_REEXAM_SDATE"));'>�@��@
							<input type=text name='CENTER_REMID_REEXAM_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "CENTER_REMID_REEXAM_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "CENTER_REMID_REEXAM_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					<tr><td class=tdgl2 colspan=2>��L�����]�w�G</td></tr>
					<tr>
						<td align='right' class='tdgl1'>�������Z���G���<font color=red>��</font>�G</td>
						<td class='tdGrayLight'><input type=text name='MID_ANNO_DATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "MID_ANNO_DATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "MID_ANNO_DATE"));'>����榡(yyyyddmm)</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>�������Z���G���<font color=red>��</font>�G</td>
						<td class='tdGrayLight'><input type=text name='FNL_ANNO_DATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "FNL_ANNO_DATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "FNL_ANNO_DATE"));'>����榡(yyyyddmm)</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>�}��ǥͤ��^�妨�Z��C�L�_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='STU_PNT_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "STU_PNT_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "STU_PNT_SDATE"));'>�@��@
							<input type=text name='STU_PNT_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "STU_PNT_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "STU_PNT_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>					
					<tr>
						<td align='right' class='tdgl1'>�]�w���Z���q��v<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							���ɡG<input type=text name='GMARK_RATE'> �H�@&nbsp;
							�����G<input type=text name='MID_RATE'>�H�@&nbsp;
							�����G<input type=text name='FNL_RATE'>�H
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>���ɦ��Z���q����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
						<!-- <input type=text name='GMARK_EVAL_TIMES'> -->
							<select name='GMARK_EVAL_TIMES' id='gmark_eval_times'>
								<option value='2'>2�����q</option>
								<option value='3'>3�����q</option>
						</td>
						
					</tr>
					<tr>
						<td align='right' class='tdgl1'>��w�wĵ�Ѽ�<font color=red>��</font>�G</td>
						<td class='tdGrayLight'><input type=text name='LOCK_WARN_DAYS'>��</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>���ɦ��Z�Ƭd�_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='GMARK_REEXAM_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "GMARK_REEXAM_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "GMARK_REEXAM_SDATE"));'>�@��@
							<input type=text name='GMARK_REEXAM_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "GMARK_REEXAM_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "GMARK_REEXAM_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>�����Ҧ��Z�Ƭd�_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='MID_REEXAM_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "MID_REEXAM_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "MID_REEXAM_SDATE"));'>�@��@
							<input type=text name='MID_REEXAM_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "MID_REEXAM_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "MID_REEXAM_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>�����Ҧ��Z�Ƭd�_����<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='FNL_REEXAM_SDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "FNL_REEXAM_SDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "FNL_REEXAM_SDATE"));'>�@��@
							<input type=text name='FNL_REEXAM_EDATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "FNL_REEXAM_EDATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "FNL_REEXAM_EDATE"));'>
							����榡(yyyyddmm)
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>�Ƭd����O(�C��)<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<input type=text name='REEXAM_FEE'>
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl2'>�ӽЪ���<font color=red>��</font>�G</td>
						<td class='tdGrayLight'>
							<textarea rows=2 cols=50 name='REEXAM_APP_PRT_EXPL'></textarea>
						</td>
					</tr>
					<tr>
						<td align='right' class='tdgl1'>�}��C�L�ɵo��Ǵ��Ǥ��ҩ��Ѥ��<font color=red>��</font>�G</td>
						<td class='tdGrayLight'><input type=text name='PNT_SCD201R_DATE'><img src='/images/calendar.gif' alt='���ϥ� 'style='cursor:hand' onkeypress='Calendar.showCalendar(this, _i("EDIT", "PNT_SCD201R_DATE"));'onclick='Calendar.showCalendar(this, _i("EDIT", "PNT_SCD201R_DATE"));'>����榡(yyyyddmm)</td>
					</tr>
				</table>
				<!-- �s��e������ -->
			</td>
			<td width="13" background="<%=vr%>images/ap_index_mtb_06.gif" alt="�ƪ��ιϥ�">&nbsp;</td>
		</tr>
		<tr>
			<td width="13"><img src="<%=vr%>images/ap_index_mtb_07.gif" alt="�ƪ��ιϥ�" width="13" height="15"></td>
			<td width="100%"><img src="<%=vr%>images/ap_index_mtb_08.gif" alt="�ƪ��ιϥ�" width="100%" height="15"></td>
			<td width="13"><img src="<%=vr%>images/ap_index_mtb_09.gif" alt="�ƪ��ιϥ�" width="13" height="15"></td>
		</tr>
	</table>
	<!-- �s����e������ -->
</form>
<!-- �w�q�s�誺 Form ���� -->

<script>
	var ayear = "<%=ayear%>";
	var sms = "<%=sms%>";
	document.write ("<font color=\"white\">" + document.lastModified + "</font>");
	window.attachEvent("onload", page_init);
	window.attachEvent("onload", onloadEvent);
</script>
</body>
</html>