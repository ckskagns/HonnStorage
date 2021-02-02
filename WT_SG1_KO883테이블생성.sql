-- DROP TABLE WT_SG1_KO883
CREATE TABLE WT_SG1_KO883(
     EMP_NO		nvarchar(13)	
    ,NAME		nvarchar(30)	
    ,ROLL_PSTN_NM   nvarchar(12)	
    ,DEPT_NM		nvarchar(40)	
    ,WORK_DT		nvarchar(20)	
    ,DAY_WEEK		nvarchar(12)	
    ,START_TIME		nvarchar(8)	
    ,END_TIME		nvarchar(8)	
	,END_TIME_S		nvarchar(8)
    ,TOT_TIME		nvarchar(8)	
    ,OT		nvarchar(8)	
    ,HT		nvarchar(8)	
    ,TT		nvarchar(8)
	,FLG_REPORT1		nvarchar(2) default 'N'	
    ,FLG_REPORT2		nvarchar(2) default 'N'	
    ,ETC1		nvarchar(24)	
    ,ETC2		nvarchar(24)	
    ,ETC3		nvarchar(24)
	,INSRT_USER_ID nvarchar(24)
	,INSRT_DT  datetime
	,UPDT_USER_ID nvarchar(24)
	,UPDT_DT   datetime

)

-- select * from WT_SG1_KO883