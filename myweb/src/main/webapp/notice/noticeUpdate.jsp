<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="ssi.jsp" %>
<%@ include file="../member/auth.jsp" %>
<%@ include file="../header.jsp" %>

    
<!-- 본문 시작 noticeUpdate.jsp-->
<h3>공지사항 수정</h3>
<p align="right">
<% if(s_mlevel.equals("A1")) {%>
		<p align="right"><input type="button" value="글쓰기" class="btn" onclick="location.href='noticeForm.jsp'"></p>
<%	}//if end %>
	&nbsp;&nbsp;
	<a href="noticeList.jsp" class="btn btn-primary" role="button">[글목록]</a>	
</p>
<%
	int noticeno=Integer.parseInt(request.getParameter("noticeno"));
	dto=dao.read(noticeno);//글번호가 일치하는 행을 가져오기
	if(dto==null){
		out.println("해당 글없음");
	}else{		
%>
		<form name="noticefrm" id="noticefrm" method="post" action="noticeUpdateProc.jsp" onsubmit="return bbsCheck()">
		<!-- 사용자에게는 필요없는 값이지만, 프로그램 흐름상 필요한 값은 hidden속성으로 담아서 넘긴다 -->
		<input type="hidden" name="noticeno" value="<%=noticeno%>">
		<input type="hidden" name="col" value="<%=col%>">
		<input type="hidden" name="word" value="<%=word%>">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<table class="table">
			<tr>
	  			<th style="background-color: #FFF8DC; text-align: center;">제목</th>
				<td><input type="text" name="subject" id="subject" value="<%=dto.getSubject() %>" maxlength="100" required class="form-control"></td>
			</tr>
			<tr>
	   			<th style="background-color: #FFF8DC; text-align: center;">내용</th>
	   			<td><textarea rows="5" class="form-control" name="content" id="content"><%=dto.getContent() %></textarea></td>
			</tr>

		</table>
		<br>
		<input type="submit" value="수정" class="btn btn-warning">
		<input type="reset" value="취소" class="btn btn-danger">
		</form>

<%	
	}//if end
%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>