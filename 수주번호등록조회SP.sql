
CREATE PROCEDURE [dbo].[USP_H4007M5_KO883P_111]            
 (                        
	@DILIG_EMP_NO    nvarchar(26)  --사번                
    , @DEPT_CD    nvarchar(26)  --부서                         
 ) AS                      
                
 BEGIN                                          
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED                                    
                                       
SET NOCOUNT ON                    
             
    
select 
    a.EMP_NO,
	a.name,
	a.DEPT_NM,
	dbo.ufn_getcodename('h0002', a.roll_pstn) as ROLL_PSTN_NM,
	b.ST_NUM,
	b.BIND_NUM,
	b.EMAIL,
	dbo.ufn_getcodename('CTEST', a.DEPT_NM) as G_EMAIL,
	a.HAND_TEL_NO

  --A.YYYY,     
  --A.DILIG_EMP_NO,     
  --b.NAME as EMP_NAME,    
  --B.roll_pstn as ROLL_PSTN,     
  --dbo.ufn_getcodename('h0002', B.roll_pstn) as ROLL_PSTN_NM,    
  --dept.dept_cd,    
  --dept.dept_nm,     
  --a.BASIC_QTY,     
  --a.ETC1_QTY,  
  --a.USER_QTY     
 from HAA010T(NOLOCK) a    
 join Ex_Number B on A.emp_no = B.emp_no    
  order by   a.ROLL_PSTN    
            
 END 

