package net.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import java.util.random.*;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import net.bbs.BbsDTO;
import net.utility.DBClose;
import net.utility.DBOpen;
import net.utility.MyAuthenticator;

public class MemberDAO { //Data Access Object
						//데이터베이스 비지니스 로직 구현. DB 접근 객체
	
	private DBOpen dbopen=null;
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	private StringBuilder sql=null;
	
	public MemberDAO() {
		dbopen=new DBOpen();
	}//end
	
	public String loginProc(MemberDTO dto) {
		String mlevel=null;
		
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" SELECT mlevel ");		
			sql.append(" FROM member ");		
			sql.append(" WHERE id=? AND passwd=? ");		
			sql.append(" AND mlevel IN ('A1', 'B1', 'C1', 'D1') ");		
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				mlevel=rs.getString("mlevel");
			}//if end			
			
		} catch (Exception e) {
			System.out.println("로그인 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}//end		
		return mlevel;		
	}//loginProc() end
	
	
	public int duplecateID(String id) {
		int cnt=0;
		
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" SELECT count(id) as count ");		
			sql.append(" FROM member ");		
			sql.append(" WHERE id=? ");		
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				cnt=rs.getInt("count");
			}//if end			
			
		} catch (Exception e) {
			System.out.println("로그인 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}//end		
		return cnt;		
	}//
	
	
	public int memcreate(MemberDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" INSERT INTO member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate) ");
			sql.append(" VALUES (?,?,?,?,?,?,?,?,?,'D1', sysdate) ");
		
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getMname());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getEmail());                                                                                                    
			pstmt.setString(6, dto.getZipcode());                                                                                                    
			pstmt.setString(7, dto.getAddress1());                                                                                                    
			pstmt.setString(8, dto.getAddress2());                                                                                                    
			pstmt.setString(9, dto.getJob());                                                                                                    
			
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("회원가입 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt);
		}//end
		return cnt;
	}//memcreate() end
	
	
	//강사님 코드
	public boolean findID(MemberDTO dto) {
		boolean flag=false;
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" SELECT id ");		
			sql.append(" FROM member ");		
			sql.append(" WHERE mname=? and email=? ");	
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getMname());
			pstmt.setString(2, dto.getEmail());
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				//1) 아이디 가져오기
				String id=rs.getString("id");
				
				//[임시 비밀번호 발급]
				//대문자, 소문자, 숫자를 이용해서 랜덤하게 10글자 만들기
				String[] ch = {
						"0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
						"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
						"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
						"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
						"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
				};//ch[0]~ch[61]
				
				//ch배열에 랜덤하게 10글자 뽑아서 가져오기
				//2) 임시비밀번호 만들기
				StringBuilder imsiPW=new StringBuilder();
				for(int i=0; i<10; i++) {
					int num=(int)(Math.random()*ch.length);
					imsiPW.append(ch[num]);
				}//for end
				
				//임시비밀번호를 테이블에 수정 및 저장하기
				sql=new StringBuilder();//sql을 다시 사용하기 위해 새로이 메모리 할당
				sql.append(" UPDATE member");
				sql.append(" SET passwd=? ");
				sql.append(" WHERE mname=? AND email=?");
				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setString(1, imsiPW.toString());//임시비밀번호			
				pstmt.setString(2, dto.getMname());
				pstmt.setString(3, dto.getEmail());
				
				int cnt=pstmt.executeUpdate();
				if(cnt==1) {//임시 비밀번호로 member 테이블에 수정되었다면
				//3) 아이디(id)와 임시비밀번호(imsiPW)를 메일로 보내기
					String content ="임시 비밀번호로 로그인 후, 회원 정보 수정에서 비밀번호를 변경하시길 바랍니다.";			
					content += "<br>";
					content += "고객님의 아이디는 <strong>"+id+"</strong> 이며";
					content += "<br>";
					content += "임시비밀번호는 <strong>"+imsiPW.toString()+"</strong>입니다.";	
					
					//메일서버(POP3/SMTP) 지정하기
					String mailServer="mw-002.cafe24.com"; //cafe24 메일서버
					Properties props=new Properties();
					props.put("mail.smtp.host",mailServer);
					props.put("mail.smtp.auth", true);
					
					//메일서버에서 인증받은 계정+비번
					Authenticator myAuth=new MyAuthenticator();//다형성
					//메일 서버와 계정+비번 유효한지 검증
					Session sess=Session.getInstance(props, myAuth);					
					
					InternetAddress[] address = {new InternetAddress(dto.getEmail())};//받는 사람 이메일 주소
					Message msg = new MimeMessage(sess);						//메일 관련 정보 작성
					msg.setRecipients(Message.RecipientType.TO, address);		//받는 사람
					msg.setFrom(new InternetAddress("aurorannn@gmail.com"));	//보내는 사람
					msg.setSubject("Myweb 임시비밀번호 발급");						//메일 제목
					msg.setContent(content, "text/html; charset=UTF-8");		//메일 내용
					msg.setSentDate(new Date());								//메일 보낸 날짜
					Transport.send(msg);										//메일 전송
					
					flag=true;//최종적으로 성공
					
				}//if end			
				
			}else{
				flag=false;//else는 안써도 상관없다
			}//if end			
			
		} catch (Exception e) {
			System.out.println("아이디찾기 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt);
		}//end
		return flag;
	}//findID() end
	
	
	
	

	/*경은 코드
	public String findID(MemberDTO dto) {
		String id="";
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" SELECT id ");		
			sql.append(" FROM member ");		
			sql.append(" WHERE mname=? and email=? ");	
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getMname());
			pstmt.setString(2, dto.getEmail());
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				id=rs.getString("id");
			}//if end			
			
		} catch (Exception e) {
			System.out.println("아이디찾기 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt);
		}//end
		return id;
	}//findID() end
	*/
	
	public static String tempPassword(int leng){
		int index = 0;
		char[] charSet = new char[] {
				'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
				'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
				'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
		};	//배열안의 문자 숫자는 원하는대로

		StringBuffer password = new StringBuffer();
		Random random = new Random();

		for (int i = 0; i < leng ; i++) {
			double rd = random.nextDouble();
			index = (int) (charSet.length * rd);
			
			password.append(charSet[index]);
			
			//System.out.println("index::" + index + "	charSet::"+ charSet[index]);
		}
		
		return password.toString(); 
	    //StringBuffer를 String으로 변환해서 return 하려면 toString()을 사용하면 된다.
	}//tempPassword() end

	
	public int passupdateProc(MemberDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" UPDATE member");
			sql.append(" SET passwd=? ");
			sql.append(" WHERE mname=? AND email=?");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getPasswd());			
			pstmt.setString(2, dto.getMname());
			pstmt.setString(3, dto.getEmail());
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("업데이트 실패 : "+e);
		} finally {
			DBClose.close(con, pstmt);
		}//end
		return cnt;	
		
	}
	
	public MemberDTO read(String id) {
		MemberDTO dto=null;
		
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" SELECT id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate ");		
			sql.append(" FROM member ");		
			sql.append(" WHERE id=? ");		
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				dto=new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setMname(rs.getString("mname"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setJob(rs.getString("job"));
				dto.setMlevel(rs.getString("mlevel"));
				dto.setMdate(rs.getString("mdate"));
				
			}//if end			
			
		} catch (Exception e) {
			System.out.println("회원정보보기 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}//end		
		return dto;	
	}//read() end
	
	
	
	
	public int memupdate(MemberDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();//오라클 데이터베이스 연결
			
			sql=new StringBuilder();
			sql.append(" UPDATE member ");
			sql.append(" SET passwd=?, mname=?, tel=?, email=?, zipcode=?, address1=?, address2=?, job=? ");
			sql.append(" WHERE id=? ");

		
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getPasswd());
			pstmt.setString(2, dto.getMname());
			pstmt.setString(3, dto.getTel());
			pstmt.setString(4, dto.getEmail());                                                                                                    
			pstmt.setString(5, dto.getZipcode());                                                                                                    
			pstmt.setString(6, dto.getAddress1());                                                                                                    
			pstmt.setString(7, dto.getAddress2());                                                                                                    
			pstmt.setString(8, dto.getJob());    
			pstmt.setString(9, dto.getId());

			
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("회원정보 수정 실패 : "+e);
		}finally {
			DBClose.close(con, pstmt);
		}//end
		return cnt;
	}//memcreate() end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}//class end
