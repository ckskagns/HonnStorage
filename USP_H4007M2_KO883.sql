                  
                    
ALTER PROCEDURE [dbo].[USP_H4007M2_KO883]                    
 (          
 @EMP_NO nvarchar(26), -- ���        
 @DEPT_NO nvarchar(26), -- �μ���ȣ        
 @Work_From nvarchar(26), -- �ٹ�����From           
    @Work_To  nvarchar(26)  -- �ٹ�����To        
                     
 ) AS                              
                        
 BEGIN                                                  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED                                            
                                               
SET NOCOUNT ON                            
        
  IF @Work_From IS NULL OR @Work_From = '' SET @Work_From ='1900-01-01'             
  IF @Work_To IS NULL OR @Work_To = '' SET @Work_To ='2099-12-31'         
  
        

      
select  distinct      

      
  A.EMP_NO    ,       
  A.NAME      ,      
  B.DEPT_NM     ,  
  dbo.ufn_getcodename('h0002', roll_pstn) as ROLL_PSTN_NM,  
  CONVERT (varchar,A.WORK_DT,23) as WORK_DT ,      
   (SELECT MINOR_NM FROM B_MINOR WHERE MAJOR_CD = 'XH004' AND MINOR_CD = A.DAY_WEEK) AS DAY_WEEK,  
      
CASE A.DAY_WEEK  
WHEN '01'  
THEN    
      CASE E.APPROVAL_RTN  
      WHEN '1'  
      THEN CASE F.REPORT_TYPE  
           WHEN '1'  
           THEN CASE D.DILIG_NM  
                WHEN '����ٹ�1'  
                THEN CASE ISNULL(convert(char(8),A.START_TIME,108),'')
				     WHEN ''
					 THEN convert(char(8),'09:00:00',108)
					 ELSE convert(char(8),A.START_TIME,108)
					 END
				WHEN '����(����)'
				THEN convert(char(8),'14:00:00',108)  
				WHEN '����(����)'
				THEN convert(char(8),'09:00:00',108)  
		        END 
		   WHEN '2'
		   THEN CASE D.DILIG_NM  
                WHEN '����ٹ�1'  
                THEN  convert(char(8),A.START_TIME ,108)
		        END
		   ELSE convert(char(8),'00:00:00' ,108)
		   END
	  ELSE CASE ISNULL(A.START_TIME,'')  
           WHEN ''  
           THEN  CASE ISNULL(A.END_TIME,'')  
                 WHEN ''  
                 THEN '00:00:00'  
                 ELSE '09:00:00'  
                 END  
           ELSE convert(char(8),A.START_TIME,108)   
           END  
	  END

 WHEN '02'
 THEN CASE E.APPROVAL_RTN
      WHEN '1'
	  THEN CASE F.REPORT_TYPE
	       WHEN '2'
		   THEN CASE D.DILIG_NM
		        WHEN '���ϱٹ�1'
				THEN convert(char(8),dateadd(n,(C.DILIG_HH_FR * 60) + C.DILIG_MM_FR , 0),108) 
				ELSE convert(char(8),'00:00:00' ,108)
				END
			ELSE convert(char(8),'00:00:00' ,108)
			END
	  ELSE convert(char(8),'00:00:00' ,108)
	  END
WHEN '09'  --����(����8��)�϶�
THEN    
      CASE E.APPROVAL_RTN  
      WHEN '1'  
      THEN CASE F.REPORT_TYPE  
           WHEN '1'  
           THEN CASE D.DILIG_NM  
                WHEN '����ٹ�1'  
                THEN CASE ISNULL(convert(char(8),A.START_TIME,108),'')
				     WHEN ''
					 THEN convert(char(8),'08:00:00',108)
					 ELSE convert(char(8),A.START_TIME,108)
					 END
				WHEN '����(����)'
				THEN convert(char(8),'13:00:00',108)  
				WHEN '����(����)'
				THEN convert(char(8),'08:00:00',108)  
		        END 
		   WHEN '2'
		   THEN CASE D.DILIG_NM  
                WHEN '����ٹ�1'  
                THEN  convert(char(8),A.START_TIME ,108)
		        END
		   ELSE convert(char(8),'00:00:00' ,108)
		   END
	  ELSE CASE ISNULL(A.START_TIME,'')  
           WHEN ''  
           THEN  CASE ISNULL(A.END_TIME,'')  
                 WHEN ''  
                 THEN '00:00:00'  
                 ELSE '08:00:00'  
                 END  
           ELSE convert(char(8),A.START_TIME,108)   
           END  
	  END
WHEN '10'  --�߰�(18��)�϶�
THEN    
      CASE E.APPROVAL_RTN  
      WHEN '1'  
      THEN CASE F.REPORT_TYPE  
           WHEN '1'  
           THEN CASE D.DILIG_NM  
                WHEN '����ٹ�1'  
                THEN CASE ISNULL(convert(char(8),A.START_TIME,108),'')
				     WHEN ''
					 THEN convert(char(8),'18:00:00',108)
					 ELSE convert(char(8),A.START_TIME,108)
					 END
				WHEN '����(����)'
				THEN convert(char(8),'21:00:00',108)  
				WHEN '����(����)'
				THEN convert(char(8),'18:00:00',108)  
		        END 
		   WHEN '2'
		   THEN CASE D.DILIG_NM  
                WHEN '����ٹ�1'  
                THEN  convert(char(8),A.START_TIME ,108)
		        END
		   ELSE convert(char(8),'00:00:00' ,108)
		   END
	  ELSE CASE ISNULL(A.START_TIME,'')  
           WHEN ''  
           THEN  CASE ISNULL(A.END_TIME,'')  
                 WHEN ''  
                 THEN '00:00:00'  
                 ELSE '18:00:00'  
                 END  
           ELSE convert(char(8),A.START_TIME,108)   
           END  
	  END	          
 ELSE  CASE ISNULL(A.START_TIME,'')  
       WHEN ''  
       THEN  CASE ISNULL(A.END_TIME,'')  
             WHEN ''  
             THEN '00:00:00'  
             ELSE '18:00:00'  
             END  
       ELSE convert(char(8),A.START_TIME,108)   
       END  
 END   
  as START_TIME,   
CASE ISNULL(E.APPROVAL_RTN,'')  
WHEN ''  
THEN CASE A.DAY_WEEK  
     WHEN '01'  
     THEN CASE ISNULL(D.DILIG_NM,'')  
          WHEN ''  
          THEN CASE ISNULL(A.END_TIME,'')  
               WHEN ''  
               THEN CASE ISNULL(A.START_TIME,'')  
                    WHEN ''  
                    THEN convert(char(8),'00:00:00',108)
                    ELSE convert(char(8),'18:00:00',108)
                    END  
              ELSE convert(char(8),'18:00:00',108) 
              END  
          ELSE CASE ISNULL(A.END_TIME,'')  
               WHEN ''  
               THEN CASE ISNULL(A.START_TIME,'')  
                    WHEN ''  
                    THEN convert(char(8),'00:00:00',108)  
                    ELSE convert(char(8),'18:00:00',108) 
                    END  
               ELSE convert(char(8),'18:00:00',108) 
               END  
          END  
     WHEN '02'  
     THEN '00:00:00' 
     WHEN '09'  --����(����8��)�׽�Ʈ
           THEN CASE ISNULL(D.DILIG_NM,'')  
                WHEN ''  
                THEN CASE ISNULL(A.END_TIME,'')  
                     WHEN ''  
                     THEN CASE ISNULL(A.START_TIME,'')  
                          WHEN ''  
                          THEN '00:00:00'  
                          ELSE '17:00:00'  
                          END  
                    ELSE convert(char(8), A.END_TIME,108)  
                    END  
                ELSE CASE ISNULL(A.END_TIME,'')  
                     WHEN ''  
                     THEN CASE ISNULL(A.START_TIME,'')  
                          WHEN ''  
                          THEN '00:00:00'  
                          ELSE '17:00:00'  
                          END  
                     ELSE convert(char(8), A.END_TIME,108)  
                     END  
                END 
      WHEN '10'  --�߰�(18��)�϶� �׽�Ʈ
      THEN CASE ISNULL(D.DILIG_NM,'')  
           WHEN ''  
           THEN CASE ISNULL(A.END_TIME,'')  
                WHEN ''  
                THEN CASE ISNULL(A.START_TIME,'')  
                     WHEN ''  
                     THEN '00:00:00'  
                     ELSE '03:00:00'  
                     END  
                 ELSE convert(char(8), A.END_TIME,108)  
                 END  
           ELSE CASE ISNULL(A.END_TIME,'')  
                WHEN ''  
                THEN CASE ISNULL(A.START_TIME,'')  
                     WHEN ''  
                     THEN '00:00:00'  
                     ELSE '03:00:00'  
                     END  
                ELSE convert(char(8), A.END_TIME,108)  
                END  
           END 
      ELSE  convert(char(8),'00:00:00',108)  
      END  
 WHEN '1'  
 THEN   CASE A.DAY_WEEK  
        WHEN '01'   
        THEN CASE ISNULL(D.DILIG_NM,'')  
             WHEN ''  
             THEN CASE ISNULL(A.END_TIME,'')  
                  WHEN ''  
                  THEN CASE ISNULL(A.START_TIME,'')  
                       WHEN ''  
                       THEN '00:00:00'  
                       ELSE '18:00:00'  
                       END  
                  ELSE convert(char(8), A.END_TIME,108)  
                  END  
             WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
             THEN '18:00:00'  
             WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
             THEN '14:00:00'  
             WHEN '����ٹ�1'   
             THEN  CASE F.REPORT_TYPE
                   WHEN '1'
	               THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
	                    WHEN ''
	                    THEN convert(char(8),'18:00:00',108)
	                    ELSE convert(char(8),A.END_TIME,108)
	                    END  
                   WHEN '2'  
                   THEN   
                        CASE   
                        WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') >= convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 1080 ,0),108) -- �����ǽð��� ǥ�ؽð�(18��+����ٹ��ð�) ���� ũ�ų� ������ ������� ���
   	                    THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
						WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') < convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 1080 ,0),108) -- �����ǽð��� ǥ�ؽð�(18��+����ٹ��ð�) ���� ������ ���� ���� ��� 
						THEN convert(char(8),A.END_TIME - 
						                                 CASE 
														 WHEN ISNULL(A.START_TIME ,'') = ''
														 THEN convert(char(8),'09:00:00',108)
														 WHEN A.START_TIME >= convert(char(8),'09:00:00',108)
														 THEN A.START_TIME
														 WHEN A.START_TIME < convert(char(8),'09:00:00',108)
														 THEN convert(char(8),'09:00:00',108)
														 ELSE convert(char(8),'09:00:00',108)
														 END
														      
														 ,108)
                        ELSE CASE ISNULL(A.END_TIME,'')  
                             WHEN ''  
                             THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO +1080 , 0),108)   -- ��ٽð��� ���������� ���ڰ����� ����ٹ��ð��� �ҷ��� ����ϴ½�  
                             ELSE convert(char(8),A.END_TIME,108)  
                             END
                         END  
                    ELSE convert(char(8),'00:00:00',108)  
                    END   
             WHEN '����ٹ�2'  
             THEN CASE F.REPORT_TYPE
                   WHEN '1'
	               THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
	                    WHEN ''
	                    THEN convert(char(8),'18:00:00',108)
	                    ELSE convert(char(8),A.END_TIME,108)
	                    END  
                   WHEN '2'  
                   THEN   
                        CASE   
                        WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 1080 ,0),108) -- �����ǽð��� ǥ�ؽð�(18��+����ٹ��ð�) �� ��  
   	                    THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
                        ELSE CASE ISNULL(A.END_TIME,'')  
                             WHEN ''  
                             THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO +1080 , 0),108)   -- ��ٽð��� ���������� ���ڰ����� ����ٹ��ð��� �ҷ��� ����ϴ½�  
                             ELSE convert(char(8),A.END_TIME,108)  
                             END
                         END  
                    ELSE convert(char(8),'00:00:00',108)  
                    END
         ELSE CASE ISNULL(A.END_TIME,'')  
              WHEN ''  
              THEN '18:00:00'  
              ELSE convert(char(8), A.END_TIME,108)  
              END  
         END  
    WHEN '02'  
    THEN CASE ISNULL(D.DILIG_NM,'')  
         WHEN ''  
         THEN '00:00:00'  
         WHEN '���ϱٹ�1'  
         THEN   
              CASE F.REPORT_TYPE  
              WHEN '2'  
              THEN convert(char(8), dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO , 0),108)  
              ELSE convert(char(8),'00:00:00',108)  
              END  
         ELSE convert(char(8),'00:00:00',108)  
         END
    WHEN '09'   
    THEN CASE ISNULL(D.DILIG_NM,'')  
         WHEN ''  
         THEN CASE ISNULL(A.END_TIME,'')  
              WHEN ''  
              THEN CASE ISNULL(A.START_TIME,'')  
                   WHEN ''  
                   THEN '00:00:00'  
                   ELSE '16:00:00'  
                   END  
              ELSE convert(char(8), A.END_TIME,108)  
              END  
         WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
         THEN '17:00:00'  
         WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
         THEN '13:00:00'  
         WHEN '����ٹ�1'   
         THEN  CASE F.REPORT_TYPE
               WHEN '1'
	           THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
	                WHEN ''
		            THEN convert(char(8),'17:00:00',108)
		            ELSE convert(char(8),A.END_TIME,108)
		            END  
               WHEN '2'  
               THEN   
                    CASE   
                    WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 1020 ,0),108) -- �����ǽð��� ǥ�ؽð�(18��+����ٹ��ð�) �� ��  
   	                THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
                    ELSE CASE ISNULL(A.END_TIME,'')  
                         WHEN ''  
                         THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO +1080 , 0),108)   -- ��ٽð��� ���������� ���ڰ����� ����ٹ��ð��� �ҷ��� ����ϴ½�  
                         ELSE convert(char(8),A.END_TIME,108)  
                         END  
                    END  
                 ELSE convert(char(8),'00:00:00',108)  
                 END
         WHEN '����ٹ�2'  
         THEN  CASE F.REPORT_TYPE
               WHEN '1'
	           THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
	                WHEN ''
		            THEN convert(char(8),'17:00:00',108)
		            ELSE convert(char(8),A.END_TIME,108)
		            END  
               WHEN '2'  
               THEN   
                CASE   
                WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 1020 ,0),108) -- �����ǽð��� ǥ�ؽð�(18��+����ٹ��ð�) �� ��  
   	            THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
                ELSE CASE ISNULL(A.END_TIME,'')  
                     WHEN ''  
                     THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO +1080 , 0),108)   -- ��ٽð��� ���������� ���ڰ����� ����ٹ��ð��� �ҷ��� ����ϴ½�  
                     ELSE convert(char(8),A.END_TIME,108)  
                     END  
                END  
               ELSE convert(char(8),'00:00:00',108)  
               END
         ELSE CASE ISNULL(A.END_TIME,'')  
              WHEN ''  
              THEN '17:00:00'  
              ELSE convert(char(8), A.END_TIME,108)  
              END  
         END
	ELSE convert(char(8),'00:00:00',108)
	END 
 --WHEN '10'   
 --THEN CASE ISNULL(D.DILIG_NM,'')  
 --     WHEN ''  
 --     THEN CASE ISNULL(A.END_TIME,'')  
 --          WHEN ''  
 --          THEN CASE ISNULL(A.START_TIME,'')  
 --               WHEN ''  
 --               THEN '00:00:00'  
 --               ELSE '03:00:00'  
 --               END  
 --         ELSE convert(char(8), A.END_TIME,108)  
 --         END  
 --     WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
 --     THEN '03:00:00'  
 --     WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
 --     THEN '21:00:00'  
 --     WHEN '����ٹ�1'   
 --     THEN  CASE F.REPORT_TYPE
 --           WHEN '1'
	--        THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
	--             WHEN ''
	--	         THEN convert(char(8),'03:00:00',108)
	--	         ELSE convert(char(8),A.END_TIME,108)
	--	         END  
 --           WHEN '2'  
 --           THEN   
 --              CASE ISNULL(A.END_TIME,'')  
 --              WHEN ''  
 --              THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO + 840 , 0),108)   -- ��ٽð��� ���������� ���ڰ����� ����ٹ��ð��� �ҷ��� ����ϴ½�  
 --              ELSE convert(char(8),A.END_TIME,108)  
 --              END    
 --           ELSE convert(char(8),'00:00:00',108)  
 --           END   
 --     WHEN '����ٹ�2'  
 --     THEN  CASE F.REPORT_TYPE
 --           WHEN '1'
	--        THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
	--             WHEN ''
	--	         THEN convert(char(8),'03:00:00',108)
	--	         ELSE convert(char(8),A.END_TIME,108)
	--	         END  
 --           WHEN '2'  
 --           THEN   
 --              CASE ISNULL(A.END_TIME,'')  
 --              WHEN ''  
 --              THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO + 840 , 0),108)   -- ��ٽð��� ���������� ���ڰ����� ����ٹ��ð��� �ҷ��� ����ϴ½�  
 --              ELSE convert(char(8),A.END_TIME,108)  
 --              END    
 --           ELSE convert(char(8),'00:00:00',108)  
 --           END   
 --     ELSE CASE ISNULL(A.END_TIME,'')  
 --          WHEN ''  
 --          THEN '18:00:00'  
 --          ELSE convert(char(8), A.END_TIME,108)  
 --          END  
 --     END  
 --   ELSE CASE ISNULL(D.DILIG_NM,'')  -- ����,������ ������ ��� ����Ǽ��� ��ٽð� ��� ��  
 --        WHEN ''  
 --        THEN CASE ISNULL(A.END_TIME,'')  
 --             WHEN ''  
 --             THEN CASE ISNULL(A.START_TIME,'')  
 --                  WHEN ''  
 --                  THEN '00:00:00'  
 --                  ELSE '16:00:00'  
 --                  END  
 --             ELSE convert(char(8), A.END_TIME,108)  
 --             END  
 --        ELSE convert(char(8),'00:00:00',108)  
 --        END  
     
 --    END    
ELSE CASE A.DAY_WEEK    
     WHEN '02'    
     THEN '00:00:00'    
     WHEN '01'    
     THEN CASE ISNULL(D.DILIG_NM,'')  -- ����,������ ������ ��� ����Ǽ��� ��ٽð� ��� ��    
          WHEN ''    
          THEN CASE ISNULL(A.END_TIME,'')    
               WHEN ''    
               THEN CASE ISNULL(A.START_TIME,'')    
                    WHEN ''    
                    THEN '00:00:00'    
                    ELSE '18:00:00'    
                    END    
               ELSE convert(char(8),'18:00:00',108)   
               END  
          ELSE CASE ISNULL(A.END_TIME,'')    
               WHEN ''    
               THEN CASE ISNULL(A.START_TIME,'')    
                    WHEN ''    
                    THEN convert(char(8),'00:00:00',108)    
                    ELSE convert(char(8),'18:00:00',108)    
                    END    
               ELSE convert(char(8),'18:00:00',108)   
               END    
           END
     WHEN '09'    
     THEN CASE ISNULL(D.DILIG_NM,'')  -- ����,������ ������ ��� ����Ǽ��� ��ٽð� ��� ��    
          WHEN ''    
          THEN CASE ISNULL(A.END_TIME,'')    
               WHEN ''    
               THEN CASE ISNULL(A.START_TIME,'')    
                    WHEN ''    
                    THEN '00:00:00'    
                    ELSE '17:00:00'    
                    END    
               ELSE convert(char(8),'17:00:00',108)   
               END  
          ELSE CASE ISNULL(A.END_TIME,'')    
               WHEN ''    
               THEN CASE ISNULL(A.START_TIME,'')    
                    WHEN ''    
                    THEN convert(char(8),'00:00:00',108)    
                    ELSE convert(char(8),'17:00:00',108)    
                    END    
               ELSE convert(char(8),'17:00:00',108)   
               END    
           END
     ELSE convert(char(8),'00:00:00',108)    
     END    

END
 as END_TIME,
  
--     CASE ISNULL(E.APPROVAL_RTN,'')      
--     WHEN ''      
--     THEN CASE A.DAY_WEEK      
--          WHEN '01'      
--          THEN CASE ISNULL(D.DILIG_NM,'')      
--               WHEN ''      
--               THEN CASE ISNULL(A.END_TIME,'')      
--                    WHEN ''      
--                    THEN CASE ISNULL(A.START_TIME,'')      
--                         WHEN ''      
--                         THEN '00:00:00'      
--                         ELSE '18:00:00'      
--                         END      
--                   ELSE convert(char(8), A.END_TIME,108)      
--                   END      
--               ELSE CASE ISNULL(A.END_TIME,'')      
--                    WHEN ''      
--                    THEN CASE ISNULL(A.START_TIME,'')      
--                         WHEN ''      
--                         THEN '00:00:00'      
--                         ELSE '18:00:00'      
--                         END      
--                    ELSE convert(char(8), A.END_TIME,108)      
--                    END      
--               END      
--       WHEN '02'      
--       THEN '00:00:00'      
   
--                      ELSE  convert(char(8),'00:00:00',108)      
--       END      
--WHEN '1'  
--     THEN   CASE A.DAY_WEEK  
--            WHEN '01'   
--            THEN CASE ISNULL(D.DILIG_NM,'')  
--                 WHEN ''  
--                 THEN CASE ISNULL(A.END_TIME,'')  
--                      WHEN ''  
--                      THEN CASE ISNULL(A.START_TIME,'')  
--                      WHEN ''  
--                      THEN '00:00:00'  
--                      ELSE '18:00:00'  
--                      END  
--                 ELSE convert(char(8), A.END_TIME,108)  
--                 END  
--            WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
--            THEN '18:00:00'  
--			WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
--            THEN '14:00:00'  
--            WHEN '����ٹ�1'   
--            THEN  CASE F.REPORT_TYPE
--			      WHEN '1'
--				  THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
--				       WHEN ''
--					   THEN convert(char(8),'18:00:00',108)
--					   ELSE convert(char(8),A.END_TIME,108)
--					   END  
--                  WHEN '2'  
--                  THEN   
--                   CASE   
--                   WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 1080 ,0),108) -- �����ǽð��� ǥ�ؽð�(18��+����ٹ��ð�) �� ��  
--		    	   THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
--                   ELSE CASE ISNULL(A.END_TIME,'')  
--                        WHEN ''  
--                     THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO +1080 , 0),108)   -- ��ٽð��� ���������� ���ڰ����� ����ٹ��ð��� �ҷ��� ����ϴ½�  
--                        ELSE convert(char(8),A.END_TIME,108)  
--                     END  
--                   END  
--               ELSE convert(char(8),'00:00:00',108)  
--               END   
--            WHEN '����ٹ�2'  
--            THEN  CASE F.REPORT_TYPE  
--                  WHEN '1'
--				  THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
--				       WHEN ''
--					   THEN convert(char(8),'18:00:00',108)
--					   ELSE convert(char(8),A.END_TIME,108)
--					   END
--				  WHEN '2'  
--               THEN    
--                    CASE   
--                 WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 1080 ,0),108)  
--                 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 1080 ,0),108)  
--                 ELSE CASE ISNULL(A.END_TIME,'')  
--                      WHEN ''  
--                   THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 1080 ,0),108)  
--                      ELSE convert(char(8),A.END_TIME,108)  
--                   END  
--                 END  
--                ELSE convert(char(8),'00:00:00',108)  
--                END   
--            ELSE CASE ISNULL(A.END_TIME,'')  
--                       WHEN ''  
--                    THEN '18:00:00'  
--                    ELSE convert(char(8), A.END_TIME,108)  
--                    END  
--            END  
--       WHEN '02'  
--       THEN CASE ISNULL(D.DILIG_NM,'')  
--            WHEN ''  
--            THEN '00:00:00'  
--            WHEN '���ϱٹ�1'  
--            THEN   
--                 CASE F.REPORT_TYPE  
--                 WHEN '2'  
--                 THEN convert(char(8), dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO , 0),108)  
--                 ELSE convert(char(8),'00:00:00',108)  
--                 END  
--            ELSE convert(char(8),'00:00:00',108)  
--            END
--	   WHEN '09'   
--            THEN CASE ISNULL(D.DILIG_NM,'')  
--                 WHEN ''  
--                 THEN CASE ISNULL(A.END_TIME,'')  
--                      WHEN ''  
--                      THEN CASE ISNULL(A.START_TIME,'')  
--                      WHEN ''  
--                      THEN '00:00:00'  
--                      ELSE '16:00:00'  
--                      END  
--                 ELSE convert(char(8), A.END_TIME,108)  
--                 END  
--            WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
--            THEN '16:00:00'  
--			WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
--            THEN '12:00:00'  
--            WHEN '����ٹ�1'   
--            THEN  CASE F.REPORT_TYPE
--			      WHEN '1'
--				  THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
--				       WHEN ''
--					   THEN convert(char(8),'16:00:00',108)
--					   ELSE convert(char(8),A.END_TIME,108)
--					   END  
--                  WHEN '2'  
--                  THEN   
--                   CASE   
--                   WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 840 ,0),108) -- �����ǽð��� ǥ�ؽð�(16��+����ٹ��ð�) �� ��  
--		    	   THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
--                   ELSE CASE ISNULL(A.END_TIME,'')  
--                        WHEN ''  
--                     THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO + 840 , 0),108)   -- ��ٽð��� ���������� ���ڰ����� ����ٹ��ð��� �ҷ��� ����ϴ½�  
--                        ELSE convert(char(8),A.END_TIME,108)  
--                     END  
--                   END  
--               ELSE convert(char(8),'00:00:00',108)  
--               END   
--            WHEN '����ٹ�2'  
--            THEN  CASE F.REPORT_TYPE  
--                  WHEN '1'
--				  THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
--				       WHEN ''
--					   THEN convert(char(8),'18:00:00',108)
--					   ELSE convert(char(8),A.END_TIME,108)
--					   END
--				  WHEN '2'  
--               THEN    
--                    CASE   
--                 WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 1080 ,0),108)  
--                 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 1080 ,0),108)  
--                 ELSE CASE ISNULL(A.END_TIME,'')  
--                      WHEN ''  
--                   THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 1080 ,0),108)  
--                      ELSE convert(char(8),A.END_TIME,108)  
--                   END  
--                 END  
--                ELSE convert(char(8),'00:00:00',108)  
--                END   
--            ELSE CASE ISNULL(A.END_TIME,'')  
--                       WHEN ''  
--                    THEN '18:00:00'  
--                    ELSE convert(char(8), A.END_TIME,108)  
--                    END  
--            END
--	   WHEN '10'   
--            THEN CASE ISNULL(D.DILIG_NM,'')  
--                 WHEN ''  
--                 THEN CASE ISNULL(A.END_TIME,'')  
--                      WHEN ''  
--                      THEN CASE ISNULL(A.START_TIME,'')  
--                      WHEN ''  
--                      THEN '00:00:00'  
--                      ELSE '03:00:00'  
--                      END  
--                 ELSE convert(char(8), A.END_TIME,108)  
--                 END  
--            WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
--            THEN '03:00:00'  
--			WHEN '����(����)' -- ���� �����϶� �ٹ��ð� ��� CASE��  
--            THEN '21:00:00'  
--            WHEN '����ٹ�1'   
--            THEN  CASE F.REPORT_TYPE
--			      WHEN '1'
--				  THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
--				       WHEN ''
--					   THEN convert(char(8),'03:00:00',108)
--					   ELSE convert(char(8),A.END_TIME,108)
--					   END  
--                  WHEN '2'  
--                  THEN   
--                    CASE ISNULL(A.END_TIME,'')  
--                     WHEN ''  
--                     THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO + 840 , 0),108)   -- ��ٽð��� ���������� ���ڰ����� ����ٹ��ð��� �ҷ��� ����ϴ½�  
--                     ELSE convert(char(8),A.END_TIME,108)  
--                     END    
--                  ELSE convert(char(8),'00:00:00',108)  
--                  END   
--            WHEN '����ٹ�2'  
--            THEN  CASE F.REPORT_TYPE
--			      WHEN '1'
--				  THEN CASE ISNULL(convert(char(8),A.END_TIME,108),'')
--				       WHEN ''
--					   THEN convert(char(8),'03:00:00',108)
--					   ELSE convert(char(8),A.END_TIME,108)
--					   END  
--                  WHEN '2'  
--                  THEN   
--                     CASE ISNULL(A.END_TIME,'')  
--                     WHEN ''  
--                     THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO + 840 , 0),108)   -- ��ٽð��� ���������� ���ڰ����� ����ٹ��ð��� �ҷ��� ����ϴ½�  
--                     ELSE convert(char(8),A.END_TIME,108)  
--                     END    
--                  ELSE convert(char(8),'00:00:00',108)  
--                  END   
--            ELSE CASE ISNULL(A.END_TIME,'')  
--                 WHEN ''  
--                 THEN '18:00:00'  
--                 ELSE convert(char(8), A.END_TIME,108)  
--                 END  
--            END  
--       ELSE CASE ISNULL(D.DILIG_NM,'')  -- ����,������ ������ ��� ����Ǽ��� ��ٽð� ��� ��  
--            WHEN ''  
--            THEN CASE ISNULL(A.END_TIME,'')  
--                 WHEN ''  
--                 THEN CASE ISNULL(A.START_TIME,'')  
--                      WHEN ''  
--                      THEN '00:00:00'  
--                      ELSE '16:00:00'  
--                      END  
--                 ELSE convert(char(8), A.END_TIME,108)  
--                 END  
--            ELSE convert(char(8),'00:00:00',108)  
--            END  
        
--        END
--         ELSE CASE A.DAY_WEEK      
--        WHEN '02'      
--        THEN '00:00:00'      
--        WHEN '01'      
--        THEN CASE ISNULL(D.DILIG_NM,'')  -- ����,������ ������ ��� ����Ǽ��� ��ٽð� ��� ��      
--             WHEN ''      
--             THEN CASE ISNULL(A.END_TIME,'')      
--                                      WHEN ''      
--                                      THEN CASE ISNULL(A.START_TIME,'')      
--                                      WHEN ''      
--                                      THEN '00:00:00'      
--                                      ELSE '18:00:00'      
--                                         END      
--                                    ELSE convert(char(8), A.END_TIME,108)      
--                                    END      
--          ELSE CASE ISNULL(A.END_TIME,'')      
--                                      WHEN ''      
--                                      THEN CASE ISNULL(A.START_TIME,'')      
--                                           WHEN ''      
--                                           THEN '00:00:00'      
--                                           ELSE '18:00:00'      
--                                           END      
--                                      ELSE convert(char(8), A.END_TIME,108)      
--                                      END      
--          END      
--        ELSE convert(char(8),'00:00:00',108)      
--        END      
--                --ELSE convert(char(8),'00:00:00',108)      
--    END      

CASE ISNULL(A.END_TIME,'')  
WHEN ''  
THEN CASE A.DAY_WEEK
     WHEN '01'
	 THEN  
          CASE ISNULL(A.START_TIME,'')  
          WHEN ''  
          THEN convert(char(8),'00:00:00',108)  
          ELSE convert(char(8),'18:00:00',108)  
          END
	 WHEN '09'
	 THEN CASE ISNULL(A.START_TIME,'')  
          WHEN ''  
          THEN convert(char(8),'00:00:00',108)  
          ELSE convert(char(8),'17:00:00',108)  
          END
	 ELSE convert(char(8),'00:00:00',108)
	 END
ELSE convert(char(8),A.END_TIME,108) 
END       
 as END_TIME_S,  
convert(varchar(12),  
CAST(  
DATEDIFF(n,  -- �ѱٹ� Hour���  
  CASE ISNULL(E.APPROVAL_RTN,'')      
     WHEN ''      
     THEN CASE A.DAY_WEEK      
          WHEN '01'      
          THEN  CASE ISNULL(A.START_TIME ,'')      
                WHEN ''      
                THEN CASE ISNULL(A.END_TIME,'')      
                     WHEN ''      
                     THEN convert(char(8),'00:00:00',108)      
                     ELSE convert(char(8),'09:00:00',108)      
                     END         
                ELSE   CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��        
                       WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                       THEN convert(char(8),'09:00:00',108)    
                       WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)      
                       THEN convert(char(8),A.START_TIME,108)      
                       WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'09:00:00',108)      
                       THEN convert(char(8),'09:00:00',108)     
                       ELSE convert(char(8),'09:00:00',108)      
                       END      
                END      
       WHEN '02'      
       THEN convert(char(8),'00:00:00',108)
	   WHEN '09'      --����(08��)
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'08:00:00',108)      
                 END      
            ELSE  CASE        -- ��ٽð��� 7�� �����϶��� ��ٽð��� 7�÷� �����ϴ� CASE��        
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                  THEN convert(char(8),'08:00:00',108)    
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),A.START_TIME,108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),'08:00:00',108)     
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
            END
	   WHEN '10'      
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'00:00:00',108)      
                 END      
            ELSE  CASE   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),A.START_TIME - '17:00:00',108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),'00:00:00',108)     
                  ELSE convert(char(8),'00:00:00',108)      
                  END      
            END      
       ELSE convert(char(8),'00:00:00',108)    
       END      
     WHEN '1'      
     THEN CASE ISNULL(D.DILIG_NM,'')      
          WHEN ''      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'09:00:00',108)      
                WHEN '02'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'      
                THEN convert(char(8),'08:00:00',108)
				WHEN '10'      
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '����(����)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END
          WHEN '����(����)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '����ٹ�1'    
          THEN  CASE F.REPORT_TYPE  
                WHEN '2'  
                THEN    
                     CASE A.DAY_WEEK      
                     WHEN '01'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   -- ����ٹ��ǰ�� 0�ú��� �ٹ��ð��� ����ϴ� ���� �߰� '20.12.14    
                           ELSE convert(char(8),'00:00:00',108)  
                           END
	      		     WHEN '09'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   
                           ELSE convert(char(8),'00:00:00',108)  
                           END
	      		     WHEN '10'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   
                           ELSE convert(char(8),'00:00:00',108)  
                           END	   
                     ELSE convert(char(8),'00:00:00',108)      
                     END  
               ELSE convert(char(8),'00:00:00',108)   
                    END    
         WHEN '����ٹ�2'    
         THEN CASE F.REPORT_TYPE  
              WHEN '2'  
              THEN   
                   CASE A.DAY_WEEK      
                   WHEN '01'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)   -- ����ٹ��ǰ�� 0�ú��� �ٹ��ð��� ����ϴ� ���� �߰� '20.12.14    
                         ELSE convert(char(8),'00:00:00',108)  
                         END
				   WHEN '09'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)    
                         ELSE convert(char(8),'00:00:00',108)  
                         END  
                   ELSE convert(char(8),'00:00:00',108)      
                   END  
             ELSE convert(char(8),'00:00:00',108)   
             END   
          WHEN '���ϱٹ�1'    
          THEN CASE F.REPORT_TYPE  
               WHEN '2'  
               THEN  
                   CASE A.DAY_WEEK    
                   WHEN '02'    
                   THEN convert(char(8),'00:00:00',108)  
                   ELSE convert(char(8),'00:00:00',108)    
                   END  
               ELSE convert(char(8),'00:00:00',108)    
               END     
          ELSE CASE A.DAY_WEEK      
               WHEN '01'      
               THEN convert(char(8),'09:00:00',108)
			   WHEN '09'      
               THEN convert(char(8),'08:00:00',108)
			   WHEN '10'      
               THEN convert(char(8),'00:00:00',108)
               ELSE convert(char(8),'00:00:00',108)      
               END      
          END      
     ELSE CASE A.DAY_WEEK      
          WHEN '01'      
          THEN  CASE ISNULL(A.START_TIME ,'')      
                WHEN ''      
                THEN CASE ISNULL(A.END_TIME,'')      
                     WHEN ''      
                     THEN convert(char(8),'00:00:00',108)      
                     ELSE convert(char(8),'09:00:00',108)      
                     END      
                ELSE      
                     CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��   
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                     THEN convert(char(8),'09:00:00',108)       
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)      
                     THEN convert(char(8), A.START_TIME,108)      
                     WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'09:00:00',108)      
                     THEN convert(char(8),'09:00:00',108)    
                     ELSE convert(char(8),'09:00:00',108)      
                     END      
               END      
       WHEN '02'      
       THEN convert(char(8),'00:00:00',108)
	   WHEN '09'      
       THEN  CASE ISNULL(A.START_TIME ,'')      
             WHEN ''      
             THEN CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN convert(char(8),'00:00:00',108)      
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
             ELSE      
                  CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                  THEN convert(char(8),'08:00:00',108)       
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)      
                  THEN convert(char(8), A.START_TIME,108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),'08:00:00',108)    
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
             END
	   WHEN '10'      
       THEN  CASE ISNULL(A.START_TIME ,'')      
             WHEN ''      
             THEN CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN convert(char(8),'00:00:00',108)      
                  ELSE convert(char(8),'07:00:00',108)      
                  END      
             ELSE      
                  CASE     
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)      
                  THEN convert(char(8), A.START_TIME - '17:00:00',108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),'00:00:00',108)    
                  ELSE convert(char(8),'00:00:00',108)      
                  END      
             END
       ELSE convert(char(8),'00:00:00',108)      
       END      
     END      
        ,   --// ��ٽð��� ���� //      
CASE ISNULL(E.APPROVAL_RTN,'')      
WHEN ''      
THEN CASE A.DAY_WEEK      
     WHEN '01'      
     THEN   CASE ISNULL(D.DILIG_NM,'')      
            WHEN ''      
            THEN  CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'17:00:00',108)      
                       END      
                  ELSE convert(char(8),'17:00:00',108)      
                  END      
            ELSE CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN CASE ISNULL(A.START_TIME,'')      
                      WHEN ''      
                      THEN convert(char(8),'00:00:00',108)      
                      ELSE convert(char(8),'17:00:00',108)      
                      END      
                 ELSE convert(char(8),'17:00:00',108)      
                 END      
           END      
      WHEN '02'      
      THEN convert(char(8),'00:00:00',108)      
      WHEN '09'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'16:00:00',108)      
                        END      
                   ELSE convert(char(8),'16:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'16:00:00',108)      
                       END      
                  ELSE convert(char(8),'16:00:00',108)      
                  END 
		     
             END
      WHEN '10'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'08:00:00',108)      
                        END      
                   ELSE convert(char(8),'08:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'08:00:00',108)      
                       END      
                  ELSE convert(char(8),'08:00:00',108)      
                  END 
		     
             END
	  ELSE convert(char(8),'00:00:00',108)      
      END      
WHEN '1'      
THEN         
      CASE ISNULL(D.DILIG_NM,'')      
      WHEN ''      
      THEN CASE A.DAY_WEEK      
           WHEN '01'      
           THEN convert(char(8),'17:00:00',108)      
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)        
		   WHEN '09'      
           THEN convert(char(8),'16:00:00',108)
		   WHEN '10'      
           THEN convert(char(8),'08:00:00',108)
           ELSE convert(char(8),'17:00:00',108)      
           END  
      WHEN '����(����)'  
      THEN CASE A.DAY_WEEK  
           WHEN '01'  
           THEN convert(char(8),'04:00:00',108)
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)
		   WHEN '09'  
           THEN convert(char(8),'04:00:00',108)
		   WHEN '10'  
           THEN convert(char(8),'04:00:00',108)
           ELSE convert(char(8),'00:00:00',108)      
           END         
      WHEN '����(����)'      
      THEN CASE A.DAY_WEEK      
           WHEN '01'  
           THEN convert(char(8),'04:00:00',108)
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)
		   WHEN '09'  
           THEN convert(char(8),'04:00:00',108)
		   WHEN '10'  
           THEN convert(char(8),'04:00:00',108)
           ELSE convert(char(8),'00:00:00',108)      
           END      
      WHEN '����ٹ�1'      
      THEN CASE A.DAY_WEEK    
           WHEN '01'
		   THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'08:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END 
            WHEN '02'    
            THEN convert(char(8),'00:00:00',108)
			WHEN '09'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'16:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
				ELSE  convert(char(8),'00:00:00',108)
			    END
			WHEN '10'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'08:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END      
       WHEN '����ٹ�2'      
       THEN CASE A.DAY_WEEK    
            WHEN '01'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'17:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END 
            WHEN '02'    
            THEN convert(char(8),'00:00:00',108)
			WHEN '09'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'15:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'07:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END 
       WHEN '���ϱٹ�1'    
       THEN CASE F.REPORT_TYPE
	        WHEN '2'
			THEN 
	          CASE A.DAY_WEEK  
              WHEN '02'  
			  THEN CASE 
			       WHEN convert(char(8),dateadd(hh,C.DILIG_HH , 0),108) >= '05:00:00' -- �ް��ٹ��ð��� 5�ð� �̻��϶� ���ɽð� 1�ð� ���� ��
			       THEN convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM - 60 , 0),108) -- ��(minute)������� �߰� '21.01.12
			       ELSE convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM , 0),108)
			  	   END 
              ELSE convert(char(8),'00:00:00',108)  
              END
			ELSE  convert(char(8),'00:00:00',108)  
			END   
       ELSE convert(char(8),'00:00:00',108)      
       END
ELSE CASE A.DAY_WEEK      
     WHEN '01'      
     THEN   CASE ISNULL(D.DILIG_NM,'')      
            WHEN ''      
            THEN  CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'17:00:00',108)      
                       END      
                  ELSE convert(char(8),'17:00:00',108)      
                  END      
            ELSE CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN CASE ISNULL(A.START_TIME,'')      
                      WHEN ''      
                      THEN convert(char(8),'00:00:00',108)      
                      ELSE convert(char(8),'17:00:00',108)      
                      END      
                 ELSE convert(char(8),'17:00:00',108)      
                 END      
           END      
      WHEN '02'      
      THEN convert(char(8),'00:00:00',108)      
      WHEN '09'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'16:00:00',108)      
                        END      
                   ELSE convert(char(8),'16:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'16:00:00',108)      
                       END      
                  ELSE convert(char(8),'16:00:00',108)      
                  END 
		     
             END
      WHEN '10'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'08:00:00',108)      
                        END      
                   ELSE convert(char(8),'08:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'08:00:00',108)      
                       END      
                  ELSE convert(char(8),'08:00:00',108)      
                  END 
		     
             END
	  ELSE convert(char(8),'00:00:00',108)      
      END      
END      

    )/60 as varchar(4) ) + ':' +  
  -- �ѱٹ� Minute���  
   case   
 when    
DATEDIFF(n,  -- �ѱٹ� Hour���  
  CASE ISNULL(E.APPROVAL_RTN,'')      
     WHEN ''      
     THEN CASE A.DAY_WEEK      
          WHEN '01'      
          THEN  CASE ISNULL(A.START_TIME ,'')      
                WHEN ''      
                THEN CASE ISNULL(A.END_TIME,'')      
                     WHEN ''      
                     THEN convert(char(8),'00:00:00',108)      
                     ELSE convert(char(8),'09:00:00',108)      
                     END         
                   ELSE   CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��        
                          WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                          THEN convert(char(8),'09:00:00',108)    
                          WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)      
                          THEN convert(char(8),A.START_TIME,108)      
                          WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'09:00:00',108)      
                          THEN convert(char(8),'09:00:00',108)     
                          ELSE convert(char(8),'09:00:00',108)      
                          END      
                END      
       WHEN '02'      
       THEN convert(char(8),'00:00:00',108)
	   WHEN '09'      --����(08��)
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'08:00:00',108)      
                 END      
            ELSE  CASE        -- ��ٽð��� 7�� �����϶��� ��ٽð��� 7�÷� �����ϴ� CASE��        
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                  THEN convert(char(8),'08:00:00',108)    
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),A.START_TIME,108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),'08:00:00',108)     
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
            END
	   WHEN '10'      
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'00:00:00',108)      
                 END      
            ELSE  CASE   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),A.START_TIME - '17:00:00',108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),'00:00:00',108)     
                  ELSE convert(char(8),'00:00:00',108)      
                  END      
            END      
       ELSE convert(char(8),'00:00:00',108)    
       END      
     WHEN '1'      
     THEN CASE ISNULL(D.DILIG_NM,'')      
          WHEN ''      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'09:00:00',108)      
                WHEN '02'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'      
                THEN convert(char(8),'08:00:00',108)
				WHEN '10'      
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '����(����)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END
          WHEN '����(����)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '����ٹ�1'    
          THEN  CASE F.REPORT_TYPE  
                WHEN '2'  
                THEN    
                     CASE A.DAY_WEEK      
                     WHEN '01'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   -- ����ٹ��ǰ�� 0�ú��� �ٹ��ð��� ����ϴ� ���� �߰� '20.12.14    
                           ELSE convert(char(8),'00:00:00',108)  
                           END
	      		     WHEN '09'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   
                           ELSE convert(char(8),'00:00:00',108)  
                           END
	      		     WHEN '10'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   
                           ELSE convert(char(8),'00:00:00',108)  
                           END	   
                     ELSE convert(char(8),'00:00:00',108)      
                     END  
               ELSE convert(char(8),'00:00:00',108)   
                    END    
         WHEN '����ٹ�2'    
         THEN CASE F.REPORT_TYPE  
              WHEN '2'  
              THEN   
                   CASE A.DAY_WEEK      
                   WHEN '01'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)   -- ����ٹ��ǰ�� 0�ú��� �ٹ��ð��� ����ϴ� ���� �߰� '20.12.14    
                         ELSE convert(char(8),'00:00:00',108)  
                         END
				   WHEN '09'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)    
                         ELSE convert(char(8),'00:00:00',108)  
                         END  
                   ELSE convert(char(8),'00:00:00',108)      
                   END  
             ELSE convert(char(8),'00:00:00',108)   
             END   
          WHEN '���ϱٹ�1'    
          THEN CASE F.REPORT_TYPE  
               WHEN '2'  
               THEN  
                   CASE A.DAY_WEEK    
                   WHEN '02'    
                   THEN convert(char(8),'00:00:00',108)  
                   ELSE convert(char(8),'00:00:00',108)    
                   END  
               ELSE convert(char(8),'00:00:00',108)    
               END     
          ELSE CASE A.DAY_WEEK      
               WHEN '01'      
               THEN convert(char(8),'09:00:00',108)
			   WHEN '09'      
               THEN convert(char(8),'08:00:00',108)
			   WHEN '10'      
               THEN convert(char(8),'00:00:00',108)
               ELSE convert(char(8),'00:00:00',108)      
               END      
          END      
     ELSE CASE A.DAY_WEEK      
          WHEN '01'      
          THEN  CASE ISNULL(A.START_TIME ,'')      
                WHEN ''      
                THEN CASE ISNULL(A.END_TIME,'')      
                     WHEN ''      
                     THEN convert(char(8),'00:00:00',108)      
                     ELSE convert(char(8),'09:00:00',108)      
                     END      
                ELSE      
                     CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��   
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                     THEN convert(char(8),'09:00:00',108)       
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)      
                     THEN convert(char(8), A.START_TIME,108)      
                     WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'09:00:00',108)      
                     THEN convert(char(8),'09:00:00',108)    
                     ELSE convert(char(8),'09:00:00',108)      
                     END      
               END      
       WHEN '02'      
       THEN convert(char(8),'00:00:00',108)
	   WHEN '09'      
       THEN  CASE ISNULL(A.START_TIME ,'')      
             WHEN ''      
             THEN CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN convert(char(8),'00:00:00',108)      
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
             ELSE      
                  CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                  THEN convert(char(8),'08:00:00',108)       
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)      
                  THEN convert(char(8), A.START_TIME,108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),'08:00:00',108)    
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
             END
	   WHEN '10'      
       THEN  CASE ISNULL(A.START_TIME ,'')      
             WHEN ''      
             THEN CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN convert(char(8),'00:00:00',108)      
                  ELSE convert(char(8),'07:00:00',108)      
                  END      
             ELSE      
                  CASE     
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)      
                  THEN convert(char(8), A.START_TIME - '17:00:00',108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),'00:00:00',108)    
                  ELSE convert(char(8),'00:00:00',108)      
                  END      
             END
       ELSE convert(char(8),'00:00:00',108)      
       END      
     END      
        ,   --// ��ٽð��� ���� //      
CASE ISNULL(E.APPROVAL_RTN,'')      
WHEN ''      
THEN CASE A.DAY_WEEK      
     WHEN '01'      
     THEN   CASE ISNULL(D.DILIG_NM,'')      
            WHEN ''      
            THEN  CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'17:00:00',108)      
                       END      
                  ELSE convert(char(8),'17:00:00',108)      
                  END      
            ELSE CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN CASE ISNULL(A.START_TIME,'')      
                      WHEN ''      
                      THEN convert(char(8),'00:00:00',108)      
                      ELSE convert(char(8),'17:00:00',108)      
                      END      
                 ELSE convert(char(8),'17:00:00',108)      
                 END      
           END      
      WHEN '02'      
      THEN convert(char(8),'00:00:00',108)      
      WHEN '09'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'16:00:00',108)      
                        END      
                   ELSE convert(char(8),'16:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'16:00:00',108)      
                       END      
                  ELSE convert(char(8),'16:00:00',108)      
                  END 
		     
             END
      WHEN '10'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'08:00:00',108)      
                        END      
                   ELSE convert(char(8),'08:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'08:00:00',108)      
                       END      
                  ELSE convert(char(8),'08:00:00',108)      
                  END 
		     
             END
	  ELSE convert(char(8),'00:00:00',108)      
      END      
WHEN '1'      
THEN         
      CASE ISNULL(D.DILIG_NM,'')      
      WHEN ''      
      THEN CASE A.DAY_WEEK      
           WHEN '01'      
           THEN convert(char(8),'17:00:00',108)      
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)        
		   WHEN '09'      
           THEN convert(char(8),'16:00:00',108)
		   WHEN '10'      
           THEN convert(char(8),'08:00:00',108)
           ELSE convert(char(8),'17:00:00',108)      
           END  
      WHEN '����(����)'  
      THEN CASE A.DAY_WEEK  
           WHEN '01'  
           THEN convert(char(8),'04:00:00',108)
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)
		   WHEN '09'  
           THEN convert(char(8),'04:00:00',108)
		   WHEN '10'  
           THEN convert(char(8),'04:00:00',108)
           ELSE convert(char(8),'00:00:00',108)      
           END         
      WHEN '����(����)'      
      THEN CASE A.DAY_WEEK      
           WHEN '01'  
           THEN convert(char(8),'04:00:00',108)
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)
		   WHEN '09'  
           THEN convert(char(8),'04:00:00',108)
		   WHEN '10'  
           THEN convert(char(8),'04:00:00',108)
           ELSE convert(char(8),'00:00:00',108)      
           END      
      WHEN '����ٹ�1'      
      THEN CASE A.DAY_WEEK    
           WHEN '01'
		   THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'08:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END 
            WHEN '02'    
            THEN convert(char(8),'00:00:00',108)
			WHEN '09'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'16:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
				ELSE  convert(char(8),'00:00:00',108)
			    END
			WHEN '10'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'08:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END      
       WHEN '����ٹ�2'      
       THEN CASE A.DAY_WEEK    
            WHEN '01'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'17:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END 
            WHEN '02'    
            THEN convert(char(8),'00:00:00',108)
			WHEN '09'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'15:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'07:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END 
       WHEN '���ϱٹ�1'    
       THEN CASE F.REPORT_TYPE
	        WHEN '2'
			THEN 
	          CASE A.DAY_WEEK  
              WHEN '02'  
			  THEN CASE 
			       WHEN convert(char(8),dateadd(hh,C.DILIG_HH , 0),108) >= '05:00:00' -- �ް��ٹ��ð��� 5�ð� �̻��϶� ���ɽð� 1�ð� ���� ��
			       THEN convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM - 60 , 0),108) -- ��(minute)������� �߰� '21.01.12
			       ELSE convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM , 0),108)
			  	   END 
              ELSE convert(char(8),'00:00:00',108)  
              END
			ELSE  convert(char(8),'00:00:00',108)  
			END   
       ELSE convert(char(8),'00:00:00',108)      
       END
ELSE CASE A.DAY_WEEK      
     WHEN '01'      
     THEN   CASE ISNULL(D.DILIG_NM,'')      
            WHEN ''      
            THEN  CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'17:00:00',108)      
                       END      
                  ELSE convert(char(8),'17:00:00',108)      
                  END      
            ELSE CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN CASE ISNULL(A.START_TIME,'')      
                      WHEN ''      
                      THEN convert(char(8),'00:00:00',108)      
                      ELSE convert(char(8),'17:00:00',108)      
                      END      
                 ELSE convert(char(8),'17:00:00',108)      
                 END      
           END      
      WHEN '02'      
      THEN convert(char(8),'00:00:00',108)      
      WHEN '09'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'16:00:00',108)      
                        END      
                   ELSE convert(char(8),'16:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'16:00:00',108)      
                       END      
                  ELSE convert(char(8),'16:00:00',108)      
                  END 
		     
             END
      WHEN '10'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'08:00:00',108)      
                        END      
                   ELSE convert(char(8),'08:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'08:00:00',108)      
                       END      
                  ELSE convert(char(8),'08:00:00',108)      
                  END 
		     
             END
	  ELSE convert(char(8),'00:00:00',108)      
      END      
END
    )%60   < 10 THEN '0' + CAST(  
DATEDIFF(n,  -- �ѱٹ� Hour���  
  CASE ISNULL(E.APPROVAL_RTN,'')      
     WHEN ''      
     THEN CASE A.DAY_WEEK      
          WHEN '01'      
          THEN  CASE ISNULL(A.START_TIME ,'')      
                WHEN ''      
                THEN CASE ISNULL(A.END_TIME,'')      
                     WHEN ''      
                     THEN convert(char(8),'00:00:00',108)      
                     ELSE convert(char(8),'09:00:00',108)      
                     END         
                   ELSE   CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��        
                          WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                          THEN convert(char(8),'09:00:00',108)    
                          WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)      
                          THEN convert(char(8),A.START_TIME,108)      
                          WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'09:00:00',108)      
                          THEN convert(char(8),'09:00:00',108)     
                          ELSE convert(char(8),'09:00:00',108)      
                          END      
                END      
       WHEN '02'      
       THEN convert(char(8),'00:00:00',108)
	   WHEN '09'      --����(08��)
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'08:00:00',108)      
                 END      
            ELSE  CASE        -- ��ٽð��� 7�� �����϶��� ��ٽð��� 7�÷� �����ϴ� CASE��        
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                  THEN convert(char(8),'08:00:00',108)    
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),A.START_TIME,108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),'08:00:00',108)     
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
            END
	   WHEN '10'      
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'00:00:00',108)      
                 END      
            ELSE  CASE   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),A.START_TIME - '17:00:00',108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),'00:00:00',108)     
                  ELSE convert(char(8),'00:00:00',108)      
                  END      
            END      
       ELSE convert(char(8),'00:00:00',108)    
       END      
     WHEN '1'      
     THEN CASE ISNULL(D.DILIG_NM,'')      
          WHEN ''      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'09:00:00',108)      
                WHEN '02'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'      
                THEN convert(char(8),'08:00:00',108)
				WHEN '10'      
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '����(����)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END
          WHEN '����(����)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '����ٹ�1'    
          THEN  CASE F.REPORT_TYPE  
                WHEN '2'  
                THEN    
                     CASE A.DAY_WEEK      
                     WHEN '01'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   -- ����ٹ��ǰ�� 0�ú��� �ٹ��ð��� ����ϴ� ���� �߰� '20.12.14    
                           ELSE convert(char(8),'00:00:00',108)  
                           END
	      		     WHEN '09'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   
                           ELSE convert(char(8),'00:00:00',108)  
                           END
	      		     WHEN '10'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   
                           ELSE convert(char(8),'00:00:00',108)  
                           END	   
                     ELSE convert(char(8),'00:00:00',108)      
                     END  
               ELSE convert(char(8),'00:00:00',108)   
                    END    
         WHEN '����ٹ�2'    
         THEN CASE F.REPORT_TYPE  
              WHEN '2'  
              THEN   
                   CASE A.DAY_WEEK      
                   WHEN '01'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)   -- ����ٹ��ǰ�� 0�ú��� �ٹ��ð��� ����ϴ� ���� �߰� '20.12.14    
                         ELSE convert(char(8),'00:00:00',108)  
                         END
				   WHEN '09'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)    
                         ELSE convert(char(8),'00:00:00',108)  
                         END  
                   ELSE convert(char(8),'00:00:00',108)      
                   END  
             ELSE convert(char(8),'00:00:00',108)   
             END   
          WHEN '���ϱٹ�1'    
          THEN CASE F.REPORT_TYPE  
               WHEN '2'  
               THEN  
                   CASE A.DAY_WEEK    
                   WHEN '02'    
                   THEN convert(char(8),'00:00:00',108)  
                   ELSE convert(char(8),'00:00:00',108)    
                   END  
               ELSE convert(char(8),'00:00:00',108)    
               END     
          ELSE CASE A.DAY_WEEK      
               WHEN '01'      
               THEN convert(char(8),'09:00:00',108)
			   WHEN '09'      
               THEN convert(char(8),'08:00:00',108)
			   WHEN '10'      
               THEN convert(char(8),'00:00:00',108)
               ELSE convert(char(8),'00:00:00',108)      
               END      
          END      
     ELSE CASE A.DAY_WEEK      
          WHEN '01'      
          THEN  CASE ISNULL(A.START_TIME ,'')      
                WHEN ''      
                THEN CASE ISNULL(A.END_TIME,'')      
                     WHEN ''      
                     THEN convert(char(8),'00:00:00',108)      
                     ELSE convert(char(8),'09:00:00',108)      
                     END      
                ELSE      
                     CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��   
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                     THEN convert(char(8),'09:00:00',108)       
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)      
                     THEN convert(char(8), A.START_TIME,108)      
                     WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'09:00:00',108)      
                     THEN convert(char(8),'09:00:00',108)    
                     ELSE convert(char(8),'09:00:00',108)      
                     END      
               END      
       WHEN '02'      
       THEN convert(char(8),'00:00:00',108)
	   WHEN '09'      
       THEN  CASE ISNULL(A.START_TIME ,'')      
             WHEN ''      
             THEN CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN convert(char(8),'00:00:00',108)      
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
             ELSE      
                  CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                  THEN convert(char(8),'08:00:00',108)       
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)      
                  THEN convert(char(8), A.START_TIME,108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),'08:00:00',108)    
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
             END
	   WHEN '10'      
       THEN  CASE ISNULL(A.START_TIME ,'')      
             WHEN ''      
             THEN CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN convert(char(8),'00:00:00',108)      
                  ELSE convert(char(8),'07:00:00',108)      
                  END      
             ELSE      
                  CASE     
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)      
                  THEN convert(char(8), A.START_TIME - '17:00:00',108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),'00:00:00',108)    
                  ELSE convert(char(8),'00:00:00',108)      
                  END      
             END
       ELSE convert(char(8),'00:00:00',108)      
       END      
     END      
        ,   --// ��ٽð��� ���� //      
CASE ISNULL(E.APPROVAL_RTN,'')      
WHEN ''      
THEN CASE A.DAY_WEEK      
     WHEN '01'      
     THEN   CASE ISNULL(D.DILIG_NM,'')      
            WHEN ''      
            THEN  CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'17:00:00',108)      
                       END      
                  ELSE convert(char(8),'17:00:00',108)      
                  END      
            ELSE CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN CASE ISNULL(A.START_TIME,'')      
                      WHEN ''      
                      THEN convert(char(8),'00:00:00',108)      
                      ELSE convert(char(8),'17:00:00',108)      
                      END      
                 ELSE convert(char(8),'17:00:00',108)      
                 END      
           END      
      WHEN '02'      
      THEN convert(char(8),'00:00:00',108)      
      WHEN '09'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'16:00:00',108)      
                        END      
                   ELSE convert(char(8),'16:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'16:00:00',108)      
                       END      
                  ELSE convert(char(8),'16:00:00',108)      
                  END 
		     
             END
      WHEN '10'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'08:00:00',108)      
                        END      
                   ELSE convert(char(8),'08:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'08:00:00',108)      
                       END      
                  ELSE convert(char(8),'08:00:00',108)      
                  END 
		     
             END
	  ELSE convert(char(8),'00:00:00',108)      
      END      
WHEN '1'      
THEN         
      CASE ISNULL(D.DILIG_NM,'')      
      WHEN ''      
      THEN CASE A.DAY_WEEK      
           WHEN '01'      
           THEN convert(char(8),'17:00:00',108)      
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)        
		   WHEN '09'      
           THEN convert(char(8),'16:00:00',108)
		   WHEN '10'      
           THEN convert(char(8),'08:00:00',108)
           ELSE convert(char(8),'17:00:00',108)      
           END  
      WHEN '����(����)'  
      THEN CASE A.DAY_WEEK  
           WHEN '01'  
           THEN convert(char(8),'04:00:00',108)
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)
		   WHEN '09'  
           THEN convert(char(8),'04:00:00',108)
		   WHEN '10'  
           THEN convert(char(8),'04:00:00',108)
           ELSE convert(char(8),'00:00:00',108)      
           END         
      WHEN '����(����)'      
      THEN CASE A.DAY_WEEK      
           WHEN '01'  
           THEN convert(char(8),'04:00:00',108)
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)
		   WHEN '09'  
           THEN convert(char(8),'04:00:00',108)
		   WHEN '10'  
           THEN convert(char(8),'04:00:00',108)
           ELSE convert(char(8),'00:00:00',108)      
           END      
      WHEN '����ٹ�1'      
      THEN CASE A.DAY_WEEK    
           WHEN '01'
		   THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'08:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END 
            WHEN '02'    
            THEN convert(char(8),'00:00:00',108)
			WHEN '09'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'16:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
				ELSE  convert(char(8),'00:00:00',108)
			    END
			WHEN '10'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'08:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END      
       WHEN '����ٹ�2'      
       THEN CASE A.DAY_WEEK    
            WHEN '01'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'17:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END 
            WHEN '02'    
            THEN convert(char(8),'00:00:00',108)
			WHEN '09'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'15:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'07:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END 
       WHEN '���ϱٹ�1'    
       THEN CASE F.REPORT_TYPE
	        WHEN '2'
			THEN 
	          CASE A.DAY_WEEK  
              WHEN '02'  
			  THEN CASE 
			       WHEN convert(char(8),dateadd(hh,C.DILIG_HH , 0),108) >= '05:00:00' -- �ް��ٹ��ð��� 5�ð� �̻��϶� ���ɽð� 1�ð� ���� ��
			       THEN convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM - 60 , 0),108) -- ��(minute)������� �߰� '21.01.12
			       ELSE convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM , 0),108)
			  	   END 
              ELSE convert(char(8),'00:00:00',108)  
              END
			ELSE  convert(char(8),'00:00:00',108)  
			END   
       ELSE convert(char(8),'00:00:00',108)      
       END
ELSE CASE A.DAY_WEEK      
     WHEN '01'      
     THEN   CASE ISNULL(D.DILIG_NM,'')      
            WHEN ''      
            THEN  CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'17:00:00',108)      
                       END      
                  ELSE convert(char(8),'17:00:00',108)      
                  END      
            ELSE CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN CASE ISNULL(A.START_TIME,'')      
                      WHEN ''      
                      THEN convert(char(8),'00:00:00',108)      
                      ELSE convert(char(8),'17:00:00',108)      
                      END      
                 ELSE convert(char(8),'17:00:00',108)      
                 END      
           END      
      WHEN '02'      
      THEN convert(char(8),'00:00:00',108)      
      WHEN '09'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'16:00:00',108)      
                        END      
                   ELSE convert(char(8),'16:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'16:00:00',108)      
                       END      
                  ELSE convert(char(8),'16:00:00',108)      
                  END 
		     
             END
      WHEN '10'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'08:00:00',108)      
                        END      
                   ELSE convert(char(8),'08:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'08:00:00',108)      
                       END      
                  ELSE convert(char(8),'08:00:00',108)      
                  END 
		     
             END
	  ELSE convert(char(8),'00:00:00',108)      
      END      
END
    )%60 as varchar(4) )   
        
       ELSE CAST(  
DATEDIFF(n,  -- �ѱٹ� Hour���  
  CASE ISNULL(E.APPROVAL_RTN,'')      
     WHEN ''      
     THEN CASE A.DAY_WEEK      
          WHEN '01'      
          THEN  CASE ISNULL(A.START_TIME ,'')      
                WHEN ''      
                THEN CASE ISNULL(A.END_TIME,'')      
                     WHEN ''      
                     THEN convert(char(8),'00:00:00',108)      
                     ELSE convert(char(8),'09:00:00',108)      
                     END         
                   ELSE   CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��        
                          WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                          THEN convert(char(8),'09:00:00',108)    
                          WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)      
                          THEN convert(char(8),A.START_TIME,108)      
                          WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'09:00:00',108)      
                          THEN convert(char(8),'09:00:00',108)     
                          ELSE convert(char(8),'09:00:00',108)      
                          END      
                END      
       WHEN '02'      
       THEN convert(char(8),'00:00:00',108)
	   WHEN '09'      --����(08��)
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'08:00:00',108)      
                 END      
            ELSE  CASE        -- ��ٽð��� 7�� �����϶��� ��ٽð��� 7�÷� �����ϴ� CASE��        
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                  THEN convert(char(8),'08:00:00',108)    
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),A.START_TIME,108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),'08:00:00',108)     
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
            END
	   WHEN '10'      
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'00:00:00',108)      
                 END      
            ELSE  CASE   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),A.START_TIME - '17:00:00',108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),'00:00:00',108)     
                  ELSE convert(char(8),'00:00:00',108)      
                  END      
            END      
       ELSE convert(char(8),'00:00:00',108)    
       END      
     WHEN '1'      
     THEN CASE ISNULL(D.DILIG_NM,'')      
          WHEN ''      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'09:00:00',108)      
                WHEN '02'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'      
                THEN convert(char(8),'08:00:00',108)
				WHEN '10'      
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '����(����)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END
          WHEN '����(����)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '����ٹ�1'    
          THEN  CASE F.REPORT_TYPE  
                WHEN '2'  
                THEN    
                     CASE A.DAY_WEEK      
                     WHEN '01'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   -- ����ٹ��ǰ�� 0�ú��� �ٹ��ð��� ����ϴ� ���� �߰� '20.12.14    
                           ELSE convert(char(8),'00:00:00',108)  
                           END
	      		     WHEN '09'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   
                           ELSE convert(char(8),'00:00:00',108)  
                           END
	      		     WHEN '10'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   
                           ELSE convert(char(8),'00:00:00',108)  
                           END	   
                     ELSE convert(char(8),'00:00:00',108)      
                     END  
               ELSE convert(char(8),'00:00:00',108)   
                    END    
         WHEN '����ٹ�2'    
         THEN CASE F.REPORT_TYPE  
              WHEN '2'  
              THEN   
                   CASE A.DAY_WEEK      
                   WHEN '01'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)   -- ����ٹ��ǰ�� 0�ú��� �ٹ��ð��� ����ϴ� ���� �߰� '20.12.14    
                         ELSE convert(char(8),'00:00:00',108)  
                         END
				   WHEN '09'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)    
                         ELSE convert(char(8),'00:00:00',108)  
                         END  
                   ELSE convert(char(8),'00:00:00',108)      
                   END  
             ELSE convert(char(8),'00:00:00',108)   
             END   
          WHEN '���ϱٹ�1'    
          THEN CASE F.REPORT_TYPE  
               WHEN '2'  
               THEN  
                   CASE A.DAY_WEEK    
                   WHEN '02'    
                   THEN convert(char(8),'00:00:00',108)  
                   ELSE convert(char(8),'00:00:00',108)    
                   END  
               ELSE convert(char(8),'00:00:00',108)    
               END     
          ELSE CASE A.DAY_WEEK      
               WHEN '01'      
               THEN convert(char(8),'09:00:00',108)
			   WHEN '09'      
               THEN convert(char(8),'08:00:00',108)
			   WHEN '10'      
               THEN convert(char(8),'00:00:00',108)
               ELSE convert(char(8),'00:00:00',108)      
               END      
          END      
     ELSE CASE A.DAY_WEEK      
          WHEN '01'      
          THEN  CASE ISNULL(A.START_TIME ,'')      
                WHEN ''      
                THEN CASE ISNULL(A.END_TIME,'')      
                     WHEN ''      
                     THEN convert(char(8),'00:00:00',108)      
                     ELSE convert(char(8),'09:00:00',108)      
                     END      
                ELSE      
                     CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��   
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                     THEN convert(char(8),'09:00:00',108)       
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)      
                     THEN convert(char(8), A.START_TIME,108)      
                     WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'09:00:00',108)      
                     THEN convert(char(8),'09:00:00',108)    
                     ELSE convert(char(8),'09:00:00',108)      
                     END      
               END      
       WHEN '02'      
       THEN convert(char(8),'00:00:00',108)
	   WHEN '09'      
       THEN  CASE ISNULL(A.START_TIME ,'')      
             WHEN ''      
             THEN CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN convert(char(8),'00:00:00',108)      
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
             ELSE      
                  CASE        -- ��ٽð��� 9�� �����϶��� ��ٽð��� 9�÷� �����ϴ� CASE��   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18�� �̻��϶� (CS�ٹ�)�ð� �ӽ��� �ٹ��ð� 8�ð����� ������  
                  THEN convert(char(8),'08:00:00',108)       
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)      
                  THEN convert(char(8), A.START_TIME,108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'08:00:00',108)      
                  THEN convert(char(8),'08:00:00',108)    
                  ELSE convert(char(8),'08:00:00',108)      
                  END      
             END
	   WHEN '10'      
       THEN  CASE ISNULL(A.START_TIME ,'')      
             WHEN ''      
             THEN CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN convert(char(8),'00:00:00',108)      
                  ELSE convert(char(8),'07:00:00',108)      
                  END      
             ELSE      
                  CASE     
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)      
                  THEN convert(char(8), A.START_TIME - '17:00:00',108)      
                  WHEN convert(char(8),A.START_TIME,108) < convert(char(8),'18:00:00',108)      
                  THEN convert(char(8),'00:00:00',108)    
                  ELSE convert(char(8),'00:00:00',108)      
                  END      
             END
       ELSE convert(char(8),'00:00:00',108)      
       END      
     END      
        ,   --// ��ٽð��� ���� //      
CASE ISNULL(E.APPROVAL_RTN,'')      
WHEN ''      
THEN CASE A.DAY_WEEK      
     WHEN '01'      
     THEN   CASE ISNULL(D.DILIG_NM,'')      
            WHEN ''      
            THEN  CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'17:00:00',108)      
                       END      
                  ELSE convert(char(8),'17:00:00',108)      
                  END      
            ELSE CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN CASE ISNULL(A.START_TIME,'')      
                      WHEN ''      
                      THEN convert(char(8),'00:00:00',108)      
                      ELSE convert(char(8),'17:00:00',108)      
                      END      
                 ELSE convert(char(8),'17:00:00',108)      
                 END      
           END      
      WHEN '02'      
      THEN convert(char(8),'00:00:00',108)      
      WHEN '09'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'16:00:00',108)      
                        END      
                   ELSE convert(char(8),'16:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'16:00:00',108)      
                       END      
                  ELSE convert(char(8),'16:00:00',108)      
                  END 
		     
             END
      WHEN '10'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'08:00:00',108)      
                        END      
                   ELSE convert(char(8),'08:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'08:00:00',108)      
                       END      
                  ELSE convert(char(8),'08:00:00',108)      
                  END 
		     
             END
	  ELSE convert(char(8),'00:00:00',108)      
      END      
WHEN '1'      
THEN         
      CASE ISNULL(D.DILIG_NM,'')      
      WHEN ''      
      THEN CASE A.DAY_WEEK      
           WHEN '01'      
           THEN convert(char(8),'17:00:00',108)      
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)        
		   WHEN '09'      
           THEN convert(char(8),'16:00:00',108)
		   WHEN '10'      
           THEN convert(char(8),'08:00:00',108)
           ELSE convert(char(8),'17:00:00',108)      
           END  
      WHEN '����(����)'  
      THEN CASE A.DAY_WEEK  
           WHEN '01'  
           THEN convert(char(8),'04:00:00',108)
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)
		   WHEN '09'  
           THEN convert(char(8),'04:00:00',108)
		   WHEN '10'  
           THEN convert(char(8),'04:00:00',108)
           ELSE convert(char(8),'00:00:00',108)      
           END         
      WHEN '����(����)'      
      THEN CASE A.DAY_WEEK      
           WHEN '01'  
           THEN convert(char(8),'04:00:00',108)
           WHEN '02'      
           THEN convert(char(8),'00:00:00',108)
		   WHEN '09'  
           THEN convert(char(8),'04:00:00',108)
		   WHEN '10'  
           THEN convert(char(8),'04:00:00',108)
           ELSE convert(char(8),'00:00:00',108)      
           END      
      WHEN '����ٹ�1'      
      THEN CASE A.DAY_WEEK    
           WHEN '01'
		   THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'08:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END 
            WHEN '02'    
            THEN convert(char(8),'00:00:00',108)
			WHEN '09'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'16:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
				ELSE  convert(char(8),'00:00:00',108)
			    END
			WHEN '10'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'08:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END      
       WHEN '����ٹ�2'      
       THEN CASE A.DAY_WEEK    
            WHEN '01'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'17:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END 
            WHEN '02'    
            THEN convert(char(8),'00:00:00',108)
			WHEN '09'
		    THEN
	            CASE F.REPORT_TYPE
			    WHEN '1'
			    THEN convert(char(8),'15:00:00',108)
	            WHEN '2'
			    THEN    
	                 CASE ISNULL(A.START_TIME,'')
		             WHEN ''
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'07:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- ��(minute)������� �߰� '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- ��(minute)������� �߰� '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END 
       WHEN '���ϱٹ�1'    
       THEN CASE F.REPORT_TYPE
	        WHEN '2'
			THEN 
	          CASE A.DAY_WEEK  
              WHEN '02'  
			  THEN CASE 
			       WHEN convert(char(8),dateadd(hh,C.DILIG_HH , 0),108) >= '05:00:00' -- �ް��ٹ��ð��� 5�ð� �̻��϶� ���ɽð� 1�ð� ���� ��
			       THEN convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM - 60 , 0),108) -- ��(minute)������� �߰� '21.01.12
			       ELSE convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM , 0),108)
			  	   END 
              ELSE convert(char(8),'00:00:00',108)  
              END
			ELSE  convert(char(8),'00:00:00',108)  
			END   
       ELSE convert(char(8),'00:00:00',108)      
       END
ELSE CASE A.DAY_WEEK      
     WHEN '01'      
     THEN   CASE ISNULL(D.DILIG_NM,'')      
            WHEN ''      
            THEN  CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'17:00:00',108)      
                       END      
                  ELSE convert(char(8),'17:00:00',108)      
                  END      
            ELSE CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN CASE ISNULL(A.START_TIME,'')      
                      WHEN ''      
                      THEN convert(char(8),'00:00:00',108)      
                      ELSE convert(char(8),'17:00:00',108)      
                      END      
                 ELSE convert(char(8),'17:00:00',108)      
                 END      
           END      
      WHEN '02'      
      THEN convert(char(8),'00:00:00',108)      
      WHEN '09'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'16:00:00',108)      
                        END      
                   ELSE convert(char(8),'16:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'16:00:00',108)      
                       END      
                  ELSE convert(char(8),'16:00:00',108)      
                  END 
		     
             END
      WHEN '10'      
      THEN   CASE ISNULL(D.DILIG_NM,'')      
             WHEN ''      
             THEN  CASE ISNULL(A.END_TIME,'')      
                   WHEN ''      
                   THEN CASE ISNULL(A.START_TIME,'')      
                        WHEN ''      
                        THEN convert(char(8),'00:00:00',108)      
                        ELSE convert(char(8),'08:00:00',108)      
                        END      
                   ELSE convert(char(8),'08:00:00',108)      
                   END      
             ELSE CASE ISNULL(A.END_TIME,'')      
                  WHEN ''      
                  THEN CASE ISNULL(A.START_TIME,'')      
                       WHEN ''      
                       THEN convert(char(8),'00:00:00',108)      
                       ELSE convert(char(8),'08:00:00',108)      
                       END      
                  ELSE convert(char(8),'08:00:00',108)      
                  END 
		     
             END
	  ELSE convert(char(8),'00:00:00',108)      
      END      
END
    )%60 as varchar(4) )  
    END   
      
    ,114) as TOT_TIME,  
 CASE E.APPROVAL_RTN  
 WHEN '1'  
 THEN CASE F.REPORT_TYPE  
      WHEN '2'  
      THEN   
           CASE D.DILIG_NM  
           WHEN '����ٹ�1'  
           --THEN convert(char(8),dateadd(hh, C.DILIG_HH  ,0),108) 
		   THEN convert(char(8),dateadd( n, (C.DILIG_HH * 60) + C.DILIG_MM - 30  ,0),108) -- ��(minute)������� �߰� '21.01.12
           WHEN '����ٹ�2'  
           THEN  convert(char(8),dateadd( n, (C.DILIG_HH * 60) + C.DILIG_MM  - 30 ,0),108) 
           END  
      ELSE NULL 
      END  
 ELSE NULL  
 END as OT,      
CASE D.DILIG_NM  
WHEN '���ϱٹ�1'  
THEN CASE F.REPORT_TYPE  
     WHEN '2'  
     THEN    
         CASE E.APPROVAL_RTN  
         WHEN '1'  
         THEN CASE A.DAY_WEEK  
              WHEN '02'  
              THEN CASE 
			       WHEN convert(char(8),dateadd(hh,C.DILIG_HH , 0),108) >= '05:00:00' -- �ް��ٹ��ð��� 5�ð� �̻��϶� ���ɽð� 1�ð� ���� ��
			       THEN convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM - 60 , 0),108) -- ��(minute)������� �߰� '21.01.12
			       ELSE convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM , 0),108)
			  	   END
              ELSE convert(char(8),'00:00:00',108)  
              END  
ELSE NULL
         END  
ELSE NULL  
END   
    END  as HT,      
  CASE A.DAY_WEEK  
  WHEN '01'  
  THEN CASE  
  WHEN D.DILIG_NM <> '����(����)'  
  THEN  
   CASE   
   WHEN convert(char(8),A.START_TIME,108) > '09:00:00'  
   THEN CASE   
     WHEN convert(char(8),A.START_TIME,108) < '12:00:00'  
     THEN convert(char(8),A.START_TIME - '09:00:00',108)   
     END  
   ELSE NULL   
   END  
  END  
  END as TT  ,      
  A.ISRT_EMP_NO     ,       
  A.UPDT_EMP_NO ,      
  A.UPDT_DT,
CASE ISNULL(E.APPROVAL_RTN,'')
WHEN ''      
THEN NULL
WHEN '1'
THEN D.DILIG_NM
ELSE NULL
END  
   as ETC1,
CASE ISNULL(E.APPROVAL_RTN,'')
WHEN ''
THEN ''
WHEN '1'
THEN ''
ELSE CASE F.REPORT_TYPE
     WHEN '2'
  THEN
       CASE D.DILIG_NM
       WHEN '����ٹ�1'
    THEN '�̽���'
    WHEN '���ϱٹ�1'
    THEN '�̽���'
    ELSE NULL
    END
  ELSE NULL
  END
END AS ETC2,  
  CASE E.APPROVAL_RTN    
  WHEN '1'    
  THEN CASE D.DILIG_NM    
       WHEN '����ٹ�1'    
     THEN    
          CASE   
             WHEN F.REPORT_TYPE = '1'    
             THEN '��û'        
             ELSE NULL    
             END    
       WHEN '���ϱٹ�1'    
       THEN CASE F.REPORT_TYPE    
            WHEN '1'    
            THEN '��û'    
            ELSE NULL    
            END    
  ELSE NULL    
  END    
  ELSE NULL    
  END as FLG_REPORT1   , 
  CASE E.APPROVAL_RTN    
  WHEN '1'    
  THEN CASE D.DILIG_NM    
       WHEN '����ٹ�1'    
     THEN    
          CASE  
             WHEN F.REPORT_TYPE = '2'    
             THEN '���'    
             ELSE NULL    
             END    
       WHEN '���ϱٹ�1'    
       THEN CASE F.REPORT_TYPE   
            WHEN '2'    
            THEN '���'    
            ELSE NULL    
            END    
  ELSE NULL    
  END    
  ELSE NULL    
  END as FLG_REPORT2
  
from WT_MA_KO883 A              
join HAA010T B on A.EMP_NO = B.EMP_NO      
LEFT OUTER join H4006M3_D_KO883 C on A.EMP_NO = C.DILIG_EMP_NO and A.WORK_DT = C.DILIG_DT_FR  
LEFT OUTER join HCA010T D on D.DILIG_CD = C.DILIG_CD  
LEFT OUTER join ERP_IF_APPROVAL E on C.DILIG_REQ_NO = E.DOC_NO   
LEFT JOIN H4006M3_H_KO883 F (NOLOCK) ON F.DILIG_REQ_NO = E.DOC_NO   


where         
( @EMP_NO ='' or A.EMP_NO = @EMP_NO )      
and (@DEPT_NO = '' or B.DEPT_CD = @DEPT_NO)            
and CONVERT (DATETIME, A.WORK_DT) BETWEEN  CONVERT (DATETIME, @Work_From) AND  CONVERT (DATETIME, @Work_To ) 

        
 order by EMP_NO,WORK_DT,HT,OT,ETC1
                    
 END     
    
 --select * from WT_MA_KO883