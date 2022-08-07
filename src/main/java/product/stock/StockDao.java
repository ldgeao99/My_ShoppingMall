package product.stock;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.commons.collections.bag.SynchronizedSortedBag;

import com.oreilly.servlet.MultipartRequest;

public class StockDao {
	private Connection conn = null;

	private static StockDao instance;

	public static StockDao getInstance() {
		if (instance == null) {
			instance = new StockDao();
		}
		return instance;
	}

	private StockDao(){
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
	
	public ArrayList<StockBean> getAllStockByPno(int pno){
		
		int cnt = -1;
		ArrayList<StockBean> list = new ArrayList<StockBean>();
				
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			// 3. SQL 작상 및 분석
			String sql = "select * from stock where pno=? order by no";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, pno);

			// 4. SQL문 실행
			rs = ps.executeQuery();
			
			while(rs.next()) {
				StockBean sbean = new StockBean();
				sbean.setNo(rs.getInt("no"));
				sbean.setPno(rs.getInt("pno"));
				sbean.setOpname(rs.getString("opname"));
				sbean.setCount(rs.getInt("count"));
				
				list.add(sbean);
			}

			
		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("getAllStockByPno() SQL문 실행중 오류 발생");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return list;
	}

	public int insertStock(MultipartRequest multi) {

		int cnt = -1;

		PreparedStatement ps = null;

		
		/* 재고 수량 처리하는 부분 */
		try {
			String preParseStr = multi.getParameter("opnums");
			//System.out.println("preParseStr:" + preParseStr);
			
			String[] strArr = preParseStr.split(",");
			for(String s : strArr){
				//System.out.println(s + " abc");
				String opname = multi.getParameter("opn_" + s); // 실제로 값을 얻는 부분
				int count = Integer.parseInt(multi.getParameter("stock_" + s));
				System.out.println(opname + " " + count);
				
				// 3. SQL 작상 및 분석
				String sql = "insert into stock values(stockseq.nextval,(select last_number-1 from user_sequences where sequence_name = 'PRODSEQ'),?,?)";
				ps = conn.prepareStatement(sql);
				
				ps.setString(1, opname);
				ps.setInt(2, count);
				
				// 4. SQL문 실행
				cnt = ps.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("insertStock() SQL문 실행중 오류 발생");
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
	
	
	public int insertStockForUpdate(MultipartRequest multi) {
		
		int cnt = -1;

		PreparedStatement ps = null;

		
		/* 재고 수량 처리하는 부분 */
		try {
			String preParseStr = multi.getParameter("opnums");
			//System.out.println("preParseStr:" + preParseStr);
			
			String[] strArr = preParseStr.split(",");
			for(String s : strArr){
				//System.out.println(s + " abc");
				String opname = multi.getParameter("opn_" + s); // 실제로 값을 얻는 부분
				int count = Integer.parseInt(multi.getParameter("stock_" + s));
				//System.out.println(opname + " " + count);
				
				// 3. SQL 작상 및 분석
				String sql = "insert into stock values(stockseq.nextval,?,?,?)";
				ps = conn.prepareStatement(sql);
				
				ps.setInt(1, Integer.parseInt(multi.getParameter("pno")));
				ps.setString(2, opname);
				ps.setInt(3, count);
				
				// 4. SQL문 실행
				cnt = ps.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("insertStock() SQL문 실행중 오류 발생");
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
	
	
	public int deleteAllStock(int pno) {
		
		int cnt = -1;

		PreparedStatement ps = null;

		try {
			// 3. SQL 작상 및 분석
			String sql = "delete from stock where pno=" + pno;
			ps = conn.prepareStatement(sql);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("deleteStock() SQL문 실행중 오류 발생");
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
	
	public int updateByOrder(int pno, String opname, int qty) {
		
		int cnt = -1;

		PreparedStatement ps = null;

		try {
			// 3. SQL 작상 및 분석
			String sql = "update stock set count=count-? where pno=? and opname=?"; // stock에서 재고도 qty로 했으면 더 깔끔했을 듯?
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, qty);
			ps.setInt(2, pno);
			ps.setString(3, opname);
			
			// 4. SQL문 실행
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println(e);
			System.out.println("updateByOrder() SQL문 실행중 오류 발생");
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
