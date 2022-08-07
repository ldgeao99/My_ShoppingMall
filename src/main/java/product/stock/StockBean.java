package product.stock;

public class StockBean {
	
	private int no;
	private int pno;
	private String opname;
	private int count;
	
	public int getNo() {
		return no;
	}
	public void setNo(int number) {
		this.no = number;
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public String getOpname() {
		return opname;
	}
	public void setOpname(String opname) {
		this.opname = opname;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
}
