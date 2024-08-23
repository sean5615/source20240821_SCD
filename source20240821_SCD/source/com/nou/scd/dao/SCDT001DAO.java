package com.nou.scd.dao;

import com.nou.DAO;
import com.acer.db.DBManager;
import com.acer.util.DateUtil;
import com.acer.util.Utility;
import java.sql.Connection;
import java.util.Hashtable;
import javax.servlet.http.HttpSession;

public class SCDT001DAO extends DAO
{
    private SCDT001DAO(){
        this.columnAry    =    new String[]{"ASYS","AYEAR","SMS","MID_KEYIN_SDATE","MID_KEYIN_EDATE","FNL_KEYIN_SDATE","FNL_KEYIN_EDATE","MID_ANNO_DATE","FNL_ANNO_DATE","GMARK_EVAL_TIMES","LOCK_WARN_DAYS","GMARK_REEXAM_SDATE","GMARK_REEXAM_EDATE","MID_REEXAM_SDATE","MID_REEXAM_EDATE","FNL_REEXAM_SDATE","FNL_REEXAM_EDATE","REEXAM_FEE","REEXAM_APP_PRT_EXPL","MIDMARK_COMPAR_MK","FNLMARK_COMPAR_MK","GMARK_RATE","MID_RATE","FNL_RATE","PASS_REPL_MK","GOOD_ST_MARK","UPD_DATE","UPD_TIME","UPD_USER_ID","ROWSTAMP","TCH_GMARK_SDATE","TCH_GMARK_EDATE","TCH_MID_SDATE","TCH_MID_EDATE","TCH_FNL_SDATE","TCH_FNL_EDATE","SETTLEMENT_MK","REMID_REEXAM_SDATE","REMID_REEXAM_EDATE","CENTER_REMID_REEXAM_SDATE","CENTER_REMID_REEXAM_EDATE","REMID_MARK","STU_PNT_SDATE","STU_PNT_EDATE","PNT_SCD201R_DATE"};
    }

    public SCDT001DAO(DBManager dbManager, Connection conn)
    {
        this();
        this.dbManager    =    dbManager;
        this.conn    =    conn;
        this.tableName    =    "SCDT001";
    }

    public SCDT001DAO(DBManager dbManager, Connection conn, String USER_ID) throws Exception
    {
        this();
        this.dbManager    =    dbManager;
        this.conn    =    conn;
        this.tableName    =    "SCDT001";
        this.setUPD_DATE(DateUtil.getNowDate());
        this.setUPD_TIME(DateUtil.getNowTimeS());
        this.setUPD_USER_ID(USER_ID);
        this.setROWSTAMP(DateUtil.getNowTimeMs());
    }

    public SCDT001DAO(DBManager dbManager, Connection conn, Hashtable requestMap, HttpSession session) throws Exception
    {
        this();
        this.dbManager    =    dbManager;
        this.conn    =    conn;
        this.tableName    =    "SCDT001";
        for (int i = 0; i < this.columnAry.length; i++)
        {
            if (requestMap.get(this.columnAry[i]) != null)
                this.columnMap.put(this.columnAry[i], Utility.dbStr(requestMap.get(this.columnAry[i])));
        }
        this.setUPD_DATE(DateUtil.getNowDate());
        this.setUPD_TIME(DateUtil.getNowTimeS());
        this.setUPD_USER_ID((String)session.getAttribute("USER_ID"));
        this.setROWSTAMP(DateUtil.getNowTimeMs());
    }

    public SCDT001DAO(DBManager dbManager, Connection conn, Hashtable requestMap, String USER_ID) throws Exception
    {
        this();
        this.dbManager    =    dbManager;
        this.conn    =    conn;
        this.tableName    =    "SCDT001";
        for (int i = 0; i < this.columnAry.length; i++)
        {
            if (requestMap.get(this.columnAry[i]) != null)
                this.columnMap.put(this.columnAry[i], Utility.dbStr(requestMap.get(this.columnAry[i])));
        }
        this.setUPD_DATE(DateUtil.getNowDate());
        this.setUPD_TIME(DateUtil.getNowTimeS());
        this.setUPD_USER_ID(USER_ID);
        this.setROWSTAMP(DateUtil.getNowTimeMs());
    }
    
    public void setASYS(String ASYS)
    {
        this.columnMap.put ("ASYS", ASYS);
    }

    public void setAYEAR(String AYEAR)
    {
        this.columnMap.put ("AYEAR", AYEAR);
    }

    public void setSMS(String SMS)
    {
        this.columnMap.put ("SMS", SMS);
    }

    public void setMID_KEYIN_SDATE(String MID_KEYIN_SDATE)
    {
        this.columnMap.put ("MID_KEYIN_SDATE", MID_KEYIN_SDATE);
    }

    public void setMID_KEYIN_EDATE(String MID_KEYIN_EDATE)
    {
        this.columnMap.put ("MID_KEYIN_EDATE", MID_KEYIN_EDATE);
    }

    public void setFNL_KEYIN_SDATE(String FNL_KEYIN_SDATE)
    {
        this.columnMap.put ("FNL_KEYIN_SDATE", FNL_KEYIN_SDATE);
    }

    public void setFNL_KEYIN_EDATE(String FNL_KEYIN_EDATE)
    {
        this.columnMap.put ("FNL_KEYIN_EDATE", FNL_KEYIN_EDATE);
    }

    public void setMID_ANNO_DATE(String MID_ANNO_DATE)
    {
        this.columnMap.put ("MID_ANNO_DATE", MID_ANNO_DATE);
    }

    public void setFNL_ANNO_DATE(String FNL_ANNO_DATE)
    {
        this.columnMap.put ("FNL_ANNO_DATE", FNL_ANNO_DATE);
    }

    public void setGMARK_EVAL_TIMES(String GMARK_EVAL_TIMES)
    {
        this.columnMap.put ("GMARK_EVAL_TIMES", GMARK_EVAL_TIMES);
    }

    public void setLOCK_WARN_DAYS(String LOCK_WARN_DAYS)
    {
        this.columnMap.put ("LOCK_WARN_DAYS", LOCK_WARN_DAYS);
    }

    public void setGMARK_REEXAM_SDATE(String GMARK_REEXAM_SDATE)
    {
        this.columnMap.put ("GMARK_REEXAM_SDATE", GMARK_REEXAM_SDATE);
    }

    public void setGMARK_REEXAM_EDATE(String GMARK_REEXAM_EDATE)
    {
        this.columnMap.put ("GMARK_REEXAM_EDATE", GMARK_REEXAM_EDATE);
    }

    public void setMID_REEXAM_SDATE(String MID_REEXAM_SDATE)
    {
        this.columnMap.put ("MID_REEXAM_SDATE", MID_REEXAM_SDATE);
    }

    public void setMID_REEXAM_EDATE(String MID_REEXAM_EDATE)
    {
        this.columnMap.put ("MID_REEXAM_EDATE", MID_REEXAM_EDATE);
    }

    public void setFNL_REEXAM_SDATE(String FNL_REEXAM_SDATE)
    {
        this.columnMap.put ("FNL_REEXAM_SDATE", FNL_REEXAM_SDATE);
    }

    public void setFNL_REEXAM_EDATE(String FNL_REEXAM_EDATE)
    {
        this.columnMap.put ("FNL_REEXAM_EDATE", FNL_REEXAM_EDATE);
    }

    public void setREEXAM_FEE(String REEXAM_FEE)
    {
        this.columnMap.put ("REEXAM_FEE", REEXAM_FEE);
    }

    public void setREEXAM_APP_PRT_EXPL(String REEXAM_APP_PRT_EXPL)
    {
        this.columnMap.put ("REEXAM_APP_PRT_EXPL", REEXAM_APP_PRT_EXPL);
    }

    public void setMIDMARK_COMPAR_MK(String MIDMARK_COMPAR_MK)
    {
        this.columnMap.put ("MIDMARK_COMPAR_MK", MIDMARK_COMPAR_MK);
    }

    public void setFNLMARK_COMPAR_MK(String FNLMARK_COMPAR_MK)
    {
        this.columnMap.put ("FNLMARK_COMPAR_MK", FNLMARK_COMPAR_MK);
    }

    public void setGMARK_RATE(String GMARK_RATE)
    {
        this.columnMap.put ("GMARK_RATE", GMARK_RATE);
    }

    public void setMID_RATE(String MID_RATE)
    {
        this.columnMap.put ("MID_RATE", MID_RATE);
    }

    public void setFNL_RATE(String FNL_RATE)
    {
        this.columnMap.put ("FNL_RATE", FNL_RATE);
    }

    public void setPASS_REPL_MK(String PASS_REPL_MK)
    {
        this.columnMap.put ("PASS_REPL_MK", PASS_REPL_MK);
    }

    public void setGOOD_ST_MARK(String GOOD_ST_MARK)
    {
        this.columnMap.put ("GOOD_ST_MARK", GOOD_ST_MARK);
    }

    public void setUPD_DATE(String UPD_DATE)
    {
        this.columnMap.put ("UPD_DATE", UPD_DATE);
    }

    public void setUPD_TIME(String UPD_TIME)
    {
        this.columnMap.put ("UPD_TIME", UPD_TIME);
    }

    public void setUPD_USER_ID(String UPD_USER_ID)
    {
        this.columnMap.put ("UPD_USER_ID", UPD_USER_ID);
    }

    public void setROWSTAMP(String ROWSTAMP)
    {
        this.columnMap.put ("ROWSTAMP", ROWSTAMP);
    }

    public void setTCH_GMARK_SDATE(String TCH_GMARK_SDATE)
    {
        this.columnMap.put ("TCH_GMARK_SDATE", TCH_GMARK_SDATE);
    }

    public void setTCH_GMARK_EDATE(String TCH_GMARK_EDATE)
    {
        this.columnMap.put ("TCH_GMARK_EDATE", TCH_GMARK_EDATE);
    }

    public void setTCH_MID_SDATE(String TCH_MID_SDATE)
    {
        this.columnMap.put ("TCH_MID_SDATE", TCH_MID_SDATE);
    }

    public void setTCH_MID_EDATE(String TCH_MID_EDATE)
    {
        this.columnMap.put ("TCH_MID_EDATE", TCH_MID_EDATE);
    }

    public void setTCH_FNL_SDATE(String TCH_FNL_SDATE)
    {
        this.columnMap.put ("TCH_FNL_SDATE", TCH_FNL_SDATE);
    }

    public void setTCH_FNL_EDATE(String TCH_FNL_EDATE)
    {
        this.columnMap.put ("TCH_FNL_EDATE", TCH_FNL_EDATE);
    }

    public void setSETTLEMENT_MK(String SETTLEMENT_MK)
    {
        this.columnMap.put ("SETTLEMENT_MK", SETTLEMENT_MK);
    }
    
    public void setREMID_REEXAM_SDATE(String REMID_REEXAM_SDATE)
    {
        this.columnMap.put ("REMID_REEXAM_SDATE", REMID_REEXAM_SDATE);
    }
    
    public void setREMID_REEXAM_EDATE(String REMID_REEXAM_EDATE)
    {
        this.columnMap.put ("REMID_REEXAM_EDATE", REMID_REEXAM_EDATE);
    }
    
    public void setCENTER_REMID_REEXAM_SDATE(String CENTER_REMID_REEXAM_SDATE)
    {
        this.columnMap.put ("CENTER_REMID_REEXAM_SDATE", CENTER_REMID_REEXAM_SDATE);
    } 
    
    public void setCENTER_REMID_REEXAM_EDATE(String CENTER_REMID_REEXAM_EDATE)
    {
        this.columnMap.put ("CENTER_REMID_REEXAM_EDATE", CENTER_REMID_REEXAM_EDATE);
    }
    
    public void setREMID_MARK(String REMID_MARK)
    {
        this.columnMap.put ("REMID_MARK", REMID_MARK);
    } 
    
    public void setSTU_PNT_SDATE(String STU_PNT_SDATE)
    {
        this.columnMap.put ("STU_PNT_SDATE", STU_PNT_SDATE);
    }
    
    public void setSTU_PNT_EDATE(String STU_PNT_EDATE)
    {
        this.columnMap.put ("STU_PNT_EDATE", STU_PNT_EDATE);
    } 
    
    public void setPNT_SCD201R_DATE(String PNT_SCD201R_DATE)
    {
        this.columnMap.put ("PNT_SCD201R_DATE", PNT_SCD201R_DATE);
    }
        
}
