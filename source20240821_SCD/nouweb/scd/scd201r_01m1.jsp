<%/*
----------------------------------------------------------------------------------
File Name		: scd201r_01m1.jsp
Author			: sRu
Description		: 列印學分證明書 - 處理邏輯頁面
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.3		097/01/14	sRu		加入'以下空白'
0.0.2		096/05/16	sRu		修改無法列印
0.0.1		096/04/23	sRu    	Code Generate Create
								累計實得學分-實得學分 、操行成績 未做
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/scd_method.jsp"%>
<%@ include file="/utility/modulepageinit.jsp"%>
<%@ page import="com.nou.stu.dao.*"%>
<%@ page import="com.nou.sys.dao.*"%>
<%@ page import="com.nou.cou.dao.*"%>
<%@ page import="com.nou.scd.dao.*"%>
<%@ page import="com.nou.sgu.dao.*"%>
<%!
/** 處理列印功能 */
private void doPrint(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	// 依照學號判斷列印空大(9碼)或是空專(7碼)的學分證明書
	String ASYS = (String)requestMap.get("ASYS");
	if("1".equals(ASYS)){
		doPrintStuType1(out,dbManager,requestMap,session);// 空大
	}else{
		doPrintStuType2(out,dbManager,requestMap,session);// 空專
	}
}

/** 列印空大學分證明書 */
private void doPrintStuType1(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	DBResult rs_1 = null;
	DBResult rs_2 = null;
	try
	{
		Connection	conn	=	dbManager.getConnection(AUTCONNECT.mapConnect("NOU", session));

		DBResult	rs	=	dbManager.getSimpleResultSet(conn);
		rs.open();
		rs_1	=	dbManager.getSimpleResultSet(conn);
		rs_1.open();
		rs_2	=	dbManager.getSimpleResultSet(conn);
		rs_2.open();
		String BO	= Utility.checkNull(requestMap.get("BO"), ""); //是否補發 只是列印一個補字
		if("1".equals(BO) || "".equals(BO)){
			BO = "補";
			//chk
			String msg = this.doChk(dbManager,conn, requestMap); 
			if (!"".equals(msg))
			{
				out.println("<script>top.close();alert(\"本學期「成績單暨學分證明書」尚未統一製發，將於  "+msg+" 起開放補發!!\");</script>");
				return;
			}
		}else{
			BO = "";
		}
		String ASYS = (String)session.getAttribute("ASYS");
		String AYEAR		= Utility.checkNull(requestMap.get("AYEAR"), "");
		String AYEAR_N = String.valueOf(Integer.parseInt(AYEAR));
		String SMS = Utility.checkNull(requestMap.get("SMS"), "");
		String SMS_NAME = Utility.checkNull(requestMap.get("SMS_NAME"), "");
		//String CENTER_CODE	= "";
		//String CENTER_CODE_NAME = "";
		String STNO	= Utility.checkNull(requestMap.get("STNO"), "");
		//by poto 批次判斷
		String PROG_ID	= Utility.checkNull(requestMap.get("PROG_ID"), "");
		String SQL_1 = "";
		DBResult RS_BATCH = dbManager.getSimpleResultSet(conn);//批次連線
		RS_BATCH.open();
		if("SCD033M".equals(PROG_ID)){
			STUT003GATEWAY	SS=	new STUT003GATEWAY(dbManager, conn);
			SQL_1 = SS.getSQL(requestMap);
			RS_BATCH.executeQuery(SQL_1);
		}else{
			STUT003DAO	SS3	=	new STUT003DAO(dbManager, conn);
			SS3.setResultColumn("STNO");
			SS3.setSTNO(STNO);
			RS_BATCH = SS3.query();
		}
		RptFile		rptFile	=	new RptFile(session.getId());
		rptFile.setColumn("表身_1,表身_2,表身_3,表身_4,表身_5,表身_6,表身_7,表身_8,表身_9,表身_10,表身_11,表身_12,表身_13,表身_14,表身_15,表身_16,表身_17,表身_18,表身_19,表身_20,表身_21,表身_22,表身_23,表身_24,表身_25,表身_26,表身_27,表身_28,表身_29,表身_30,表身_31,表身_32,表身_33,表身_34,表身_35,表身_36,表身_37,表身_38,表身_39,表身_40,表身_41,表身_42,表身_43,表身_44,表身_45,表身_46,表身_47,表身_48,表身_49,表身_50,表身_51,表身_52,表身_53,表身_54,表身_55,表身_56,表身_57,表身_58,表身_59,表身_60,表身_61,表身_62,表身_63,表身_64,表身_65,表身_66,表身_67,表身_68,表身_69,表身_70,表身_71,表身_72,表身_73,表身_74,表身_75,表身_76,表身_77,表身_78,表身_79,表身_80,表身_81,表身_82,表身_83,表身_84,表身_85,表身_86,表身_87,表身_88,表身_89,表身_90,表身_91,表身_92,表身_93,表身_94,表身_95,表身_96,表身_97,表身_98,表身_99");

		while(RS_BATCH.next()){
			STNO = RS_BATCH.getString("STNO");
			StringBuffer SQL_STUT003 = new StringBuffer();
			SQL_STUT003.append("SELECT    \n");
			SQL_STUT003.append("A.STNO, A.IDNO, A.STTYPE,A.BIRTHDATE, A.CENTER_CODE, \n");
			//SQL_STUT003.append("NVL(A.ACCUM_PASS_CRD,'0') AS ACCUM_PASS_CRD,NVL(A.ACCUM_REPL_CRD,'0') AS ACCUM_REPL_CRD,NVL(A.ACCUM_REDUCE_CRD,'0') AS ACCUM_REDUCE_CRD, \n");
			//by poto 新加入的為了 可以區分累積到當學期的學分數
			SQL_STUT003.append("nvl((select sum(b.crd) \n");
			SQL_STUT003.append("from scdt004 a  \n");
			SQL_STUT003.append("join cout002 b on a.crsno =b.crsno \n");
			SQL_STUT003.append("where 1=1  \n");
			SQL_STUT003.append("and a.stno ='"+STNO+"'  \n");
			SQL_STUT003.append("and (((a.MIDMARK != -1 OR a.FNLMARK != -1) AND a.SMS IN ('1','2') AND TRIM(a.MIDMARK) IS NOT NULL  ) OR (a.FNLMARK != -1 AND a.SMS ='3' ))  \n");
			SQL_STUT003.append("AND TRIM(a.FNLMARK) IS NOT NULL AND trim(a.PASS_REPL_MK) is null  \n");
			SQL_STUT003.append("and nvl(trim(a.CRSNO_SMSGPA),'0') >= 60  \n");
			SQL_STUT003.append("and trim(OLD_STNO) is null  \n");
			SQL_STUT003.append("and a.ayear||decode(a.sms,'3','0',a.sms) <= '"+AYEAR+"' || DECODE('"+SMS+"','3','0','"+SMS+"')),'0') as ACCUM_PASS_CRD,  \n");
			SQL_STUT003.append("nvl((select SUM(NVL(c3.REPL_CRD,0)+NVL(c3.ADOPT_CRD,0)) AS SUM_REPL from ccst003 c3 where  c3.stno ='"+STNO+"' and trim(c3.old_stno) is null and c3.ayear||decode(c3.sms,'3','0',c3.sms) <= '"+AYEAR+"' || DECODE('"+SMS+"','3','0','"+SMS+"')),'0') AS ACCUM_REPL_CRD,  \n");
			SQL_STUT003.append("nvl((select SUM(NVL(c3.REDUCE_CRD,0)) AS SUM_REDUCE from ccst003 c3 where  c3.stno ='"+STNO+"' and trim(c3.old_stno) is null and c3.ayear||decode(c3.sms,'3','0',c3.sms) <= '"+AYEAR+"' || DECODE('"+SMS+"','3','0','"+SMS+"') ),'0') AS ACCUM_REDUCE_CRD,  \n");
			//end
			SQL_STUT003.append("B.SEX,B.NAME,B.CRRSADDR_ZIP,B.CRRSADDR, \n");
			SQL_STUT003.append("SUBSTR(S1.CODE_NAME,1,1) AS STTYPE_NAME, \n");
			//110學年度起，center_code 13為海外學生服務中心，以前之13中心名稱仍維持〝新北學習指導中心〞
			if(!AYEAR.equals("") && Integer.parseInt(AYEAR) < 110) {
				SQL_STUT003.append("DECODE(STUT004.CENTER_CODE,'13','新北學習指導中心',S02.CENTER_NAME) AS CENTER_CODE_NAME, \n");
				SQL_STUT003.append("DECODE(STUT004.CENTER_CODE,'13','新北',S02.CENTER_ABBRNAME) AS CENTER_ABBRNAME \n");				
			}
			else {
				SQL_STUT003.append("S02.CENTER_NAME AS CENTER_CODE_NAME, \n");
				SQL_STUT003.append("S02.CENTER_ABBRNAME AS CENTER_ABBRNAME \n");
			}
			SQL_STUT003.append("FROM STUT003 A \n");
			SQL_STUT003.append("JOIN STUT002 B ON A.IDNO = B.IDNO AND A.BIRTHDATE = B.BIRTHDATE \n");
			SQL_STUT003.append("JOIN SCDT008 C ON C.STNO = A.STNO  AND C.AYEAR='"+AYEAR+"' AND C.SMS ='"+SMS+"' \n");
			SQL_STUT003.append("LEFT JOIN STUT004 STUT004 ON STUT004.STNO = A.STNO  AND STUT004.AYEAR='"+AYEAR+"' AND STUT004.SMS ='"+SMS+"' \n");
			SQL_STUT003.append("JOIN SYST001 S1 ON S1.KIND = 'STTYPE' AND S1.CODE = NVL(STUT004.STTYPE,A.STTYPE) \n");
			SQL_STUT003.append("JOIN SYST002 S02 ON  S02.CENTER_CODE = C.CENTER_CODE \n");
			SQL_STUT003.append("WHERE A.STNO ='"+STNO+"' ");
			SQL_STUT003.append("AND A.INFORMAL_STUTYPE IS NULL  ");  //不可為旁聽生
			rs = dbManager.getSimpleResultSet(conn);
			rs.open();
			rs.executeQuery(SQL_STUT003.toString());

			//檢查是否要列印出姓名與相關日期	start
			SCDT004DAO	SCDT004_1	=	new SCDT004DAO(dbManager, conn);
			SCDT004_1.setResultColumn("AYEAR, SMS, CRSNO,  STNO, CRSNO_SMSGPA AS MARK ");
			SCDT004_1.setWhere(" STNO = '"+STNO+"' AND AYEAR= '"+AYEAR+"' AND SMS='"+SMS+"' AND CRSNO_SMSGPA >=60 ORDER BY CRSNO ");
			DBResult	rs_name	= null;
			rs_name	=	SCDT004_1.query();
			int printvalue=0;
			if (rs_name.next()){
				printvalue=1;
			}
			rs_name.close();
			//檢查是否要列印出姓名與相關日期	end
			while (rs.next())
			{
				String STTYPE_NAME = rs.getString("STTYPE_NAME");
				String CENTER_CODE_NAME = rs.getString("CENTER_CODE_NAME");
				String NAME = rs.getString("NAME");
				String CRRSADDR_ZIP = rs.getString("CRRSADDR_ZIP");
				String CRRSADDR = rs.getString("CRRSADDR");
				String SEX = rs.getString("SEX");
				if(printvalue==1){
					rptFile.add("(" + AYEAR_N + ")空大");				//學年
					rptFile.add(BO+STTYPE_NAME+"證字第 ");              //身份別
					rptFile.add(STNO+" 號");							//證號
					rptFile.add(NAME);				//姓名
				}else{
					rptFile.add(" ");				//學年
					rptFile.add("");                //身份別
					rptFile.add("");				//證號
					rptFile.add("＊＊＊＊＊");			//姓名
				}

				//----------------------------- 出年年月日 (BIRTHDATE) - 開始
				if(!rs.getString("BIRTHDATE").equals(""))
				{
					String F_DATE = rs.getString("BIRTHDATE").replaceAll("/","");
					F_DATE = DateUtil.convertDate(F_DATE);
					if(printvalue==1){
						rptFile.add(toChanisesFullChar(F_DATE.substring(0,3),1));
						rptFile.add(toChanisesFullChar(F_DATE.substring(3,5),1));
						rptFile.add(toChanisesFullChar(F_DATE.substring(5,7),1));
					}else{
						rptFile.add("＊＊＊");
						rptFile.add("＊＊");
						rptFile.add("＊＊");
					}
				}
				else
				{
					rptFile.add("＊＊＊");
					rptFile.add("＊＊");
					rptFile.add("＊＊");
				}
				//----------------------------- 出年年月日 (BIRTHDATE) - 結束

				//------------------------------------------學年 、 學期  - 開始
				if(printvalue==1){
					if(!AYEAR.equals("")){
						rptFile.add(toChanisesFullChar(AYEAR,1));
					}else{
						rptFile.add("");
					}

					if(!SMS.equals("")){
						rptFile.add(toFullSpace(SMS_NAME,3));				//學期
					}else{
						rptFile.add("");
					}
				}else{
					rptFile.add("＊＊＊");
					rptFile.add("＊　　");
				}
				//------------------------------------------學年 、 學期  - 結束

				//年月
				String sysdate = DateUtil.getNowCDate();
				if(printvalue==1){
					if(!sysdate.equals(""))
					{
						rptFile.add(toChanisesFullChar(sysdate.substring(0,3),1));
						rptFile.add(toChanisesFullChar(sysdate.substring(3,5),1));
						rptFile.add(toChanisesFullChar(sysdate.substring(5,7),1));
					}
					else
					{
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}
				}else{
						rptFile.add("＊＊");
						rptFile.add("＊＊");
						rptFile.add("＊＊");
				}

				SCDT004DAO	SCDT004	=	new SCDT004DAO(dbManager, conn);
				SCDT004.setResultColumn("AYEAR, SMS, CRSNO,  STNO, CRSNO_SMSGPA AS MARK ");
				SCDT004.setWhere(" STNO = '"+STNO+"' AND AYEAR= '"+AYEAR+"' AND SMS='"+SMS+"' AND CRSNO_SMSGPA >=60 ORDER BY CRSNO ");
				StringBuffer SQL_SCDT004_1 = new StringBuffer();
				SQL_SCDT004_1.append("SELECT  ");
				SQL_SCDT004_1.append("A.AYEAR, A.SMS, A.CRSNO, A.STNO, A.CRSNO_SMSGPA AS MARK, ");
				SQL_SCDT004_1.append("B.CRS_NAME ,B.FACULTY_CODE AS FACULTY ,B.CRD, ");
				SQL_SCDT004_1.append("C.FACULTY_NAME ");
				SQL_SCDT004_1.append("FROM SCDT004 A ");
				SQL_SCDT004_1.append("LEFT JOIN COUT002 B ON A.CRSNO = B.CRSNO  ");
				SQL_SCDT004_1.append("LEFT JOIN SYST003 C ON B.FACULTY_CODE = C.FACULTY_CODE  AND C.ASYS = '1' ");
				SQL_SCDT004_1.append("WHERE A.STNO = '"+STNO+"' AND A.AYEAR= '"+AYEAR+"' AND A.SMS='"+SMS+"' AND A.CRSNO_SMSGPA >=60 ORDER BY A.CRSNO");
				rs_1 = dbManager.getSimpleResultSet(conn);
				rs_1.open();
				rs_1.executeQuery(SQL_SCDT004_1.toString());
				int rs_1_count = 0;
				while(rs_1.next())
				{
					rs_1_count ++;
					String CRSNO = rs_1.getString("CRSNO");
					rptFile.add(rs_1.getString("CRS_NAME"));			//科目名稱_01
					rptFile.add(rs_1.getString("CRD"));				//學分_01
					rptFile.add(rs_1.getString("FACULTY_NAME"));			//科目名稱_01
					if(rs_1_count == 9){
						break;
					}
				}
				rs_1.close();
				if(rs_1_count < 9){
					//by poto 註記'以下空白'
					rptFile.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;以下空白");
					//rptFile.add("以下空白");
					rptFile.add("");
					rptFile.add("");
					for(int i =0; i<9-(rs_1_count+1);i++)
					{
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}
				}
				//------------------------------------------學年 、 學期  - 開始
				if(!AYEAR.equals("")){
					rptFile.add(toChanisesFullChar(AYEAR,1));
				}else{
					rptFile.add("");
				}
				if(!SMS.equals("")){
					rptFile.add(toFullSpace(SMS_NAME,1));				//學期
				}else{
					rptFile.add("");
				}
				//------------------------------------------學年 、 學期  - 結束

				rptFile.add("(" + STTYPE_NAME.substring(0,1) + ")");			//身份別
				//by poto 中心別改抓SCDW004 如果SCDW004 就抓原本STUT003
				/**start**/
				//CENTER_CODE	= rs.getString("CENTER_CODE");
				//CENTER_CODE_NAME = "";
				//SCDW004DAO SW04	=	new SCDW004DAO(dbManager, conn);
				//SW04.setResultColumn(" CENTER_CODE ");
				//SW04.setWhere(" STNO = '"+STNO+"' AND AYEAR= '"+AYEAR+"' AND SMS='"+SMS+"' AND ROWNUM < 2 ");
				//rs_2.open();
				//rs_2	=	SW04.query();
				//if(rs_2.next()){
				//	CENTER_CODE = rs_2.getString("CENTER_CODE");
				//}
				//rs_2.close();
				/**end**/
				//SYST002DAO S02	=	new SYST002DAO(dbManager, conn);
				//S02.setResultColumn("CENTER_NAME, CENTER_ABBRNAME");
				//S02.setWhere(" CENTER_CODE = '"+CENTER_CODE+"' ");
				//rs_2.open();
				//rs_2 = S02.query();
				//if(rs_2.next()){
				//CENTER_CODE_NAME = rs_2.getString("CENTER_NAME");
				//}
				//rs_2.close();
				//String s=CENTER_CODE_NAME;
				//rptFile.add(s);			//中心別
				rptFile.add(CENTER_CODE_NAME);			//中心別
				rptFile.add(STNO);				//學號
				rptFile.add(NAME);				//姓名

				//-------------------------------------------  sutu010 科目代號、科目名稱、學分、成績 - 開始
				//by poto
				StringBuffer SQL_SCD004 = new StringBuffer();
				SQL_SCD004.append("SELECT SCDT004.STNO,SCDT004.AYEAR, SCDT004.SMS,SCDT004.CRSNO,COUT002.CRS_NAME, ");
				SQL_SCD004.append("SCDT004.CRSNO||decode(SCDT004.PASS_REPL_MK,'R','已修抵','S','已修抵','')||decode(SUBSTR(SCDT004.CRSNO,1,2),'99','*','') AS CRS_SHOW, ");
				SQL_SCD004.append("SCDT004.CRSNO_SMSGPA AS MARK,NVL(SCDT004.MIDMARK,'') AS MIDMARK,NVL(SCDT004.FNLMARK,'') AS FNLMARK, ");
				SQL_SCD004.append("decode(SCDT004.PASS_REPL_MK,'R',COUT002.CRD ,'S',COUT002.CRD ,0) AS SR_CRD , COUT002.CRD ");
				SQL_SCD004.append("FROM SCDT004 SCDT004 ");
				SQL_SCD004.append("JOIN COUT002 COUT002 ON SCDT004.CRSNO = COUT002.CRSNO ");
				SQL_SCD004.append("WHERE 1=1 ");
				SQL_SCD004.append("AND SCDT004.SMS = '"+SMS+"'  ");
				SQL_SCD004.append("AND SCDT004.AYEAR = '"+AYEAR+"'  ");
				SQL_SCD004.append("AND SCDT004.STNO = '"+STNO+"' ORDER BY SCDT004.CRSNO ");
				rs_1 = dbManager.getSimpleResultSet(conn);
				rs_1.open();
				rs_1.executeQuery(SQL_SCD004.toString());

				rs_1_count = 0;
				int CRD_ADD = 0;
				int SR_CRD = 0;
				int memodisplay=0;		//0:不顯示 1:顯示
				while(rs_1.next())
				{
					rs_1_count ++;
					String CRSNO = rs_1.getString("CRSNO");
					String SMS1 = rs_1.getString("SMS");
					String CRS_SHOW = rs_1.getString("CRS_SHOW");
					SR_CRD = SR_CRD + rs_1.getInt("SR_CRD");
					rptFile.add(CRS_SHOW);
					rptFile.add(rs_1.getString("CRS_NAME"));			//科目名稱_01
					rptFile.add(rs_1.getString("CRD"));				//學分_01
					String thisMark = "";
					String MIDMARK = rs_1.getString("MIDMARK");
					String FNLMARK = rs_1.getString("FNLMARK");
					if(rs_1.getString("MARK").equals("-1")||(("-1".equals(MIDMARK)||"3".equals(SMS1))&&"-1".equals(FNLMARK))) {
						thisMark = "缺";
						memodisplay=1;
					} else {
						//by poto
						if(rs_1.getInt("MARK")>59){
							CRD_ADD = CRD_ADD + rs_1.getInt("CRD");
						}
						thisMark = rs_1.getString("MARK");
					}
					rptFile.add(thisMark);			//成績_01
					if(rs_1_count == 9){
						break;
					}
				}
				rs_1.close();
				if(rs_1_count < 9)
				{
				//by poto 註記'以下空白'
					rptFile.add("");
					rptFile.add("<center>以下空白	</center>");
					rptFile.add("");
					rptFile.add("");
					for(int i =0; i<9-(rs_1_count+1);i++)
					{
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}
				}
				//------------------------------------------- 本學期平均成績 - 開始
				String sql = 	"SELECT  NVL(ROUND(SUM(C002.CRD*S004.CRSNO_SMSGPA) /SUM(C002.CRD),2),'0') AS NUM  " +
								"from SCDT004 S004 " +
								"join COUT002 C002 ON S004.CRSNO = C002.CRSNO " +
								"WHERE "+
								"    S004.AYEAR = '"+AYEAR+"' "+
								"AND S004.SMS = '"+SMS+"' "+
								"AND S004.STNO = '"+STNO+"' "+
								"AND (((S004.MIDMARK != -1 OR S004.FNLMARK != -1) AND S004.SMS IN ('1','2') AND TRIM(S004.MIDMARK) IS NOT NULL  ) OR (S004.FNLMARK != -1 AND S004.SMS ='3' )) "+
								"AND TRIM(S004.FNLMARK) IS NOT NULL";
				rs_1.open();
				rs_1.executeQuery(sql);

				if(rs_1.next()){
					if(SMS.equals("3")){
						rptFile.add("*****");			//本學期平均成績
					}else{
						if("0".equals(rs_1.getString("NUM"))){
							rptFile.add("0.00");			//本學期平均成績
						}else{
							rptFile.add(getFullMark(rs_1.getString("NUM")));			//本學期平均成績
						}
					}
				}else{
					rptFile.add("*****");
				}
				rs_1.close();
				//------------------------------------------- 本學期平均成績 - 結束
				rptFile.add(CRD_ADD);				//本學期修得學分

				/***累計實得學分 = SCDT004 及格學分數***/
				SCDT004GATEWAY SS = new SCDT004GATEWAY(dbManager, conn);
				Hashtable ht_crd = new Hashtable();
				ht_crd.put("STNO",STNO);
				if(SMS.equals("3"))
				   SMS = "0";
				ht_crd.put("AYEARSMS",AYEAR+SMS);
				ht_crd.put("SQL_SCDT004"," and trim(B.OLD_STNO) is null ");


				String g1=SS.Sum_crd(ht_crd);
				if(g1.equals("")){
					g1="0";
				}
				rptFile.add(g1);				//累計修得學分
				rptFile.add(rs.getString("ACCUM_REPL_CRD"));	//累計抵免學分
				rptFile.add(rs.getString("ACCUM_REDUCE_CRD"));	//累計減修學分
				rptFile.add(rs.getInt("ACCUM_PASS_CRD"));			//累計實得學分
				//by poto //2017_IS141 修正同學收
				String SEX_NAME = "先生";
                if("1".equals(SEX)){
                  SEX_NAME = "同學";
                }else{
                  SEX_NAME = "同學";
                }
				rptFile.add(getName(dbManager,conn));	//教務長
				rptFile.add(CRRSADDR_ZIP);		//通訊郵遞區號
				rptFile.add(CRRSADDR);			//通訊地址
				rptFile.add(NAME+"    "+SEX_NAME);				//姓名

				//---------------------------------------------------------成績複查 - 開始
				/*
				SCDT001DAO	scdt001=	new SCDT001DAO(dbManager, conn);
				scdt001.setResultColumn("TO_NUMBER(SUBSTR(FNL_REEXAM_SDATE,5,2)) AS S_MONTH,TO_NUMBER(SUBSTR(FNL_REEXAM_SDATE,7,2)) AS S_DATE,TO_NUMBER(SUBSTR(FNL_REEXAM_EDATE,5,2)) AS E_MONTH,TO_NUMBER(SUBSTR(FNL_REEXAM_EDATE,7,2)) AS E_DATE");
				scdt001.setASYS(ASYS);
				scdt001.setAYEAR(AYEAR);
				scdt001.setSMS(SMS);
				rs_1.open();
				rs_1	=	scdt001.query();
				if(rs_1.next())
				{
					if("1".equals(Utility.checkNull(requestMap.get("BO"), ""))){
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}else{
						if(!rs_1.getString("S_MONTH").equals(""))
						{
							rptFile.add("成績複查時間："+toChanisesFullChar(rs_1.getString("S_MONTH"))+"月");		//成績複查起_月
							rptFile.add(toChanisesFullChar(rs_1.getString("S_DATE"))+"日至");		//成績複查起_日
						}
						else
						{
							rptFile.add("");
							rptFile.add("");
						}
						if(!rs_1.getString("E_MONTH").equals(""))
						{
							rptFile.add(toChanisesFullChar(rs_1.getString("E_MONTH"))+"月");		//成績複查迄_月
							rptFile.add(toChanisesFullChar(rs_1.getString("E_DATE"))+"日");		//成績複查迄_日
						}
						else
						{
							rptFile.add("");
							rptFile.add("");
						}
					}
				}
				else
				{
					rptFile.add("");
					rptFile.add("");
					rptFile.add("");
					rptFile.add("");
				}
				rs_1.close();
				*/
				rptFile.add("");
				rptFile.add("");
				rptFile.add("");
				rptFile.add("");
				//---------------------------------------------------------成績複查 - 結束

					//顯示缺考
					if(memodisplay==1){
						rptFile.add("『缺』：表考試缺考，該科不列入學期平均成績");
					}else{
						rptFile.add("　");
					}


					//年月
					if(!sysdate.equals(""))
					{
						if(sysdate.substring(0,1).equals("0")){
							rptFile.add(sysdate.substring(1,3)+" 年");
						}else{
							rptFile.add(sysdate.substring(0,3)+" 年");
						}
						rptFile.add(sysdate.substring(3,5)+" 月");
						rptFile.add(sysdate.substring(5,7)+" 日"+BO+"發");
					}
					else
					{
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}
				}
				rs.close();//while(rs.next())_end
			}
			RS_BATCH.close();//while(RS_BATCH.next())_end
			if (rptFile.size() == 0)
			{
				out.println("<script>top.close();alert(\"無符合資料可供列印!!\");</script>");
				return;
			}

			
			
			/** 初始化報表物件 */
			//20190307新增判斷是不是ie11
			
			String BROWSER_TYPE = Utility.checkNull(requestMap.get("BROWSER_TYPE"), "");
			
			System.out.println(BROWSER_TYPE);
			
			report report_ = null;
			
			if("o".equals(BROWSER_TYPE)) {
				report_	=	new report(dbManager, conn, out, "scd201r_01r1", report.onlineHtmlMode);
			} else {
				report_	=	new report(dbManager, conn, out, "scd201r_02r1", report.onlineHtmlMode);
			}
			
			/** 靜態變數處理 */
			Hashtable	ht	=	new Hashtable();
			report_.setDynamicVariable(ht);

			/** 開始列印 */
			report_.genReport(rptFile);
	}
	catch (Exception ex)
	{
		throw ex;
	}
	finally
	{
		dbManager.close();
	}
}


/** 列印空專學分證明書 */
private void doPrintStuType2(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	DBResult	rs_1	= null;
	DBResult	rs_2	= null;

	try
	{
		Connection	conn	=	dbManager.getConnection(AUTCONNECT.mapConnect("NOU", session));

		DBResult	rs	=	dbManager.getSimpleResultSet(conn);
		rs.open();
		rs_1	=	dbManager.getSimpleResultSet(conn);
		rs_1.open();
		rs_2	=	dbManager.getSimpleResultSet(conn);
		rs_2.open();

		String BO	= Utility.checkNull(requestMap.get("BO"), ""); //是否補發 只是列印一個補字
		String BO_NAME = "";
		String BO_NAME_1 = "";
		if("1".equals(BO) || "".equals(BO)){
			BO_NAME = "空大附專補證字第";
			BO_NAME_1 = "補";
		}else{
			BO_NAME = "空大附專證字第";
		}
		//學制&學年
		String ASYS = (String)session.getAttribute("ASYS");
		String AYEAR		= Utility.checkNull(requestMap.get("AYEAR"), "");
		String AYEAR_N = String.valueOf(Integer.parseInt(AYEAR));

		//學期
		String SMS			= Utility.checkNull(requestMap.get("SMS"), "");
		String SMS_NAME = "";
		if(!SMS.equals(""))
		{
			SYST001DAO syst001	=	new SYST001DAO(dbManager, conn);
			syst001.setResultColumn("CODE_NAME");
			syst001.setKIND("SMS");
			syst001.setCODE(SMS);
			rs_1	=	syst001.query();
			if(rs_1.next())
				SMS_NAME = rs_1.getString("CODE_NAME");
		}

		//中心
		String CENTER_CODE	= Utility.checkNull(requestMap.get("CENTER_CODE"), "");
		String CENTER_CODE_NAME = "";
		if(!CENTER_CODE.equals("")){
			SYST002DAO syst002	=	new SYST002DAO(dbManager, conn);
			syst002.setResultColumn("CENTER_ABBRNAME");
			syst002.setCENTER_CODE(CENTER_CODE);
			rs_1	=	syst002.query();
			if(rs_1.next()){
				CENTER_CODE_NAME = rs_1.getString("CENTER_ABBRNAME");
			}
		}

			String STNO	= Utility.checkNull(requestMap.get("STNO"), "");
			//by poto 批次判斷
			String PROG_ID	= Utility.checkNull(requestMap.get("PROG_ID"), "");
			String SQL_1 = "";
			DBResult RS_BATCH = dbManager.getSimpleResultSet(conn);//批次連線
			RS_BATCH.open();
			if("SCD033M".equals(PROG_ID)){
				STUT003GATEWAY	SS=	new STUT003GATEWAY(dbManager, conn);
				SQL_1 = SS.getSQL(requestMap);
				RS_BATCH.executeQuery(SQL_1);
			}else{
				STUT003DAO	SS3	=	new STUT003DAO(dbManager, conn);
				SS3.setResultColumn("STNO");
				SS3.setSTNO(STNO);
				RS_BATCH = SS3.query();
			}

			RptFile		rptFile	=	new RptFile(session.getId());
			rptFile.setColumn("表身_1,表身_2,表身_3,表身_4,表身_5,表身_6,表身_7,表身_8,表身_9,表身_10,表身_11,表身_12,表身_13,表身_14,表身_15,表身_16,表身_17,表身_18,表身_19,表身_20,表身_21,表身_22,表身_23,表身_24,表身_25,表身_26,表身_27,表身_28,表身_29,表身_30,表身_31,表身_32,表身_33,表身_34,表身_35,表身_36,表身_37,表身_38,表身_39,表身_40,表身_41,表身_42,表身_43,表身_44,表身_45,表身_46,表身_47,表身_48,表身_49,表身_50,表身_51,表身_52,表身_53,表身_54,表身_55,表身_56,表身_57,表身_58,表身_59,表身_60,表身_61,表身_62,表身_63,表身_64,表身_65,表身_66,表身_67,表身_68,表身_69,表身_70,表身_71,表身_72,表身_73,表身_74,表身_75,表身_76,表身_77,表身_78,表身_79,表身_80,表身_81,表身_82,表身_83,表身_84,表身_85,表身_86,表身_87,表身_88,表身_89,表身_90,表身_91,表身_92,表身_93,表身_94,表身_95,表身_96,表身_97,表身_98,表身_99,表身_100,表身_101,表身_102,表身_103,表身_104,表身_105,表身_106,表身_107,表身_108");
		while(RS_BATCH.next()){
			//批次列印
			// STNO = RS_BATCH.getString("STNO");
			// STUT003DAO	stut003	=	new STUT003DAO(dbManager, conn);
			// stut003.setResultColumn("STNO, IDNO, STTYPE,BIRTHDATE, CENTER_CODE, NVL(ACCUM_PASS_CRD,'0') AS ACCUM_PASS_CRD, NVL(ACCUM_REPL_CRD,'0') AS ACCUM_REPL_CRD, NVL(ACCUM_REDUCE_CRD,'0') AS ACCUM_REDUCE_CRD");
			// stut003.setSTNO(STNO);
			// rs	=	stut003.query();
			STNO = RS_BATCH.getString("STNO");
			StringBuffer SQL_STUT003 = new StringBuffer();
			SQL_STUT003.append("SELECT    \n");
			SQL_STUT003.append("A.STNO, A.IDNO, A.STTYPE,A.BIRTHDATE, A.CENTER_CODE, \n");
			//by poto 新加入的為了 可以區分累積到當學期的學分數
			SQL_STUT003.append("nvl((select sum(b.crd) \n");
			SQL_STUT003.append("from scdt004 a  \n");
			SQL_STUT003.append("join cout002 b on a.crsno =b.crsno \n");
			SQL_STUT003.append("where 1=1  \n");
			SQL_STUT003.append("and a.stno ='"+STNO+"'  \n");
			SQL_STUT003.append("and (((a.MIDMARK != -1 OR a.FNLMARK != -1) AND a.SMS IN ('1','2') AND TRIM(a.MIDMARK) IS NOT NULL  ) OR (a.FNLMARK != -1 AND a.SMS ='3' ))  \n");
			SQL_STUT003.append("AND TRIM(a.FNLMARK) IS NOT NULL  \n");
			SQL_STUT003.append("and nvl(trim(a.CRSNO_SMSGPA),'0') >= 60  \n");
			SQL_STUT003.append("and trim(OLD_STNO) is null and trim(PASS_REPL_MK) is null  \n");
			SQL_STUT003.append("and a.ayear||decode(a.sms,'3','0',a.sms) <= '"+AYEAR+"' || DECODE('"+SMS+"','3','0','"+SMS+"')),'0') as ACCUM_PASS_CRD,  \n");
			SQL_STUT003.append("nvl((select SUM(NVL(c3.REPL_CRD,0)+NVL(c3.ADOPT_CRD,0)) AS SUM_REPL from ccst003 c3 where  c3.stno ='"+STNO+"' and trim(c3.old_stno) is null and c3.ayear||decode(c3.sms,'3','0',c3.sms) <= '"+AYEAR+"' || DECODE('"+SMS+"','3','0','"+SMS+"')),'0') AS ACCUM_REPL_CRD,  \n");
			SQL_STUT003.append("nvl((select SUM(NVL(c3.REDUCE_CRD,0)) AS SUM_REDUCE from ccst003 c3 where  c3.stno ='"+STNO+"' and trim(c3.old_stno) is null and c3.ayear||decode(c3.sms,'3','0',c3.sms) <= '"+AYEAR+"' || DECODE('"+SMS+"','3','0','"+SMS+"') ),'0') AS ACCUM_REDUCE_CRD,  \n");
			//end
			SQL_STUT003.append("B.SEX,B.NAME,B.CRRSADDR_ZIP,B.CRRSADDR, \n");
			SQL_STUT003.append("SUBSTR(S1.CODE_NAME,1,1) AS STTYPE_NAME \n");
			SQL_STUT003.append("FROM STUT003 A \n");
			SQL_STUT003.append("JOIN STUT002 B ON A.IDNO = B.IDNO AND A.BIRTHDATE = B.BIRTHDATE \n");
			SQL_STUT003.append("LEFT JOIN STUT004 STUT004 ON STUT004.STNO = A.STNO  AND STUT004.AYEAR='"+AYEAR+"' AND STUT004.SMS ='"+SMS+"' \n");
			SQL_STUT003.append("JOIN SYST001 S1 ON S1.KIND = 'STTYPE' AND S1.CODE = NVL(STUT004.STTYPE,A.STTYPE) \n");
			SQL_STUT003.append("WHERE A.STNO ='"+STNO+"' ");
			SQL_STUT003.append("AND A.INFORMAL_STUTYPE IS NULL  ");  //不可為旁聽生
			rs = dbManager.getSimpleResultSet(conn);
			rs.open();
			rs.executeQuery(SQL_STUT003.toString());

			//檢查是否要列印出姓名與相關日期	start
			SCDT004DAO	SCDT004_1	=	new SCDT004DAO(dbManager, conn);
			SCDT004_1.setResultColumn("AYEAR, SMS, CRSNO,  STNO, CRSNO_SMSGPA AS MARK ");
			SCDT004_1.setWhere(" STNO = '"+STNO+"' AND AYEAR= '"+AYEAR+"' AND SMS='"+SMS+"' AND CRSNO_SMSGPA >=60 ");
			DBResult	rs_name	= null;
			rs_name	=	SCDT004_1.query();
			int printvalue=0;
			if (rs_name.next()){
				printvalue=1;
			}
			//檢查是否要列印出姓名與相關日期	end

			while (rs.next())
			{
				String NAME = "";
				String CRRSADDR_ZIP = "";
				String CRRSADDR = "";
				// ---------------------------- 姓名 (NAME) - 開始
				STUT002DAO	stut002	=	new STUT002DAO(dbManager, conn);
				stut002.setResultColumn("NAME,CRRSADDR_ZIP, CRRSADDR ");
				stut002.setIDNO(rs.getString("IDNO"));
				stut002.setBIRTHDATE(rs.getString("BIRTHDATE"));
				rs_1	=	stut002.query();
				if (rs_1.next())
				{
					NAME = rs_1.getString("NAME");
					CRRSADDR_ZIP =  rs_1.getString("CRRSADDR_ZIP");
					CRRSADDR = 	rs_1.getString("CRRSADDR");
				}

				if(printvalue==1)
				{
					rptFile.add("(" + AYEAR_N + ")");		//學年
					rptFile.add(BO_NAME);              //身份別
					rptFile.add(STNO+" 號");				//證號
					rptFile.add(NAME);				//姓名
				}else{
					rptFile.add(" ");				//學年
					rptFile.add("");                //身份別
					rptFile.add("");				//證號
					rptFile.add("＊＊＊＊＊");				//姓名
				}

				// ---------------------------- 姓名 (NAME) - 結束

				//----------------------------- 出年年月日 (BIRTHDATE) - 開始
				if(!rs.getString("BIRTHDATE").equals(""))
				{
					String F_DATE = rs.getString("BIRTHDATE").replaceAll("/","");
					F_DATE = DateUtil.convertDate(F_DATE);
					if(printvalue==1){
						rptFile.add(toChanisesFullChar(F_DATE.substring(0,3),1));
						rptFile.add(toChanisesFullChar(F_DATE.substring(3,5),1));
						rptFile.add(toChanisesFullChar(F_DATE.substring(5,7),1));
					}else{
						rptFile.add("＊＊＊");
						rptFile.add("＊＊");
						rptFile.add("＊＊");
					}
				}
				else
				{
					rptFile.add("＊＊＊");
					rptFile.add("＊＊");
					rptFile.add("＊＊");

				}
				//----------------------------- 出年年月日 (BIRTHDATE) - 結束

				//------------------------------------------學年 、 學期  - 開始
				if(printvalue==1)
				{
					if(!AYEAR.equals(""))
						rptFile.add(toChanisesFullChar(AYEAR,1));
					else
						rptFile.add("");


					if(!SMS.equals(""))
						rptFile.add(toFullSpace(SMS_NAME,3));				//學期
					else
						rptFile.add("");
				}else{
					rptFile.add("＊＊");
					rptFile.add("＊");
				}
				//年月
				String sysdate = DateUtil.getNowCDate();
				if(printvalue==1){
					if(!sysdate.equals(""))
					{
						rptFile.add(toChanisesFullChar(sysdate.substring(0,3),1));
						rptFile.add(toChanisesFullChar(sysdate.substring(3,5),1));
						rptFile.add(toChanisesFullChar(sysdate.substring(5,7),1));
					}
					else
					{
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}
				}else{
						rptFile.add("＊＊");
						rptFile.add("＊＊");
						rptFile.add("＊＊");
				}


				//------------------------------------------學年 、 學期  - 結束
				SCDT004DAO	SCDT004	=	new SCDT004DAO(dbManager, conn);
				SCDT004.setResultColumn(
					"AYEAR, SMS, CRSNO,  STNO, CRSNO_SMSGPA AS MARK, "+
					"(SELECT CRS_NAME FROM COUT002 WHERE COUT002.CRSNO=SCDT004.CRSNO) AS CRS_NAME, "+
					"(SELECT CRD FROM COUT002 WHERE COUT002.CRSNO=SCDT004.CRSNO) AS CRD, "+
					"NVL((SELECT c.CRS_GROUP_CODE_NAME  "+
					" FROM STUT003 a "+
					" JOIN COUT103 b ON b.AYEAR='"+AYEAR+"' AND b.SMS='"+SMS+"' AND b.FACULTY_CODE||b.TOTAL_CRS_NO=a.PRE_MAJOR_FACULTY||a.J_FACULTY_CODE "+
					" JOIN COUT102 c ON b.FACULTY_CODE||b.TOTAL_CRS_NO=c.FACULTY_CODE||c.TOTAL_CRS_NO AND b.CRS_GROUP_CODE=c.CRS_GROUP_CODE WHERE a.STNO=SCDT004.STNO AND b.CRSNO=SCDT004.CRSNO),'相關選修') AS CRS_GROUP_CODE_NAME "
				);
				SCDT004.setWhere(" STNO = '"+STNO+"' AND AYEAR= '"+AYEAR+"' AND SMS='"+SMS+"' AND CRSNO_SMSGPA >=60 ORDER BY CRSNO ");
				rs_1	=	SCDT004.query();

				int rs_1_count = 0;
				while(rs_1.next())
				{
					rptFile.add(rs_1.getString("CRS_NAME"));			//科目名稱_01
					rptFile.add(rs_1.getString("CRD"));				//學分_01
					rptFile.add(rs_1.getString("CRS_GROUP_CODE_NAME"));			//科目名稱_01

					if(rs_1_count == 9)
						break;
					rs_1_count++;
				}
				if(rs_1_count < 9)
				{
					//by poto 註記'以下空白'
					rptFile.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;以下空白");
					rptFile.add("");
					rptFile.add("");
					for(int i =0; i<9-(rs_1_count+1);i++)
					{
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}
				}
				//----------------------------- stut010 ----- 結束

				rptFile.add( !AYEAR.equals("") ? AYEAR_N : "");
				rptFile.add( !SMS.equals("") ? toFullSpace(SMS_NAME,1) : "");

				//------------------------------------------學年 、 學期  - 結束

				//rptFile.add("(" + STTYPE_NAME.substring(0,1) + ")");			//身份別
				//by poto
				rptFile.add(getJcode(dbManager,conn,STNO));
				//by poto
				SYST002DAO SSS	=	new SYST002DAO(dbManager, conn);
				SSS.setResultColumn("CENTER_ABBRNAME");
				SSS.setCENTER_CODE(rs.getString("CENTER_CODE"));
				rs_1	=	SSS.query();
				if(rs_1.next()){
					CENTER_CODE_NAME = rs_1.getString("CENTER_ABBRNAME");
				}


					rptFile.add(CENTER_CODE_NAME);			//中心別
					rptFile.add(STNO);				//學號
					rptFile.add(NAME);				//姓名

				//-------------------------------------------  sutu010 科目代號、科目名稱、類別、學分、成績 - 開始
				//by sorge取得學生修課的成績
				StringBuffer SQL_SCD004 = new StringBuffer();
				SQL_SCD004.append(
					"SELECT b.CRS_NAME, a.AYEAR, a.SMS, a.CRSNO, \n" +
					"	   a.CRSNO||decode(SUBSTR(a.CRSNO,1,2),'99','','')||decode(a.PASS_REPL_MK,'R','已修抵','S','已修抵','') AS CRS_SHOW,  \n" +
					"	   a.STNO,  \n" +
					"	   a.CRSNO_SMSGPA AS MARK, NVL(a.MIDMARK,'') AS MIDMARK, NVL(a.FNLMARK,'') AS FNLMARK, decode(a.PASS_REPL_MK,'R',b.CRD ,'S',b.CRD ,0) AS SR_CRD , \n" +
					"	   b.CRD, NVL(e.CRS_GROUP_CODE_NAME,'相關選修') AS CRS_GROUP_CODE_NAME \n" +
					"FROM SCDT004 a  \n" +
					"JOIN COUT002 b ON a.CRSNO = b.CRSNO \n" +
					"LEFT JOIN STUT003 c ON a.STNO = c.STNO \n" +
					"LEFT JOIN COUT103 d ON a.AYEAR=d.AYEAR AND a.SMS=d.SMS AND a.CRSNO=d.CRSNO AND d.FACULTY_CODE||d.TOTAL_CRS_NO=c.PRE_MAJOR_FACULTY||c.J_FACULTY_CODE \n" +
					"LEFT JOIN COUT102 e ON d.FACULTY_CODE=e.FACULTY_CODE AND d.TOTAL_CRS_NO=e.TOTAL_CRS_NO AND d.CRS_GROUP_CODE=e.CRS_GROUP_CODE \n" +
					"WHERE 1=1  \n" +
					"AND a.SMS = '"+SMS+"'  AND a.AYEAR = '"+AYEAR+"'  AND a.STNO = '"+STNO+"' \n" +
					"ORDER BY CRSNO "
				);
				rs_1 = dbManager.getSimpleResultSet(conn);
				rs_1.open();
				rs_1.executeQuery(SQL_SCD004.toString());

				rs_1_count = 0;
				int CRD_ADD = 0;
				int SR_CRD = 0;
				int memodisplay=0;		//0:不顯示 1:顯示
				while(rs_1.next())
				{
					rs_1_count ++;
					String CRSNO = rs_1.getString("CRSNO");
					String SMS1 = rs_1.getString("SMS");
					String CRS_SHOW = rs_1.getString("CRS_SHOW");
					SR_CRD = SR_CRD + rs_1.getInt("SR_CRD");

					rptFile.add(CRS_SHOW);
					rptFile.add(rs_1.getString("CRS_NAME"));
					rptFile.add(rs_1.getString("CRS_GROUP_CODE_NAME"));
					rptFile.add(rs_1.getString("CRD"));

					String thisMark = "";
					String MIDMARK = rs_1.getString("MIDMARK");
					String FNLMARK = rs_1.getString("FNLMARK");
					if(rs_1.getString("MARK").equals("-1")||(("-1".equals(MIDMARK)||"3".equals(SMS1))&&"-1".equals(FNLMARK))) {
						thisMark = "缺";
						memodisplay=1;
					} else {
						//by poto
						if(rs_1.getInt("MARK")>59){
							CRD_ADD = CRD_ADD + rs_1.getInt("CRD");
						}
						thisMark = rs_1.getString("MARK");
					}
					rptFile.add(thisMark);			//成績_01

					if(rs_1_count == 9)
						break;
				}
				if(rs_1_count < 9)
				{
				//by poto 註記'以下空白'
					rptFile.add("");
					rptFile.add("<center>以下空白</center>");
					rptFile.add("");
					rptFile.add("");
					rptFile.add("");
					for(int i =0; i<9-(rs_1_count+1);i++)
					{
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}
				}
				//-------------------------------------------  sutu010 科目代號、科目名稱、學分、成績 - 結束

				//------------------------------------------- 本學期平均成績 - 開始

				String sql = 	"SELECT  NVL(ROUND(SUM(C002.CRD*S004.CRSNO_SMSGPA) /SUM(C002.CRD),2),'0') AS NUM  " +
								"from SCDT004 S004 " +
								"join COUT002 C002 ON S004.CRSNO = C002.CRSNO " +
								"WHERE "+
								"    S004.AYEAR = '"+AYEAR+"' "+
								"AND S004.SMS = '"+SMS+"' "+
								"AND S004.STNO = '"+STNO+"' "+
								"AND (((S004.MIDMARK != -1 OR S004.FNLMARK != -1) AND S004.SMS IN ('1','2') AND TRIM(S004.MIDMARK) IS NOT NULL ) OR (S004.FNLMARK != -1 AND S004.SMS ='3' )) "+
								"AND TRIM(S004.FNLMARK) IS NOT NULL";
				rs_1.executeQuery(sql);

				if(rs_1.next()){
					if(SMS.equals("3")){
						rptFile.add("*****");			//本學期平均成績
					}else{
						if("0".equals(rs_1.getString("NUM")))
							rptFile.add("0.00");			//本學期平均成績
						else
							rptFile.add(getFullMark(rs_1.getString("NUM")));			//本學期平均成績
					}
				}else
					rptFile.add("*****");
				//------------------------------------------- 本學期平均成績 - 結束

				rptFile.add(CRD_ADD);				//本學期修得學分

				/***累計實得學分 = SCDT004 及格學分數***/
				SCDT004GATEWAY SS = new SCDT004GATEWAY(dbManager, conn);
				Hashtable ht_crd = new Hashtable();
				ht_crd.put("STNO",STNO);
				if (SMS.equals("3"))
				    SMS = "0";
				ht_crd.put("AYEARSMS",AYEAR+SMS);
				ht_crd.put("SQL_SCDT004"," and trim(B.OLD_STNO) is null ");
				String g1=SS.Sum_crd(ht_crd);
				if(g1.equals("")){
					g1="0";
				}
				rptFile.add(g1);				//累計修得學分
				rptFile.add(rs.getString("ACCUM_REPL_CRD"));	//累計抵免學分
				if(rs.getInt("ACCUM_REDUCE_CRD")==0){
					rptFile.add("0&nbsp;");	//累計減修學分
				}else{
					rptFile.add(rs.getString("ACCUM_REDUCE_CRD"));	//累計減修學分
				}
				//rptFile.add(rs.getInt("ACCUM_PASS_CRD"));			//累計實得學分
				rptFile.add("*****");				
				//by poto教務長名稱
				rptFile.add(getName(dbManager,conn));
				rptFile.add(CRRSADDR_ZIP);		//通訊郵遞區號
				rptFile.add(CRRSADDR);			//通訊地址
				rptFile.add(NAME);				//姓名

				//---------------------------------------------------------成績複查 - 開始
				/*
				SCDT001DAO	scdt001=	new SCDT001DAO(dbManager, conn);
				scdt001.setResultColumn("TO_NUMBER(SUBSTR(FNL_REEXAM_SDATE,5,2)) AS S_MONTH,TO_NUMBER(SUBSTR(FNL_REEXAM_SDATE,7,2)) AS S_DATE,TO_NUMBER(SUBSTR(FNL_REEXAM_EDATE,5,2)) AS E_MONTH,TO_NUMBER(SUBSTR(FNL_REEXAM_EDATE,7,2)) AS E_DATE");
				scdt001.setASYS(ASYS);
				scdt001.setAYEAR(AYEAR);
				scdt001.setSMS(SMS);
				rs_1	=	scdt001.query();
				if(rs_1.next())
				{

					if("1".equals(Utility.checkNull(requestMap.get("BO"), ""))){
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}else{
						if(!rs_1.getString("S_MONTH").equals(""))
						{
							rptFile.add("成績複查時間："+toChanisesFullChar(rs_1.getString("S_MONTH"))+"月");		//成績複查起_月
							rptFile.add(toChanisesFullChar(rs_1.getString("S_DATE"))+"日至");		//成績複查起_日
						}
						else
						{
							rptFile.add("");
							rptFile.add("");
						}
						if(!rs_1.getString("E_MONTH").equals(""))
						{
							rptFile.add(toChanisesFullChar(rs_1.getString("E_MONTH"))+"月");		//成績複查迄_月
							rptFile.add(toChanisesFullChar(rs_1.getString("E_DATE"))+"日");		//成績複查迄_日
						}
						else
						{
							rptFile.add("");
							rptFile.add("");
						}
					}
				}
				else
				{
					rptFile.add("");
					rptFile.add("");
					rptFile.add("");
					rptFile.add("");
				}
				*/
				//---------------------------------------------------------成績複查 - 結束
				rptFile.add("");
				rptFile.add("");
				rptFile.add("");
				rptFile.add("");

					//顯示缺考
					if(memodisplay==1){
						rptFile.add("『缺』：表考試缺考，該科不列入學期平均成績");
					}else{
						rptFile.add("");
					}
					//年月
					if(!sysdate.equals(""))
					{
						if(sysdate.substring(0,1).equals("0")){
							rptFile.add(sysdate.substring(1,3)+" 年");
						}else{
							rptFile.add(sysdate.substring(0,3)+" 年");
						}
						rptFile.add(sysdate.substring(3,5)+" 月");
						rptFile.add(sysdate.substring(5,7)+" 日"+BO_NAME_1+"發");
					}
					else
					{
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}

				}
				rs.close();//while(rs.next())_end
			}
			RS_BATCH.close();//while(RS_BATCH.next())_end
			if (rptFile.size() == 0)
			{
				out.println("<script>top.close();alert(\"無符合資料可供列印!!\");</script>");
				return;
			}

			
			/** 初始化報表物件 */
			//20190307新增判斷是不是ie11
			
			report report_ = null;
			
			String BROWSER_TYPE = Utility.checkNull(requestMap.get("BROWSER_TYPE"), "");
			
			if("o".equals(BROWSER_TYPE)) {
				report_	=	new report(dbManager, conn, out, "scd201r_01r2", report.onlineHtmlMode);
			} else {
				report_	=	new report(dbManager, conn, out, "scd201r_02r2", report.onlineHtmlMode);
			}

			/** 靜態變數處理 */
			Hashtable	ht	=	new Hashtable();
			report_.setDynamicVariable(ht);

			/** 開始列印 */
			report_.genReport(rptFile);
	}
	catch (Exception ex)
	{
		throw ex;
	}
	finally
	{
		dbManager.close();
	}
}

/** 
 */
public static String toFullSpace(String s,int a){
  String ca = "";	
  if(s==null || s.equals("")){
    return "";
  }
  s = s.substring(0,1);
  System.out.println(s);
  ca = Utility.fillBackStr(s, a, '	');
  System.out.println(ca);
  return String.valueOf(ca);
}

/**
 * (2005/7/28) 說明：轉成中文全型字
 * @author tonny
 * @param s
 * @param a a = 0,正常處理  a = 1 把第一個0去掉換成空白
 * @return
 */
public static String toChanisesFullChar(String s,int a){
  if(s==null || s.equals("")){
    return "";
  }
  
  char[] ca = s.toCharArray();
  for(int i=0; i<ca.length; i++){
    //by poto
  	if(i==0 && s.substring(0,1).equals("0") && a==1 ){    ca[i] = (char)12288;        continue;                  }  //半型空白轉成全型空白
    if(ca[i] > '\200'){    continue;   }      //超過這個應該都是中文字了…
    if(ca[i] == 32){    ca[i] = (char)12288;        continue;                  }  //半型空白轉成全型空白
    if(Character.isLetterOrDigit(ca[i])){   ca[i] = (char)(ca[i] + 65248);  continue;  }  //是有定義的字、數字及符號

    ca[i] = (char)12288;  //其它不合要求的，全部轉成全型空白。
  }  	
  return String.valueOf(ca);
}
/**
 * (2005/7/28) 說明：轉成中文全型字
 * @author tonny
 * @param s
 * @return
 */
public static String toChanisesFullChar(String s){
  if(s==null || s.equals("")){
    return "";
  }

  char[] ca = s.toCharArray();
  for(int i=0; i<ca.length; i++){
    if(ca[i] > '\200'){    continue;   }      //超過這個應該都是中文字了…
    if(ca[i] == 32){    ca[i] = (char)12288;        continue;                  }  //半型空白轉成全型空白
    if(Character.isLetterOrDigit(ca[i])){   ca[i] = (char)(ca[i] + 65248);  continue;  }  //是有定義的字、數字及符號

    ca[i] = (char)12288;  //其它不合要求的，全部轉成全型空白。
  }

  return String.valueOf(ca);
}

public String getJcode(DBManager dbManager,Connection conn, String STNO){
	DBResult rs_J = null;
	StringBuffer	sql_1		=	new StringBuffer();
	String Jcode ="";
	sql_1.append("select TOTAL_CRS_NAME AS NAME ");
	sql_1.append("from stut003 a ");
	sql_1.append("join syst008 b on a.PRE_MAJOR_FACULTY=b.FACULTY_CODE AND  a.J_FACULTY_CODE = b.TOTAL_CRS_NO ");
	sql_1.append("where a.stno ='"+STNO+"'");
	try{
		rs_J = dbManager.getSimpleResultSet(conn);
		rs_J.open();
		rs_J.executeQuery(sql_1.toString());
		while (rs_J.next()) {
			Jcode =rs_J.getString("NAME");
		}
		if(Jcode.length()>8){
			String[] code = Jcode.split("-");
			String spece = "&nbsp;";
			//for (int i = 1; i <= 125; i++){
			for (int i = 1; i <= 12; i++){
			//	spece = spece + "&nbsp;";
				spece = spece ;
			}
			if(code.length>1){
				Jcode =
				"<font size ='2'>"
				+code[0]
				//+"<br>"
				+spece
				+"-"
				+code[1]
				+"</font>";
			}else{
				Jcode = "<font size ='2'>"+Jcode+"</font>";
			}
		}


	}
	catch (Exception ex)
	{
		//throw ex;
	}
	finally
	{
		
	}
	return Jcode;
}

public String getName(DBManager dbManager,Connection conn){
	DBResult rs_J = null;
	StringBuffer	sql_1		=	new StringBuffer();
	String NAME ="";
	sql_1.append("select distinct USER_NAME AS NAME ");
	sql_1.append("from syst010 ");
	sql_1.append("join autt001 on syst010.idno = autt001.user_idno ");
	sql_1.append("where  syst010.DEP_CODE= '510' and syst010.DUTY_TYPE = '02'");

	try{
		rs_J = dbManager.getSimpleResultSet(conn);
		rs_J.open();
		rs_J.executeQuery(sql_1.toString());
		while (rs_J.next()) {
			NAME =rs_J.getString("NAME");
		}
	}
	catch (Exception ex)
	{
		//throw ex;
	}
	finally
	{
		
	}
	return NAME;
}

private String doChk(DBManager dbManager, Connection conn,Hashtable requestMap) throws Exception
{	
	String MSG = "";
	try
	{
		String AYEAR = Utility.checkNull(requestMap.get("AYEAR"), "");
		String SMS = Utility.checkNull(requestMap.get("SMS"), "");
		
		String SQL = "select PNT_SCD201R_DATE from SCDT001 x where x.ayear='"+AYEAR+"' and x.sms='"+SMS+"' and x.pnt_scd201r_date > TO_CHAR(SYSDATE,'YYYYMMDD')";
		MSG = UtilityX.getSqlDataForString(dbManager, conn, SQL,"PNT_SCD201R_DATE" );		
	}
	catch (Exception ex)
	{
		throw ex;
	}
	return MSG;
}
%>