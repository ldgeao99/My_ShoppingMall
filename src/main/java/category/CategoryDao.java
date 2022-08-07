package category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CategoryDao {
	
	private Connection conn = null;
	
	private static CategoryDao instance;
	public static CategoryDao getInstance() {
		if(instance == null) {
			instance = new CategoryDao();
		}
		return instance;
	}
	
	private CategoryDao(){
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
	
	public ArrayList<CategoryBean> getAllCategory(){
		
		ArrayList<CategoryBean> list = new ArrayList<CategoryBean>();
		
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// 3. SQL 작상 및 분석
			String sql = "select lcate.no as lno, lcate.name as lname, lcate.step as lstep, scate.no as sno, scate.name as sname, scate.step as sstep\r\n"
					+ "from (select * from lcategory order by step asc) lcate left outer join (select * from scategory order by lcno asc, step asc) scate\r\n"
					+ "on lcate.no = scate.lcno\r\n"
					+ "order by lstep asc, sstep asc"; 
			ps = conn.prepareStatement(sql);
			
			// 4. SQL문 실행
			rs = ps.executeQuery();
			
			while(rs.next()) {
				CategoryBean cbean = new CategoryBean();
		
				cbean.setLno(rs.getInt("lno"));
				cbean.setLname(rs.getString("lname"));
				cbean.setLstep(rs.getInt("lstep"));
				cbean.setSno(rs.getInt("sno"));
				cbean.setSname(rs.getString("sname"));
				cbean.setSstep(rs.getInt("sstep"));
				
				list.add(cbean);
			}

		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("getAllCategory() 메소드 내 SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
				
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println(e);
				System.out.println("접속 종료 실패");
			}
		}
		return list;
	}//getAllCategory()
	
	public ArrayList<CategoryBean> getOnlyLargeCategory(){
		
		ArrayList<CategoryBean> list = new ArrayList<CategoryBean>();
		
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// 3. SQL 작상 및 분석
			String sql = "select * from lcategory order by step asc"; 
			ps = conn.prepareStatement(sql);
			
			// 4. SQL문 실행
			rs = ps.executeQuery();
			
			while(rs.next()) {
				CategoryBean cbean = new CategoryBean();
		
				cbean.setLno(rs.getInt("no"));
				cbean.setLname(rs.getString("name"));
				cbean.setLstep(rs.getInt("step"));
				
				list.add(cbean);
			}

		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("getAllCategory() 메소드 내 SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
				
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println(e);
				System.out.println("접속 종료 실패");
			}
		}
		return list;
	}//getOnlyLargeCategory()
	
	public ArrayList<CategoryBean> getOnlySmallCategory(int lno){
		
		ArrayList<CategoryBean> list = new ArrayList<CategoryBean>();
		
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// 3. SQL 작상 및 분석
			String sql = "select * from scategory where lcno=? order by lcno asc, step asc"; 
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, lno);
			
			// 4. SQL문 실행
			rs = ps.executeQuery();
			
			while(rs.next()) {
				CategoryBean cbean = new CategoryBean();
				
				cbean.setSno(rs.getInt("no"));
				cbean.setSname(rs.getString("name"));
				cbean.setSstep(rs.getInt("step"));
				cbean.setLno(rs.getInt("lcno"));
				
				list.add(cbean);
			}

		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("getAllCategory() 메소드 내 SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
				
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println(e);
				System.out.println("접속 종료 실패");
			}
		}
		return list;
	}//getOnlySmallCategory()
	
	
	
	public int countLcategory() { // lcategory 테이블의 모든 행의 개수 반환
		int cnt = -1;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			// 3. SQL 작상 및 분석
			String sql = "select count(*) as cnt from lcategory";
			ps = conn.prepareStatement(sql);

			// 4. SQL문 실행
			rs = ps.executeQuery();

			if(rs.next()) {
				cnt = rs.getInt("cnt");
			}
			
		} catch (SQLException e) {
			System.out.println("countLcategory() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}
	
	public int countScategory(int lno) { // scategory 테이블의 모든 행의 개수 반환
		int cnt = -1;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			// 3. SQL 작상 및 분석
			String sql = "select count(*) as cnt from scategory where lcno=" + lno;
			ps = conn.prepareStatement(sql);

			// 4. SQL문 실행
			rs = ps.executeQuery();

			if(rs.next()) {
				cnt = rs.getInt("cnt");
			}
			
		} catch (SQLException e) {
			System.out.println("countScategory() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}
	
	public int updateDownLStep(int lno, int lstep) { // 2  1
		int cnt = -1;
		
		PreparedStatement ps = null;

		try {
			// 3. SQL 작상 및 분석
			// 2) lno의 step보다 1 큰 아이의 step을 1 감소시킨다.
			String sql_1 = "update lcategory set step = step-1 where step = ? + 1";
			ps = conn.prepareStatement(sql_1);
			ps.setInt(1, lstep);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			ps.close();
			
			// 1) lno의 step을 1 증가시킨다.
			String sql_2 = "update lcategory set step = step+1 where no=?";
			ps = conn.prepareStatement(sql_2);
			ps.setInt(1, lno);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("updateDownLStep() SQL문 실행중 오류 발생");
		} finally {
			try {
				// 이렇게 null 비교를 해주고 모두 반환하면 더 완벽하다고 하심
				//if (conn != null)
				//	conn.close();

				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}
	
	public int updateUpLStep(int lno, int lstep) {
		int cnt = -1;
		
		PreparedStatement ps = null;

		try {
			// 3. SQL 작상 및 분석
			// 2) lno의 step보다 1 작은 아이의 step을 1 증가시킨다.
			String sql_1 = "update lcategory set step = step+1 where step = ? - 1";
			ps = conn.prepareStatement(sql_1);
			ps.setInt(1, lstep);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			ps.close();
			
			// 1) lno의 step을 1 감소시킨다.
			String sql_2 = "update lcategory set step = step-1 where no=?";
			ps = conn.prepareStatement(sql_2);
			ps.setInt(1, lno);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("updateUpLStep() SQL문 실행중 오류 발생");
		} finally {
			try {
				// 이렇게 null 비교를 해주고 모두 반환하면 더 완벽하다고 하심
				//if (conn != null)
				//	conn.close();

				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}
	
	public int updateDownSStep(int lno, int sno, int sstep) {
		int cnt = -1;
		
		PreparedStatement ps = null;

		try {
			// 3. SQL 작상 및 분석
			String sql_1 = "update scategory set step = step-1 where step = ? + 1 and lcno=?";
			ps = conn.prepareStatement(sql_1);
			ps.setInt(1, sstep);
			ps.setInt(2, lno);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			ps.close();
			
			String sql_2 = "update scategory set step = step+1 where no=?";
			ps = conn.prepareStatement(sql_2);
			ps.setInt(1, sno);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("updateDownLStep() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}
	
	public int updateUpSStep(int lno, int sno, int sstep) {
		
		int cnt = -1;
		
		PreparedStatement ps = null;

		try {
			// 3. SQL 작상 및 분석
			String sql_1 = "update scategory set step = step+1 where step = ? - 1 and lcno=?";
			ps = conn.prepareStatement(sql_1);
			ps.setInt(1, sstep);
			ps.setInt(2, lno);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			ps.close();
			
			String sql_2 = "update scategory set step = step-1 where no=?";
			ps = conn.prepareStatement(sql_2);
			ps.setInt(1, sno);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("updateDownLStep() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}
	
	public int insertLCategory(String lcname) {
		int cnt = -1;

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// 3. SQL 작상 및 분석
			String sql_1 = "select max(step) from lcategory";
			ps = conn.prepareStatement(sql_1);

			int maxStep = -1;

			// 4. SQL문 실행
			rs = ps.executeQuery();
			if (rs.next()) {
				maxStep = rs.getInt(1); // 레코드가 아무것도 존재하지 않으면 0이 반환됨
			}
			ps.close();

			String sql_2 = "insert into lcategory values(lcateseq.nextval, ?, ?)";
			ps = conn.prepareStatement(sql_2);
			ps.setString(1, lcname);
			ps.setInt(2, maxStep + 1);

			// 4. SQL문 실행
			cnt = ps.executeUpdate();

		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("insertSCategory() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}
	
	public int insertSCategory(int lno, String scname) {
		
		int cnt = -1;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			// 3. SQL 작상 및 분석
			String sql_1 = "select max(step) from scategory where lcno=" + lno;
			ps = conn.prepareStatement(sql_1);
			
			int maxStep = -1;
			
			// 4. SQL문 실행
			rs = ps.executeQuery();
			if(rs.next()) {
				maxStep = rs.getInt(1); // 레코드가 아무것도 존재하지 않으면 0이 반환됨
			}
			ps.close();
			
			String sql_2 = "insert into scategory values(scateseq.nextval, ?, ?, ?)";
			ps = conn.prepareStatement(sql_2);
			ps.setString(1, scname);
			ps.setInt(2, maxStep+1);
			ps.setInt(3, lno);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("insertSCategory() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;	
	}
	
	public int deleteSCategory(int sno, int sstep){
		
		int cnt = -1;
		
		PreparedStatement ps = null;
		
		try {
			
			// 3. SQL 작상 및 분석
			String sql_1 = "update scategory set step=step-1 where lcno=(select lcno from scategory where no=?) and step>?";
			ps = conn.prepareStatement(sql_1);
			ps.setInt(1, sno);
			ps.setInt(2, sstep);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			ps.close();
			
			// 3. SQL 작상 및 분석
			String sql_2 = "delete from scategory where no=" + sno;
			ps = conn.prepareStatement(sql_2);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			ps.close();
			
			

		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("deleteSCategory() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}
	
	
	public int deleteLCategory(int lno, int lstep){
		
		int cnt = -1;
		
		PreparedStatement ps = null;
		
		try {
			
			// 3. SQL 작상 및 분석
			String sql_1 = "update lcategory set step=step-1 where step>?";
			ps = conn.prepareStatement(sql_1);
			ps.setInt(1, lstep);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			ps.close();
			
			// 3. SQL 작상 및 분석
			String sql_2 = "delete from lcategory where no=" + lno;
			ps = conn.prepareStatement(sql_2);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			ps.close();
			
		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("deleteLCategory() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}
	
	public int updateLCategoryName(int lno, String lcname) {
		
		int cnt = -1;
		
		PreparedStatement ps = null;
		
		try {
			
			// 3. SQL 작상 및 분석
			String sql = "update lcategory set name=? where no=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, lcname);
			ps.setInt(2, lno);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("updateLCategoryName() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}
	
	public int updateSCategoryName(int sno, String scname) {
		
		int cnt = -1;

		PreparedStatement ps = null;

		try {

			// 3. SQL 작상 및 분석
			String sql = "update scategory set name=? where no=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, scname);
			ps.setInt(2, sno);

			// 4. SQL문 실행
			cnt = ps.executeUpdate();

		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("updateLCategoryName() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}
}

