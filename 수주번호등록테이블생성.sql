select * from HAA010T

begin tran
CREATE TABLE Ex_Number (
       YYYY        nchar(4)             NOT NULL,
       EMP_NO      nvarchar(26)             NOT NULL,
       ST_NUM      nvarchar(40),
       BIND_NUM    nvarchar(40),  
       EMAIL       nvarchar(80),
	   ETC_QTY1    nvarchar(40),
	   ETC_QTY2    nvarchar(40),
	   ETC_QTY3    nvarchar(40),
	   ISRT_EMP_NO nvarchar(40),
	   ISRT_DT     datetime,
	   UPDT_EMP_NO nvarchar(40),
	   UPDT_DT     datetime
    
      CONSTRAINT PK_Ex_NUM PRIMARY KEY (EMP_NO,YYYY)
    
);

commit

begin tran
INSERT INTO Ex_Number (YYYY,EMP_NO) SELECT YYYY,DILIG_EMP_NO FROM H4006M3_Q_KO883

commit

select * from Ex_Number order by yyyy




