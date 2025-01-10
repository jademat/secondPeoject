package com.hhlb.model;

public class CartDTO {

	private int cart_no;
	private int product_no;
	private int category_no;
	private String user_id;
	private int cart_deliveryfee;
	
	
	public int getCart_no() {
		return cart_no;
	}
	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}
	
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	
	public int getCategory_no() {
		return category_no;
	}
	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getCart_deliveryfee() {
		return cart_deliveryfee;
	}
	public void setCart_deliveryfee(int cart_deliveryfee) {
		this.cart_deliveryfee = cart_deliveryfee;
	}
	
}
