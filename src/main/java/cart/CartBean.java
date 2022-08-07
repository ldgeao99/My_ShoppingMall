package cart;

public class CartBean {
	
	int no;		   	// 시리얼넘버
	String pname;  	// 상품명
	int pno;
	String opname; 	// 옵션명
	int qty;	   	// 수량
	int oneprice;	// 단가
	String mainimgn; // 메인상품 이미지 파일명
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
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
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getOneprice() {
		return oneprice;
	}
	public void setOneprice(int oneprice) {
		this.oneprice = oneprice;
	}
	public String getMainimgn() {
		return mainimgn;
	}
	public void setMainimgn(String mainimgn) {
		this.mainimgn = mainimgn;
	}
}