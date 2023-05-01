<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

    
<!-- 본문 시작 bbsDel.jsp-->
<!-- 글번호(bbsno)와 비밀번호(passwd)가 일치하면 삭제 -->
<h3>＊ 글삭제 ＊</h3>
<p><a href="bbsList.jsp">[글목록]</a></p>
<%
	int bbsno=Integer.parseInt(request.getParameter("bbsno"));
%>
<div style="padding: 10%">
<form method="post" action="bbsDelProc.jsp" onsubmit="return pwCheck()"><!-- myscript.js -->
	<input type="hidden" name="bbsno" value="<%=bbsno%>">
	<table class="table">
	<tr>
		<th class="success" style="text-align: center" width="300px">비밀번호</th>
		<td width="500px"><input type="password" name="passwd" id="passwd" required></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="삭제" class="btn btn-danger">
		</td>
	</tr>
	</table>
</form>
</div>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>