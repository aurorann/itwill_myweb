package net.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.bbs.BbsDTO;
import net.utility.DBClose;
import net.utility.DBOpen;

public class NoticeDAO {
	
	private DBOpen dbopen=null;
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	private StringBuilder sql=null;
	
	public NoticeDAO() {
		dbopen=new DBOpen();
	}//end
	
	public int create(NoticeDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" INSERT INTO tb_notice(noticeno,subject,content) ");
			sql.append(" VALUES (noticeno_seq.nextval, ?, ?) ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());                                                                                                
			
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("글추가 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt);
		}//end
		return cnt;
	}//create() end
	
	public ArrayList<NoticeDTO> list() {
		//데이터베이스에서 가져온 데이터(rs)를 한꺼번에 모아서 (ArrayList)
		//noticeList.jsp에 전달한다
		ArrayList<NoticeDTO> list=null;
		
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" SELECT noticeno, subject, regdt ");
			sql.append(" FROM tb_notice ");
			sql.append(" ORDER BY noticeno DESC ");
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()){
				list=new ArrayList<>(); //전체 행을 저장
				do {
					//커서가 가리키는 한 줄 저장
					NoticeDTO dto=new NoticeDTO();
					dto.setNoticeno(rs.getInt("noticeno"));
					dto.setSubject(rs.getString("subject"));
					dto.setRegdt(rs.getString("regdt"));
					
					list.add(dto);//list 저장
					
				} while (rs.next());
			}else{ //else가 없어도 상관없다
				list=null;
			}//if end
			
		} catch (Exception e) {
			System.out.println("공지사항 목록 보기 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		return list;
	}//list() end
	
	
	public int count2(String col, String word) {
		
		int cnt=0;
		
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" SELECT count(*) as cnt FROM tb_notice ");
			
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
	
	
	public NoticeDTO read(int noticeno) {
		NoticeDTO dto=null;
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" SELECT noticeno, subject, content, regdt ");
			sql.append(" FROM tb_notice ");
			sql.append(" WHERE noticeno=?");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, noticeno);
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				dto=new NoticeDTO();
				dto.setNoticeno(rs.getInt("noticeno"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRegdt(rs.getString("regdt"));
			
			}//if end			
		} catch (Exception e) {
			System.out.println("공지사항 보기 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		return dto;
	}//read() end
	
	
	
	public int updateProc(NoticeDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" UPDATE tb_notice");
			sql.append(" SET subject=?, content=? ");
			sql.append(" WHERE noticeno=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNoticeno()); 
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("업데이트 실패 : "+e);
		} finally {
			DBClose.close(con, pstmt);
		}//end
		return cnt;	
		
	}//updateproc() end
	
	
	

}//class end
