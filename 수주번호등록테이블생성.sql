select * from HAA010T

begin tran
CREATE TABLE Ex_Number (
       EMP_NO                nvarchar(26)             NOT NULL,
       ST_NUM      nvarchar(40),
       BIND_NUM    nvarchar(40),  
       EMAIL       nvarchar(80)
    
      CONSTRAINT PK_Ex_NUM PRIMARY KEY (EMP_NO)
    
);

commit

begin tran
INSERT INTO Ex_Number (EMP_NO) SELECT EMP_NO FROM HAA010T

commit

select * from Ex_Number




