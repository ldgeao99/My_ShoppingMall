package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CartDao {
	private Connection conn = null;

	private static CartDao instance;

	public static CartDao getInstance() {
		if (instance == null) {
			instance = new CartDao();
		}
		return instance;
	}

	private CartDao(){
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
	
	public ArrayList<CartBean> getAllItem(int mno){
		
		ArrayList<CartBean> ctlist = new ArrayList<CartBean>(); 
		
		PreparedStatement ps = null;
		ResultSet rs = null;

		/* 재고 수량 처리하는 부분 */
		try {
			// 3. SQL 작상 및 분석
			String sql = "select ct.no, pro.name, ct.opname, pro.discprice, ct.qty, pro.mainimgn\r\n"
					+ "from product pro inner join cart ct\r\n"
					+ "on pro.no = ct.pno\r\n"
					+ "where mno=?";
			ps = conn.prepareStatement(sql);

			ps.setInt(1, mno);

			// 4. SQL문 실행
			rs = ps.executeQuery();
			
			while(rs.next()) {
				CartBean ctbean = new CartBean();
				
				ctbean.setNo(rs.getInt("no"));
				ctbean.setPname(rs.getString("name"));
				ctbean.setOneprice(rs.getInt("discprice"));
				ctbean.setOpname(rs.getString("opname"));
				ctbean.setQty(rs.getInt("qty"));
				ctbean.setMainimgn(rs.getString("mainimgn"));
				
				ctlist.add(ctbean);
			}

		} catch (

		SQLException e) {
			System.out.println(e);
			System.out.println("getAllItem() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return ctlist;
	}
	
	public CartBean getItem(int no){
		
		CartBean ctbean = null; 
		
		PreparedStatement ps = null;
		ResultSet rs = null;

		/* 재고 수량 처리하는 부분 */
		try {
			// 3. SQL 작상 및 분석
			String sql = "select ct.no, pro.name, ct.opname, ct.pno, pro.discprice, ct.qty, pro.mainimgn\r\n"
					+ "from product pro inner join cart ct\r\n"
					+ "on pro.no = ct.pno where ct.no=?";
			ps = conn.prepareStatement(sql);

			ps.setInt(1, no);

			// 4. SQL문 실행
			rs = ps.executeQuery();
			
			if(rs.next()) {
				ctbean = new CartBean();

				ctbean.setNo(rs.getInt("no"));
				ctbean.setPname(rs.getString("name"));
				ctbean.setPno(rs.getInt("pno"));
				ctbean.setOneprice(rs.getInt("discprice"));
				ctbean.setOpname(rs.getString("opname"));
				ctbean.setQty(rs.getInt("qty"));
				ctbean.setMainimgn(rs.getString("mainimgn"));
			}

		} catch (

		SQLException e) {
			System.out.println(e);
			System.out.println("getItem() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return ctbean;
	}
	
	public int insertItem(int mno, int pno, int qty, String opname) {
		
		int cnt = -1;

		PreparedStatement ps = null;

		/* 재고 수량 처리하는 부분 */
		try {
			// 3. SQL 작상 및 분석
			String sql = "insert into cart values(cartseq.nextval,?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);

			ps.setInt(1, mno);
			ps.setInt(2, pno);
			ps.setString(3, opname);
			ps.setInt(4, qty);

			// 4. SQL문 실행
			cnt = ps.executeUpdate();

		} catch (

		SQLException e) {
			System.out.println(e);
			System.out.println("insertItem() SQL문 실행중 오류 발생");
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
	
	public int countItemInCart(int mno) { // 해당 사용자가 장바구니에 담고있는 상품의 행 개수 
		
		int result = -1;

		PreparedStatement ps = null;
		ResultSet rs = null;
		
		/* 재고 수량 처리하는 부분 */
		try {
			// 3. SQL 작상 및 분석
			String sql = "select count(*) from cart where mno=" + mno;
			ps = conn.prepareStatement(sql);

			// 4. SQL문 실행
			rs = ps.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}

		} catch (

		SQLException e) {
			System.out.println(e);
			System.out.println("countItemInCart() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return result;
	}
	
	public int deleteItem(int itemno) {
		
		int cnt = -1;

		PreparedStatement ps = null;

		/* 재고 수량 처리하는 부분 */
		try {
			// 3. SQL 작상 및 분석
			String sql = "delete from cart where no=" + itemno;
			ps = conn.prepareStatement(sql);

			// 4. SQL문 실행
			cnt = ps.executeUpdate();

		} catch (

		SQLException e) {
			System.out.println(e);
			System.out.println("deleteItem() SQL문 실행중 오류 발생");
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
	
	public int updateItem(int no, int qty){
		int cnt = -1;

		PreparedStatement ps = null;

		/* 재고 수량 처리하는 부분 */
		try {
			// 3. SQL 작상 및 분석
			String sql = "update cart set qty = ? where no=?";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, qty);
			ps.setInt(2, no);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();

		} catch (

		SQLException e) {
			System.out.println(e);
			System.out.println("updateItem() SQL문 실행중 오류 발생");
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
	
	public int getMaxCtno(int mno) {
		int maxCtno = -1;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		/* 재고 수량 처리하는 부분 */
		try {
			// 3. SQL 작상 및 분석
			String sql = "select max(no) from cart where mno=?";
			ps = conn.prepareStatement(sql);

			ps.setInt(1, mno);

			// 4. SQL문 실행
			rs = ps.executeQuery();
			
			if(rs.next()) {
				maxCtno = rs.getInt(1);
			}

		} catch (

		SQLException e) {
			System.out.println(e);
			System.out.println("getAllItem() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return maxCtno;
	}
}
