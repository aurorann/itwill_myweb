<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

    
<!-- 본문 시작 bbsUpdate.jsp-->
<h3>＊ 게시판 수정 ＊</h3>
<p align="right">
	<a href="bbsForm.jsp" class="btn btn-primary" role="button">[글쓰기]</a>
	&nbsp;&nbsp;
	<a href="bbsList.jsp" class="btn btn-primary" role="button">[글목록]</a>	
</p>
<%
	int bbsno=Integer.parseInt(request.getParameter("bbsno"));
	dto=dao.read(bbsno);//글번호가 일치하는 행을 가져오기
	if(dto==null){
		out.println("해당 글없음");
	}else{		
%>
		<form name="bbsfrm" id="bbsfrm" method="post" action="bbsUpdateProc.jsp" onsubmit="return bbsCheck()">
		<!-- 사용자에게는 필요없는 값이지만, 프로그램 흐름상 필요한 값은 hidden속성으로 담아서 넘긴다 -->
		<input type="hidden" name="bbsno" value="<%=bbsno%>">
		<input type="hidden" name="col" value="<%=col%>">
		<input type="hidden" name="word" value="<%=word%>">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<table class="table">
			<tr>
	   			<th style="background-color: #FFF8DC; text-align: center;">작성자</th>
				<td><input type="text" name="wname" id="wname" value="<%=dto.getWname() %>" maxlength="50" placeholder="이름" required autofocus class="form-control"></td>
			</tr>
			<tr>
	  			<th style="background-color: #FFF8DC; text-align: center;">제목</th>
				<td><input type="text" name="subject" id="subject" value="<%=dto.getSubject() %>" maxlength="100" required class="form-control"></td>
			</tr>
			<tr>
	   			<th style="background-color: #FFF8DC; text-align: center;">내용</th>
	   			<td><textarea rows="5" class="form-control" name="content" id="content"><%=dto.getContent() %></textarea></td>
			</tr>
			<tr>
	   			<th style="background-color: #FFF8DC; text-align: center;">비밀번호</th>
	   			<td><input type="password" name="passwd" id="passwd" class="form-control" maxlength="10" required></td>
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