<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="./ssi.jsp" %>
<%@ include file="../header.jsp" %>
    
<!-- 본문 시작 memberUpdateProc.jsp-->

<h3>회원정보 수정 결과</h3>
<% 
	String id 	= request.getParameter("id").trim();
	String passwd = request.getParameter("passwd").trim();
	String mname = request.getParameter("mname").trim();
	String tel = request.getParameter("tel").trim();
	String email = request.getParameter("email").trim();
	String zipcode = request.getParameter("zipcode").trim();
	String address1 = request.getParameter("address1").trim();
	String address2 = request.getParameter("address2").trim();
	String job = request.getParameter("job").trim();
	
	dto.setId(id);
	dto.setPasswd(passwd);
	dto.setMname(mname);
	dto.setTel(tel);
	dto.setEmail(email);
	dto.setZipcode(zipcode);
	dto.setAddress1(address1);
	dto.setAddress2(address2);
	dto.setJob(job);
	
	int cnt=dao.memupdate(dto);
	
	if(cnt==0){
		out.println("<p>회원정보 수정에 실패했습니다</p>");
		out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
	}else{
		out.println("<script>");
		out.println("	alert('회원정보가 수정되었습니다');");
		out.println("	location.href='loginForm.jsp';");//목록페이지 이동
		out.println("</script>");
	}//if end



%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>