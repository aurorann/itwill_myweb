/**
myscript.js
 */

function bbsCheck(){
    //게시판 유효성 검사

    //1) 작성자 2글자 이상 입력
    let wname=document.getElementById("wname").value;  //작성자 가져오기
    wname=wname.trim();
    if(wname.length<2){
        alert("작성자명을 2글자 이상 입력하세요");
        document.getElementById("wname").focus();//작성자 칸에 커서 생성
        return false;//전송하지 않음
    }//if end

    //2) 제목 2글자 이상 입력
    let subject=document.getElementById("subject").value;  //작성자 가져오기
    subject=subject.trim();
    if(subject.length<2){
        alert("제목을 2글자 이상 입력하세요");
        document.getElementById("subject").focus();//작성자 칸에 커서 생성
        return false;//전송하지 않음
    }//if end

    //3) 내용 2글자 이상 입력
    let content=document.getElementById("content").value;  //작성자 가져오기
    content=content.trim();
    if(content.length<2){
        alert("내용을 2글자 이상 입력하세요");
        document.getElementById("content").focus();//작성자 칸에 커서 생성
        return false;//전송하지 않음
    }//if end

    //4) 비밀번호는 4글자 이상, 숫자형 기호만 입력
    let passwd=document.getElementById("passwd").value;  //작성자 가져오기
    passwd=passwd.trim();
    if(passwd.length<4 || isNaN(passwd)){
        alert("비밀번호를 4글자 이상 입력하세요");
        document.getElementById("passwd").focus();//작성자 칸에 커서 생성
        return false;//전송하지 않음
    }//if end


    return true;//onsubmit이벤트에서 서버로 전송

}//bbsCheck() end


function pwCheck(){	
    let passwd=document.getElementById("passwd").value;  //작성자 가져오기
    passwd=passwd.trim();
    if(passwd.length<4 || isNaN(passwd)){
        alert("비밀번호를 4글자 이상 입력하세요");
        document.getElementById("passwd").focus();//작성자 칸에 커서 생성
        return false;//전송하지 않음
    }//if end    
    
    let message="진행된 내용은 복구되지 않습니다\n계속 진행할까요?"
    if(confirm(message)){//확인(ture), 취소(false) 버튼 2개 생성
		return true;
	}else{
		return false;
	}//if end   
	
}//pwCheck() end


function searchCheck(){	
	//검색어를 입력해야만 서버로 전송
    let word=document.getElementById("word").value;  //작성자 가져오기
    word=word.trim();
    if(word.length==0){
        alert("검색어를 입력해 주세요");
        document.getElementById("word").focus();//작성자 칸에 커서 생성
        return false;//전송하지 않음
    }//if end    
    
    return true;
    
}//pwCheck() end


function loginCheck(){//로그인 유효성 검사(아이디, 비번)
	//1)아이디 5~10글자 이내인지 검사
	let id=document.getElementById("id").value;//아이디 가져오기
	id=id.trim();
	if(!(id.length>=5 && id.length<=10)){
		alert("아이디를 5~10글자 사이로 입력해주세요")
		document.getElementById("id").focus();
		return false;
	}//if end
	
	//2)비밀번호 5~10글자 이내인지 검사
	let passwd=document.getElementById("passwd").value;//비밀번호 가져오기
	passwd=passwd.trim();
	if(!(passwd.length>=5 && passwd.length<=10)){
		alert("비밀번호를 5~10글자 사이로 입력해주세요")
		document.getElementById("passwd").focus();
		return false;
	}//if end	
	
	return true;
	
}//loginCheck


function idCheck(){//회원가입 아이디 중복 확인. 유효성 검사

	//모달창(주소가 없다. 탭이 생성이 안된다)
	//->부모창과 자식창이 한몸으로 구성되어 있음
	//->참조 https://www.w3schools.com/bootstrap/bootstrap_modal.asp
	
	//새창만들기(주소가 있다. 탭이 생성되거나 새로운 주소로 넘어간다)
	//->부모창과 자식창이 별개로 구성되어 있음
	//->모바일에 기반을 둔 frontend단에서는 사용하지 말것!!
	//->참조 https://www.w3schools.com/jsref/met_win_open.asp
	window.open("idCheckForm.jsp", "idwin", "width=500, height=350");
	
}//idCheck() end


function emailCheck(){//회원가입 이메일 중복 확인. 유효성 검사

	window.open("emailCheckForm.jsp", "emwin", "width=600, height=350");
	
}//idCheck() end


function memberCheck(){//회원가입 유효성 검사
	//1)아이디 5~10글자 인지?
	let id=document.getElementById("id").value;
    id=id.trim();
    if(!(id.length>=5 && id.length<=10)){
        alert("ID를 5~10글자 사이로 입력하세요");
        document.getElementById("id").focus();
        return false;//전송하지 않음
    }//if end
    
    //2)비밀번호 5~10글자 인지?
    let passwd=document.getElementById("passwd").value;
	passwd=passwd.trim();
	if(!(passwd.length>=5 && passwd.length<=10)){
		alert("비밀번호를 5~10글자 사이로 입력해주세요");
		document.getElementById("passwd").focus();
		return false;
	}//if end	
	
    //3)비밀번호와 비밀번호확인이 서로 일치하는지?
    let repasswd=document.getElementById("repasswd").value;
	repasswd=repasswd.trim();
	if(!(repasswd==passwd)){
		alert("비밀번호를 다시 확인해주세요");
		document.getElementById("repasswd").focus();
		return false;
	}//if end	

    //4)이름 두글자 이상 인지?
    let mname=document.getElementById("mname").value;
    mname=mname.trim();
    if(mname.length<2){
        alert("이름을 2글자 이상 입력하세요");
        document.getElementById("mname").focus();
        return false;//전송하지 않음
    }//if end

    //5)이메일 5글자 인지?
    let email=document.getElementById("email").value;
	email=email.trim();
	if(email.length<5){
		alert("이메일을 다시 확인해 주세요")
		document.getElementById("email").focus();
		return false;
	}//if end	

    //6)직업을 선택했는지?
    let job=document.getElementById("job").value;
    job=job.trim();
    if(job()==""){
        alert("직업을 선택해 주세요");
        document.getElementById("job").focus();
        return false;//전송하지 않음
    }//if end
	
}//memberCheck() end


function findIDCheck(){
	
	 //이름 두글자 이상 인지?
    let mname=document.getElementById("mname").value;
    mname=mname.trim();
    if(mname.length<2){
        alert("이름을 2글자 이상 입력하세요");
        document.getElementById("mname").focus();
        return false;//전송하지 않음
    }//if end
    
    //이메일 5글자 인지?
    let email=document.getElementById("email").value;
	email=email.trim();
	if(email.length<5){
		alert("이메일을 다시 확인해 주세요")
		document.getElementById("email").focus();
		return false;
	}//if end	    
    
}//findIDCheck() end


function pdsCheck(){
    //포토갤러리 유효성 검사
    //1)이름
    let wname=document.getElementById("wname").value;  //작성자 가져오기
    wname=wname.trim();
    if(wname.length<2){
        alert("작성자명을 2글자 이상 입력하세요");
        document.getElementById("wname").focus();//작성자 칸에 커서 생성
        return false;//전송하지 않음
    }//if end

    //2)제목
    let subject=document.getElementById("subject").value;  //작성자 가져오기
    subject=subject.trim();
    if(subject.length<2){
        alert("제목을 2글자 이상 입력하세요");
        document.getElementById("subject").focus();//작성자 칸에 커서 생성
        return false;//전송하지 않음
    }//if end

    //3)비밀번호
    let passwd=document.getElementById("passwd").value;  //작성자 가져오기
    passwd=passwd.trim();
    if(passwd.length<4 || isNaN(passwd)){
        alert("비밀번호를 4글자 이상 입력하세요");
        document.getElementById("passwd").focus();//작성자 칸에 커서 생성
        return false;//전송하지 않음
    }//if end

    //4)첨부파일
    //->파일의 확장명이 이미지 파일(png, jpg, gif)인지 확인
    let filename=document.getElementById("filename").value;//예) sky.png
    filename=filename.trim();
    if(filename.length==0){
        alert("첨부 파일을 선택해주세요");
        return false;
    }else{
        let dot=filename.lastIndexOf(".");  //filename변수값에서 마지막 .의 순서값
        let ext=filename.substr(dot+1);     //확장명 : 마지막 . 이후 문자열 잘라내기
        ext=ext.toLowerCase();              //확장명을 전부 소문자 치환

        if(ext=="png" || ext=="jpg" || ext=="gif"){
            return true;
        }else{
            alert("이미지 파일만 업로드 가능합니다");
            return false;
        }//if end
    }//if end
    
	return true;
	
}//pdsCheck() end


function pwCheck2(){	
    let passwd=document.getElementById("passwd").value;  //작성자 가져오기
    passwd=passwd.trim();
    if(passwd.length<4 || isNaN(passwd)){
        alert("비밀번호를 4글자 이상 입력하세요");
        document.getElementById("passwd").focus();//작성자 칸에 커서 생성
        return false;//전송하지 않음
    }//if end    
    
    let message="진행된 내용은 복구되지 않습니다\n계속 진행할까요?"
    if(confirm(message)){//확인(ture), 취소(false) 버튼 2개 생성
		return true;
	}else{
		return false;
	}//if end   
	
}//pwCheck() end

















