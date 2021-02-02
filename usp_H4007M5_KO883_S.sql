  
  

/*          
--WT_SG1_KO883         
DROP PROC usp_H4007M5_KO883_S           
DROP TYPE dbo.UTP_H4007M5_KO883          
CREATE TYPE dbo.UTP_H4007M5_KO883 AS TABLE          
(        
     EMP_NO  nvarchar(13) --1  
    ,NAME  nvarchar(30) --2  
    ,ROLL_PSTN_NM   nvarchar(12) --3  
    ,DEPT_NM  nvarchar(40) --4  
    ,WORK_DT  nvarchar(20) --5  
    ,DAY_WEEK  nvarchar(12) --6  
    ,START_TIME  nvarchar(8) --7  
    ,END_TIME  nvarchar(8) --8  
	,END_TIME_S  nvarchar(8) --9  
    ,TOT_TIME  nvarchar(8) --10  
    ,OT  nvarchar(8) --11  
    ,HT  nvarchar(8) --12  
    ,TT  nvarchar(8) --13  
    ,ETC1  nvarchar(24) --14
	,ETC2  nvarchar(24) --15
	,FLG_REPORT1  nvarchar(2) --16  
	,FLG_REPORT2  nvarchar(2) --17   
 ,CUD_CHAR   NVARCHAR(01) --18          
    ,ROW_NUM    INT    --19            
)          
*/          
/********************************************************************************************/          
/***** PROCEDURE NAME : usp_H4007M5_KO883_S          *****/          
/***** AUTHOR   : CHA            *****/          
/***** CREATE DATE  : 2020-12-23                *****/          
/***** DESCRIPTION  : 근태시간조정              *****/           
/***** HISTORY   :                   *****/          
/********************************************************************************************/                    
CREATE PROCEDURE [dbo].[usp_H4007M5_KO883_S]              
(               
  @TBL_DATA   UTP_H4007M5_KO883 READONLY              
, @USER_ID    NVARCHAR(13)              
, @MSG_CD     NVARCHAR(06)  OUTPUT              
, @MESSAGE    NVARCHAR(200)  OUTPUT              
, @ERR_POS    INT     OUTPUT              
)              
AS              
              
BEGIN              
 SET NOCOUNT ON              
              
 DECLARE                    
   
  @CUR_EMP_NO  nvarchar(24) --1  
    ,@CUR_NAME  nvarchar(24) --2  
    ,@CUR_ROLL_PSTN_NM   nvarchar(24) --3  
    ,@CUR_DEPT_NM  nvarchar(24) --4  
    ,@CUR_WORK_DT  nvarchar(24) --5  
    ,@CUR_DAY_WEEK  nvarchar(24) --6  
    ,@CUR_START_TIME nvarchar(24) --7  
    ,@CUR_END_TIME  nvarchar(24)    --8  
	,@CUR_END_TIME_S  nvarchar(24)    --9
    ,@CUR_TOT_TIME  nvarchar(24)    --10  
    ,@CUR_OT  nvarchar(24) --11  
    ,@CUR_HT  nvarchar(24) --12  
    ,@CUR_TT  nvarchar(24) --13  
    ,@CUR_ETC1  nvarchar(24) --14
	,@CUR_ETC2  nvarchar(24) --15
	,@CUR_FLG_REPORT1  nvarchar(24) --16
	,@CUR_FLG_REPORT2  nvarchar(24) --17
    ,@CUR_CUD_CHAR   NVARCHAR(01) --18          
    ,@CUR_ROW_NUM   INT    --19          
    ,@ERROR_NUMBER INT   --20  
    
              
  BEGIN TRY              
  BEGIN TRANSACTION              
              
               
  DECLARE Cur_WorkList CURSOR LOCAL FOR              
              
   
 SELECT   
     A.EMP_NO          --1
    ,A.NAME            --2
    ,A.ROLL_PSTN_NM    --3
    ,A.DEPT_NM         --4
    ,A.WORK_DT         --5
    ,A.DAY_WEEK        --6
    ,A.START_TIME      --7
    ,A.END_TIME        --8
	,A.END_TIME_S        --9
    ,A.TOT_TIME        --10
    ,A.OT              --11
    ,A.HT              --12
    ,A.TT              --13
    ,A.ETC1            --14
	,A.ETC2            --15
	,A.FLG_REPORT1     --16
	,A.FLG_REPORT2     --17
 ,A.CUD_CHAR           --18
    ,A.ROW_NUM         --19
                
  FROM @TBL_DATA A                   
              
  OPEN Cur_WorkList               
  FETCH NEXT FROM Cur_WorkList              
  INTO                  
   @CUR_EMP_NO         --1
  ,@CUR_NAME           --2
  ,@CUR_ROLL_PSTN_NM   --3 
  ,@CUR_DEPT_NM        --4
  ,@CUR_WORK_DT        --5
  ,@CUR_DAY_WEEK       --6
  ,@CUR_START_TIME     --7
  ,@CUR_END_TIME       --8
  ,@CUR_END_TIME_S     --9
  ,@CUR_TOT_TIME       --10
  ,@CUR_OT             --11
  ,@CUR_HT             --12
  ,@CUR_TT             --13
  ,@CUR_ETC1           --14
  ,@CUR_ETC2           --15
  ,@CUR_FLG_REPORT1    --16
  ,@CUR_FLG_REPORT2    --17
  ,@CUR_CUD_CHAR       --18  
  ,@CUR_ROW_NUM        --19
    
                    
  WHILE(@@FETCH_STATUS=0)              
  BEGIN              
   SET @ERR_POS = @CUR_ROW_NUM        
     
   IF convert(char(8),@CUR_TOT_TIME ,108) < convert(char(8),'00:00:00',108)  
   SET @CUR_TOT_TIME = convert(char(8),'00:00:00',108)  
              
  IF (@CUR_CUD_CHAR = 'U')     
   --IF (@CUD_CHAR = 'U')                 
  BEGIN              

   -- 두번째로 INSERT하는경우 중복데이터가 존재할때 Update로 덮어씌우는 쿼리 실행  
   IF EXISTS(                           
   SELECT TOP 1 * FROM WT_SG1_KO883   
    
   WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'') 
   AND ISNULL(START_TIME,'') = ISNULL(@CUR_START_TIME,'')   
   AND ISNULL(END_TIME,'') = ISNULL(@CUR_END_TIME,'') AND ISNULL(OT,'') = ISNULL(@CUR_OT,'') AND ISNULL(FLG_REPORT1,'')  = ISNULL(@CUR_FLG_REPORT1,'')
   AND ISNULL(ETC1,'') = ISNULL(@CUR_ETC1,'')   AND ISNULL(FLG_REPORT2,'') = ISNULL(@CUR_FLG_REPORT2,'') 

   )     
       UPDATE WT_SG1_KO883  
    SET  
         EMP_NO  =  @CUR_EMP_NO   
        ,NAME    =  @CUR_NAME    
        ,ROLL_PSTN_NM =  @CUR_ROLL_PSTN_NM  
        ,DEPT_NM   =  @CUR_DEPT_NM    
        ,WORK_DT   =  @CUR_WORK_DT    
        ,DAY_WEEK   =  @CUR_DAY_WEEK    
        ,START_TIME   =  @CUR_START_TIME  
        ,END_TIME   =  @CUR_END_TIME   
		,END_TIME_S   =  @CUR_END_TIME_S   
        ,TOT_TIME   =  @CUR_TOT_TIME   
        ,OT     =  @CUR_OT  
        ,HT     =  @CUR_HT  
        ,TT     =  @CUR_TT  
        ,ETC1    =  @CUR_ETC1  
		,ETC2    =  @CUR_ETC2
		,FLG_REPORT1    =  CASE @CUR_FLG_REPORT1
		                   WHEN '신청' 
						   THEN 'Y'
						   ELSE 'N'
						   END
		,FLG_REPORT2    =  CASE @CUR_FLG_REPORT2
		                   WHEN '결과' 
						   THEN 'Y'
						   ELSE 'N'
						   END

  ,UPDT_USER_ID = @USER_ID  
  ,UPDT_DT      = GETDATE()  
       WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'') AND ISNULL(START_TIME,'') = ISNULL(@CUR_START_TIME,'')   
       AND ISNULL(END_TIME,'') = ISNULL(@CUR_END_TIME,'') AND ISNULL(OT,'') = ISNULL(@CUR_OT,'') AND ISNULL(ETC1,'') = ISNULL(@CUR_ETC1,'')  AND ISNULL(FLG_REPORT1,'') = ISNULL(@CUR_FLG_REPORT1,'') AND ISNULL(FLG_REPORT2,'') = ISNULL(@CUR_FLG_REPORT2,'') 

ELSE IF  -- 같은사번, 같은일자의 연장근무 신청값 승인은있는데 결과값 승인이 진행 안된 경우 신청의 값을 덮어쓰는 조건문
EXISTS(                           
   SELECT TOP 1 * FROM WT_SG1_KO883   
    
   WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')   AND FLG_REPORT1 ='N' AND ISNULL(@CUR_FLG_REPORT1,'') = '신청' AND ETC1 <>'반차(오전)'
   order by EMP_NO,WORK_DT,TOT_TIME

   )     
       UPDATE WT_SG1_KO883  
    SET  
         EMP_NO  =  @CUR_EMP_NO   
        ,NAME    =  @CUR_NAME    
        ,ROLL_PSTN_NM =  @CUR_ROLL_PSTN_NM  
        ,DEPT_NM   =  @CUR_DEPT_NM    
        ,WORK_DT   =  @CUR_WORK_DT    
        ,DAY_WEEK   =  @CUR_DAY_WEEK    
        ,START_TIME   =  @CUR_START_TIME  
        ,END_TIME   =  @CUR_END_TIME
		,END_TIME_S = @CUR_END_TIME_S   
        ,TOT_TIME   =  @CUR_TOT_TIME   
        ,OT     =  @CUR_OT  
        ,HT     =  @CUR_HT  
        ,TT     =  @CUR_TT  
        ,ETC1    =  @CUR_ETC1
		--,ETC2    =  @CUR_ETC2  
		,FLG_REPORT1 = CASE @CUR_FLG_REPORT1
		               WHEN '신청' 
					   THEN 'Y'
					   ELSE 'N'
					   END 
  ,UPDT_USER_ID = @USER_ID  
  ,UPDT_DT      = GETDATE()  
       WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')   AND ISNULL(FLG_REPORT1,'') = 'N'

ELSE IF  -- 같은사번,같은일자의 반차(오전)전자결재값이 있는데 연장근무인경우 -1 ( 신청행을 반차행과 합치는 과정)
EXISTS(                           
   SELECT TOP 1 * FROM WT_SG1_KO883   
    
   WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')   AND FLG_REPORT1 ='N' AND ISNULL(@CUR_FLG_REPORT1,'') = '신청'AND ETC1 = '반차(오전)'
   

   )     
       UPDATE WT_SG1_KO883  
         SET  
         EMP_NO  =  @CUR_EMP_NO   
        ,NAME    =  @CUR_NAME    
        ,ROLL_PSTN_NM =  @CUR_ROLL_PSTN_NM  
        ,DEPT_NM   =  @CUR_DEPT_NM    
        ,WORK_DT   =  @CUR_WORK_DT    
        ,DAY_WEEK   =  @CUR_DAY_WEEK    
        ,START_TIME   =  @CUR_START_TIME  
        ,END_TIME   =  @CUR_END_TIME
		,END_TIME_S = @CUR_END_TIME_S   
        ,TOT_TIME   =  '04:00:00'  
        ,OT     =  @CUR_OT  
        ,HT     =  @CUR_HT  
        ,TT     =  @CUR_TT  
        ,ETC1    =  @CUR_ETC1
		,ETC2    =  '반차(오전)' 
		,FLG_REPORT1 = CASE @CUR_FLG_REPORT1
		               WHEN '신청' 
					   THEN 'Y'
					   ELSE 'N'
					   END 
  ,UPDT_USER_ID = @USER_ID  
  ,UPDT_DT      = GETDATE()  
       WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')   AND ISNULL(FLG_REPORT1,'') = 'N'AND ISNULL(ETC1,'') = '반차(오전)'

ELSE IF  -- 같은사번,같은일자의 반차(오전)전자결재값이 있는데 연장근무인경우 - 2 ( 신청+반차행을 결과행과 합치는과정)
EXISTS(                           
   SELECT TOP 1 * FROM WT_SG1_KO883   
    
   WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')   AND FLG_REPORT1 ='Y' AND ISNULL(@CUR_FLG_REPORT2,'') = '결과'AND ISNULL(ETC2,'') = '반차(오전)'
   order by EMP_NO,WORK_DT,TOT_TIME

   )     
       UPDATE WT_SG1_KO883  
         SET  
         EMP_NO  =  @CUR_EMP_NO   
        ,NAME    =  @CUR_NAME    
        ,ROLL_PSTN_NM =  @CUR_ROLL_PSTN_NM  
        ,DEPT_NM   =  @CUR_DEPT_NM    
        ,WORK_DT   =  @CUR_WORK_DT    
        ,DAY_WEEK   =  @CUR_DAY_WEEK    
        ,START_TIME   =  @CUR_START_TIME  
        ,END_TIME   =  @CUR_END_TIME
		,END_TIME_S = @CUR_END_TIME_S   
        ,TOT_TIME   =  convert(char(8),dateadd(n,datediff(n,0,@CUR_OT) + 240,0) ,108)   
        ,OT     =  @CUR_OT  
        ,HT     =  @CUR_HT  
        ,TT     =  @CUR_TT  
        ,ETC1    =  @CUR_ETC1
		--,ETC2    =  '반차(오전)' 
		,FLG_REPORT2 = CASE @CUR_FLG_REPORT2
		               WHEN '결과' 
					   THEN 'Y'
					   ELSE 'N'
					   END 
  ,UPDT_USER_ID = @USER_ID  
  ,UPDT_DT      = GETDATE()  
       WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')   AND ISNULL(FLG_REPORT1,'') = 'Y'AND ISNULL(ETC2,'') = '반차(오전)'

/*
ELSE IF  -- 연장근무 신청 승인값이 없는데 결과값만 올린경우
 EXISTS(                           
   SELECT TOP 1 * FROM WT_SG1_KO883   
    
   WHERE FLG_REPORT1 ='N' AND FLG_REPORT2 ='Y' AND ETC1 = '연장근무1'  AND ETC2 <> '신청상신필요'
   

   )     
       UPDATE WT_SG1_KO883  
         SET  
         
       TOT_TIME   =  '08:00:00'  		
      , ETC2 = '신청상신필요'
      ,UPDT_USER_ID = @USER_ID  
      ,UPDT_DT      = GETDATE()  
       WHERE FLG_REPORT1 ='N' AND FLG_REPORT2 ='Y' AND ETC1 = '연장근무1'  AND ETC2 <> '신청상신필요'


ELSE IF  -- 휴일근무 신청 승인값이 없는데 결과값만 올린경우
 EXISTS(                           
   SELECT TOP 1 * FROM WT_SG1_KO883   
    
   WHERE FLG_REPORT1 ='N' AND FLG_REPORT2 ='Y' AND ETC1 = '휴일근무1'  AND ETC2 <> '신청상신필요'
   

   )     
       UPDATE WT_SG1_KO883  
         SET  
         
        TOT_TIME   =  '00:00:00'  		
	  , ETC2 = '신청상신필요'
      ,UPDT_USER_ID = @USER_ID  
      ,UPDT_DT      = GETDATE()  
       WHERE FLG_REPORT1 ='N' AND FLG_REPORT2 ='Y' AND ETC1 = '휴일근무1'  AND ETC2 <> '신청상신필요'
*/	   

ELSE IF  -- 전자결재 승인값이 없고 미승인 데이터의 행이있어 행이 두개 표시될때 합치는식
EXISTS(                           
   SELECT TOP 1 * FROM WT_SG1_KO883   
    
   WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')    AND ISNULL(@CUR_ETC2,'') = '미승인' AND ISNULL(FLG_REPORT1,'') = 'N' AND ISNULL(FLG_REPORT2,'') = 'N' 
   order by EMP_NO,WORK_DT,TOT_TIME

   )     
       UPDATE WT_SG1_KO883  
    SET  
         
		ETC2    =  @CUR_ETC2  

  ,UPDT_USER_ID = @USER_ID  
  ,UPDT_DT      = GETDATE()  
       WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')     AND ISNULL(@CUR_ETC2,'') = '미승인' AND ISNULL(FLG_REPORT1,'') = 'N' AND ISNULL(FLG_REPORT2,'') = 'N' 

ELSE IF  -- 신청,결과 각각의 결재가 있을 때 신청,결과를 한가지 행에 update
EXISTS(                           
   SELECT TOP 1 * FROM WT_SG1_KO883   
    
   WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')   AND ISNULL(FLG_REPORT1,'') = 'Y' AND ISNULL(@CUR_FLG_REPORT2,'') = '결과' AND ISNULL(ETC1,'') <> '반차(오전)'
   order by EMP_NO,WORK_DT,TOT_TIME

   )     
       UPDATE WT_SG1_KO883  
    SET  
         EMP_NO  =  @CUR_EMP_NO   
        ,NAME    =  @CUR_NAME    
        ,ROLL_PSTN_NM =  @CUR_ROLL_PSTN_NM  
        ,DEPT_NM   =  @CUR_DEPT_NM    
        ,WORK_DT   =  @CUR_WORK_DT    
        ,DAY_WEEK   =  @CUR_DAY_WEEK    
        ,START_TIME   =  @CUR_START_TIME  
        ,END_TIME   =  @CUR_END_TIME
		,END_TIME_S = @CUR_END_TIME_S   
        ,TOT_TIME   =  @CUR_TOT_TIME   
        ,OT     =  @CUR_OT  
        ,HT     =  @CUR_HT  
        ,TT     =  @CUR_TT  
        ,ETC1    =  @CUR_ETC1
		,ETC2    =  @CUR_ETC2  
		,FLG_REPORT2 = CASE @CUR_FLG_REPORT2
		               WHEN '결과' 
					   THEN 'Y'
					   ELSE 'N'
					   END 
  ,UPDT_USER_ID = @USER_ID  
  ,UPDT_DT      = GETDATE()  
       WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')   AND ISNULL(FLG_REPORT1,'') = 'Y'



--ELSE IF  -- 연장근무 신청보고서 없이 결과보고서만 올릴때
--NOT EXISTS(                           
--   SELECT TOP 1 * FROM WT_SG1_KO883   
    
--   WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')  AND ISNULL(FLG_REPORT1,'') = 'Y' AND ISNULL(@CUR_FLG_REPORT2,'') = '결과'  AND ISNULL(@CUR_ETC1,'') = '연장근무1' 
--   order by EMP_NO,WORK_DT,TOT_TIME

--   )     
--       UPDATE WT_SG1_KO883  
--    SET  
--         EMP_NO  =  @CUR_EMP_NO   
--        ,NAME    =  @CUR_NAME    
--        ,ROLL_PSTN_NM =  @CUR_ROLL_PSTN_NM  
--        ,DEPT_NM   =  @CUR_DEPT_NM    
--        ,WORK_DT   =  @CUR_WORK_DT    
--        ,DAY_WEEK   =  @CUR_DAY_WEEK    
--        ,START_TIME   =  @CUR_START_TIME  
--        ,END_TIME   =  @CUR_END_TIME   
--        ,TOT_TIME   =  convert(char(8),'08:00:00',108)     
--        ,OT     =  convert(char(8),'00:00:00',108)  
--        ,HT     =  @CUR_HT  
--        ,TT     =  @CUR_TT  
--        ,ETC1    =  @CUR_ETC1  
--		,FLG_REPORT2 = CASE @CUR_FLG_REPORT2
--		               WHEN '결과' 
--					   THEN 'Y'
--					   ELSE 'N'
--					   END 
--  ,UPDT_USER_ID = @USER_ID  
--  ,UPDT_DT      = GETDATE()  
--       WHERE ISNULL(EMP_NO,'') = ISNULL(@CUR_EMP_NO,'') AND ISNULL(WORK_DT,'') = ISNULL(@CUR_WORK_DT,'')  

ELSE  
 INSERT INTO WT_SG1_KO883          
     (          
     EMP_NO         --1
    ,NAME           --2
    ,ROLL_PSTN_NM   --3 
    ,DEPT_NM        --4
    ,WORK_DT        --5
    ,DAY_WEEK       --6
    ,START_TIME     --7
    ,END_TIME       --8
	,END_TIME_S     --9
  ,TOT_TIME         --10
    ,OT             --11
    ,HT             --12
    ,TT             --13
    ,ETC1           --14
	,ETC2           --15
	,FLG_REPORT1    --16
	,FLG_REPORT2    --17
 ,INSRT_USER_ID     --18
 ,INSRT_DT          --19
 ,UPDT_USER_ID      --20
 ,UPDT_DT           --21
       
     )          
     VALUES          
     (          
     @CUR_EMP_NO        --1
    ,@CUR_NAME          --2
    ,@CUR_ROLL_PSTN_NM  --3   
    ,@CUR_DEPT_NM       --4
    ,@CUR_WORK_DT       --5
    ,@CUR_DAY_WEEK      --6
    ,@CUR_START_TIME    --7
    ,@CUR_END_TIME      --8
	,@CUR_END_TIME_S    --9
    ,@CUR_TOT_TIME      --10
    ,@CUR_OT            --11
    ,@CUR_HT            --12
    ,@CUR_TT            --13
    ,@CUR_ETC1          --14
	,@CUR_ETC2          --15
	,CASE @CUR_FLG_REPORT1  --16
	 WHEN '신청'
	 THEN 'Y'
	 ELSE 'N'
	 END
	,CASE @CUR_FLG_REPORT2  --17
	 WHEN '결과'
	 THEN 'Y'
	 ELSE 'N'
	 END
    ,@USER_ID           --18
 ,GETDATE()             --19
 ,@USER_ID              --20
 ,GETDATE()             --21
     )          
                  
              
  END              
  --ELSE IF (@CUR_CUD_CHAR = 'D')              
  --BEGIN              
                  
  --  --DELETE FROM IP_DTL               
  --  --WHERE              
  --  --  IP = @IP  
      
              
  --END              
          
       
               
  FETCH NEXT FROM Cur_WorkList              
  INTO               
      
     @CUR_EMP_NO            
    ,@CUR_NAME                
    ,@CUR_ROLL_PSTN_NM     
    ,@CUR_DEPT_NM    
    ,@CUR_WORK_DT    
    ,@CUR_DAY_WEEK    
    ,@CUR_START_TIME   
    ,@CUR_END_TIME    
	,@CUR_END_TIME_S
    ,@CUR_TOT_TIME    
    ,@CUR_OT    
    ,@CUR_HT    
    ,@CUR_TT    
    ,@CUR_ETC1  
	,@CUR_ETC2 
	,@CUR_FLG_REPORT1 
	,@CUR_FLG_REPORT2     
    ,@CUR_CUD_CHAR         
    ,@CUR_ROW_NUM            
              
              
  END --WHILE END              
               
              
 CLOSE Cur_WorkList              
 DEALLOCATE Cur_WorkList                         
              
 END TRY              
 BEGIN CATCH              
               
 SET @ERROR_NUMBER = ERROR_NUMBER()              
                
  IF @ERROR_NUMBER = 2627  --%1! 제약 조건 '%2!'을(를) 위반했습니다. 개체 '%3!'에 중복 키를 삽입할 수 없습니다. 중복 키 값은 %4!입니다.              
   BEGIN              
    SET @MSG_CD   = '970001' -- %1 이(가) 이미 존재합니다.                 
   END              
              
  ELSE IF @ERROR_NUMBER = 547  -- %1! 문이 %2! 제약 조건 "%3!"과(와) 충돌했습니다. 데이터베이스 "%4!", 테이블 "%5!"%6!%7!%8!에서 충돌이 발생했습니다.              
   BEGIN              
    SET @MSG_CD   = '971000' -- %1 이(가) 참조하고 있는 데이터가 있습니다. 작업을 진행할 수 없습니다.                   
   END              
              
  ELSE IF @ERROR_NUMBER = 1205  -- 트랜잭션(프로세스 ID %1!)이 %2! 리소스에서 다른 프로세스와의 교착 상태가 발생하여 실행이 중지되었습니다. 트랜잭션을 다시 실행하십시오.              
   BEGIN              
    SET @MSG_CD   = '122918' -- %1 저장에 실패했습니다.                      
   END              
              
  ELSE              
   SET @MESSAGE  = ERROR_MESSAGE()              
              
  GOTO __ERROR              
 END CATCH              
              
 IF @@TRANCOUNT > 0 COMMIT TRANSACTION              
 RETURN 1              
              
 __ERROR:              
 IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION              
 RETURN -1              
END 