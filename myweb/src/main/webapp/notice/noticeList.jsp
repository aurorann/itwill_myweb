<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="ssi.jsp" %>
<%@ include file="../member/auth.jsp" %>
<%@ include file="../header.jsp" %>
    
<!-- 본문 시작 noticeList.jsp-->
<h3>공 지 사 항</h3>
<br>
<div>
<% if(s_mlevel.equals("A1")) {%>
		<p align="right"><input type="button" value="글쓰기" class="btn" onclick="location.href='noticeForm.jsp'"></p>
<%	}//if end %>
<table class="table table-striped">
<tr>
	<th style="text-align: center;">글번호</th>	
	<th style="text-align: center; padding-left: 20px;">글제목</th>
	<th style="text-align: center;">등록일</th>

</tr>
<%

	//한페이지당 출력할 행의 갯수
	int recordPerPage=10;	

	ArrayList<NoticeDTO> list=dao.list();
	if(list==null){
		out.println("<tr>");
		out.println("	<td colspan ='4'>");
		out.println("	<strong>글 없음</strong>");
		out.println("	</td>");
		out.println("</tr>");
	}else{
		
		//오늘 날짜를 문자열 "2023-04-14" 만들기
		String today=Utility.getDate();
				
		for(int i=0; i<list.size(); i++){
			dto=list.get(i);//dto에서 가져온 한줄을 dto에 담는다
%>
			<tr>
				<td><%=dto.getNoticeno() %></td>
				<td style="text-align: left; padding-left: 20px;">
					<a href="noticeRead.jsp?noticeno=<%=dto.getNoticeno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>"><%=dto.getSubject() %></a>
<%
					//오늘 작성한 글제목 뒤에 new 이미지 출력
					//작성일(regdt)에서 "년월일" 자르기
					String regdt=dto.getRegdt().substring(0, 10);
					if(regdt.equals(today)){//작성일이 오늘날짜와 같다면
						out.println("<img src='../images/new_1.png'>");
					}//if end					
%>	
				</td>
				<td><%=dto.getRegdt().substring(0, 10) %></td>
			</tr>
<%
		}//for end
		
		//글갯수
		int totalRecord=dao.count2(col, word);
		out.println("<tr>");
		out.println("	<td colspan='4' style='text-align:center;'>");
		out.println("		글갯수:<strong>" + totalRecord + "</strong>");
		out.println("	</td>");
		out.println("</tr>");
		
		
		//페이지 리스트
		out.println("<tr>");
		out.println("	<td colspan='4' style='text-align:center; height:50px'>");
		
		String paging=new Paging().paging3(totalRecord, nowPage, recordPerPage, col, word, "bbsList.jsp");
		out.println(paging);
		
		out.println("	</td>");
		out.println("</tr>");		
%>

<%		
	}//if end
%>
	</table>
</div>

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>