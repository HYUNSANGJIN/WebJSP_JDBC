<%@page import="java.util.Scanner"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- 
    	지금 하는 작업은 java 코드(servlet)에서 하는 작업이다
     -->
    
    <%
    	// 1. 인터페이스 선언
    	Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs = null;
    	
    	
    	try{
    		// 2. 드라이버 로딩
    		Class.forName("oracle.jdbc.OracleDriver");
    		System.out.println("Oracle 로딩..");
    		
    		// 3. 연결 객체 생성
    		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bituser","1004");
    		System.out.println("연결 여부 확인 : false가 나오면 정상 -> " + conn.isClosed());
    		
    		// 4. 명령 객체 생성
    		stmt = conn.createStatement();
    		
    		// 4-1. parameter 설정 (해도그만 안해도그만)
    		String job = "";
    		Scanner sc = new Scanner(System.in);
    		System.out.println("직종입력");
    		job = sc.nextLine();
    		
    		// 4-2. 명령구문 생성
    		String sql = "select empno, ename, job from emp where job = '"+job+"'";
    		// ㄴ where job='CLERK'
    		
    		// 5. 명령실행
    		// DQL(select) >> 실행할때 stmt.executeQuery(sql) >> return ResultSet 타입의 객체 주소를 리턴
    		// DML(insert, delete, update) >> 결과 집합(x) >> return 반영된 행의 개수 >> stmt.executeUpdate()
    		// delete from emp; 실행하면 >> return 값은 14
    				
    		rs = stmt.executeQuery(sql);
    		
    		// 명령처리 
    		/* 
    			DQL(select)
    			1. 결과가 없는 경우(where empno=1111)
    			2. 결과가 1건일 경우(row 1개) : (PK, Unique 컬럼조회 : where empno=7788)
    			3. 결과가 여러건일 경우(row : select empno, ename, from emp where deptno=20)
    		*/
    		
    		// 1. 간단하고 단순한 방법(while)
    		//    ㄴ 장점 : 여러건의 조회 가능
    		//    ㄴ 단점 : 결과 집합이 없는 경우의 로직처리가 안됨
    	//	while(rs.next()){ // 너 결과 집합(row)이 있니??
    			// rs.getInt("empno") -> 이런식으로 가져와서 출력
    	//	}
    		
    	// ======================================================================
    			
    		// 2. 결과가 있는 경우와 없는 경우 처리(if)
    		//	  ㄴ 장점 : 없는건의 조회도 가능
    		//    ㄴ 단점 : 1건이 있는 경우는 가능 BUT 여러건의 조회는 불가능 (row read 불가)
    	//	if(rs.next()){
    			// rs.getInt("empno") -> 이런식으로 가져와서 출력
    //	}else{
    			// 조회된 데이터가 없습니다
    	//	}
    		
    	// ==========================================================================
    			
    		// 1,2번 합치기
    		// -single row 데이터 처리 가능
    		// -multi row 여러건 데이터 처리 가능
    		// -결과가 없는 경우 가능
    		if(rs.next()){
    			
    			do{
    				// 컬럼 이름을 쓰지 않고
    				// 순서를 써도 된다
    				// System.out.println(rs.getInt(1) + "," + rs.getString(2) +"," + rs.getString("job"));
    				//  ㄴ 유지보수가 떨어짐
    				System.out.println(rs.getInt("empno") + "," + rs.getString("ename") +"," + rs.getString("job"));
    			}while(rs.next());
    			
    		}else{
    			
    			System.out.println("조회된 데이터가 없습니다");
    		}
    	}catch(Exception e){
    		System.out.println(e.getMessage());
    	}finally{
    		//자원 해제
    		try{
    			stmt.close();
    			rs.close();
    			conn.close();
    		}catch(Exception e){
    			
    		}
    		
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