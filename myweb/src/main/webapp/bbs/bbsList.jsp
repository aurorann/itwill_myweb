<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
    
<!-- 본문 시작 bbsList.jsp-->
<h3>글 목 록</h3>
<br>
<div>
<p align="right"><a href="bbsForm.jsp" class="btn btn-primary" role="button">글쓰기</a></p>

<table class="table table-striped">
<tr>
	<th style="text-align: center; padding-left: 20px;">글제목</th>
	<th style="text-align: center;">작성자</th>
	<th style="text-align: center;">조회수</th>
	<th style="text-align: center;">등록일</th>

</tr>
<%

	//한페이지당 출력할 행의 갯수
	int recordPerPage=10;	

	ArrayList<BbsDTO> list=dao.list3(col, word, nowPage, recordPerPage);
	//ArrayList<Map<String, Integer>> list2= dao.recnt();
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
				<td style="text-align: left; padding-left: 20px;">
<%
					//답변이미지 출력
					for(int n=1; n<=dto.getIndent(); n++){
						out.println("<img src='../images/reply.gif'>");
					}//for end
%>
					<a href="bbsRead.jsp?bbsno=<%=dto.getBbsno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>"><%=dto.getSubject() %></a>
<%
					//오늘 작성한 글제목 뒤에 new 이미지 출력
					//작성일(regdt)에서 "년월일" 자르기
					String regdt=dto.getRegdt().substring(0, 10);
					if(regdt.equals(today)){//작성일이 오늘날짜와 같다면
						out.println("<img src='../images/new_1.png'>");
					}//if end
					
					//조회수가 10이상이면 hot이미지 넣기
					if(dto.getReadcnt()>=10){
						out.println("<img src='../images/hot.gif'>");
					}//if end
					
					//제목 옆에 댓글갯수 넣기
					int replycnt=dao.replyCount(dto);
					
					if(dto.getIndent()==0 && replycnt>0){
						out.println("("+replycnt+")");
					}//if end
					
					
					
					
					
					/*
					if(dto.getIndent()==0){
						for(int j = 0; j < list2.size(); j++){
							Map<String, Integer> row = list2.get(j);
							int test = dto.getGrpno();
							Integer grpno = new Integer(dto.getGrpno());
							int a = row.get("grpNo").intValue();
							if(row.get("grpNo").equals(grpno)){
								out.println("("+row.get("reply")+")");	
							}
						}
					}//if end
					*/
					
					
%>	
				</td>
				<td><%=dto.getWname() %></td>
				<td><%=dto.getReadcnt() %></td>
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
		<!-- 검색시작 -->
		<tr>
			<td colspan="4" style="text-align: center; height: 50px">
				<form action="bbsList.jsp" onsubmit="return searchCheck()"><!-- myscript.js함수 작성 -->
					<select name="col">
						<option value="subject_content">제목+내용</option>
						<option value="subject">제목</option>
						<option value="content">내용</option>
						<option value="wname">작성자</option>
					</select>
					<input type="text" name="word" id="word">
					<input type="submit" value="검색">					
				</form>			
			</td>
		</tr>
		<!-- 검색끝 -->
<%		
	}//if end
%>
	</table>
</div>

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>