<%@page import="java.util.Scanner"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	/*  
    		DML(insert, delete, update)
    		JDBC API 통해서 작업
    		1. 결과 집합이 없다
    		2. 반영된 결과(반영된 행의 수가 return됩니당) -> 10건이 주어졌으면 10을 return
    				update emp set sal=0 실행 >> return 14(사원데이터가 14명 있다고 가정)
    				update emp set sal=100 where empno=1111 >> return 0
    				
    				java 코드에서 조건처리 통해서( 성공과 실패 판단 )
    				0보다 크면 성공, 그렇지 않으면 실패!
    				
    		<<Key point>>
    		1. Oracle DML (developer, cmd, Tool) 하면 기본 옵션이 commit 또는 rollback을 강제
    		2. JDBC API 사용해서 작어하면 (DML작업) >> default가 auto commit임(delete해도 실반영, update해도 실반영)
    		3. java 코드에서 delete from emp >> 실행 >> 자동으로 commit이 처리되어서 실반영됨
    		4. 필요에 따라서 commit, rollback을 java코드에서 제어 가능
    		   ㄴ 하지만, default는 auto commit
    		   
    		{시작
    		   A계좌 인출(update)
    		   ...
    		   B계좌 입금(update)
    		종료} -> 시작부터 종료까지 하나의 논리적인 단위(transaction)으로 묶는다
    		 										ㄴ 성공 아니면 실패
    		 autocommit 옵션 >> false 전환
    		 ㄴ 이렇게 바꾸는 순간 java 코드에서 명시적으로 commit(), rollback()구현해야 한다
    		 
    		 ----------------------------------------------------------------------
    		 oracle 구현
    		 -----------------------
    		 CREATE TABLE dmlemp
    		 AS
    		 	SELECT * FROM emp;

    		 SELECT * FROM dmlemp;

    		 ALTER TABLE EMP 
    		 ADD CONSTRAINT pk_dmlemp_empno PRIMARY key(empno);
    		 ----------------------------------------------------------------------
    	*/
    	
    	Connection conn = null;
      	Statement stmt = null;
      	//ResultSet (x) >> DML
      	
      	try{
      		Class.forName("oracle.jdbc.OracleDriver");
      		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bituser","1004");
    		System.out.println("연결 여부 : false :" + conn.isClosed());
    		
    		stmt = conn.createStatement();
    		/*
    		//INSERT
    		int empno=0;
    		String ename="";
    		int deptno=0;
    		
    		Scanner sc = new Scanner(System.in);
    		System.out.println("사번 입력");
    		empno = Integer.parseInt(sc.nextLine());
    		
    		System.out.println("이름 입력");
    		ename = sc.nextLine();
    		
    		System.out.println("부서번호 입력");
    		deptno = Integer.parseInt(sc.nextLine());
    		
    		//insert into emp(empno,ename,deptno) values(2000,'홍길동',30)
    		//조선시대나 .... 현대 (parameter  설정 ...) >> values(?,?,?)
    		String sql="insert into dmlemp(empno,ename,deptno) ";
    		sql+= " values(" +empno+",'" + ename + "'," + deptno+ ")";
      		 
    		int resultrow = stmt.executeUpdate(sql);
    		//executeUpdate 오라클 실행시 
    		//ORA-00001: unique constraint (BITUSER.PK_DMEMP_EMPNO) violated
    		*/
    		
    		
    		/*
    		//UPDATE
    		int deptno = 20; // 부서번호 강제입력
    		String sql = "update dmlemp set sal=0 where deptno="+ deptno;
    		*/
    		
    		// DELETE
    		int deptno = 20; // 부서번호 강제입력
    		String sql = "delete from  dmlemp where deptno="+ deptno;
    		
    		
    		int resultrow = stmt.executeUpdate(sql);
    		
    		if(resultrow > 0){
    			System.out.println("반영된 행의 수 : " + resultrow);
    		}else{
    			//POINT
    			//문제가 생긴것이 아니고(예외가 발생된 것이 아니라)
    			//반영된 행이 없다
    			System.out.println("반영된 행이 없다 ...");
    		}
    	   	
      	}catch(Exception e){
      		   System.out.println(e.getMessage());
      		   
      		   //여기서 코드 처리
      		   //*********************************************
      		   //예외발생에 대한 코드 처리
      		   //*********************************************
      	}finally{
     		if(stmt != null)try {stmt.close();}catch (Exception e) {}
    		if(conn != null)try {conn.close();}catch (Exception e) {}
      	}
    %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>