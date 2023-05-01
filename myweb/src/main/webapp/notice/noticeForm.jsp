<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

    
<!-- 본문 시작 bbsForm-->
<h3>＊ 공지사항 쓰기 ＊</h3>
<p align="right"><a href="noticeList.jsp" class="btn btn-default" role="button">글목록</a></p>
																<!-- myscript.js에 함수 작성 -->
<form name="noticefrm" id="noticefrm" method="post" action="noticeIns.jsp" onsubmit="return bbsCheck()">
<div style="vertical-align: middle; line-height: auto;">
	<table class="table">
	<tr>
	   <th style="background-color: #FFF8DC; text-align: center;">제목</th>
	   <td><input type="text" name="subject" id="subject" class="form-control" maxlength="100" required></td>
	</tr>
	<tr>
	   <th style="background-color: #FFF8DC; text-align: center;">내용</th>
	   <td><textarea rows="5"  class="form-control" name="content" id="content"></textarea></td>
	</tr>
	<tr>
	    <td colspan="2" align="center">
	       <input type="submit" value="쓰기" class="btn btn-success">
	       <input type="reset"  value="취소" class="btn btn-danger">
	    </td>
	</table>
</div>
</form>

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>