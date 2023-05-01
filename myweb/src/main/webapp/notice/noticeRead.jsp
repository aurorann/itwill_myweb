<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../member/auth.jsp" %>
<%@ include file="../header.jsp" %>
    
<!-- 본문 시작 bbsRead.jsp-->
<h3>공지사항 상세보기</h3>
<p>
<% if(s_mlevel.equals("A1")) {%>
		<input type="button" value="글쓰기" class="btn" onclick="location.href='noticeForm.jsp'">
<%	}//if end %>
	<a href="noticeList.jsp?col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>">[글목록]</a><!-- 받았던 col과 word값을 다시 준다 -->
</p>
<%
	int noticeno=Integer.parseInt(request.getParameter("noticeno"));

	dto=dao.read(noticeno);
	
	if(dto==null){
		out.println("해당 글없음");
	}else{
		
%>
		<div style="padding: 10%">
		<table class="table">
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">제목</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getSubject() %></td>
			</tr>
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">작성일</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getRegdt() %></td>
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
		<% if(s_mlevel.equals("A1")) {%>
				<input type="button" value="수정" class="btn btn-warning" onclick="location.href='noticeUpdate.jsp?noticeno=<%=noticeno%>&col=<%=col%>&word=<%=word%>'">
				<input type="button" value="삭제" class="btn btn-danger" onclick="location.href='noticeDel.jsp?noticeno=<%=noticeno%>'">
		<%	}//if end %>
		</div>
<%	
	}//if end	
%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>