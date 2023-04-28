<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Web</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    <script src="js/jquery-3.6.4.min.js"></script>
    <script src="js/moment-with-locales.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <!-- layout.css import -->
    <link rel="stylesheet" href="css/layout.css">    
    <script src="js/myscript.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
      
    <style>
    </style>
</head>

<body>

 
<script>    

function showtime(){
    const d=new Date();

    let today="";
    //년도
    today += d.getFullYear() + ".";

    //월
    if(d.getMonth()+1<10){
        today+="0";
    }//if end    
    today += d.getMonth() + 1 + ".";

    //일
    if(d.getDate()<10){
        today+="0";
    }//if end    
    today += d.getDate();

    //요일값 구하기
    switch(d.getDay()){
    case 0: today+="(일)"; break;
    case 1: today+="(월)"; break;
    case 2: today+="(화)"; break;
    case 3: today+="(수)"; break;
    case 4: today+="(목)"; break;"C:/Users/itwill/Downloads/src/main/webapp/index_2.jsp"
    case 5: today+="(금)"; break;
    case 6: today+="(토)"; break;
    }//switch end

    //AM PM 구분
    if(d.getHours()<12){
        today+=" AM ";
    }else{
        today+=" PM ";
    }//if end  
    
    //시간 12시이상 구분
    if(d.getHours()<13){
        today+=d.getHours() + " : ";
    }else{
        today+=(d.getHours()-12) + " : ";
    }//if end     


    //분 
    if(d.getMinutes()<10){
    today+="0";
    }//if end    
    today += d.getMinutes() + " : ";

    //초
    if(d.getSeconds()<10){
    today+="0";
    }//if end    
    today += d.getSeconds();

    document.getElementById("clock").innerText = today;

    //1초후에 showtime함수를 호출
    timer = setTimeout(showtime, 1000);
    
}//showtime end


</script>

<!-- Navbar -->
<nav class="navbar navbar-default" id="navbar">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="<%=request.getContextPath() %>/index.jsp">HOME</a><!-- /는 무조건 루트에서부터 찾겠다는 절대경로 -->
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="./bbs/bbsList.jsp">게시판</a></li>
        <li><a href="#">공지사항</a></li>
        <li><a href="./member/loginForm.jsp">로그인</a></li>
        <li><a href="./pds/pdsList.jsp">포토갤러리</a></li>
        <li><a href="./mail/mailForm.jsp">메일보내기</a></li>
      </ul>
    </div>
  </div>
</nav><!-- 메인카테고리 끝 -->

<!-- First Container -->
<div class="container-fluid bg-1 text-center">
  <img src="images/bearggu3.gif" class="img-responsive img-circle margin" style="display:inline" alt="베어꾸" width="300px">
</div>

<!-- Second Container -->
<div class="container-fluid bg-3 text-center">    
  <div class="row">
    <div class="col-xs-12" >
        <!-- 본문 시작 -->
			<div class="bg-3 text-center">    
			  <h1 class="margin">Catch BLANC Moment</h1><br>
			  <div class="row">
			    <div class="col-sm-4">
			      <!-- <p class="text-info" data-toggle="collapse" data-target="#demo">BABY BLANC</p> -->
			      <p><button type="button" class="btn btn-default" data-toggle="collapse" data-target="#demo1">BABY BLANC</button></p>
			      <div id="demo1" class="collapse">
			      <p>블랑이 처음 만난날</p>
			      </div>
			      <img src="images/blanc_01.jpg" class="img-responsive margin img-thumbnail" style="width:100%" alt="Image">
			    </div>
			    <div class="col-sm-4">
			      <!-- <p class="text-info">BRAVE BLANC</p> -->
			      <p><button type="button" class="btn btn-default" data-toggle="collapse" data-target="#demo2">BRAVE BLANC</button></p>
			      <div id="demo2" class="collapse">
			      <p>블랑이 멋진 포즈 취한날</p>
			      </div>
			      <img src="images/blanc_06.JPG" class="img-responsive margin img-thumbnail" style="width:100%" alt="Image">
			    </div>
			    <div class="col-sm-4">
			      <!-- <p class="text-info">EXCITE BLANC</p> -->
			      <p><button type="button" class="btn btn-default" data-toggle="collapse" data-target="#demo3">EXCITE BLANC</button></p>
			      <div id="demo3" class="collapse">
			      <p>블랑이 산책하며 신난날</p>
			      </div>
			      <img src="images/blanc_09.JPG" class="img-responsive margin img-thumbnail" style="width:100%" alt="Image">
			    </div>
			  </div>
			</div>
			<hr>
			
			<!-- 디지털시계 -->
          	<div id="clock"><script>showtime();</script></div>



        <!-- 본문 끝 -->
    </div><!-- col-xs-12 끝 -->
  </div><!-- row 끝 -->
</div><!-- Second Container 끝 -->

<!-- Footer -->
<footer class="container-fluid bg-4 text-center">
  Copyright &copy; 2023 kyungEun MyWeb
</footer>

</body>
</html>