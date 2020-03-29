package com.goodjobdebu.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class Test04 {
	public static void main(String[] args) {
		String id = "c##myJsp";
		String password = "jsppassword";
		String url ="jdbc:oracle:thin:@localhost:1521:xe";
		
		Connection connection =null;
		PreparedStatement ps = null;
		Scanner scan = new Scanner(System.in);
		String name = null;
		String mail = null;
		//입력문 준비
		 System.out.println("이름을 입력하세요.");
		 name=scan.nextLine();
		 System.out.println("메일을 입력하세요.");
		 mail=scan.nextLine();
		 
		 //쿼리 작성
		String sql = 
		"insert into employee values('"+name+"','"+mail+"',1000,acc_seq.nextval,SYSDATE)";
		
		try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		 connection = DriverManager.getConnection(url,id,password);
		 

		
		 //실행
			 ps = connection.prepareStatement(sql);
			 ps.execute();//데이터입력할때  commit도 자동으로 실행이 된다.


		 
		System.out.println("데이터 입력 완료!");
		
		}catch(ClassNotFoundException e) {
			e.printStackTrace(); // OracleDriver클래스가 없을때 발생
		}catch(SQLException e) {
			e.printStackTrace(); // 커넥션(DB와 연동)하는 과정에서 예외 발생
		}finally {
			try {
			if(ps!=null) {
				ps.close();	
			}
			if(connection!=null) {
				connection.close();	
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
		}

}
