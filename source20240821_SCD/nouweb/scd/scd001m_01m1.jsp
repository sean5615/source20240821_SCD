<%/*
----------------------------------------------------------------------------------
File Name		: scd001m_01m1.jsp
Author			: matt
Description		: 設定成績參數 - 處理邏輯頁面
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		096/02/09	matt    	Code Generate Create
0.0.2		096/09/28	poto        調整欄位問題
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/modulepageinit.jsp"%>
<%@ page import="com.nou.pla.dao.*"%>
<%@ page import="com.nou.pla.bo.*"%>
<%!
/** 處理查詢 Grid 資料 */
public void doQuery(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	Connection	conn	=	null;
	DBResult	rs	=	null;

	try
	{
		conn	=	dbManager.getConnection(AUTCONNECT.mapConnect("SCD", session));

		int		pageNo		=	Integer.parseInt(Utility.checkNull(requestMap.get("pageNo"), "1"));
		int		pageSize	=	Integer.parseInt(Utility.checkNull(requestMap.get("pageSize"), "10"));

        com.nou.scd.dao.SCDT001GATEWAY s01Gateway = new com.nou.scd.dao.SCDT001GATEWAY(dbManager, conn, pageNo, pageSize);
        s01Gateway.setOrderBy("AYEAR, SMS");
        Vector vc = s01Gateway.getScdt001ForCht(requestMap);
        out.println(DataToJson.vtToJson(s01Gateway.getTotalRowCount(), vc));
	}
	catch (Exception ex)
	{
		throw ex;
	}
	finally
	{
		if (rs != null)
			rs.close();
		if (conn != null)
			conn.close();

		rs	=	null;
		conn	=	null;
	}
}

/** 處理新增存檔 */
public void doAdd(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	Connection	conn	=	null;
	com.acer.db.query.DBResult rs = null;
	try
	{
		conn	=	dbManager.getConnection(AUTCONNECT.mapConnect("SCD", session));

        requestMap.put("ASYS", Utility.nullToSpace(session.getAttribute("ASYS")));
        com.nou.scd.dao.SCDT001DAO s01Dao = new com.nou.scd.dao.SCDT001DAO(dbManager, conn, requestMap, session);
        s01Dao.insert();

        com.nou.pla.dao.PLAT012GATEWAY p12Gateway = new com.nou.pla.dao.PLAT012GATEWAY(dbManager, conn);
        Hashtable ht = new Hashtable();
        ht.put("AYEAR", Utility.dbStr(requestMap.get("AYEAR")));
        ht.put("SMS", Utility.dbStr(requestMap.get("SMS")));
        Vector vc = p12Gateway.getPlat012ForUse(ht);
        com.nou.scd.dao.SCDT002DAO s02Dao = null;
		com.nou.sys.dao.SYST002DAO sys2 = null;
		String CENTER_CODE="";
        for(int i = 0; i < vc.size(); i++) {
            Hashtable htt = (Hashtable)vc.get(i);			
			sys2= new com.nou.sys.dao.SYST002DAO(dbManager, conn);
			sys2.setResultColumn(" CENTER_CODE ");
			sys2.setWhere(" CENTER_ABRCODE='"+(String)htt.get("CENTER_ABRCODE")+"' ");			
			DBResult rs1=sys2.query();			
			if(rs1.next()){			
			   CENTER_CODE= rs1.getString("CENTER_CODE");			
			}			
			rs1.close();			
            requestMap.put("ASYS", Utility.nullToSpace(session.getAttribute("ASYS")));			
            requestMap.put("CENTER_CODE", CENTER_CODE);			
            requestMap.put("CLASS_CODE", htt.get("CLASS_CODE"));			
            requestMap.put("CRSNO", htt.get("CRSNO"));			
            requestMap.put("UPD_MK", "1");			
            s02Dao = new com.nou.scd.dao.SCDT002DAO (dbManager, conn, requestMap, session);
			try{
				s02Dao.insert();			
			}catch(Exception e1){
			
			}
            
        }
        dbManager.commit();
        out.println(DataToJson.successJson());
	}
	catch (Exception ex)
	{
		dbManager.rollback();
		throw ex;
	}
	finally
	{
		if (rs != null) rs.close();
		if (conn != null)
			conn.close();
		conn	=	null;
	}
}

/** 修改帶出資料 */
public void doQueryEdit(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	Connection	conn	=	null;
	DBResult	rs	=	null;

	try
	{
		conn	=	dbManager.getConnection(AUTCONNECT.mapConnect("SCD", session));

        com.nou.scd.dao.SCDT001DAO s01Dao = new com.nou.scd.dao.SCDT001DAO(dbManager, conn);
        s01Dao.setResultColumn("AYEAR, SMS, MID_KEYIN_SDATE, MID_KEYIN_EDATE, FNL_KEYIN_SDATE, FNL_KEYIN_EDATE, MID_ANNO_DATE, FNL_ANNO_DATE, GMARK_RATE, MID_RATE, FNL_RATE, "+
							   "GMARK_EVAL_TIMES, LOCK_WARN_DAYS, GMARK_REEXAM_SDATE, GMARK_REEXAM_EDATE, MID_REEXAM_SDATE, MID_REEXAM_EDATE, FNL_REEXAM_SDATE, FNL_REEXAM_EDATE, "+
							   "ROWSTAMP, REEXAM_FEE, REEXAM_APP_PRT_EXPL,TCH_GMARK_SDATE, TCH_GMARK_EDATE, TCH_MID_SDATE, TCH_MID_EDATE, TCH_FNL_SDATE, TCH_FNL_EDATE, "+
							   "REMID_REEXAM_SDATE, REMID_REEXAM_EDATE,CENTER_REMID_REEXAM_SDATE, CENTER_REMID_REEXAM_EDATE,REMID_MARK,STU_PNT_SDATE,STU_PNT_EDATE,PNT_SCD201R_DATE ");
		s01Dao.setWhere(" SMS = '"+requestMap.get("SMS")+"' AND AYEAR = '"+requestMap.get("AYEAR")+"' AND ASYS = '"+session.getAttribute("ASYS")+"' ");	
		rs = s01Dao.query();
        out.println(DataToJson.rsToJson(rs));
	}
	catch (Exception ex)
	{
		throw ex;
	}
	finally
	{
		if (conn != null)
			conn.close();
		if (rs != null)
			rs.close();

		rs	=	null;
		conn	=	null;
	}
}

/** 修改存檔 */
public void doModify(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	Connection	conn	=	null;

	try
	{
		conn	=	dbManager.getConnection(AUTCONNECT.mapConnect("SCD", session));
        String condition = "AYEAR = '" + Utility.dbStr(requestMap.get("AYEAR"))+ "' AND " +
						   "SMS = '" + Utility.dbStr(requestMap.get("SMS"))+ "' AND " +
						   "ASYS = '" + (String)session.getAttribute("ASYS") + "' ";
		//修改SCDT001
		com.nou.scd.dao.SCDT001DAO S01 = new com.nou.scd.dao.SCDT001DAO(dbManager, conn, requestMap, session);
		int	updateCount = S01.update(condition);
		//修改SCDT002
		Hashtable ht = new Hashtable();
		ht.put("TCH_GMARK_SDATE",(String)requestMap.get("TCH_GMARK_SDATE"));
		ht.put("TCH_GMARK_EDATE",(String)requestMap.get("TCH_GMARK_EDATE"));
		ht.put("TCH_MID_SDATE",(String)requestMap.get("TCH_MID_SDATE"));
		ht.put("TCH_MID_EDATE",(String)requestMap.get("TCH_MID_EDATE"));
		ht.put("TCH_FNL_SDATE",(String)requestMap.get("TCH_FNL_SDATE"));
		ht.put("TCH_FNL_EDATE",(String)requestMap.get("TCH_FNL_EDATE"));		
		ht.put("GMARK_RATE",(String)requestMap.get("GMARK_RATE"));
		ht.put("MID_RATE",(String)requestMap.get("MID_RATE"));
		ht.put("FNL_RATE",(String)requestMap.get("FNL_RATE"));	
		com.nou.scd.dao.SCDT002DAO S02 = new com.nou.scd.dao.SCDT002DAO(dbManager, conn, ht, session);
		int	updateCount_1 = S02.update(condition);
		dbManager.commit();
		if (updateCount == 0)
			out.println(DataToJson.faileJson("此筆資料已被異動過, <br>請重新查詢修改!!"));
		else
			out.println(DataToJson.successJson());
	}
	catch (Exception ex)
	{
		dbManager.rollback();
		throw ex;
	}
	finally
	{
		if (conn != null)
			conn.close();
		conn	=	null;
	}
}

/** 刪除資料 */
public void doDelete(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	Connection	conn	=	null;

	try
	{
		conn	=	dbManager.getConnection(AUTCONNECT.mapConnect("SCD", session));

		String[]	AYEAR		=	Utility.split(requestMap.get("AYEAR").toString(), ",");
		String[]	SMS		=	Utility.split(requestMap.get("SMS").toString(), ",");
		String[]	ASYS		=	Utility.split(requestMap.get("ASYS").toString(), ",");

		com.nou.scd.dao.SCDT001DAO s01Dao = new com.nou.scd.dao.SCDT001DAO(dbManager, conn);
		com.nou.scd.dao.SCDT002DAO s02Dao = new com.nou.scd.dao.SCDT002DAO(dbManager, conn);
        for(int i = 0; i < AYEAR.length; i++) {
            String condition = "AYEAR = '" + Utility.dbStr(AYEAR[i])+ "' AND " +
							   "ASYS = '" + Utility.dbStr(ASYS[i])+ "' AND " +
                               "SMS = '" + Utility.dbStr(SMS[i])+ "' ";
            s01Dao.delete(condition);
            s02Dao.delete(condition);
        }
        dbManager.commit();
		out.println(DataToJson.successJson());
	}
	catch (Exception ex)
	{
		dbManager.rollback();
		throw ex;
	}
	finally
	{
		if (conn != null)
			conn.close();
		conn	=	null;
	}
}

public void insertPla(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	Connection	conn	=	null;

	try
	{
		conn	=	dbManager.getConnection(AUTCONNECT.mapConnect("SCD", session));
		insertPla(dbManager,conn, requestMap, session);
        dbManager.commit();
		out.println(DataToJson.successJson());
	}
	catch (Exception ex)
	{
		dbManager.rollback();
		throw ex;
	}
	finally
	{
		if (conn != null)
			conn.close();
		conn	=	null;
	}
}
public void insertPla(DBManager dbManager,Connection conn, Hashtable requestMap, HttpSession session) throws Exception
{    		

    try
    {		
        Hashtable ht = new Hashtable();
        ht.put("AYEAR", Utility.dbStr(requestMap.get("AYEAR")));
        ht.put("SMS", Utility.dbStr(requestMap.get("SMS")));
        Vector vc = com.nou.UtilityX.getvtData(dbManager,conn,getSql(ht));
        for(int i = 0; i < vc.size(); i++) {
            Hashtable htt = (Hashtable)vc.get(i);	
            requestMap.put("ASYS", Utility.nullToSpace(session.getAttribute("ASYS")));			
            requestMap.put("CENTER_CODE", htt.get("CENTER_CODE"));			
            requestMap.put("CLASS_CODE", htt.get("CLASS_CODE"));			
            requestMap.put("CRSNO", htt.get("CRSNO"));			
            requestMap.put("UPD_MK", "1");			
            com.nou.scd.dao.SCDT002DAO s02Dao = new com.nou.scd.dao.SCDT002DAO (dbManager, conn, requestMap, session);
			try{
				s02Dao.insert();			
			}catch(Exception e1){
			
			}            
        }
    }
    catch (Exception ex)
    {
        throw ex;
    }finally
    {
     
    }
}
public String getSql(Hashtable ht) throws Exception 
{
    StringBuffer sql =  new StringBuffer();
    try {	    
    	
		sql.append("SELECT UNIQUE A.AYEAR,A.SMS,B.CENTER_CODE,A.CRSNO,A.CLASS_CODE ");
		sql.append("FROM PLAT012 A ");
		sql.append("JOIN SYST002 B ON A.CENTER_ABRCODE = B.CENTER_ABRCODE ");
		sql.append("WHERE A.AYEAR = '"+Utility.checkNull(ht.get("AYEAR"), ",")+"' AND A.SMS = '"+Utility.checkNull(ht.get("SMS"), ",")+"' ");
		sql.append("AND NOT EXISTS( ");
		sql.append("	SELECT 1 FROM SCDT002 S  ");
		sql.append("	WHERE A.AYEAR = S.AYEAR AND A.SMS = S.SMS  ");
		sql.append("	AND A.CRSNO = S.CRSNO AND A.CLASS_CODE = S.CLASS_CODE ");
		sql.append("	AND B.CENTER_CODE = S.CENTER_CODE ");
		sql.append(") ");
    } catch (Exception e) {
        throw e;
    } finally {
        
    }
    return sql.toString();
}
%>