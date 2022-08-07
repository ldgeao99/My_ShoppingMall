package orderlist;

public class OrderBean {
	
	private int no;
	private String id;
	private String name;		// 상품명
	private String mainimgn;		// 상품이미지 파일명
	private String opname;		// 옵션명
	private int qty;			// 주문수량
	private int price;
	private String time;      // 결제시간
	private String receiver;
	private String rv_hp1;
	private String rv_hp2;
	private String rv_hp3;
	private String rv_zip;
	private String rv_addr1;
	private String rv_addr2;
	private String memo;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMainimgn() {
		return mainimgn;
	}
	public void setMainimgn(String mainimgn) {
		this.mainimgn = mainimgn;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getRv_hp1() {
		return rv_hp1;
	}
	public void setRv_hp1(String rv_hp1) {
		this.rv_hp1 = rv_hp1;
	}
	public String getRv_hp2() {
		return rv_hp2;
	}
	public void setRv_hp2(String rv_hp2) {
		this.rv_hp2 = rv_hp2;
	}
	public String getRv_hp3() {
		return rv_hp3;
	}
	public void setRv_hp3(String rv_hp3) {
		this.rv_hp3 = rv_hp3;
	}
	public String getRv_zip() {
		return rv_zip;
	}
	public void setRv_zip(String rv_zip) {
		this.rv_zip = rv_zip;
	}
	public String getRv_addr1() {
		return rv_addr1;
	}
	public void setRv_addr1(String rv_addr1) {
		this.rv_addr1 = rv_addr1;
	}
	public String getRv_addr2() {
		return rv_addr2;
	}
	public void setRv_addr2(String rv_addr2) {
		this.rv_addr2 = rv_addr2;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
}
