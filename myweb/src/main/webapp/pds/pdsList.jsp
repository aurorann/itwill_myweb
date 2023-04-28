<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
    
<!-- 본문 시작 pdsList.jsp-->
<h3>포토 갤러리</h3>
<br>
<div>
<p align="right"><a href="pdsForm.jsp" class="btn btn-primary" role="button">사진올리기</a></p>
<%
	ArrayList<PdsDTO> list=dao.list();
	if(list==null){
		out.println("포토갤러리 게시글 없음");
	}else{
%>
		<table class="table table-striped">
		<tr>
			<th style="text-align: center; padding-left: 20px;">글제목</th>
			<th style="text-align: center;">사진</th>
			<th style="text-align: center;">조회수</th>
			<th style="text-align: center;">작성자</th>
			<th style="text-align: center;">등록일</th>		
		</tr>

<%
			for(int i=0; i<list.size(); i++){
				dto=list.get(i);
%>
				<tr>
					<td><a href="pdsRead.jsp?pdsno=<%=dto.getPdsno()%>"><%=dto.getSubject() %></a></td>
					<td><img src='../storage/<%=dto.getFilename() %>' width="50px"></td>
					<td><%=dto.getReadcnt() %></td>
					<td><%=dto.getWname() %></td>
					<td><%=dto.getRegdate().substring(0,10) %></td>
				</tr>
<%
			}//for end
%>

		</table>

		
<%
		out.println("전체 글 갯수 :" + list.size());
	}//if end

%>
</div>

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>