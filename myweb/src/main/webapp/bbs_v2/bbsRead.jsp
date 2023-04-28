<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
    
<!-- 본문 시작 bbsRead.jsp-->
<h3>＊ 게시판 상세보기 ＊</h3>
<p>
	<a href="bbsForm.jsp">[글쓰기]</a>
	&nbsp;&nbsp;
	<a href="bbsList.jsp?col=<%=col%>&word=<%=word%>">[글목록]</a><!-- 받았던 col과 word값을 다시 준다 -->
</p>
<%
	int bbsno=Integer.parseInt(request.getParameter("bbsno"));

	dto=dao.read(bbsno);
	
	if(dto==null){
		out.println("해당 글없음");
	}else{
		
		dao.incrementCnt(bbsno);
%>
		<div style="padding: 10%">
		<table class="table">
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">제목</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getSubject() %></td>
			</tr>
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">작성자명</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getWname() %></td>
			</tr>
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">작성일</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getRegdt() %></td>
			</tr>
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">IP</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getIp() %></td>
			</tr>
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">조회수</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getReadcnt() %></td>
			</tr>
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">내용</th>
				<td style="text-align: left; padding-left: 30px;">
<%
				//특수문자 및 엔터 치환하기
				String content=Utility.convertChar(dto.getContent());
				out.print(content);
%>
				</td>
			</tr>


		</table>
		<br>
		<input type="button" value="답변쓰기" class="btn btn-info" onclick="location.href='bbsReply.jsp?bbsno=<%=bbsno%>&col=<%=col%>&word=<%=word%>'">
		<input type="button" value="수정" class="btn btn-warning" onclick="location.href='bbsUpdate.jsp?bbsno=<%=bbsno%>&col=<%=col%>&word=<%=word%>'">
		<input type="button" value="삭제" class="btn btn-danger" onclick="location.href='bbsDel.jsp?bbsno=<%=bbsno%>'">
		</div>
<%	
	}//if end
	
%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>