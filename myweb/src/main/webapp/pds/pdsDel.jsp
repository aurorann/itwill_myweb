<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

    
<!-- 본문 시작 pdsDel.jsp-->
<!-- 글번호(pdssno)와 비밀번호(passwd)가 일치하면 행삭제 및 첨부파일 삭제 -->
<h3>＊ 글삭제 ＊</h3>
<p><a href="pdsList.jsp">[포토갤러리]</a></p>
<%
	int pdsno=Integer.parseInt(request.getParameter("pdsno"));
%>
<div style="padding: 10%">
<form method="post" action="pdsDelProc.jsp" onsubmit="return pwCheck2()"><!-- myscript.js -->
	<input type="hidden" name="pdsno" value="<%=pdsno%>">
	<table class="table">
	<tr>
		<th class="success" style="text-align: center" width="300px">비밀번호</th>
		<td width="500px"><input type="password" name="passwd" id="passwd" maslength="15" required></td>
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