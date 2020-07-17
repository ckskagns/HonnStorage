ALTER PROCEDURE [dbo].[USP_H4007M5_KO883P_111]            
 (                        
	@EMP_NO    nvarchar(26)  --사번                
    , @DEPT_CD nvarchar(26)  --부서  
	, @YYYY    nchar(4)      --기준년도                     
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
   
 from HAA010T(NOLOCK) a    
 join Ex_Number B on A.emp_no = B.emp_no
 join dbo.ufn_h_getdeptdata(GETDATE()) dept on A.EMP_NO = dept.emp_no
 where B.YYYY = @YYYY and (@EMP_NO ='' or A.EMP_NO = @EMP_NO ) and (@DEPT_CD = '' or dept.dept_cd = @DEPT_CD)     
  order by   a.ROLL_PSTN    
            
 END 

