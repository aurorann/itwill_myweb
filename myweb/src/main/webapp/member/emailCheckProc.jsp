<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="ssi.jsp" %>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    <script src="../js/jquery-3.6.4.min.js"></script>
    <script src="../js/moment-with-locales.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <!-- layout.css import -->
    <link rel="stylesheet" href="../css/layout.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>idCheckProc.jsp</title>
</head>
<body>
	<div style="text-align: center">
		<br><br>
		<h3>Email 중복확인 결과</h3>
<%
	String email=request.getParameter("email").trim();
	//String email2=request.getParameter("email2").trim();
	int cnt=dao.duplecateID(email);
	out.println("입력 Email : <strong>" + email +"</strong>");
	out.println("<br><br>");
	
	if(cnt==0){
		out.println("<p>사용 가능한 아이디 입니다.</p>");
%>
	<!-- 사용 가능한 id를 부모창에 전달 -->
	<a href="javascript:apply('<%=email%>')">[적용]</a>
	<script>
		function apply(email) {
			//alert(id);
			opener.document.memfrm.email.value=email;
			window.close();
		}//apply() end
	</script>


<%
	}else{
		out.println("<p style='color:red'>해당 이메일은 사용할 수 없습니다.</p>");
	}//if end
%>
	<hr>
	<a href="javascript:history.back()">[다시검색]</a>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="javascript:window.close()">[창닫기]</a>
	
	</div>

</body>
</html>