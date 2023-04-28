<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
    
<!-- 본문 시작 pdsRead.jsp-->
<h3>포토 갤러리 게시글 보기</h3>
<br>
<div>
<p align="right"><a href="pdsForm.jsp" class="btn btn-primary" role="button">사진올리기</a></p>
<%
	int pdsno=Integer.parseInt(request.getParameter("pdsno"));
	dto=dao.read(pdsno);
	if(dto==null){
		out.println("해당 글 없음");
	}else{
		dao.incrementCnt(pdsno);//조회수 증가
%>
		<div style="padding: 10%">
		<table class="table">
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">제목</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getSubject() %></td>
			</tr>
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">작성자</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getWname() %></td>
			</tr>
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">조회수</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getReadcnt() %></td>
			</tr>
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">작성일</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getRegdate() %></td>
			</tr>
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">파일크기</th>
				<td style="text-align: left; padding-left: 30px;"><%=dto.getFilesize() %>byte</td>
			</tr>
			<tr>
				<th class="info" width="30%" style="padding-left: 30px;">사진</th>
				<td><img src="../storage/<%=dto.getFilename()%>" width="500px"> </td>
			</tr>
		</table>
		<br>
		<input type="button" value="목록보기" class="btn btn-info" onclick="location.href='pdsList.jsp'">
		<input type="button" value="삭제" class="btn btn-danger" onclick="location.href='pdsDel.jsp?pdsno=<%=pdsno%>'">
		</div>
<%
	}//if end
%>
</div>

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>