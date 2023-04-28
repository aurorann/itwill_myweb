--bbs.sql
--답변형 및 댓글형 게시판

--테이블 삭제
drop table tb_bbs;

--테이블 생성
create table tb_bbs(
  bbsno    number(5)       not null -- 일련번호 -99999~99999
 ,wname    varchar2(20)    not null -- 작성자
 ,subject  varchar2(100)   not null -- 글제목
 ,content  varchar2(2000)  not null -- 글내용
 ,passwd   varchar2(10)    not null -- 글비밀번호
 ,readcnt  number(5)       default 0 not null -- 글조회수
 ,regdt    date            default  sysdate   -- 글작성일
 ,grpno    number(5)       not null  -- 글 그룹번호
 ,indent   number(5)       default 0 -- 들여쓰기
 ,ansnum   number(5)       default 0 -- 글순서
 ,ip       varchar2(15)    not null  -- 사용자 요청 PC의 IP
 ,primary key(bbsno)                 --bbsno 기본키 
);

--시퀀스 생성
create sequence bbs_seq;

--시퀀스 삭제
drop sequence bbs_seq;

--명령어 완료
commit;

--콘솔창 정리해서 출력하기
set linesize 1000;
col wname for a10;
col subject for a30;
col content for a20;
col passws for a10;
col ip for a20;

///////////////////////////////////////////////////////////////


--새글쓰기
bbsno : 시퀀스를 이용해서 일련번호 입력
wname, subject, content, passwd : 사용자가 입력
readcnt, regdt, indent, ansnum	: default 값
ip								: 요청 PC의 IP 저장
grpno							: max(bbsno) + 1


--그룹번호(group)만들기
select max(bbsno) from tb_bbs;
--null값이면 계산 안됨
select max(bbsno)+1 from tb_bbs;
--nvl()함수를 이용해서 max(bbsno)값이 비어있을때(null)0으로 바꿈
select nvl(max(bbsno),0) from tb_bbs;
--nvl()함수를 이용해서 max(bbsno)값이 비어있을때(null)0으로 바꾼 후 +1
select nvl(max(bbsno),0)+1 from tb_bbs;


--행추가
insert into tb_bbs(bbsno, wname, subject, content, passwd, ip, grpno)
values(bbs_seq.nextval, ?, ?, ?, ?, ?, (select nvl(max(bbsno),0)+1 from tb_bbs));

--전체목록 조회하기
select bbsno, wname, subject, readcnt, regdt, indent
from tb_bbs
order by grpno desc, ansnum asc;

--전체목록 행 갯수 조회
select bbsno from tb_bbs;

--상세보기
select * from tb_bbs where bbsno=?;

--조회수 증가
update tb_bbs 
set readcnt=readcnt+1
where bbsno=?


--행 삭제
delete from tb_bbs 
where bbsno=? and passwd=?


--행 수정
update tb_bbs set wname=?, subject=?, content=?, ip=?
where bbsno=? and passwd=?
/////////////////////////////////////////////////////////////////////////////////////


● 답변쓰기 알고리즘

글 쓰기 2가지 종류
- 새글 쓰기 : 부모글 
- 답변 쓰기 : 자식글

답변쓰기에 필요한 칼럼
- 그룹번호(grpno) : 부모글 그룹번호와 동일하게
- 들여쓰기(indent) : 부모글 들여쓰기+1
- 글순서(ansnum) : 부모글 글순서+1 한 후, 글순서 재조정(최신글을 위로 올리기위해)

번호		제목 			그룹번호  들여쓰기	글순서
1		제주도		1		0		0
▶		애월읍		1		1		1
▶▶		제주공항		2		2		2
▶		서귀포		1		1		3
2		서울시		2		0		0
▶		마포구		2		1		1
▶▶		이대			2		2		2
▶▶		신촌			2		2		3
▶		강남구		2		1		4
▶▶		역삼동		2		2		5
▶▶▶		삼원타워		2		3		6
▶		종로구		2		1		7
3		부산시		3		0		0


--글순서(ansnum) 업데이트
update tb_bbs set ansnum=ansnum+1
where grpno=? and ansnum >= 2;
/////////////////////////////////////////////////////////////////////////////////////

● [과제] 제목과 댓글(자식글)의 갯수를 조회하시오(indent칼럼 참조)
들여쓰기가 0이 아닌것들을 조회하면 되지 않을까...?

	제목
	--------------------------
	대한민국(3)
	서울(5)
	오필승코리아(0)
	무궁화 꽃이 피었습니다(2)
	
select count(*) from tb_bbs
where grpno=82 and indent!=0;


select subject, grpno, indent 
from tb_bbs 
order by grpno desc, indent asc;

select grpno, count(*)
from tb_bbs
group by grpno;

select grpno, count(*)-1
from tb_bbs
group by grpno;

select BB.subject, AA.reply
from(
		select grpno, count(*)-1 as reply
		from tb_bbs
		group by grpno
	)	AA join tb_bbs BB
on AA.grpno=BB.grpno
where BB.indent=0
order by BB.grpno desc;


select BB.subject, BB.indent, AA.grpno, AA.reply
from(
		select grpno, count(*)-1 as reply
		from tb_bbs
		group by grpno
	)	AA join tb_bbs BB
on AA.grpno=BB.grpno
where BB.indent=0
order by BB.grpno desc, BB.indent asc;


select AA.reply
from(
		select grpno, count(*)-1 as reply
		from tb_bbs
		group by grpno
	)	AA join tb_bbs BB
on AA.grpno=BB.grpno
where BB.indent=0 and BB.bbsno=21
order by BB.grpno desc, BB.indent asc;


select bbsno, wname, concat(subject, '(' || AA.reply || ')') as subject, readcnt, regdt, AA.reply
from(
		select grpno, count(*)-1 as reply
		from tb_bbs
		group by grpno
	)	AA join tb_bbs BB
on AA.grpno=BB.grpno
where BB.indent=0
order by BB.grpno desc;



/////////////////////////////////////////////////////////////////////////////////////


● [검색]

-- 제목+내용에서 '파스타'가 있는지 검색
where subject like '%파스타%' or content like '%파스타%'

-- 제목에서 '파스타'가 있는지 검색
where subject like '%파스타%'

-- 내용에서 '파스타'가 있는지 검색
where content like '%파스타%'

-- 작성자에서 '파스타'가 있는지 검색
where wname like '%파스타%'

/////////////////////////////////////////////////////////////////////////////////////

● [페이징]

- rownum 줄번호 활용

1)
select bbsno, subject, wname, readcnt, indent, regdt
from tb_bbs
order by grpno desc, ansnum asc;


2) rownum추가 - 줄번호까지 정렬됨
select bbsno, subject, wname, readcnt, indent, regdt, rownum
from tb_bbs
order by grpno desc, ansnum asc;


3) 1의  SQL문을 셀프조인하고, rownum 추가
select bbsno, subject, wname, readcnt, indent, regdt, rownum
from (
		select bbsno, subject, wname, readcnt, indent, regdt
		from tb_bbs
		order by grpno desc, ansnum asc
 );
 
 
4) 줄번호 1~5조회(1페이지)
select bbsno, subject, wname, readcnt, indent, regdt, rownum
from (
		select bbsno, subject, wname, readcnt, indent, regdt
		from tb_bbs
		order by grpno desc, ansnum asc
 )
 where rownum>=1 and rownum<=5;


5) 줄번호 6~10조회(2페이지)
select bbsno, subject, wname, readcnt, indent, regdt, rownum
from (
		select bbsno, subject, wname, readcnt, indent, regdt
		from tb_bbs
		order by grpno desc, ansnum asc
 )
 where rownum>=6 and rownum<=10;


6) 줄번호가 있는 3)의 테이블을 한번 더 셀프조인하고, rownum칼럼명을 r로 바꾼다. 컬럼명이 모두 보여져있을때에는 select *을 사용해도 된다
select *
from (
		select bbsno, subject, wname, readcnt, indent, regdt, rownum as r 
		from (
				select bbsno, subject, wname, readcnt, indent, regdt
				from tb_bbs
				order by grpno desc, ansnum asc
		 )
 )
 where r>=6 and r<=10;


7) 페이징+검색
	예) 제목에서 '파스타'가 있는 행을 검색해서 2페이지(6~10행)를 조회하시오
select *
from (
		select bbsno, subject, wname, readcnt, indent, regdt, rownum as r 
		from (
				select bbsno, subject, wname, readcnt, indent, regdt
				from tb_bbs
				where subject like '%배%'
				order by grpno desc, ansnum asc
		 )
 )
 where r>=6 and r<=10;












