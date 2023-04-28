<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    <script src="../js/jquery-3.6.4.min.js"></script>
    <script src="../js/moment-with-locales.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <!-- layout.css import -->
    <link rel="stylesheet" href="../css/layout.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>idCheckForm.jsp</title>

</head>
<body>
	<div style="margin: auto;" align="center">
		<br><br>
		<h3>아이디 중복확인</h3>
		<br>
		<form action="idCheckProc.jsp" onsubmit="return blankCheck()">
			아이디 : <input type="text" name="id" id="id" maxlength="10" autofocus>
			<br><br>
			<input type="submit" value="중복확인">
		</form>
	</div>
	<script>
		function blankCheck() {
			let id=document.getElementById("id").value;
			id=id.trim();
			if(id.length<5){
				alert("아이디는 5~10글자 이내로 입력해 주세요");
				return false;
			}//if end
			return true;
		}//blankCheck() end
	</script>
</body>
</html>