                  
                    
ALTER PROCEDURE [dbo].[USP_H4007M2_KO883]                    
 (          
 @EMP_NO nvarchar(26), -- 사번        
 @DEPT_NO nvarchar(26), -- 부서번호        
 @Work_From nvarchar(26), -- 근무일자From           
    @Work_To  nvarchar(26)  -- 근무일자To        
                     
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
                WHEN '연장근무1'  
                THEN CASE ISNULL(convert(char(8),A.START_TIME,108),'')
				     WHEN ''
					 THEN convert(char(8),'09:00:00',108)
					 ELSE convert(char(8),A.START_TIME,108)
					 END
				WHEN '반차(오전)'
				THEN convert(char(8),'14:00:00',108)  
				WHEN '반차(오후)'
				THEN convert(char(8),'09:00:00',108)  
		        END 
		   WHEN '2'
		   THEN CASE D.DILIG_NM  
                WHEN '연장근무1'  
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
		        WHEN '휴일근무1'
				THEN convert(char(8),dateadd(n,(C.DILIG_HH_FR * 60) + C.DILIG_MM_FR , 0),108) 
				ELSE convert(char(8),'00:00:00' ,108)
				END
			ELSE convert(char(8),'00:00:00' ,108)
			END
	  ELSE convert(char(8),'00:00:00' ,108)
	  END
WHEN '09'  --평일(오전8시)일때
THEN    
      CASE E.APPROVAL_RTN  
      WHEN '1'  
      THEN CASE F.REPORT_TYPE  
           WHEN '1'  
           THEN CASE D.DILIG_NM  
                WHEN '연장근무1'  
                THEN CASE ISNULL(convert(char(8),A.START_TIME,108),'')
				     WHEN ''
					 THEN convert(char(8),'08:00:00',108)
					 ELSE convert(char(8),A.START_TIME,108)
					 END
				WHEN '반차(오전)'
				THEN convert(char(8),'13:00:00',108)  
				WHEN '반차(오후)'
				THEN convert(char(8),'08:00:00',108)  
		        END 
		   WHEN '2'
		   THEN CASE D.DILIG_NM  
                WHEN '연장근무1'  
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
WHEN '10'  --야간(18시)일때
THEN    
      CASE E.APPROVAL_RTN  
      WHEN '1'  
      THEN CASE F.REPORT_TYPE  
           WHEN '1'  
           THEN CASE D.DILIG_NM  
                WHEN '연장근무1'  
                THEN CASE ISNULL(convert(char(8),A.START_TIME,108),'')
				     WHEN ''
					 THEN convert(char(8),'18:00:00',108)
					 ELSE convert(char(8),A.START_TIME,108)
					 END
				WHEN '반차(오전)'
				THEN convert(char(8),'21:00:00',108)  
				WHEN '반차(오후)'
				THEN convert(char(8),'18:00:00',108)  
		        END 
		   WHEN '2'
		   THEN CASE D.DILIG_NM  
                WHEN '연장근무1'  
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
     WHEN '09'  --평일(오전8시)테스트
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
      WHEN '10'  --야간(18시)일때 테스트
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
             WHEN '반차(오전)' -- 오후 반차일때 근무시간 계산 CASE문  
             THEN '18:00:00'  
             WHEN '반차(오후)' -- 오후 반차일때 근무시간 계산 CASE문  
             THEN '14:00:00'  
             WHEN '연장근무1'   
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
                        WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') >= convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 1080 ,0),108) -- 세콤의시간이 표준시간(18시+연장근무시간) 보다 크거나 같을때 결재기준 계산
   	                    THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
						WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') < convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 1080 ,0),108) -- 세콤의시간이 표준시간(18시+연장근무시간) 보다 작을때 세콤 기준 계산 
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
                             THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO +1080 , 0),108)   -- 퇴근시간이 안찍혔을때 전자결재의 연장근무시간을 불러와 계산하는식  
                             ELSE convert(char(8),A.END_TIME,108)  
                             END
                         END  
                    ELSE convert(char(8),'00:00:00',108)  
                    END   
             WHEN '연장근무2'  
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
                        WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 1080 ,0),108) -- 세콤의시간과 표준시간(18시+연장근무시간) 비교 식  
   	                    THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
                        ELSE CASE ISNULL(A.END_TIME,'')  
                             WHEN ''  
                             THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO +1080 , 0),108)   -- 퇴근시간이 안찍혔을때 전자결재의 연장근무시간을 불러와 계산하는식  
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
         WHEN '휴일근무1'  
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
         WHEN '반차(오전)' -- 오후 반차일때 근무시간 계산 CASE문  
         THEN '17:00:00'  
         WHEN '반차(오후)' -- 오후 반차일때 근무시간 계산 CASE문  
         THEN '13:00:00'  
         WHEN '연장근무1'   
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
                    WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 1020 ,0),108) -- 세콤의시간과 표준시간(18시+연장근무시간) 비교 식  
   	                THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
                    ELSE CASE ISNULL(A.END_TIME,'')  
                         WHEN ''  
                         THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO +1080 , 0),108)   -- 퇴근시간이 안찍혔을때 전자결재의 연장근무시간을 불러와 계산하는식  
                         ELSE convert(char(8),A.END_TIME,108)  
                         END  
                    END  
                 ELSE convert(char(8),'00:00:00',108)  
                 END
         WHEN '연장근무2'  
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
                WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 1020 ,0),108) -- 세콤의시간과 표준시간(18시+연장근무시간) 비교 식  
   	            THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
                ELSE CASE ISNULL(A.END_TIME,'')  
                     WHEN ''  
                     THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO +1080 , 0),108)   -- 퇴근시간이 안찍혔을때 전자결재의 연장근무시간을 불러와 계산하는식  
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
 --     WHEN '반차(오전)' -- 오후 반차일때 근무시간 계산 CASE문  
 --     THEN '03:00:00'  
 --     WHEN '반차(오후)' -- 오후 반차일때 근무시간 계산 CASE문  
 --     THEN '21:00:00'  
 --     WHEN '연장근무1'   
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
 --              THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO + 840 , 0),108)   -- 퇴근시간이 안찍혔을때 전자결재의 연장근무시간을 불러와 계산하는식  
 --              ELSE convert(char(8),A.END_TIME,108)  
 --              END    
 --           ELSE convert(char(8),'00:00:00',108)  
 --           END   
 --     WHEN '연장근무2'  
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
 --              THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO + 840 , 0),108)   -- 퇴근시간이 안찍혔을때 전자결재의 연장근무시간을 불러와 계산하는식  
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
 --   ELSE CASE ISNULL(D.DILIG_NM,'')  -- 평일,휴일을 제외한 모든 경우의수의 퇴근시간 계산 식  
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
     THEN CASE ISNULL(D.DILIG_NM,'')  -- 평일,휴일을 제외한 모든 경우의수의 퇴근시간 계산 식    
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
     THEN CASE ISNULL(D.DILIG_NM,'')  -- 평일,휴일을 제외한 모든 경우의수의 퇴근시간 계산 식    
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
--            WHEN '반차(오전)' -- 오후 반차일때 근무시간 계산 CASE문  
--            THEN '18:00:00'  
--			WHEN '반차(오후)' -- 오후 반차일때 근무시간 계산 CASE문  
--            THEN '14:00:00'  
--            WHEN '연장근무1'   
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
--                   WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 1080 ,0),108) -- 세콤의시간과 표준시간(18시+연장근무시간) 비교 식  
--		    	   THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
--                   ELSE CASE ISNULL(A.END_TIME,'')  
--                        WHEN ''  
--                     THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO +1080 , 0),108)   -- 퇴근시간이 안찍혔을때 전자결재의 연장근무시간을 불러와 계산하는식  
--                        ELSE convert(char(8),A.END_TIME,108)  
--                     END  
--                   END  
--               ELSE convert(char(8),'00:00:00',108)  
--               END   
--            WHEN '연장근무2'  
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
--            WHEN '휴일근무1'  
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
--            WHEN '반차(오전)' -- 오후 반차일때 근무시간 계산 CASE문  
--            THEN '16:00:00'  
--			WHEN '반차(오후)' -- 오후 반차일때 근무시간 계산 CASE문  
--            THEN '12:00:00'  
--            WHEN '연장근무1'   
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
--                   WHEN ISNULL(convert(char(8),A.END_TIME,108),'00:00:00') > convert(char(8),dateadd(n, (C.DILIG_HH * 60) + 840 ,0),108) -- 세콤의시간과 표준시간(16시+연장근무시간) 비교 식  
--		    	   THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO  , 0),108) 
--                   ELSE CASE ISNULL(A.END_TIME,'')  
--                        WHEN ''  
--                     THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO + 840 , 0),108)   -- 퇴근시간이 안찍혔을때 전자결재의 연장근무시간을 불러와 계산하는식  
--                        ELSE convert(char(8),A.END_TIME,108)  
--                     END  
--                   END  
--               ELSE convert(char(8),'00:00:00',108)  
--               END   
--            WHEN '연장근무2'  
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
--            WHEN '반차(오전)' -- 오후 반차일때 근무시간 계산 CASE문  
--            THEN '03:00:00'  
--			WHEN '반차(오후)' -- 오후 반차일때 근무시간 계산 CASE문  
--            THEN '21:00:00'  
--            WHEN '연장근무1'   
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
--                     THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO + 840 , 0),108)   -- 퇴근시간이 안찍혔을때 전자결재의 연장근무시간을 불러와 계산하는식  
--                     ELSE convert(char(8),A.END_TIME,108)  
--                     END    
--                  ELSE convert(char(8),'00:00:00',108)  
--                  END   
--            WHEN '연장근무2'  
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
--                     THEN convert(char(8),dateadd(n,(C.DILIG_HH_TO * 60) + C.DILIG_MM_TO + 840 , 0),108)   -- 퇴근시간이 안찍혔을때 전자결재의 연장근무시간을 불러와 계산하는식  
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
--       ELSE CASE ISNULL(D.DILIG_NM,'')  -- 평일,휴일을 제외한 모든 경우의수의 퇴근시간 계산 식  
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
--        THEN CASE ISNULL(D.DILIG_NM,'')  -- 평일,휴일을 제외한 모든 경우의수의 퇴근시간 계산 식      
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
DATEDIFF(n,  -- 총근무 Hour계산  
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
                ELSE   CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문        
                       WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
	   WHEN '09'      --평일(08시)
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'08:00:00',108)      
                 END      
            ELSE  CASE        -- 출근시간이 7시 이전일때는 출근시간을 7시로 고정하는 CASE문        
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
          WHEN '반차(오전)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END
          WHEN '반차(오후)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '연장근무1'    
          THEN  CASE F.REPORT_TYPE  
                WHEN '2'  
                THEN    
                     CASE A.DAY_WEEK      
                     WHEN '01'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   -- 연장근무의경우 0시부터 근무시간을 계산하는 로직 추가 '20.12.14    
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
         WHEN '연장근무2'    
         THEN CASE F.REPORT_TYPE  
              WHEN '2'  
              THEN   
                   CASE A.DAY_WEEK      
                   WHEN '01'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)   -- 연장근무의경우 0시부터 근무시간을 계산하는 로직 추가 '20.12.14    
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
          WHEN '휴일근무1'    
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
                     CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문   
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
                  CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
        ,   --// 출근시간문 종료 //      
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
      WHEN '반차(오전)'  
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
      WHEN '반차(오후)'      
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
      WHEN '연장근무1'      
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END      
       WHEN '연장근무2'      
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'07:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END 
       WHEN '휴일근무1'    
       THEN CASE F.REPORT_TYPE
	        WHEN '2'
			THEN 
	          CASE A.DAY_WEEK  
              WHEN '02'  
			  THEN CASE 
			       WHEN convert(char(8),dateadd(hh,C.DILIG_HH , 0),108) >= '05:00:00' -- 휴가근무시간이 5시간 이사일때 점심시간 1시간 차감 식
			       THEN convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM - 60 , 0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
  -- 총근무 Minute계산  
   case   
 when    
DATEDIFF(n,  -- 총근무 Hour계산  
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
                   ELSE   CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문        
                          WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
	   WHEN '09'      --평일(08시)
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'08:00:00',108)      
                 END      
            ELSE  CASE        -- 출근시간이 7시 이전일때는 출근시간을 7시로 고정하는 CASE문        
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
          WHEN '반차(오전)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END
          WHEN '반차(오후)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '연장근무1'    
          THEN  CASE F.REPORT_TYPE  
                WHEN '2'  
                THEN    
                     CASE A.DAY_WEEK      
                     WHEN '01'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   -- 연장근무의경우 0시부터 근무시간을 계산하는 로직 추가 '20.12.14    
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
         WHEN '연장근무2'    
         THEN CASE F.REPORT_TYPE  
              WHEN '2'  
              THEN   
                   CASE A.DAY_WEEK      
                   WHEN '01'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)   -- 연장근무의경우 0시부터 근무시간을 계산하는 로직 추가 '20.12.14    
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
          WHEN '휴일근무1'    
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
                     CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문   
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
                  CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
        ,   --// 출근시간문 종료 //      
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
      WHEN '반차(오전)'  
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
      WHEN '반차(오후)'      
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
      WHEN '연장근무1'      
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END      
       WHEN '연장근무2'      
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'07:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END 
       WHEN '휴일근무1'    
       THEN CASE F.REPORT_TYPE
	        WHEN '2'
			THEN 
	          CASE A.DAY_WEEK  
              WHEN '02'  
			  THEN CASE 
			       WHEN convert(char(8),dateadd(hh,C.DILIG_HH , 0),108) >= '05:00:00' -- 휴가근무시간이 5시간 이사일때 점심시간 1시간 차감 식
			       THEN convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM - 60 , 0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
DATEDIFF(n,  -- 총근무 Hour계산  
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
                   ELSE   CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문        
                          WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
	   WHEN '09'      --평일(08시)
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'08:00:00',108)      
                 END      
            ELSE  CASE        -- 출근시간이 7시 이전일때는 출근시간을 7시로 고정하는 CASE문        
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
          WHEN '반차(오전)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END
          WHEN '반차(오후)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '연장근무1'    
          THEN  CASE F.REPORT_TYPE  
                WHEN '2'  
                THEN    
                     CASE A.DAY_WEEK      
                     WHEN '01'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   -- 연장근무의경우 0시부터 근무시간을 계산하는 로직 추가 '20.12.14    
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
         WHEN '연장근무2'    
         THEN CASE F.REPORT_TYPE  
              WHEN '2'  
              THEN   
                   CASE A.DAY_WEEK      
                   WHEN '01'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)   -- 연장근무의경우 0시부터 근무시간을 계산하는 로직 추가 '20.12.14    
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
          WHEN '휴일근무1'    
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
                     CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문   
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
                  CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
        ,   --// 출근시간문 종료 //      
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
      WHEN '반차(오전)'  
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
      WHEN '반차(오후)'      
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
      WHEN '연장근무1'      
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END      
       WHEN '연장근무2'      
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'07:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END 
       WHEN '휴일근무1'    
       THEN CASE F.REPORT_TYPE
	        WHEN '2'
			THEN 
	          CASE A.DAY_WEEK  
              WHEN '02'  
			  THEN CASE 
			       WHEN convert(char(8),dateadd(hh,C.DILIG_HH , 0),108) >= '05:00:00' -- 휴가근무시간이 5시간 이사일때 점심시간 1시간 차감 식
			       THEN convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM - 60 , 0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
DATEDIFF(n,  -- 총근무 Hour계산  
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
                   ELSE   CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문        
                          WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
	   WHEN '09'      --평일(08시)
       THEN CASE ISNULL(A.START_TIME ,'')      
            WHEN ''      
            THEN CASE ISNULL(A.END_TIME,'')      
                 WHEN ''      
                 THEN convert(char(8),'00:00:00',108)      
                 ELSE convert(char(8),'08:00:00',108)      
                 END      
            ELSE  CASE        -- 출근시간이 7시 이전일때는 출근시간을 7시로 고정하는 CASE문        
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
          WHEN '반차(오전)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END
          WHEN '반차(오후)'      
          THEN  CASE A.DAY_WEEK      
                WHEN '01'      
                THEN convert(char(8),'00:00:00',108)
				WHEN '09'
                THEN convert(char(8),'00:00:00',108)
				WHEN '10'
                THEN convert(char(8),'00:00:00',108)
                ELSE convert(char(8),'00:00:00',108)      
                END      
          WHEN '연장근무1'    
          THEN  CASE F.REPORT_TYPE  
                WHEN '2'  
                THEN    
                     CASE A.DAY_WEEK      
                     WHEN '01'   
                     THEN  CASE ISNULL(A.START_TIME,'')     
                           WHEN ''  
                           THEN convert(char(8),'00:00:00',108)   -- 연장근무의경우 0시부터 근무시간을 계산하는 로직 추가 '20.12.14    
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
         WHEN '연장근무2'    
         THEN CASE F.REPORT_TYPE  
              WHEN '2'  
              THEN   
                   CASE A.DAY_WEEK      
                   WHEN '01'   
                   THEN  CASE ISNULL(A.START_TIME,'')     
                         WHEN ''  
                         THEN convert(char(8),'00:00:00',108)   -- 연장근무의경우 0시부터 근무시간을 계산하는 로직 추가 '20.12.14    
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
          WHEN '휴일근무1'    
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
                     CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문   
                     WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
                  CASE        -- 출근시간이 9시 이전일때는 출근시간을 9시로 고정하는 CASE문   
                  WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'17:00:00',108)   -- 18시 이상일때 (CS근무)시간 임시적 근무시간 8시간으로 고정식  
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
        ,   --// 출근시간문 종료 //      
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
      WHEN '반차(오전)'  
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
      WHEN '반차(오후)'      
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
      WHEN '연장근무1'      
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'08:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'18:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END      
       WHEN '연장근무2'      
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'09:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
					 THEN convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	 ELSE CASE 
		   	    	      WHEN convert(char(8),A.START_TIME,108) > convert(char(8),'07:00:00',108)
						  THEN convert(char(8),convert(datetime,dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0)) -convert(datetime,A.TT,108) ,108)  -- 분(minute)계산쿼리 추가 '21.01.12
						  ELSE convert(char(8),dateadd(n, (C.DILIG_HH * 60) + C.DILIG_MM + 450 ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
		   	    	  	  END
		   	    	 END
			    ELSE  convert(char(8),'00:00:00',108)
			    END
            ELSE convert(char(8),'00:00:00',108)     
            END 
       WHEN '휴일근무1'    
       THEN CASE F.REPORT_TYPE
	        WHEN '2'
			THEN 
	          CASE A.DAY_WEEK  
              WHEN '02'  
			  THEN CASE 
			       WHEN convert(char(8),dateadd(hh,C.DILIG_HH , 0),108) >= '05:00:00' -- 휴가근무시간이 5시간 이사일때 점심시간 1시간 차감 식
			       THEN convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM - 60 , 0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
           WHEN '연장근무1'  
           --THEN convert(char(8),dateadd(hh, C.DILIG_HH  ,0),108) 
		   THEN convert(char(8),dateadd( n, (C.DILIG_HH * 60) + C.DILIG_MM - 30  ,0),108) -- 분(minute)계산쿼리 추가 '21.01.12
           WHEN '연장근무2'  
           THEN  convert(char(8),dateadd( n, (C.DILIG_HH * 60) + C.DILIG_MM  - 30 ,0),108) 
           END  
      ELSE NULL 
      END  
 ELSE NULL  
 END as OT,      
CASE D.DILIG_NM  
WHEN '휴일근무1'  
THEN CASE F.REPORT_TYPE  
     WHEN '2'  
     THEN    
         CASE E.APPROVAL_RTN  
         WHEN '1'  
         THEN CASE A.DAY_WEEK  
              WHEN '02'  
              THEN CASE 
			       WHEN convert(char(8),dateadd(hh,C.DILIG_HH , 0),108) >= '05:00:00' -- 휴가근무시간이 5시간 이사일때 점심시간 1시간 차감 식
			       THEN convert(char(8),dateadd(n,(C.DILIG_HH * 60) + C.DILIG_MM - 60 , 0),108) -- 분(minute)계산쿼리 추가 '21.01.12
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
  WHEN D.DILIG_NM <> '반차(오전)'  
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
       WHEN '연장근무1'
    THEN '미승인'
    WHEN '휴일근무1'
    THEN '미승인'
    ELSE NULL
    END
  ELSE NULL
  END
END AS ETC2,  
  CASE E.APPROVAL_RTN    
  WHEN '1'    
  THEN CASE D.DILIG_NM    
       WHEN '연장근무1'    
     THEN    
          CASE   
             WHEN F.REPORT_TYPE = '1'    
             THEN '신청'        
             ELSE NULL    
             END    
       WHEN '휴일근무1'    
       THEN CASE F.REPORT_TYPE    
            WHEN '1'    
            THEN '신청'    
            ELSE NULL    
            END    
  ELSE NULL    
  END    
  ELSE NULL    
  END as FLG_REPORT1   , 
  CASE E.APPROVAL_RTN    
  WHEN '1'    
  THEN CASE D.DILIG_NM    
       WHEN '연장근무1'    
     THEN    
          CASE  
             WHEN F.REPORT_TYPE = '2'    
             THEN '결과'    
             ELSE NULL    
             END    
       WHEN '휴일근무1'    
       THEN CASE F.REPORT_TYPE   
            WHEN '2'    
            THEN '결과'    
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