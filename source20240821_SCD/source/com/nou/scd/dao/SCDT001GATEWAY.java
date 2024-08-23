package com.nou.scd.dao;

import com.acer.db.DBManager;
import com.acer.db.query.DBResult;
import com.acer.util.Utility;
import com.acer.apps.Page;

import java.sql.Connection;
import java.util.Vector;
import java.util.Hashtable;

/*
 * (SCDT001) Gateway/*
 *-------------------------------------------------------------------------------*
 * Author    : ���      2007/05/04
 * Modification Log :
 * Vers     Date           By             Notes
 *--------- -------------- -------------- ----------------------------------------
 * V0.0.1   2007/05/04     ���           �إߵ{��
 *                                        �s�W getScdt001ForUse(Hashtable ht)
 * V0.0.2   2007/05/21     ���           �s�W getScdt001ForCht(Hashtable ht)
 *                                             ckeckReexamDate(String ASYS, String AYEAR, String SMS, String DATE, String MARK_TYPE)
 *--------------------------------------------------------------------------------
 * V0.0.1   2007/06/22     north           �إߵ{��
 *                                        �s�W isPassPeplMk(String AYEAR, String SMS)
 *			�ت�:�P�_�Ӫ�,���O�O�_��Y
 **--------------------------------------------------------------------------------
 *
 */
public class SCDT001GATEWAY {

	/** ��ƱƧǤ覡 */
	private String orderBy = "";

	private DBManager dbmanager = null;

	private Connection conn = null;

	/* ���� */
	private int pageNo = 0;

	/** �C������ */
	private int pageSize = 0;

	/** �O���O�_���� */
	private boolean pageQuery = false;

	/** �ΨӦs�� SQL �y�k������ */
	private StringBuffer sql = new StringBuffer();

	/**
	 * <pre>
	 *  �]�w��ƱƧǤ覡.
	 *  Ex: &quot;AYEAR, SMS DESC&quot;
	 *      ���H AYEAR �ƧǦA�H SMS �˧ǧǱƧ�
	 * </pre>
	 */
	public void setOrderBy(String orderBy) {
		if (orderBy == null) {
			orderBy = "";
		}
		this.orderBy = orderBy;
	}

	/** ���o�`���� */
	public int getTotalRowCount() {
		return Page.getTotalRowCount();
	}

	/** �����\�إߪŪ����� */
	private SCDT001GATEWAY() {
	}

	/** �غc�l�A�d�ߥ�����ƥ� */
	public SCDT001GATEWAY(DBManager dbmanager, Connection conn) {
		this.dbmanager = dbmanager;
		this.conn = conn;
	}

	/** �غc�l�A�d�ߤ�����ƥ� */
	public SCDT001GATEWAY(DBManager dbmanager, Connection conn, int pageNo,
			int pageSize) {
		this.dbmanager = dbmanager;
		this.conn = conn;
		this.pageNo = pageNo;
		this.pageSize = pageSize;
		pageQuery = true;
	}

	/**
	 * �]�w����Ѽ�
	 *
	 * @param ht
	 *            �����
	 * @return �^�� Vector ����A���e�� Hashtable �����X�A<br>
	 *         �C�@�� Hashtable �� KEY �����W�١AKEY ���Ȭ���쪺��<br>
	 *         �Y����즳����W�١A�h�� KEY �Х[�W _NAME, EX: SMS �䤤�����г]�� SMS_NAME
	 * @throws Exception
	 */
	public Vector getScdt001ForUse(Hashtable ht) throws Exception {
		if (ht == null) {
			ht = new Hashtable();
		}
		Vector result = new Vector();
		if (sql.length() > 0) {
			sql.delete(0, sql.length());
		}
		sql.append(
                "SELECT S01.*  " +
                ", SUBSTR(S01.TCH_MID_SDATE,1,4)||'�~'||SUBSTR(S01.TCH_MID_SDATE,5,2)||'��'||SUBSTR(S01.TCH_MID_SDATE,7,2)||'��' AS CTCH_MID_SDATE " +
                ", SUBSTR(S01.TCH_MID_EDATE,1,4)||'�~'||SUBSTR(S01.TCH_MID_EDATE,5,2)||'��'||SUBSTR(S01.TCH_MID_EDATE,7,2)||'��' AS CTCH_MID_EDATE " +
                ", SUBSTR(S01.TCH_FNL_SDATE,1,4)||'�~'||SUBSTR(S01.TCH_FNL_SDATE,5,2)||'��'||SUBSTR(S01.TCH_FNL_SDATE,7,2)||'��' AS CTCH_FNL_SDATE " +
                ", SUBSTR(S01.TCH_FNL_EDATE,1,4)||'�~'||SUBSTR(S01.TCH_FNL_EDATE,5,2)||'��'||SUBSTR(S01.TCH_FNL_EDATE,7,2)||'��' AS CTCH_FNL_EDATE " +
                ", SUBSTR(S01.TCH_GMARK_SDATE,1,4)||'�~'||SUBSTR(S01.TCH_GMARK_SDATE,5,2)||'��'||SUBSTR(S01.TCH_GMARK_SDATE,7,2)||'��' AS CTCH_GMARK_SDATE " +
                ", SUBSTR(S01.TCH_GMARK_EDATE,1,4)||'�~'||SUBSTR(S01.TCH_GMARK_EDATE,5,2)||'��'||SUBSTR(S01.TCH_GMARK_EDATE,7,2)||'��' AS CTCH_GMARK_EDATE " +
                ", SUBSTR(S01.PNT_SCD201R_DATE,1,4)||'�~'||SUBSTR(S01.PNT_SCD201R_DATE,5,2)||'��'||SUBSTR(S01.PNT_SCD201R_DATE,7,2)||'��' AS CPNT_SCD201R_DATE " +
                "FROM SCDT001 S01 " +
                "WHERE 1 = 1 "
        );
		if (!Utility.nullToSpace(ht.get("ASYS")).equals("")) {
			sql.append("AND S01.ASYS = '" + Utility.nullToSpace(ht.get("ASYS"))
					+ "' ");
		}
		if (!Utility.nullToSpace(ht.get("AYEAR")).equals("")) {
			sql.append("AND S01.AYEAR = '"
					+ Utility.nullToSpace(ht.get("AYEAR")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("SMS")).equals("")) {
			sql.append("AND S01.SMS = '" + Utility.nullToSpace(ht.get("SMS"))
					+ "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_KEYIN_SDATE")).equals("")) {
			sql.append("AND S01.MID_KEYIN_SDATE = '"
					+ Utility.nullToSpace(ht.get("MID_KEYIN_SDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_KEYIN_EDATE")).equals("")) {
			sql.append("AND S01.MID_KEYIN_EDATE = '"
					+ Utility.nullToSpace(ht.get("MID_KEYIN_EDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_KEYIN_SDATE")).equals("")) {
			sql.append("AND S01.FNL_KEYIN_SDATE = '"
					+ Utility.nullToSpace(ht.get("FNL_KEYIN_SDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_KEYIN_EDATE")).equals("")) {
			sql.append("AND S01.FNL_KEYIN_EDATE = '"
					+ Utility.nullToSpace(ht.get("FNL_KEYIN_EDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_ANNO_DATE")).equals("")) {
			sql.append("AND S01.MID_ANNO_DATE = '"
					+ Utility.nullToSpace(ht.get("MID_ANNO_DATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_ANNO_DATE")).equals("")) {
			sql.append("AND S01.FNL_ANNO_DATE = '"
					+ Utility.nullToSpace(ht.get("FNL_ANNO_DATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("GMARK_EVAL_TIMES")).equals("")) {
			sql.append("AND S01.GMARK_EVAL_TIMES = '"
					+ Utility.nullToSpace(ht.get("GMARK_EVAL_TIMES")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("LOCK_WARN_DAYS")).equals("")) {
			sql.append("AND S01.LOCK_WARN_DAYS = '"
					+ Utility.nullToSpace(ht.get("LOCK_WARN_DAYS")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("GMARK_REEXAM_SDATE")).equals("")) {
			sql.append("AND S01.GMARK_REEXAM_SDATE = '"
					+ Utility.nullToSpace(ht.get("GMARK_REEXAM_SDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("GMARK_REEXAM_EDATE")).equals("")) {
			sql.append("AND S01.GMARK_REEXAM_EDATE = '"
					+ Utility.nullToSpace(ht.get("GMARK_REEXAM_EDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_REEXAM_SDATE")).equals("")) {
			sql.append("AND S01.MID_REEXAM_SDATE = '"
					+ Utility.nullToSpace(ht.get("MID_REEXAM_SDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_REEXAM_EDATE")).equals("")) {
			sql.append("AND S01.MID_REEXAM_EDATE = '"
					+ Utility.nullToSpace(ht.get("MID_REEXAM_EDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_REEXAM_SDATE")).equals("")) {
			sql.append("AND S01.FNL_REEXAM_SDATE = '"
					+ Utility.nullToSpace(ht.get("FNL_REEXAM_SDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_REEXAM_EDATE")).equals("")) {
			sql.append("AND S01.FNL_REEXAM_EDATE = '"
					+ Utility.nullToSpace(ht.get("FNL_REEXAM_EDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("REEXAM_FEE")).equals("")) {
			sql.append("AND S01.REEXAM_FEE = '"
					+ Utility.nullToSpace(ht.get("REEXAM_FEE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("REEXAM_APP_PRT_EXPL")).equals("")) {
			sql
					.append("AND S01.REEXAM_APP_PRT_EXPL = '"
							+ Utility
									.nullToSpace(ht.get("REEXAM_APP_PRT_EXPL"))
							+ "' ");
		}
		if (!Utility.nullToSpace(ht.get("MIDMARK_COMPAR_MK")).equals("")) {
			sql.append("AND S01.MIDMARK_COMPAR_MK = '"
					+ Utility.nullToSpace(ht.get("MIDMARK_COMPAR_MK")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNLMARK_COMPAR_MK")).equals("")) {
			sql.append("AND S01.FNLMARK_COMPAR_MK = '"
					+ Utility.nullToSpace(ht.get("FNLMARK_COMPAR_MK")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("GMARK_RATE")).equals("")) {
			sql.append("AND S01.GMARK_RATE = '"
					+ Utility.nullToSpace(ht.get("GMARK_RATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_RATE")).equals("")) {
			sql.append("AND S01.MID_RATE = '"
					+ Utility.nullToSpace(ht.get("MID_RATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_RATE")).equals("")) {
			sql.append("AND S01.FNL_RATE = '"
					+ Utility.nullToSpace(ht.get("FNL_RATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("PNT_SCD201R_DATE")).equals("")) {
			sql.append("AND S01.PNT_SCD201R_DATE = '"
					+ Utility.nullToSpace(ht.get("PNT_SCD201R_DATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("UPD_DATE")).equals("")) {
			sql.append("AND S01.UPD_DATE = '"
					+ Utility.nullToSpace(ht.get("UPD_DATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("UPD_TIME")).equals("")) {
			sql.append("AND S01.UPD_TIME = '"
					+ Utility.nullToSpace(ht.get("UPD_TIME")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("UPD_USER_ID")).equals("")) {
			sql.append("AND S01.UPD_USER_ID = '"
					+ Utility.nullToSpace(ht.get("UPD_USER_ID")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("ROWSTAMP")).equals("")) {
			sql.append("AND S01.ROWSTAMP = '"
					+ Utility.nullToSpace(ht.get("ROWSTAMP")) + "' ");
		}

		if (!orderBy.equals("")) {
			String[] orderByArray = orderBy.split(",");
			orderBy = "";
			for (int i = 0; i < orderByArray.length; i++) {
				orderByArray[i] = "S01." + orderByArray[i].trim();

				if (i == 0) {
					orderBy += "ORDER BY ";
				} else {
					orderBy += ", ";
				}
				orderBy += orderByArray[i].trim();
			}
			sql.append(orderBy.toUpperCase());
			orderBy = "";
		}

		DBResult rs = null;
		try {
			if (pageQuery) {
				// �̤������X���
				rs = Page.getPageResultSet(dbmanager, conn, sql.toString(),
						pageNo, pageSize);
			} else {
				// ���X�Ҧ����
				rs = dbmanager.getSimpleResultSet(conn);
				rs.open();
				rs.executeQuery(sql.toString());
			}
			Hashtable rowHt = null;
			while (rs.next()) {
				rowHt = new Hashtable();
				/** �N���ۤ@���L�h */
				for (int i = 1; i <= rs.getColumnCount(); i++)
					rowHt.put(rs.getColumnName(i), rs.getString(i));

				result.add(rowHt);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			if (rs != null) {
				rs.close();
			}
		}
		return result;
	}

	/**
	 * �]�w���Z�ѼơA�a�X����
	 *
	 * @param ht
	 *            �����
	 * @return �^�� Vector ����A���e�� Hashtable �����X�A<br>
	 *         �C�@�� Hashtable �� KEY �����W�١AKEY ���Ȭ���쪺��<br>
	 *         <UL>
	 *         <UI>ASYS_NAME �Ǩ��</UI> <UI>SMS_NAME �Ǵ�����</UI>
	 *         </UL>
	 * @throws Exception
	 */
	public Vector getScdt001ForCht(Hashtable ht) throws Exception {
		if (ht == null) {
			ht = new Hashtable();
		}
		Vector result = new Vector();
		if (sql.length() > 0) {
			sql.delete(0, sql.length());
		}
		sql
				.append("SELECT S01.ASYS, S01.AYEAR, S01.SMS, S01.MID_KEYIN_SDATE, S01.MID_KEYIN_EDATE, S01.FNL_KEYIN_SDATE, S01.FNL_KEYIN_EDATE, S01.MID_ANNO_DATE, S01.FNL_ANNO_DATE, S01.GMARK_EVAL_TIMES, S01.LOCK_WARN_DAYS, S01.GMARK_REEXAM_SDATE, S01.GMARK_REEXAM_EDATE, S01.MID_REEXAM_SDATE, S01.MID_REEXAM_EDATE, S01.FNL_REEXAM_SDATE, S01.FNL_REEXAM_EDATE, S01.REEXAM_FEE, S01.REEXAM_APP_PRT_EXPL, S01.MIDMARK_COMPAR_MK, S01.FNLMARK_COMPAR_MK, S01.GMARK_RATE, S01.MID_RATE, S01.FNL_RATE, S01.UPD_DATE, S01.UPD_TIME, S01.UPD_USER_ID, S01.ROWSTAMP, "
						+ "S1.ASYS_NAME, S2.SMS_NAME,S01.CENTER_REMID_REEXAM_SDATE,S01.CENTER_REMID_REEXAM_EDATE,REMID_MARK,STU_PNT_SDATE,STU_PNT_EDATE,PNT_SCD201R_DATE "
						+ "FROM SCDT001 S01, "
						+ "(SELECT CODE, CODE_NAME AS ASYS_NAME FROM SYST001 WHERE KIND = 'ASYS') S1, "
						+ "(SELECT CODE, CODE_NAME AS SMS_NAME FROM SYST001 WHERE KIND = 'SMS') S2 "
						+ "WHERE S1.CODE (+)= S01.ASYS AND S2.CODE (+)= S01.SMS ");
		if (!Utility.nullToSpace(ht.get("ASYS")).equals("")) {
			sql.append("AND S01.ASYS = '" + Utility.nullToSpace(ht.get("ASYS"))
					+ "' ");
		}
		if (!Utility.nullToSpace(ht.get("AYEAR")).equals("")) {
			sql.append("AND S01.AYEAR = '"
					+ Utility.nullToSpace(ht.get("AYEAR")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("SMS")).equals("")) {
			sql.append("AND S01.SMS = '" + Utility.nullToSpace(ht.get("SMS"))
					+ "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_KEYIN_SDATE")).equals("")) {
			sql.append("AND S01.MID_KEYIN_SDATE = '"
					+ Utility.nullToSpace(ht.get("MID_KEYIN_SDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_KEYIN_EDATE")).equals("")) {
			sql.append("AND S01.MID_KEYIN_EDATE = '"
					+ Utility.nullToSpace(ht.get("MID_KEYIN_EDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_KEYIN_SDATE")).equals("")) {
			sql.append("AND S01.FNL_KEYIN_SDATE = '"
					+ Utility.nullToSpace(ht.get("FNL_KEYIN_SDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_KEYIN_EDATE")).equals("")) {
			sql.append("AND S01.FNL_KEYIN_EDATE = '"
					+ Utility.nullToSpace(ht.get("FNL_KEYIN_EDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_ANNO_DATE")).equals("")) {
			sql.append("AND S01.MID_ANNO_DATE = '"
					+ Utility.nullToSpace(ht.get("MID_ANNO_DATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_ANNO_DATE")).equals("")) {
			sql.append("AND S01.FNL_ANNO_DATE = '"
					+ Utility.nullToSpace(ht.get("FNL_ANNO_DATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("GMARK_EVAL_TIMES")).equals("")) {
			sql.append("AND S01.GMARK_EVAL_TIMES = '"
					+ Utility.nullToSpace(ht.get("GMARK_EVAL_TIMES")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("LOCK_WARN_DAYS")).equals("")) {
			sql.append("AND S01.LOCK_WARN_DAYS = '"
					+ Utility.nullToSpace(ht.get("LOCK_WARN_DAYS")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("GMARK_REEXAM_SDATE")).equals("")) {
			sql.append("AND S01.GMARK_REEXAM_SDATE = '"
					+ Utility.nullToSpace(ht.get("GMARK_REEXAM_SDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("GMARK_REEXAM_EDATE")).equals("")) {
			sql.append("AND S01.GMARK_REEXAM_EDATE = '"
					+ Utility.nullToSpace(ht.get("GMARK_REEXAM_EDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_REEXAM_SDATE")).equals("")) {
			sql.append("AND S01.MID_REEXAM_SDATE = '"
					+ Utility.nullToSpace(ht.get("MID_REEXAM_SDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_REEXAM_EDATE")).equals("")) {
			sql.append("AND S01.MID_REEXAM_EDATE = '"
					+ Utility.nullToSpace(ht.get("MID_REEXAM_EDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_REEXAM_SDATE")).equals("")) {
			sql.append("AND S01.FNL_REEXAM_SDATE = '"
					+ Utility.nullToSpace(ht.get("FNL_REEXAM_SDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_REEXAM_EDATE")).equals("")) {
			sql.append("AND S01.FNL_REEXAM_EDATE = '"
					+ Utility.nullToSpace(ht.get("FNL_REEXAM_EDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("REEXAM_FEE")).equals("")) {
			sql.append("AND S01.REEXAM_FEE = '"
					+ Utility.nullToSpace(ht.get("REEXAM_FEE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("REEXAM_APP_PRT_EXPL")).equals("")) {
			sql
					.append("AND S01.REEXAM_APP_PRT_EXPL = '"
							+ Utility
									.nullToSpace(ht.get("REEXAM_APP_PRT_EXPL"))
							+ "' ");
		}
		if (!Utility.nullToSpace(ht.get("MIDMARK_COMPAR_MK")).equals("")) {
			sql.append("AND S01.MIDMARK_COMPAR_MK = '"
					+ Utility.nullToSpace(ht.get("MIDMARK_COMPAR_MK")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNLMARK_COMPAR_MK")).equals("")) {
			sql.append("AND S01.FNLMARK_COMPAR_MK = '"
					+ Utility.nullToSpace(ht.get("FNLMARK_COMPAR_MK")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("GMARK_RATE")).equals("")) {
			sql.append("AND S01.GMARK_RATE = '"
					+ Utility.nullToSpace(ht.get("GMARK_RATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("MID_RATE")).equals("")) {
			sql.append("AND S01.MID_RATE = '"
					+ Utility.nullToSpace(ht.get("MID_RATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("FNL_RATE")).equals("")) {
			sql.append("AND S01.FNL_RATE = '"
					+ Utility.nullToSpace(ht.get("FNL_RATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("UPD_DATE")).equals("")) {
			sql.append("AND S01.UPD_DATE = '"
					+ Utility.nullToSpace(ht.get("UPD_DATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("UPD_TIME")).equals("")) {
			sql.append("AND S01.UPD_TIME = '"
					+ Utility.nullToSpace(ht.get("UPD_TIME")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("UPD_USER_ID")).equals("")) {
			sql.append("AND S01.UPD_USER_ID = '"
					+ Utility.nullToSpace(ht.get("UPD_USER_ID")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("ROWSTAMP")).equals("")) {
			sql.append("AND S01.ROWSTAMP = '"
					+ Utility.nullToSpace(ht.get("ROWSTAMP")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("STU_PNT_SDATE")).equals("")) {
			sql.append("AND S01.STU_PNT_SDATE = '"
					+ Utility.nullToSpace(ht.get("STU_PNT_SDATE")) + "' ");
		}
		if (!Utility.nullToSpace(ht.get("STU_PNT_EDATE")).equals("")) {
			sql.append("AND S01.STU_PNT_EDATE = '"
					+ Utility.nullToSpace(ht.get("STU_PNT_EDATE")) + "' ");
		}

		if (!orderBy.equals("")) {
			String[] orderByArray = orderBy.split(",");
			orderBy = "";
			for (int i = 0; i < orderByArray.length; i++) {
				orderByArray[i] = "S01." + orderByArray[i].trim();

				if (i == 0) {
					orderBy += "ORDER BY ";
				} else {
					orderBy += ", ";
				}
				orderBy += orderByArray[i].trim();
			}
			sql.append(orderBy.toUpperCase());
			orderBy = "";
		}

		DBResult rs = null;
		try {
			if (pageQuery) {
				// �̤������X���
				rs = Page.getPageResultSet(dbmanager, conn, sql.toString(),
						pageNo, pageSize);
			} else {
				// ���X�Ҧ����
				rs = dbmanager.getSimpleResultSet(conn);
				rs.open();
				rs.executeQuery(sql.toString());
			}
			Hashtable rowHt = null;
			while (rs.next()) {
				rowHt = new Hashtable();
				/** �N���ۤ@���L�h */
				for (int i = 1; i <= rs.getColumnCount(); i++)
					rowHt.put(rs.getColumnName(i), rs.getString(i));

				result.add(rowHt);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			if (rs != null) {
				rs.close();
			}
		}
		return result;
	}

	/**
	 * �d�߬O�_�����Z�Ƭd��
	 *
	 * @param ASYS
	 *            �Ǩ�
	 * @param AYEAR
	 *            �Ǧ~
	 * @param SMS
	 *            �Ǵ�
	 * @param DATE
	 *            �褸�~���(ex:20070521)
	 * @param MARK_TYPE
	 *            �ҸէO(1.���ɦ��Z 2.�������Z 3.�������Z)
	 * @throws Exception
	 * @return true:�Ӥ�������Z�Ƭd�� false:�Ӥ���D���Z�Ƭd��
	 */
	public boolean ckeckReexamDate(String ASYS, String AYEAR, String SMS,
			String DATE, String MARK_TYPE) throws Exception {
		boolean result = false;
		if (ASYS != null
				&& AYEAR != null
				&& SMS != null
				&& DATE != null
				&& MARK_TYPE != null
				&& (MARK_TYPE.equals("1") || MARK_TYPE.equals("2") || MARK_TYPE
						.equals("3"))) {
			sql.setLength(0);
			if (MARK_TYPE.equals("1")) {
				// ���ɦ��Z�Ƭd��
				sql
						.append("SELECT * FROM SCDT001 WHERE '"
								+ DATE
								+ "' BETWEEN GMARK_REEXAM_SDATE AND GMARK_REEXAM_EDATE AND AYEAR ='"+AYEAR+"' AND SMS ='"+SMS+"' ");
			} else if (MARK_TYPE.equals("2")) {
				// �������Z�Ƭd��
				sql.append("SELECT * FROM SCDT001 WHERE '" + DATE
						+ "' BETWEEN MID_REEXAM_SDATE AND MID_REEXAM_EDATE AND AYEAR ='"+AYEAR+"' AND SMS ='"+SMS+"' ");
			} else if (MARK_TYPE.equals("3")) {
				// �������Z�Ƭd��
				sql.append("SELECT * FROM SCDT001 WHERE '" + DATE
						+ "' BETWEEN FNL_REEXAM_SDATE AND FNL_REEXAM_EDATE AND AYEAR ='"+AYEAR+"' AND SMS ='"+SMS+"' ");
			}

			// DBResult rs = null;
			// try {
			// rs = dbmanager.getSimpleResultSet(conn);
			// rs.open();
			// rs.executeQuery(sql.toString());
			// if(rs.next()) {
			// result = true;
			// }
			// } catch (Exception e) {
			// throw e;
			// } finally {
			// if(rs != null) {
			// rs.close();
			// }
			// }
			DBResult rs = null;
			try {
				if (pageQuery) {
					// �̤������X���
					rs = Page.getPageResultSet(dbmanager, conn, sql.toString(),
							pageNo, pageSize);
				} else {
					// ���X�Ҧ����
					rs = dbmanager.getSimpleResultSet(conn);
					rs.open();
					rs.executeQuery(sql.toString());
				}
				if (rs.next()) {
					result = true;
				}
			} catch (Exception e) {
				throw e;
			} finally {
				if (rs != null) {
					rs.close();
				}
			}
		}
		return result;
	}

	/**
	 * �d�߸Ӫ�,�b�S�w���Ǧ~�P�Ǵ��U,�Ҧ��Ǩ�w�פw����ѬO�_����Y
	 *
	 * @param ASYS
	 *            �Ǩ�
	 * @param SMS
	 *            �Ǵ�
	 */
	public boolean isPassPeplMk(String AYEAR, String SMS) throws Exception {
		boolean result = false;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT PASS_REPL_MK FROM SCDT001 WHERE AYEAR=" + AYEAR
				+ " AND SMS=" + SMS);

		DBResult rs = null;
		try {
			if (pageQuery) {
				// �̤������X���
				rs = Page.getPageResultSet(dbmanager, conn, sql.toString(),
						pageNo, pageSize);
			} else {
				// ���X�Ҧ����
				rs = dbmanager.getSimpleResultSet(conn);
				rs.open();
				rs.executeQuery(sql.toString());
			}

			// �O�ƥ�,�P�_Y�����ƬO�_�M��query�����ƬۦP,�ۦP��result�~��true
			int count = 0;
			// �P�_�������ȬO�_����Y
			while (rs.next()) {
				for (int j = 1; j <= rs.getColumnCount(); j++) {
					if (rs.getString(j).equals("Y")) {
						count++;
					}
				}
			}
			if (count == rs.getColumnCount()) {
				result = true;
			}
		} catch (Exception e) {
			throw e;
		} finally {
			if (rs != null) {
				rs.close();
			}
		}
		return result;
	}
}