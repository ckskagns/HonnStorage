
--���̺� ���� ����� ����
--  CREATE TYPE UTP_H4007M5_KO883 AS TABLE
--(
--    EMP_NO   NVARCHAR(26)                       
--  , ST_NUM NVARCHAR (40)            
--  , BIND_NUM  NVARCHAR (40)                        
--  , EMAIL NVARCHAR(80)                
--  , G_EMAIL  NVARCHAR(80)                  
--  , CUD_CHAR NVARCHAR(2)                
--  , ROW_NUM  INT                  
--  , ERROR_NUMBER INT   
--);
            
CREATE PROCEDURE [dbo].[USP_H4007M5_KO883_CUD]              
(               
  @TBL_DATA    UTP_H4007M5_KO883 READONLY              
, @USER_ID    NVARCHAR(13)              
, @MSG_CD     NVARCHAR(06)  OUTPUT              
, @MESSAGE    NVARCHAR(200)  OUTPUT              
, @ERR_POS    INT     OUTPUT              
)              
AS              
              
BEGIN              
 SET NOCOUNT ON              
              
 DECLARE                    
    @EMP_NO   NVARCHAR(26)                       
  , @ST_NUM NVARCHAR (40)            
  , @BIND_NUM  NVARCHAR (40)                        
  , @EMAIL NVARCHAR(80)                
  , @G_EMAIL  NVARCHAR(80)                  
  , @CUD_CHAR NVARCHAR(2)                
  , @ROW_NUM  INT                  
  , @ERROR_NUMBER INT                     
    
              
  BEGIN TRY              
  BEGIN TRANSACTION              
              
               
  DECLARE CUR_H4007M5_KO883 CURSOR LOCAL FOR              
              
  SELECT              
     EMP_NO
   , ST_NUM
   , BIND_NUM
   , EMAIL
   , G_EMAIL
   , CUD_CHAR               
   , ROW_NUM
                 
   FROM @TBL_DATA              
              
  OPEN CUR_H4007M5_KO883               
  FETCH NEXT FROM CUR_H4007M5_KO883              
  INTO               
     @EMP_NO
   , @ST_NUM
   , @BIND_NUM
   , @EMAIL
   , @G_EMAIL
   , @CUD_CHAR               
   , @ROW_NUM
 --@YYYY              
 -- , @DILIG_EMP_NO              
 -- , @BASIC_QTY       
 -- , @ETC1_QTY          
 -- , @ETC2_QTY      
 -- , @USER_QTY                  
 -- , @CUD_CHAR      
 -- , @ROW_NUM             
    
                    
  WHILE(@@FETCH_STATUS=0)              
  BEGIN              
   SET @ERR_POS = @ROW_NUM              
              
  IF (@CUD_CHAR = 'C')              
  BEGIN              
       
    INSERT INTO Ex_Number              
    (              
     EMP_NO
   , ST_NUM
   , BIND_NUM
   , EMAIL
                  
    )              
    VALUES              
    (              
	 @EMP_NO
   , @ST_NUM
   , @BIND_NUM
   , @EMAIL

                  
    )              
  END              
  ELSE IF (@CUD_CHAR = 'U')     
   --IF (@CUD_CHAR = 'U')                 
  BEGIN              
    UPDATE Ex_Number              
    SET  
	ST_NUM = @ST_NUM
   ,BIND_NUM = @BIND_NUM
   ,EMAIL = @EMAIL
   WHERE
	EMP_NO = @EMP_NO
	                  
 --    BASIC_QTY   = @BASIC_QTY        
 --   ,USER_QTY     = @USER_QTY  
 --,ETC1_QTY = @ETC1_QTY            
 --   ,UPDT_EMP_NO = @USER_ID              
 --   ,UPDT_DT   = GETDATE()              
 --   WHERE              
 --     YYYY = @YYYY               
 --   AND DILIG_EMP_NO = @DILIG_EMP_NO              
    --AND EMP_NO = @EMP_NO              
                  
              
  END              
  ELSE IF (@CUD_CHAR = 'D')              
  BEGIN              
                  
    DELETE FROM Ex_Number               
    WHERE              
      EMP_NO = @EMP_NO          
      
              
  END              
         IF (@CUD_CHAR <> 'D')       
          BEGIN          
    BEGIN      
         SET @MSG_CD   = '122918' -- %1 ���忡 �����߽��ϴ�.                   
     RAISERROR(@MSG_CD, 16, 1)      
    END      
    END      
        
               
  FETCH NEXT FROM CUR_H4007M5_KO883              
  INTO               
     @EMP_NO
   , @ST_NUM
   , @BIND_NUM
   , @EMAIL
   , @G_EMAIL
   , @CUD_CHAR               
   , @ROW_NUM          
              
              
  END --WHILE END              
               
              
 CLOSE CUR_H4007M5_KO883              
 DEALLOCATE CUR_H4007M5_KO883                        
              
 END TRY              
 BEGIN CATCH              
               
 SET @ERROR_NUMBER = ERROR_NUMBER()              
                
  IF @ERROR_NUMBER = 2627  --%1! ���� ���� '%2!'��(��) �����߽��ϴ�. ��ü '%3!'�� �ߺ� Ű�� ������ �� �����ϴ�. �ߺ� Ű ���� %4!�Դϴ�.              
   BEGIN              
    SET @MSG_CD   = '970001' -- %1 ��(��) �̹� �����մϴ�.                         
   END              
              
  ELSE IF @ERROR_NUMBER = 547  -- %1! ���� %2! ���� ���� "%3!"��(��) �浹�߽��ϴ�. �����ͺ��̽� "%4!", ���̺� "%5!"%6!%7!%8!���� �浹�� �߻��߽��ϴ�.              
   BEGIN              
    SET @MSG_CD   = '971000' -- %1 ��(��) �����ϰ� �ִ� �����Ͱ� �ֽ��ϴ�. �۾��� ������ �� �����ϴ�.                         
   END              
              
  ELSE IF @ERROR_NUMBER = 1205  -- Ʈ�����(���μ��� ID %1!)�� %2! ���ҽ����� �ٸ� ���μ������� ���� ���°� �߻��Ͽ� ������ �����Ǿ����ϴ�. Ʈ������� �ٽ� �����Ͻʽÿ�.              
   BEGIN              
    SET @MSG_CD   = '122918' -- %1 ���忡 �����߽��ϴ�.                     
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

