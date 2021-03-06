package USER;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDAO {

		private Connection conn;
		private PreparedStatement pstmt;
		private ResultSet rs;
		
		public UserDAO() {
			
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}
			catch(Exception e) {
		}
	}	
	// 로그인 메소드
	public int login( String logID , String logPassword ) {	// 로그인 메소드 // 로그인창에서 입력값 
		
		String SQL = "SELECT userPassword FROM user where userID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(logPassword)) {
					return 1;	// 로그인 성공
				}
				else {
					return 0;	// 비밀번호 다를경우
				}
			}
			return -1; // 아이디 없음
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -2;	// db오류
	}

	//회원가입 메소드
	public int join(User user)  {
		String SQL = "insert into user values( ?, ?, ?, ?, ?)";
		
		try{
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, user.getUserID()); // userID : 키본키 [PK] : 중복값 필드
		pstmt.setString(2, user.getUserPassword());
		pstmt.setString(3, user.getUserName());
		pstmt.setString(4, user.getUserGender());
		pstmt.setString(5, user.getUserEmail());
		pstmt.executeUpdate();
		return 1; // 업데이트 싱행 성공 // 회원가입 성공
		}
	catch (Exception e) {
		// TODO: handle exception
	}
	return -1; // db오류 // 중복 데이터
	}
	
	
	// 회원정보 출력 메소드
	public User userInfo(String userID) {
		
		String SQL = "SELECT * from user where userID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				return user;
			}
		}catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	// 회원정보 삭제 메소드
	public int deleteUser( String userID) {
		
		String SQL = "DELETE FROM user where userID = ?";
		
		try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, userID);
		pstmt.executeUpdate();
		
		return 1;
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		return -1;
	}

	// 회원정보 수정 메소드
	public int update( String userName, String userGender, String userEmail ,String userID) {
		
		String SQL = "UPDATE user SET userName=? , userGender=? , userEmail=? where userID =?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			
			pstmt.setString(1, userName);
			pstmt.setString(2, userGender);
			pstmt.setString(3, userEmail);
			pstmt.setString(4, userID);
			pstmt.executeUpdate();
			return 1;
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		return -1;
		
	}


}