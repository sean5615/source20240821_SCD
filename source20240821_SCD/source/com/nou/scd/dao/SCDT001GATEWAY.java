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
 * Author    : 國長      2007/05/04
 * Modification Log :
 * Vers     Date           By             Notes
 *--------- -------------- -------------- ----------------------------------------
 * V0.0.1   2007/05/04     國長           建立程式
 *                                        新增 getScdt001ForUse(Hashtable ht)
 * V0.0.2   2007/05/21     國長           新增 getScdt001ForCht(Hashtable ht)
 *                                             ckeckReexamDate(String ASYS, String AYEAR, String SMS, String DATE, String MARK_TYPE)
 *--------------------------------------------------------------------------------
 * V0.0.1   2007/06/22     north           建立程式
 *                                        新增 isPassPeplMk(String AYEAR, String SMS)
 *			目的:判斷該表中,註記是否為Y
 **--------------------------------------------------------------------------------
 *
 */
public class SCDT001GATEWAY {

	/** 資料排序方式 */
	private String orderBy = "";

	private DBManager dbmanager = null;

	private Connection conn = null;

	/* 頁數 */
	private int pageNo = 0;

	/** 每頁筆數 */
	private int pageSize = 0;

	/** 記錄是否分頁 */
	private boolean pageQuery = false;

	/** 用來存放 SQL 語法的物件 */
	private StringBuffer sql = new StringBuffer();

	/**
	 * <pre>
	 *  設定資料排序方式.
	 *  Ex: &quot;AYEAR, SMS DESC&quot;
	 *      先以 AYEAR 排序再以 SMS 倒序序排序
	 * </pre>
	 */
	public void setOrderBy(String orderBy) {
		if (orderBy == null) {
			orderBy = "";
		}
		this.orderBy = orderBy;
	}

	/** 取得總筆數 */
	public int getTotalRowCount() {
		return Page.getTotalRowCount();
	}

	/** 不允許建立空的物件 */
	private SCDT001GATEWAY() {
	}

	/** 建構子，查詢全部資料用 */
	public SCDT001GATEWAY(DBManager dbmanager, Connection conn) {
		this.dbmanager = dbmanager;
		this.conn = conn;
	}

	/** 建構子，查詢分頁資料用 */
	public SCDT001GATEWAY(DBManager dbmanager, Connection conn, int pageNo,
			int pageSize) {
		this.dbmanager = dbmanager;
		this.conn = conn;
		this.pageNo = pageNo;
		this.pageSize = pageSize;
		pageQuery = true;
	}

	/**
	 * 設定成續參數
	 *
	 * @param ht
	 *            條件值
	 * @return 回傳 Vector 物件，內容為 Hashtable 的集合，<br>
	 *         每一個 Hashtable 其 KEY 為欄位名稱，KEY 的值為欄位的值<br>
	 *         若該欄位有中文名稱，則其 KEY 請加上 _NAME, EX: SMS 其中文欄位請設為 SMS_NAME
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
                ", SUBSTR(S01.TCH_MID_SDATE,1,4)||'年'||SUBSTR(S01.TCH_MID_SDATE,5,2)||'月'||SUBSTR(S01.TCH_MID_SDATE,7,2)||'日' AS CTCH_MID_SDATE " +
                ", SUBSTR(S01.TCH_MID_EDATE,1,4)||'年'||SUBSTR(S01.TCH_MID_EDATE,5,2)||'月'||SUBSTR(S01.TCH_MID_EDATE,7,2)||'日' AS CTCH_MID_EDATE " +
                ", SUBSTR(S01.TCH_FNL_SDATE,1,4)||'年'||SUBSTR(S01.TCH_FNL_SDATE,5,2)||'月'||SUBSTR(S01.TCH_FNL_SDATE,7,2)||'日' AS CTCH_FNL_SDATE " +
                ", SUBSTR(S01.TCH_FNL_EDATE,1,4)||'年'||SUBSTR(S01.TCH_FNL_EDATE,5,2)||'月'||SUBSTR(S01.TCH_FNL_EDATE,7,2)||'日' AS CTCH_FNL_EDATE " +
                ", SUBSTR(S01.TCH_GMARK_SDATE,1,4)||'年'||SUBSTR(S01.TCH_GMARK_SDATE,5,2)||'月'||SUBSTR(S01.TCH_GMARK_SDATE,7,2)||'日' AS CTCH_GMARK_SDATE " +
                ", SUBSTR(S01.TCH_GMARK_EDATE,1,4)||'年'||SUBSTR(S01.TCH_GMARK_EDATE,5,2)||'月'||SUBSTR(S01.TCH_GMARK_EDATE,7,2)||'日' AS CTCH_GMARK_EDATE " +
                ", SUBSTR(S01.PNT_SCD201R_DATE,1,4)||'年'||SUBSTR(S01.PNT_SCD201R_DATE,5,2)||'月'||SUBSTR(S01.PNT_SCD201R_DATE,7,2)||'日' AS CPNT_SCD201R_DATE " +
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
				// 依分頁取出資料
				rs = Page.getPageResultSet(dbmanager, conn, sql.toString(),
						pageNo, pageSize);
			} else {
				// 取出所有資料
				rs = dbmanager.getSimpleResultSet(conn);
				rs.open();
				rs.executeQuery(sql.toString());
			}
			Hashtable rowHt = null;
			while (rs.next()) {
				rowHt = new Hashtable();
				/** 將欄位抄一份過去 */
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
	 * 設定成績參數，帶出中文
	 *
	 * @param ht
	 *            條件值
	 * @return 回傳 Vector 物件，內容為 Hashtable 的集合，<br>
	 *         每一個 Hashtable 其 KEY 為欄位名稱，KEY 的值為欄位的值<br>
	 *         <UL>
	 *         <UI>ASYS_NAME 學制中文</UI> <UI>SMS_NAME 學期中文</UI>
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
				// 依分頁取出資料
				rs = Page.getPageResultSet(dbmanager, conn, sql.toString(),
						pageNo, pageSize);
			} else {
				// 取出所有資料
				rs = dbmanager.getSimpleResultSet(conn);
				rs.open();
				rs.executeQuery(sql.toString());
			}
			Hashtable rowHt = null;
			while (rs.next()) {
				rowHt = new Hashtable();
				/** 將欄位抄一份過去 */
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
	 * 查詢是否為成績複查日
	 *
	 * @param ASYS
	 *            學制
	 * @param AYEAR
	 *            學年
	 * @param SMS
	 *            學期
	 * @param DATE
	 *            西元年月日(ex:20070521)
	 * @param MARK_TYPE
	 *            考試別(1.平時成績 2.期中成績 3.期未成績)
	 * @throws Exception
	 * @return true:該日期為成績複查日 false:該日期非成績複查日
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
				// 平時成績複查日
				sql
						.append("SELECT * FROM SCDT001 WHERE '"
								+ DATE
								+ "' BETWEEN GMARK_REEXAM_SDATE AND GMARK_REEXAM_EDATE AND AYEAR ='"+AYEAR+"' AND SMS ='"+SMS+"' ");
			} else if (MARK_TYPE.equals("2")) {
				// 期中成績複查日
				sql.append("SELECT * FROM SCDT001 WHERE '" + DATE
						+ "' BETWEEN MID_REEXAM_SDATE AND MID_REEXAM_EDATE AND AYEAR ='"+AYEAR+"' AND SMS ='"+SMS+"' ");
			} else if (MARK_TYPE.equals("3")) {
				// 期未成績複查日
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
					// 依分頁取出資料
					rs = Page.getPageResultSet(dbmanager, conn, sql.toString(),
							pageNo, pageSize);
				} else {
					// 取出所有資料
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
	 * 查詢該表中,在特定的學年與學期下,所有學制的已修已抵註解是否均為Y
	 *
	 * @param ASYS
	 *            學制
	 * @param SMS
	 *            學期
	 */
	public boolean isPassPeplMk(String AYEAR, String SMS) throws Exception {
		boolean result = false;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT PASS_REPL_MK FROM SCDT001 WHERE AYEAR=" + AYEAR
				+ " AND SMS=" + SMS);

		DBResult rs = null;
		try {
			if (pageQuery) {
				// 依分頁取出資料
				rs = Page.getPageResultSet(dbmanager, conn, sql.toString(),
						pageNo, pageSize);
			} else {
				// 取出所有資料
				rs = dbmanager.getSimpleResultSet(conn);
				rs.open();
				rs.executeQuery(sql.toString());
			}

			// 記數用,判斷Y的次數是否和所query的筆數相同,相同時result才為true
			int count = 0;
			// 判斷全部的值是否均為Y
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