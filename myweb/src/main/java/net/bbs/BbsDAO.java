package net.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import net.utility.DBClose;
import net.utility.DBOpen;

public class BbsDAO {//Data Access Object 데이터베이스 관련 작업
	
	private DBOpen dbopen=null;
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	private StringBuilder sql=null;
	
	public BbsDAO() {
		dbopen=new DBOpen();
	}//end
	
	public int create(BbsDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" INSERT INTO tb_bbs(bbsno, wname, subject, content, passwd, ip, grpno)");
			sql.append(" VALUES (bbs_seq.nextval, ?, ?, ?, ?, ?, (select nvl(max(bbsno),0)+1 from tb_bbs))");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());                                                                                                    
			
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("행추가 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt);
		}//end
		return cnt;
	}//create() end	
	
	
	public ArrayList<BbsDTO> list() {
		//데이터베이스에서 가져온 데이터(rs)를 한꺼번에 모아서 (ArrayList)
		//bbsList.jsp에 전달한다
		ArrayList<BbsDTO> list=null;
		
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" SELECT bbsno, wname, subject, readcnt, regdt, indent ");
			sql.append(" FROM tb_bbs ");
			sql.append(" ORDER BY grpno DESC, ansnum ASC");
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()){
				list=new ArrayList<>(); //전체 행을 저장
				do {
					//커서가 가리키는 한 줄 저장
					BbsDTO dto=new BbsDTO();
					dto.setBbsno(rs.getInt("bbsno"));
					dto.setWname(rs.getString("wname"));
					dto.setSubject(rs.getString("subject"));
					dto.setReadcnt(rs.getInt("readcnt"));
					dto.setRegdt(rs.getString("regdt"));
					dto.setIndent(rs.getInt("indent"));
					
					list.add(dto);//list 저장
					
				} while (rs.next());
			}else{ //else가 없어도 상관없다
				list=null;
			}//if end
			
		} catch (Exception e) {
			System.out.println("전체목록 보기 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		return list;
	}//list() end
	
	
	public int count() {
		
		int cnt=0;
		
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" SELECT count(*) FROM tb_bbs");
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();

			if(rs.next()){
				cnt=rs.getInt("count(*)");
			}//if end
			
		} catch (Exception e) {
			System.out.println("글갯수 확인 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		return cnt;
	}//count() end
	
	
	public BbsDTO read(int bbsno) {
		BbsDTO dto=null;
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" SELECT bbsno, wname, subject, content, readcnt, regdt, ip, grpno, indent, ansnum ");
			sql.append(" FROM tb_bbs ");
			sql.append(" WHERE bbsno=?");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				dto=new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setWname(rs.getString("wname"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setRegdt(rs.getString("regdt"));
				dto.setIp(rs.getString("ip"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));					
			}//if end			
		} catch (Exception e) {
			System.out.println("게시글보기 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		return dto;
	}//read() end
	
	
	public void incrementCnt(int bbsno) {
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" UPDATE tb_bbs ");
			sql.append(" SET readcnt=readcnt+1 ");
			sql.append(" WHERE bbsno=?");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);			
			rs=pstmt.executeQuery();
		
		} catch (Exception e) {
			System.out.println("조회수 증가 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
	}//increment() end
	
	
	public int delete(BbsDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" DELETE FROM tb_bbs");
			sql.append(" WHERE bbsno=? AND passwd=?");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getBbsno());
			pstmt.setString(2, dto.getPasswd());
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시글 삭제 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		return cnt;
	}//delete() end
	
	
	public int updateProc(BbsDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" UPDATE tb_bbs");
			sql.append(" SET wname=?, subject=?, content=?, ip=? ");
			sql.append(" WHERE bbsno=? AND passwd=?");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getIp()); 
			pstmt.setInt(5, dto.getBbsno()); 
			pstmt.setString(6, dto.getPasswd());			
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("업데이트 실패 : "+e);
		} finally {
			DBClose.close(con, pstmt);
		}//end
		return cnt;	
		
	}
	
	
	public int reply(BbsDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();	
			sql=new StringBuilder();
			
			//1)부모글 정보 가져오기(select문)
			int grpno=0; //부모글 그룹번호
			int indent=0; //부모글 들여쓰기
			int ansnum=0; //부모글 글순서			
			sql.append(" SELECT grpno, indent, ansnum ");
			sql.append(" FROM tb_bbs ");
			sql.append(" WHERE bbsno=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getBbsno()); 
			rs=pstmt.executeQuery();
			if(rs.next()){
				//그룹번호 : 부모글 그룹번호 그대로 가져오기
				grpno=rs.getInt("grpno");
				//들여쓰기 : 부모글 들여쓰기 +1
				indent=rs.getInt("indent")+1;
				//글순서 : 부모글 글순서 +1
				ansnum=rs.getInt("ansnum")+1;				
			}//if end	
			
			//2)글순서 재조정하기(update문)
			sql.delete(0, sql.length()); //1단계에서 사용했던 sql값 지우기
			sql.append(" UPDATE tb_bbs ");
			sql.append(" SET ansnum=ansnum+1 ");
			sql.append(" WHERE grpno=? AND ansnum >= ? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno); //dto에서 가져오면 안됨. 현재 페이지에서 만든 변수를 넣어야한다.
			pstmt.setInt(2, ansnum); 
			rs=pstmt.executeQuery();

			
			//3)답변글 추가하기(insert문)
			sql.delete(0, sql.length()); //2단계에서 사용했던 sql값 지우기
			sql.append(" INSERT INTO tb_bbs(bbsno, wname, subject, content, passwd, ip, grpno, indent, ansnum) ");
			sql.append(" VALUES (bbs_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?) ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());
			pstmt.setInt(6, grpno);//1단계에서 만든 그룹번호
			pstmt.setInt(7, indent);//1단계에서 만든 들여번호
			pstmt.setInt(8, ansnum);//1단계에서 만든 글순서
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("답변추가 실패 : "+e);
		} finally {
			DBClose.close(con, pstmt);
		}//end
		return cnt;	
	} //reply() end
	
	
	public int count2(String col, String word) {
		
		int cnt=0;
		
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" SELECT count(*) as cnt FROM tb_bbs ");
			
			if(word.length()>=1) {//검색어가 존재한다면
				String search="";
				if(col.equals("subject_content")) {
					search += " WHERE subject LIKE '%" + word + "%'";
					search += " OR content LIKE '%" + word + "%'";
				}else if(col.equals("subject")){
					search += " WHERE subject LIKE '%" + word + "%'";
				}else if(col.equals("content")){
					search += " WHERE content LIKE '%" + word + "%'";
				}else if(col.equals("wname")){
					search += " WHERE wname LIKE '%" + word + "%'";
				}//if end
				sql.append(search);
			}//if end
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()){
				cnt=rs.getInt("cnt");
			}//if end
			
		} catch (Exception e) {
			System.out.println("글갯수 확인 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		return cnt;
	}//count() end
	
	
	public ArrayList<BbsDTO> list2(String col, String word) {
		ArrayList<BbsDTO> list=null;
		
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" SELECT bbsno, wname, subject, readcnt, regdt, indent ");
			sql.append(" FROM tb_bbs ");
			
			if(word.length()>=1) {//검색어가 존재한다면
				String search="";
				if(col.equals("subject_content")) {
					search += " WHERE subject LIKE '%" + word + "%'";
					search += " OR content LIKE '%" + word + "%'";
				}else if(col.equals("subject")){
					search += " WHERE subject LIKE '%" + word + "%'";
				}else if(col.equals("content")){
					search += " WHERE content LIKE '%" + word + "%'";
				}else if(col.equals("wname")){
					search += " WHERE wname LIKE '%" + word + "%'";
				}//if end
				sql.append(search);
			}//if end			
			
			sql.append(" ORDER BY grpno DESC, ansnum ASC");
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()){
				list=new ArrayList<>(); //전체 행을 저장
				do {
					//커서가 가리키는 한 줄 저장
					BbsDTO dto=new BbsDTO();
					dto.setBbsno(rs.getInt("bbsno"));
					dto.setWname(rs.getString("wname"));
					dto.setSubject(rs.getString("subject"));
					dto.setReadcnt(rs.getInt("readcnt"));
					dto.setRegdt(rs.getString("regdt"));
					dto.setIndent(rs.getInt("indent"));
					
					list.add(dto);//list 저장
					
				} while (rs.next());
			}else{ //else가 없어도 상관없다
				list=null;
			}//if end
			
		} catch (Exception e) {
			System.out.println("전체목록 보기 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		return list;
	}//list() end
	
	
	
	public ArrayList<BbsDTO> list3(String col, String word, int nowPage, int recordPerPage) {
		ArrayList<BbsDTO> list=null;
		
		//페이지당 출력할 행의 갯수(10개를 기준)
        //1 페이지 : WHERE r>=1  AND r<=10;
        //2 페이지 : WHERE r>=11 AND r<=20;
        //3 페이지 : WHERE r>=21 AND r<=30;
		int startRow = ((nowPage-1) * recordPerPage) + 1 ;
        int endRow   = nowPage * recordPerPage;
		
		try {
			con=dbopen.getConnection();			
			sql=new StringBuilder();
			
			word=word.trim();
			
			if(word.length()==0) {//검색어가 존재하지 않는 경우 -> bbs.sql의 페이징에서 6번 내용으로 쿼리문 작성

				sql.append(" SELECT * ");
				sql.append(" FROM ( ");
				sql.append(" 		SELECT bbsno, subject, wname, readcnt, indent, regdt, rownum as r ");
				sql.append(" 		FROM ( ");
				sql.append(" 				SELECT bbsno, subject, wname, readcnt, indent, regdt ");
				sql.append(" 				FROM tb_bbs ");
				sql.append(" 				ORDER BY grpno desc, ansnum asc ");
				sql.append(" 		) ");
				sql.append(" ) ");
				sql.append(" WHERE r>=" + startRow + " AND r<=" + endRow);

			}else {//검색어가 존재하는 경우 -> bbs.sql의 페이징에서 7번 내용으로 쿼리문 작성
				
				sql.append(" SELECT * ");
				sql.append(" FROM ( ");
				sql.append(" 		SELECT bbsno, subject, wname, readcnt, indent, regdt, rownum as r ");
				sql.append(" 		FROM ( ");
				sql.append(" 				SELECT bbsno, subject, wname, readcnt, indent, regdt ");
				sql.append(" 				FROM tb_bbs ");
				
				String search="";
				if(col.equals("subject_content")) {
					search += " WHERE subject LIKE '%" + word + "%'";
					search += " OR content LIKE '%" + word + "%'";
				}else if(col.equals("subject")){
					search += " WHERE subject LIKE '%" + word + "%'";
				}else if(col.equals("content")){
					search += " WHERE content LIKE '%" + word + "%'";
				}else if(col.equals("wname")){
					search += " WHERE wname LIKE '%" + word + "%'";
				}//if end
				sql.append(search);	
				
				sql.append(" 				ORDER BY grpno desc, ansnum asc ");
				sql.append(" 		) ");
				sql.append(" ) ");
				sql.append(" WHERE r>=" + startRow + " AND r<=" + endRow);
				
			}//if end
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()){
				list=new ArrayList<>(); //전체 행을 저장
				do {
					//커서가 가리키는 한 줄 저장
					BbsDTO dto=new BbsDTO();
					dto.setBbsno(rs.getInt("bbsno"));
					dto.setWname(rs.getString("wname"));
					dto.setSubject(rs.getString("subject"));
					dto.setReadcnt(rs.getInt("readcnt"));
					dto.setRegdt(rs.getString("regdt"));
					dto.setIndent(rs.getInt("indent"));
					
					list.add(dto);//list 저장
					
				} while (rs.next());
			}else{ //else가 없어도 상관없다
				list=null;
			}//if end
			
		} catch (Exception e) {
			System.out.println("전체목록 보기 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		return list;
	}//list() end
	
	
	public int replyCount(BbsDTO dto) {
		
		int cnt=0;
		
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" SELECT AA.reply ");
			sql.append(" FROM( ");
			sql.append(" 		SELECT grpno, count(*)-1 as reply ");
			sql.append(" 		FROM tb_bbs ");
			sql.append(" 		GROUP BY grpno ");
			sql.append(" 	)	AA JOIN tb_bbs BB ");
			sql.append(" ON AA.grpno=BB.grpno ");
			sql.append(" WHERE BB.indent=0 AND BB.bbsno=?");
			sql.append(" ORDER BY BB.grpno DESC, BB.indent ASC ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getBbsno()); 

			rs=pstmt.executeQuery();
			if(rs.next()){
				cnt=rs.getInt("reply");
			}//if end
			
		} catch (Exception e) {
			System.out.println("댓글갯수 확인 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		return cnt;
	}//count() end

	
	
	
	
	
	
	

}//class end
