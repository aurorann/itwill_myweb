<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="net.utility.Utility"%>
<%@page import="javax.mail.Session"%>
<%@page import="net.utility.MyAuthenticator"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../member/ssi.jsp" %>
<%@ include file="../header.jsp" %>
    
<!-- 본문 시작 mailProc.jsp-->
<h3>메일 보내기 결과</h3>
<br><br>
<%
	String email = request.getParameter("email").trim();
	String ID = request.getParameter("id").trim();
	String mname = request.getParameter("mname").trim();
	String randompw=dao.tempPassword(10);
	
	//dto객체에 담기
	dto.setPasswd(randompw);
	dto.setMname(mname);
	dto.setEmail(email);
	
	int cnt=dao.passupdateProc(dto);
	
	if(cnt==0){
		out.println("<p>임시비밀번호 발급에 실패했습니다</p>");
		out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
	}else{
		
		try{
			
			//1) 사용하고자 하는 메일서버에서 인증받은 계정과 비번 등록하기
			//	-> MyAuthenticator 클래스 생성
			
			//2) 메일서버(POP3/SMTP) 지정하기(우체통)
			String mailServer="mw-002.cafe24.com"; //cafe24 메일서버
			Properties props=new Properties();
			props.put("mail.smtp.host",mailServer);
			props.put("mail.smtp.auth", true);

			//3) 메일서버에서 인증받은 계정+비번
			Authenticator myAuth=new MyAuthenticator();//다형성

			//4) 2)와 3)이 유효한지 검증
			Session sess=Session.getInstance(props, myAuth);
			//out.print("메일 서버 인증 성공!!");
			
			//5) 메일 보내기
			request.setCharacterEncoding("UTF-8");
			String to = email;
			String from ="aurorannn@gmail.com";
			String subject ="아이디와 임시 비밀번호";
			String content ="";
			
			//엔터 및 특수문자 변경
			content=Utility.convertChar(content);
			
			content+="고객님의 아이디는 "+ID+" 이며";
			content+="<br>";
			content+="임시비밀번호는 "+randompw+"입니다.";		
			

			
			//이미지 출력하기
			content+="<img src='http://localhost:9090/myweb/images/bearggu2.gif'>";
			
		
			//받는 사람 이메일 주소
			InternetAddress[] address = {new InternetAddress(to)};
			/*
				수신인이 여러명인 경우
				InternetAddress[] address = {new InternetAddress(to1),
											 new InternetAddress(to2),
											 new InternetAddress(to3),
											 new InternetAddress(to4),
											 new InternetAddress(to5), ~~};		
			*/
			
			//메일 관련 정보 작성
			Message msg = new MimeMessage(sess);
			
			//받는 사람
			msg.setRecipients(Message.RecipientType.TO, address);
			//참조	Message.RecipientType.CC
			//숨은참조	Message.RecipientType.BCC
			
			//보내는 사람
			msg.setFrom(new InternetAddress(from));
			
			//메일 제목
			msg.setSubject(subject);
			
			//메일 내용
			msg.setContent(content, "text/html; charset=UTF-8");
			
			//메일 보낸 날짜
			msg.setSentDate(new Date());
			
			//메일 전송
			Transport.send(msg);
			
			out.print(to+"님에게 아이디와 임시비밀번호가 메일로 발송되었습니다");
%>
<br>
<p align="center">
	<a href="../member/loginForm.jsp" class="btn btn-primary" role="button">로그인하러가기</a>
</p>
<%			
			
				
		}catch(Exception e){
			out.println("<p>메일 전송에 실패했습니다 "+e+"</p>");
			out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
		}//end
		
	}//if end
%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>