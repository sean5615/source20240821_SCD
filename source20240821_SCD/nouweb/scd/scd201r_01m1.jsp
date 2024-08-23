<%/*
----------------------------------------------------------------------------------
File Name		: scd201r_01m1.jsp
Author			: sRu
Description		: �C�L�Ǥ��ҩ��� - �B�z�޿譶��
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.3		097/01/14	sRu		�[�J'�H�U�ť�'
0.0.2		096/05/16	sRu		�ק�L�k�C�L
0.0.1		096/04/23	sRu    	Code Generate Create
								�֭p��o�Ǥ�-��o�Ǥ� �B�ަ榨�Z ����
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
/** �B�z�C�L�\�� */
private void doPrint(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	// �̷ӾǸ��P�_�C�L�Ťj(9�X)�άO�űM(7�X)���Ǥ��ҩ���
	String ASYS = (String)requestMap.get("ASYS");
	if("1".equals(ASYS)){
		doPrintStuType1(out,dbManager,requestMap,session);// �Ťj
	}else{
		doPrintStuType2(out,dbManager,requestMap,session);// �űM
	}
}

/** �C�L�Ťj�Ǥ��ҩ��� */
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
		String BO	= Utility.checkNull(requestMap.get("BO"), ""); //�O�_�ɵo �u�O�C�L�@�Ӹɦr
		if("1".equals(BO) || "".equals(BO)){
			BO = "��";
			//chk
			String msg = this.doChk(dbManager,conn, requestMap); 
			if (!"".equals(msg))
			{
				out.println("<script>top.close();alert(\"���Ǵ��u���Z��[�Ǥ��ҩ��ѡv�|���Τ@�s�o�A�N��  "+msg+" �_�}��ɵo!!\");</script>");
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
		//by poto �妸�P�_
		String PROG_ID	= Utility.checkNull(requestMap.get("PROG_ID"), "");
		String SQL_1 = "";
		DBResult RS_BATCH = dbManager.getSimpleResultSet(conn);//�妸�s�u
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
		rptFile.setColumn("��_1,��_2,��_3,��_4,��_5,��_6,��_7,��_8,��_9,��_10,��_11,��_12,��_13,��_14,��_15,��_16,��_17,��_18,��_19,��_20,��_21,��_22,��_23,��_24,��_25,��_26,��_27,��_28,��_29,��_30,��_31,��_32,��_33,��_34,��_35,��_36,��_37,��_38,��_39,��_40,��_41,��_42,��_43,��_44,��_45,��_46,��_47,��_48,��_49,��_50,��_51,��_52,��_53,��_54,��_55,��_56,��_57,��_58,��_59,��_60,��_61,��_62,��_63,��_64,��_65,��_66,��_67,��_68,��_69,��_70,��_71,��_72,��_73,��_74,��_75,��_76,��_77,��_78,��_79,��_80,��_81,��_82,��_83,��_84,��_85,��_86,��_87,��_88,��_89,��_90,��_91,��_92,��_93,��_94,��_95,��_96,��_97,��_98,��_99");

		while(RS_BATCH.next()){
			STNO = RS_BATCH.getString("STNO");
			StringBuffer SQL_STUT003 = new StringBuffer();
			SQL_STUT003.append("SELECT    \n");
			SQL_STUT003.append("A.STNO, A.IDNO, A.STTYPE,A.BIRTHDATE, A.CENTER_CODE, \n");
			//SQL_STUT003.append("NVL(A.ACCUM_PASS_CRD,'0') AS ACCUM_PASS_CRD,NVL(A.ACCUM_REPL_CRD,'0') AS ACCUM_REPL_CRD,NVL(A.ACCUM_REDUCE_CRD,'0') AS ACCUM_REDUCE_CRD, \n");
			//by poto �s�[�J�����F �i�H�Ϥ��ֿn���Ǵ����Ǥ���
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
			//110�Ǧ~�װ_�Acenter_code 13�����~�ǥͪA�Ȥ��ߡA�H�e��13���ߦW�٤��������s�_�ǲ߫��ɤ��ߡ�
			if(!AYEAR.equals("") && Integer.parseInt(AYEAR) < 110) {
				SQL_STUT003.append("DECODE(STUT004.CENTER_CODE,'13','�s�_�ǲ߫��ɤ���',S02.CENTER_NAME) AS CENTER_CODE_NAME, \n");
				SQL_STUT003.append("DECODE(STUT004.CENTER_CODE,'13','�s�_',S02.CENTER_ABBRNAME) AS CENTER_ABBRNAME \n");				
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
			SQL_STUT003.append("AND A.INFORMAL_STUTYPE IS NULL  ");  //���i����ť��
			rs = dbManager.getSimpleResultSet(conn);
			rs.open();
			rs.executeQuery(SQL_STUT003.toString());

			//�ˬd�O�_�n�C�L�X�m�W�P�������	start
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
			//�ˬd�O�_�n�C�L�X�m�W�P�������	end
			while (rs.next())
			{
				String STTYPE_NAME = rs.getString("STTYPE_NAME");
				String CENTER_CODE_NAME = rs.getString("CENTER_CODE_NAME");
				String NAME = rs.getString("NAME");
				String CRRSADDR_ZIP = rs.getString("CRRSADDR_ZIP");
				String CRRSADDR = rs.getString("CRRSADDR");
				String SEX = rs.getString("SEX");
				if(printvalue==1){
					rptFile.add("(" + AYEAR_N + ")�Ťj");				//�Ǧ~
					rptFile.add(BO+STTYPE_NAME+"�Ҧr�� ");              //�����O
					rptFile.add(STNO+" ��");							//�Ҹ�
					rptFile.add(NAME);				//�m�W
				}else{
					rptFile.add(" ");				//�Ǧ~
					rptFile.add("");                //�����O
					rptFile.add("");				//�Ҹ�
					rptFile.add("����������");			//�m�W
				}

				//----------------------------- �X�~�~��� (BIRTHDATE) - �}�l
				if(!rs.getString("BIRTHDATE").equals(""))
				{
					String F_DATE = rs.getString("BIRTHDATE").replaceAll("/","");
					F_DATE = DateUtil.convertDate(F_DATE);
					if(printvalue==1){
						rptFile.add(toChanisesFullChar(F_DATE.substring(0,3),1));
						rptFile.add(toChanisesFullChar(F_DATE.substring(3,5),1));
						rptFile.add(toChanisesFullChar(F_DATE.substring(5,7),1));
					}else{
						rptFile.add("������");
						rptFile.add("����");
						rptFile.add("����");
					}
				}
				else
				{
					rptFile.add("������");
					rptFile.add("����");
					rptFile.add("����");
				}
				//----------------------------- �X�~�~��� (BIRTHDATE) - ����

				//------------------------------------------�Ǧ~ �B �Ǵ�  - �}�l
				if(printvalue==1){
					if(!AYEAR.equals("")){
						rptFile.add(toChanisesFullChar(AYEAR,1));
					}else{
						rptFile.add("");
					}

					if(!SMS.equals("")){
						rptFile.add(toFullSpace(SMS_NAME,3));				//�Ǵ�
					}else{
						rptFile.add("");
					}
				}else{
					rptFile.add("������");
					rptFile.add("���@�@");
				}
				//------------------------------------------�Ǧ~ �B �Ǵ�  - ����

				//�~��
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
						rptFile.add("����");
						rptFile.add("����");
						rptFile.add("����");
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
					rptFile.add(rs_1.getString("CRS_NAME"));			//��ئW��_01
					rptFile.add(rs_1.getString("CRD"));				//�Ǥ�_01
					rptFile.add(rs_1.getString("FACULTY_NAME"));			//��ئW��_01
					if(rs_1_count == 9){
						break;
					}
				}
				rs_1.close();
				if(rs_1_count < 9){
					//by poto ���O'�H�U�ť�'
					rptFile.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�H�U�ť�");
					//rptFile.add("�H�U�ť�");
					rptFile.add("");
					rptFile.add("");
					for(int i =0; i<9-(rs_1_count+1);i++)
					{
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}
				}
				//------------------------------------------�Ǧ~ �B �Ǵ�  - �}�l
				if(!AYEAR.equals("")){
					rptFile.add(toChanisesFullChar(AYEAR,1));
				}else{
					rptFile.add("");
				}
				if(!SMS.equals("")){
					rptFile.add(toFullSpace(SMS_NAME,1));				//�Ǵ�
				}else{
					rptFile.add("");
				}
				//------------------------------------------�Ǧ~ �B �Ǵ�  - ����

				rptFile.add("(" + STTYPE_NAME.substring(0,1) + ")");			//�����O
				//by poto ���ߧO���SCDW004 �p�GSCDW004 �N��쥻STUT003
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
				//rptFile.add(s);			//���ߧO
				rptFile.add(CENTER_CODE_NAME);			//���ߧO
				rptFile.add(STNO);				//�Ǹ�
				rptFile.add(NAME);				//�m�W

				//-------------------------------------------  sutu010 ��إN���B��ئW�١B�Ǥ��B���Z - �}�l
				//by poto
				StringBuffer SQL_SCD004 = new StringBuffer();
				SQL_SCD004.append("SELECT SCDT004.STNO,SCDT004.AYEAR, SCDT004.SMS,SCDT004.CRSNO,COUT002.CRS_NAME, ");
				SQL_SCD004.append("SCDT004.CRSNO||decode(SCDT004.PASS_REPL_MK,'R','�w�ש�','S','�w�ש�','')||decode(SUBSTR(SCDT004.CRSNO,1,2),'99','*','') AS CRS_SHOW, ");
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
				int memodisplay=0;		//0:����� 1:���
				while(rs_1.next())
				{
					rs_1_count ++;
					String CRSNO = rs_1.getString("CRSNO");
					String SMS1 = rs_1.getString("SMS");
					String CRS_SHOW = rs_1.getString("CRS_SHOW");
					SR_CRD = SR_CRD + rs_1.getInt("SR_CRD");
					rptFile.add(CRS_SHOW);
					rptFile.add(rs_1.getString("CRS_NAME"));			//��ئW��_01
					rptFile.add(rs_1.getString("CRD"));				//�Ǥ�_01
					String thisMark = "";
					String MIDMARK = rs_1.getString("MIDMARK");
					String FNLMARK = rs_1.getString("FNLMARK");
					if(rs_1.getString("MARK").equals("-1")||(("-1".equals(MIDMARK)||"3".equals(SMS1))&&"-1".equals(FNLMARK))) {
						thisMark = "��";
						memodisplay=1;
					} else {
						//by poto
						if(rs_1.getInt("MARK")>59){
							CRD_ADD = CRD_ADD + rs_1.getInt("CRD");
						}
						thisMark = rs_1.getString("MARK");
					}
					rptFile.add(thisMark);			//���Z_01
					if(rs_1_count == 9){
						break;
					}
				}
				rs_1.close();
				if(rs_1_count < 9)
				{
				//by poto ���O'�H�U�ť�'
					rptFile.add("");
					rptFile.add("<center>�H�U�ť�	</center>");
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
				//------------------------------------------- ���Ǵ��������Z - �}�l
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
						rptFile.add("*****");			//���Ǵ��������Z
					}else{
						if("0".equals(rs_1.getString("NUM"))){
							rptFile.add("0.00");			//���Ǵ��������Z
						}else{
							rptFile.add(getFullMark(rs_1.getString("NUM")));			//���Ǵ��������Z
						}
					}
				}else{
					rptFile.add("*****");
				}
				rs_1.close();
				//------------------------------------------- ���Ǵ��������Z - ����
				rptFile.add(CRD_ADD);				//���Ǵ��ױo�Ǥ�

				/***�֭p��o�Ǥ� = SCDT004 �ή�Ǥ���***/
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
				rptFile.add(g1);				//�֭p�ױo�Ǥ�
				rptFile.add(rs.getString("ACCUM_REPL_CRD"));	//�֭p��K�Ǥ�
				rptFile.add(rs.getString("ACCUM_REDUCE_CRD"));	//�֭p��׾Ǥ�
				rptFile.add(rs.getInt("ACCUM_PASS_CRD"));			//�֭p��o�Ǥ�
				//by poto //2017_IS141 �ץ��P�Ǧ�
				String SEX_NAME = "����";
                if("1".equals(SEX)){
                  SEX_NAME = "�P��";
                }else{
                  SEX_NAME = "�P��";
                }
				rptFile.add(getName(dbManager,conn));	//�аȪ�
				rptFile.add(CRRSADDR_ZIP);		//�q�T�l���ϸ�
				rptFile.add(CRRSADDR);			//�q�T�a�}
				rptFile.add(NAME+"    "+SEX_NAME);				//�m�W

				//---------------------------------------------------------���Z�Ƭd - �}�l
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
							rptFile.add("���Z�Ƭd�ɶ��G"+toChanisesFullChar(rs_1.getString("S_MONTH"))+"��");		//���Z�Ƭd�__��
							rptFile.add(toChanisesFullChar(rs_1.getString("S_DATE"))+"���");		//���Z�Ƭd�__��
						}
						else
						{
							rptFile.add("");
							rptFile.add("");
						}
						if(!rs_1.getString("E_MONTH").equals(""))
						{
							rptFile.add(toChanisesFullChar(rs_1.getString("E_MONTH"))+"��");		//���Z�Ƭd��_��
							rptFile.add(toChanisesFullChar(rs_1.getString("E_DATE"))+"��");		//���Z�Ƭd��_��
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
				//---------------------------------------------------------���Z�Ƭd - ����

					//��ܯʦ�
					if(memodisplay==1){
						rptFile.add("�y�ʡz�G��ҸկʦҡA�Ӭ줣�C�J�Ǵ��������Z");
					}else{
						rptFile.add("�@");
					}


					//�~��
					if(!sysdate.equals(""))
					{
						if(sysdate.substring(0,1).equals("0")){
							rptFile.add(sysdate.substring(1,3)+" �~");
						}else{
							rptFile.add(sysdate.substring(0,3)+" �~");
						}
						rptFile.add(sysdate.substring(3,5)+" ��");
						rptFile.add(sysdate.substring(5,7)+" ��"+BO+"�o");
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
				out.println("<script>top.close();alert(\"�L�ŦX��ƥi�ѦC�L!!\");</script>");
				return;
			}

			
			
			/** ��l�Ƴ����� */
			//20190307�s�W�P�_�O���Oie11
			
			String BROWSER_TYPE = Utility.checkNull(requestMap.get("BROWSER_TYPE"), "");
			
			System.out.println(BROWSER_TYPE);
			
			report report_ = null;
			
			if("o".equals(BROWSER_TYPE)) {
				report_	=	new report(dbManager, conn, out, "scd201r_01r1", report.onlineHtmlMode);
			} else {
				report_	=	new report(dbManager, conn, out, "scd201r_02r1", report.onlineHtmlMode);
			}
			
			/** �R�A�ܼƳB�z */
			Hashtable	ht	=	new Hashtable();
			report_.setDynamicVariable(ht);

			/** �}�l�C�L */
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


/** �C�L�űM�Ǥ��ҩ��� */
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

		String BO	= Utility.checkNull(requestMap.get("BO"), ""); //�O�_�ɵo �u�O�C�L�@�Ӹɦr
		String BO_NAME = "";
		String BO_NAME_1 = "";
		if("1".equals(BO) || "".equals(BO)){
			BO_NAME = "�Ťj���M���Ҧr��";
			BO_NAME_1 = "��";
		}else{
			BO_NAME = "�Ťj���M�Ҧr��";
		}
		//�Ǩ�&�Ǧ~
		String ASYS = (String)session.getAttribute("ASYS");
		String AYEAR		= Utility.checkNull(requestMap.get("AYEAR"), "");
		String AYEAR_N = String.valueOf(Integer.parseInt(AYEAR));

		//�Ǵ�
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

		//����
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
			//by poto �妸�P�_
			String PROG_ID	= Utility.checkNull(requestMap.get("PROG_ID"), "");
			String SQL_1 = "";
			DBResult RS_BATCH = dbManager.getSimpleResultSet(conn);//�妸�s�u
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
			rptFile.setColumn("��_1,��_2,��_3,��_4,��_5,��_6,��_7,��_8,��_9,��_10,��_11,��_12,��_13,��_14,��_15,��_16,��_17,��_18,��_19,��_20,��_21,��_22,��_23,��_24,��_25,��_26,��_27,��_28,��_29,��_30,��_31,��_32,��_33,��_34,��_35,��_36,��_37,��_38,��_39,��_40,��_41,��_42,��_43,��_44,��_45,��_46,��_47,��_48,��_49,��_50,��_51,��_52,��_53,��_54,��_55,��_56,��_57,��_58,��_59,��_60,��_61,��_62,��_63,��_64,��_65,��_66,��_67,��_68,��_69,��_70,��_71,��_72,��_73,��_74,��_75,��_76,��_77,��_78,��_79,��_80,��_81,��_82,��_83,��_84,��_85,��_86,��_87,��_88,��_89,��_90,��_91,��_92,��_93,��_94,��_95,��_96,��_97,��_98,��_99,��_100,��_101,��_102,��_103,��_104,��_105,��_106,��_107,��_108");
		while(RS_BATCH.next()){
			//�妸�C�L
			// STNO = RS_BATCH.getString("STNO");
			// STUT003DAO	stut003	=	new STUT003DAO(dbManager, conn);
			// stut003.setResultColumn("STNO, IDNO, STTYPE,BIRTHDATE, CENTER_CODE, NVL(ACCUM_PASS_CRD,'0') AS ACCUM_PASS_CRD, NVL(ACCUM_REPL_CRD,'0') AS ACCUM_REPL_CRD, NVL(ACCUM_REDUCE_CRD,'0') AS ACCUM_REDUCE_CRD");
			// stut003.setSTNO(STNO);
			// rs	=	stut003.query();
			STNO = RS_BATCH.getString("STNO");
			StringBuffer SQL_STUT003 = new StringBuffer();
			SQL_STUT003.append("SELECT    \n");
			SQL_STUT003.append("A.STNO, A.IDNO, A.STTYPE,A.BIRTHDATE, A.CENTER_CODE, \n");
			//by poto �s�[�J�����F �i�H�Ϥ��ֿn���Ǵ����Ǥ���
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
			SQL_STUT003.append("AND A.INFORMAL_STUTYPE IS NULL  ");  //���i����ť��
			rs = dbManager.getSimpleResultSet(conn);
			rs.open();
			rs.executeQuery(SQL_STUT003.toString());

			//�ˬd�O�_�n�C�L�X�m�W�P�������	start
			SCDT004DAO	SCDT004_1	=	new SCDT004DAO(dbManager, conn);
			SCDT004_1.setResultColumn("AYEAR, SMS, CRSNO,  STNO, CRSNO_SMSGPA AS MARK ");
			SCDT004_1.setWhere(" STNO = '"+STNO+"' AND AYEAR= '"+AYEAR+"' AND SMS='"+SMS+"' AND CRSNO_SMSGPA >=60 ");
			DBResult	rs_name	= null;
			rs_name	=	SCDT004_1.query();
			int printvalue=0;
			if (rs_name.next()){
				printvalue=1;
			}
			//�ˬd�O�_�n�C�L�X�m�W�P�������	end

			while (rs.next())
			{
				String NAME = "";
				String CRRSADDR_ZIP = "";
				String CRRSADDR = "";
				// ---------------------------- �m�W (NAME) - �}�l
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
					rptFile.add("(" + AYEAR_N + ")");		//�Ǧ~
					rptFile.add(BO_NAME);              //�����O
					rptFile.add(STNO+" ��");				//�Ҹ�
					rptFile.add(NAME);				//�m�W
				}else{
					rptFile.add(" ");				//�Ǧ~
					rptFile.add("");                //�����O
					rptFile.add("");				//�Ҹ�
					rptFile.add("����������");				//�m�W
				}

				// ---------------------------- �m�W (NAME) - ����

				//----------------------------- �X�~�~��� (BIRTHDATE) - �}�l
				if(!rs.getString("BIRTHDATE").equals(""))
				{
					String F_DATE = rs.getString("BIRTHDATE").replaceAll("/","");
					F_DATE = DateUtil.convertDate(F_DATE);
					if(printvalue==1){
						rptFile.add(toChanisesFullChar(F_DATE.substring(0,3),1));
						rptFile.add(toChanisesFullChar(F_DATE.substring(3,5),1));
						rptFile.add(toChanisesFullChar(F_DATE.substring(5,7),1));
					}else{
						rptFile.add("������");
						rptFile.add("����");
						rptFile.add("����");
					}
				}
				else
				{
					rptFile.add("������");
					rptFile.add("����");
					rptFile.add("����");

				}
				//----------------------------- �X�~�~��� (BIRTHDATE) - ����

				//------------------------------------------�Ǧ~ �B �Ǵ�  - �}�l
				if(printvalue==1)
				{
					if(!AYEAR.equals(""))
						rptFile.add(toChanisesFullChar(AYEAR,1));
					else
						rptFile.add("");


					if(!SMS.equals(""))
						rptFile.add(toFullSpace(SMS_NAME,3));				//�Ǵ�
					else
						rptFile.add("");
				}else{
					rptFile.add("����");
					rptFile.add("��");
				}
				//�~��
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
						rptFile.add("����");
						rptFile.add("����");
						rptFile.add("����");
				}


				//------------------------------------------�Ǧ~ �B �Ǵ�  - ����
				SCDT004DAO	SCDT004	=	new SCDT004DAO(dbManager, conn);
				SCDT004.setResultColumn(
					"AYEAR, SMS, CRSNO,  STNO, CRSNO_SMSGPA AS MARK, "+
					"(SELECT CRS_NAME FROM COUT002 WHERE COUT002.CRSNO=SCDT004.CRSNO) AS CRS_NAME, "+
					"(SELECT CRD FROM COUT002 WHERE COUT002.CRSNO=SCDT004.CRSNO) AS CRD, "+
					"NVL((SELECT c.CRS_GROUP_CODE_NAME  "+
					" FROM STUT003 a "+
					" JOIN COUT103 b ON b.AYEAR='"+AYEAR+"' AND b.SMS='"+SMS+"' AND b.FACULTY_CODE||b.TOTAL_CRS_NO=a.PRE_MAJOR_FACULTY||a.J_FACULTY_CODE "+
					" JOIN COUT102 c ON b.FACULTY_CODE||b.TOTAL_CRS_NO=c.FACULTY_CODE||c.TOTAL_CRS_NO AND b.CRS_GROUP_CODE=c.CRS_GROUP_CODE WHERE a.STNO=SCDT004.STNO AND b.CRSNO=SCDT004.CRSNO),'�������') AS CRS_GROUP_CODE_NAME "
				);
				SCDT004.setWhere(" STNO = '"+STNO+"' AND AYEAR= '"+AYEAR+"' AND SMS='"+SMS+"' AND CRSNO_SMSGPA >=60 ORDER BY CRSNO ");
				rs_1	=	SCDT004.query();

				int rs_1_count = 0;
				while(rs_1.next())
				{
					rptFile.add(rs_1.getString("CRS_NAME"));			//��ئW��_01
					rptFile.add(rs_1.getString("CRD"));				//�Ǥ�_01
					rptFile.add(rs_1.getString("CRS_GROUP_CODE_NAME"));			//��ئW��_01

					if(rs_1_count == 9)
						break;
					rs_1_count++;
				}
				if(rs_1_count < 9)
				{
					//by poto ���O'�H�U�ť�'
					rptFile.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�H�U�ť�");
					rptFile.add("");
					rptFile.add("");
					for(int i =0; i<9-(rs_1_count+1);i++)
					{
						rptFile.add("");
						rptFile.add("");
						rptFile.add("");
					}
				}
				//----------------------------- stut010 ----- ����

				rptFile.add( !AYEAR.equals("") ? AYEAR_N : "");
				rptFile.add( !SMS.equals("") ? toFullSpace(SMS_NAME,1) : "");

				//------------------------------------------�Ǧ~ �B �Ǵ�  - ����

				//rptFile.add("(" + STTYPE_NAME.substring(0,1) + ")");			//�����O
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


					rptFile.add(CENTER_CODE_NAME);			//���ߧO
					rptFile.add(STNO);				//�Ǹ�
					rptFile.add(NAME);				//�m�W

				//-------------------------------------------  sutu010 ��إN���B��ئW�١B���O�B�Ǥ��B���Z - �}�l
				//by sorge���o�ǥͭ׽Ҫ����Z
				StringBuffer SQL_SCD004 = new StringBuffer();
				SQL_SCD004.append(
					"SELECT b.CRS_NAME, a.AYEAR, a.SMS, a.CRSNO, \n" +
					"	   a.CRSNO||decode(SUBSTR(a.CRSNO,1,2),'99','','')||decode(a.PASS_REPL_MK,'R','�w�ש�','S','�w�ש�','') AS CRS_SHOW,  \n" +
					"	   a.STNO,  \n" +
					"	   a.CRSNO_SMSGPA AS MARK, NVL(a.MIDMARK,'') AS MIDMARK, NVL(a.FNLMARK,'') AS FNLMARK, decode(a.PASS_REPL_MK,'R',b.CRD ,'S',b.CRD ,0) AS SR_CRD , \n" +
					"	   b.CRD, NVL(e.CRS_GROUP_CODE_NAME,'�������') AS CRS_GROUP_CODE_NAME \n" +
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
				int memodisplay=0;		//0:����� 1:���
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
						thisMark = "��";
						memodisplay=1;
					} else {
						//by poto
						if(rs_1.getInt("MARK")>59){
							CRD_ADD = CRD_ADD + rs_1.getInt("CRD");
						}
						thisMark = rs_1.getString("MARK");
					}
					rptFile.add(thisMark);			//���Z_01

					if(rs_1_count == 9)
						break;
				}
				if(rs_1_count < 9)
				{
				//by poto ���O'�H�U�ť�'
					rptFile.add("");
					rptFile.add("<center>�H�U�ť�</center>");
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
				//-------------------------------------------  sutu010 ��إN���B��ئW�١B�Ǥ��B���Z - ����

				//------------------------------------------- ���Ǵ��������Z - �}�l

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
						rptFile.add("*****");			//���Ǵ��������Z
					}else{
						if("0".equals(rs_1.getString("NUM")))
							rptFile.add("0.00");			//���Ǵ��������Z
						else
							rptFile.add(getFullMark(rs_1.getString("NUM")));			//���Ǵ��������Z
					}
				}else
					rptFile.add("*****");
				//------------------------------------------- ���Ǵ��������Z - ����

				rptFile.add(CRD_ADD);				//���Ǵ��ױo�Ǥ�

				/***�֭p��o�Ǥ� = SCDT004 �ή�Ǥ���***/
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
				rptFile.add(g1);				//�֭p�ױo�Ǥ�
				rptFile.add(rs.getString("ACCUM_REPL_CRD"));	//�֭p��K�Ǥ�
				if(rs.getInt("ACCUM_REDUCE_CRD")==0){
					rptFile.add("0&nbsp;");	//�֭p��׾Ǥ�
				}else{
					rptFile.add(rs.getString("ACCUM_REDUCE_CRD"));	//�֭p��׾Ǥ�
				}
				//rptFile.add(rs.getInt("ACCUM_PASS_CRD"));			//�֭p��o�Ǥ�
				rptFile.add("*****");				
				//by poto�аȪ��W��
				rptFile.add(getName(dbManager,conn));
				rptFile.add(CRRSADDR_ZIP);		//�q�T�l���ϸ�
				rptFile.add(CRRSADDR);			//�q�T�a�}
				rptFile.add(NAME);				//�m�W

				//---------------------------------------------------------���Z�Ƭd - �}�l
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
							rptFile.add("���Z�Ƭd�ɶ��G"+toChanisesFullChar(rs_1.getString("S_MONTH"))+"��");		//���Z�Ƭd�__��
							rptFile.add(toChanisesFullChar(rs_1.getString("S_DATE"))+"���");		//���Z�Ƭd�__��
						}
						else
						{
							rptFile.add("");
							rptFile.add("");
						}
						if(!rs_1.getString("E_MONTH").equals(""))
						{
							rptFile.add(toChanisesFullChar(rs_1.getString("E_MONTH"))+"��");		//���Z�Ƭd��_��
							rptFile.add(toChanisesFullChar(rs_1.getString("E_DATE"))+"��");		//���Z�Ƭd��_��
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
				//---------------------------------------------------------���Z�Ƭd - ����
				rptFile.add("");
				rptFile.add("");
				rptFile.add("");
				rptFile.add("");

					//��ܯʦ�
					if(memodisplay==1){
						rptFile.add("�y�ʡz�G��ҸկʦҡA�Ӭ줣�C�J�Ǵ��������Z");
					}else{
						rptFile.add("");
					}
					//�~��
					if(!sysdate.equals(""))
					{
						if(sysdate.substring(0,1).equals("0")){
							rptFile.add(sysdate.substring(1,3)+" �~");
						}else{
							rptFile.add(sysdate.substring(0,3)+" �~");
						}
						rptFile.add(sysdate.substring(3,5)+" ��");
						rptFile.add(sysdate.substring(5,7)+" ��"+BO_NAME_1+"�o");
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
				out.println("<script>top.close();alert(\"�L�ŦX��ƥi�ѦC�L!!\");</script>");
				return;
			}

			
			/** ��l�Ƴ����� */
			//20190307�s�W�P�_�O���Oie11
			
			report report_ = null;
			
			String BROWSER_TYPE = Utility.checkNull(requestMap.get("BROWSER_TYPE"), "");
			
			if("o".equals(BROWSER_TYPE)) {
				report_	=	new report(dbManager, conn, out, "scd201r_01r2", report.onlineHtmlMode);
			} else {
				report_	=	new report(dbManager, conn, out, "scd201r_02r2", report.onlineHtmlMode);
			}

			/** �R�A�ܼƳB�z */
			Hashtable	ht	=	new Hashtable();
			report_.setDynamicVariable(ht);

			/** �}�l�C�L */
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
 * (2005/7/28) �����G�ন��������r
 * @author tonny
 * @param s
 * @param a a = 0,���`�B�z  a = 1 ��Ĥ@��0�h�������ť�
 * @return
 */
public static String toChanisesFullChar(String s,int a){
  if(s==null || s.equals("")){
    return "";
  }
  
  char[] ca = s.toCharArray();
  for(int i=0; i<ca.length; i++){
    //by poto
  	if(i==0 && s.substring(0,1).equals("0") && a==1 ){    ca[i] = (char)12288;        continue;                  }  //�b���ť��ন�����ť�
    if(ca[i] > '\200'){    continue;   }      //�W�L�o�����ӳ��O����r�F�K
    if(ca[i] == 32){    ca[i] = (char)12288;        continue;                  }  //�b���ť��ন�����ť�
    if(Character.isLetterOrDigit(ca[i])){   ca[i] = (char)(ca[i] + 65248);  continue;  }  //�O���w�q���r�B�Ʀr�βŸ�

    ca[i] = (char)12288;  //�䥦���X�n�D���A�����ন�����ťաC
  }  	
  return String.valueOf(ca);
}
/**
 * (2005/7/28) �����G�ন��������r
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
    if(ca[i] > '\200'){    continue;   }      //�W�L�o�����ӳ��O����r�F�K
    if(ca[i] == 32){    ca[i] = (char)12288;        continue;                  }  //�b���ť��ন�����ť�
    if(Character.isLetterOrDigit(ca[i])){   ca[i] = (char)(ca[i] + 65248);  continue;  }  //�O���w�q���r�B�Ʀr�βŸ�

    ca[i] = (char)12288;  //�䥦���X�n�D���A�����ন�����ťաC
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