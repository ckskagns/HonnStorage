package com.goodjobdebu.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class Test05 {
	public static void main(String[] args) {
		String id = "c##myJsp";
		String password = "jsppassword";
		String url ="jdbc:oracle:thin:@localhost:1521:xe";
		
		Connection connection =null;
		PreparedStatement ps = null;

		
		try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		 connection = DriverManager.getConnection(url,id,password);
		 
		 // Employee테이블에 입력받은 학생 이름, 연락처를 레코드로 추가해보자.
		 Scanner sc = new Scanner(System.in);
		 String name;
		 String tel;
		 System.out.print("학생이름 : ");
		 name = sc.next();
		 System.out.println("학생 연락처 : ");
		 tel = sc.next();
		 
		 int kr,en,ma;
		 double avg;
		 
		 System.out.print("국어 : ");
		 kr = sc.nextInt();
		 System.out.print("영어 : ");
		 en = sc.nextInt();
		 System.out.print("수학 : ");
		 ma = sc.nextInt();		
		
		 avg = (kr+en+ma)/3.0;		 
		 
		 String sql = "INSERT INTO student values(student_seq.NEXTVAL,?,?,?,?,?,?,SYSDATE)";
		 ps = connection.prepareStatement(sql);
		 ps.setString(1, name);
		 ps.setString(2, tel);
		 ps.setInt(3, kr);
		 ps.setInt(4, en);
		 ps.setInt(5, ma);
		 ps.setDouble(6, avg);
		 ps.execute();
		 System.out.println("학생추가완료");


		
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
