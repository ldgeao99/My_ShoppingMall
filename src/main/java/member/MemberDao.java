package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDao {
	private Connection conn = null;

	private static MemberDao instance;

	public static MemberDao getInstance() {
		if (instance == null) {
			instance = new MemberDao();
		}
		return instance;
	}

	private MemberDao(){
		try {
			/* Context.xml을 살펴봐서 설정을 읽어본다 */
			Context initContext = new InitialContext();
			/* 내가 설정한 Context.xml 정보가 comp/env 이런 폴더안에 저장됨 */
			Context envContext = (Context) initContext.lookup("java:comp/env"); // java:comp/env 에 설정 정보가 저장되는건 내가 임의로 수정할 수 없음.
			/* 위 폴더가서 jbdc/OracleDb 이름으로 설정한 것을가져와라 */
			DataSource ds = (DataSource) envContext.lookup("jdbc/OracleDB");
			// 사용자가 사이트에 접속하면 컨넥션 객체를 얻음. 그리고 이 컨넥션 객체를 가지고 로그인을 하고 자시고 하는거임. 등등의 DB작업
			conn = ds.getConnection(); // 설정 정보를 가지고 계정에 접송해서 Connection 
			System.out.println("생성자에서 conn :" + conn);
		} catch (NamingException e) {
			System.out.println("CategoryDao 생성자에서 컨넥션 객체를 얻다가 오류 발생");
		} catch (SQLException e) {
			System.out.println("CategoryDao 생성자에서 컨넥션 객체를 얻다가 오류 발생");
		}
	}
	
	public int insertMember(MemberBean mbean) {
	
		int cnt = -1;
		
		PreparedStatement ps = null;
		
		try {
			// 3. SQL 작상 및 분석
			String sql = "insert into member values(memseq.nextval,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);

			ps.setString(1, mbean.getId());
			ps.setString(2, mbean.getPassword());
			ps.setString(3, mbean.getName());
			ps.setString(4, mbean.getRrn1());
			ps.setString(5, mbean.getRrn2());
			ps.setString(6, mbean.getHp1());
			ps.setString(7, mbean.getHp2());
			ps.setString(8, mbean.getHp3());
			ps.setString(9, mbean.getZip());
			ps.setString(10, mbean.getAddr1());
			ps.setString(11, mbean.getAddr2());

			// 4. SQL문 실행
			cnt = ps.executeUpdate();

		} catch (SQLException e) {
			System.out.println("insertMember() 실행중 에러");
			System.out.println(e);
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println(e);
			}
		}
		return cnt;
	}
	
	public MemberBean getMemberByInfo(String id, String password) {
		// 2.

		PreparedStatement ps = null;
		ResultSet rs = null;

		MemberBean mbean = null;

		try {
			// 3. SQL 작상 및 분석
			String sql = "select * from member where id=? and password=?";
			ps = conn.prepareStatement(sql);

			ps.setString(1, id);
			ps.setString(2, password);
			
			// 4. SQL문 실행
			rs = ps.executeQuery();
			
			if (rs.next()) {
				mbean = new MemberBean();
				
				mbean.setNo(rs.getInt("no"));
				mbean.setId(rs.getString("id"));
				mbean.setPassword(rs.getString("password"));
				mbean.setRrn1(rs.getString("rrn1"));
				mbean.setRrn2(rs.getString("rrn2"));
				mbean.setHp1(rs.getString("hp1"));
				mbean.setHp2(rs.getString("hp2"));
				mbean.setHp3(rs.getString("hp3"));
				mbean.setZip(rs.getString("zip"));
				mbean.setAddr1(rs.getString("addr1"));
				mbean.setAddr2(rs.getString("addr2"));	
			}
		} catch (SQLException e) {
			System.out.println("getMemberByInfo() 실행중 에러");
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println(e);
			}
		}
		return mbean;
	}
	
	public MemberBean getMemberById(String id) {
		
		PreparedStatement ps = null;
		ResultSet rs = null;

		MemberBean mbean = null;

		try {
			// 3. SQL 작상 및 분석
			String sql = "select * from member where id=?";
			ps = conn.prepareStatement(sql);

			ps.setString(1, id);
			
			// 4. SQL문 실행
			rs = ps.executeQuery();

			if (rs.next()) {
				mbean = new MemberBean();
				
				mbean.setNo(rs.getInt("no"));
				mbean.setId(rs.getString("id"));
				mbean.setPassword(rs.getString("password"));
				mbean.setName(rs.getString("name"));
				mbean.setRrn1(rs.getString("rrn1"));
				mbean.setRrn2(rs.getString("rrn2"));
				mbean.setHp1(rs.getString("hp1"));
				mbean.setHp2(rs.getString("hp2"));
				mbean.setHp3(rs.getString("hp3"));
				mbean.setZip(rs.getString("zip"));
				mbean.setAddr1(rs.getString("addr1"));
				mbean.setAddr2(rs.getString("addr2"));
			}
		} catch (SQLException e) {
			System.out.println("getMemberById() 실행중 에러");
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println(e);
			}
		}
		return mbean;
	}
}
