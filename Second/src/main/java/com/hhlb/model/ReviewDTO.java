package com.hhlb.model;

public class ReviewDTO {

	private int review_no;
	private int user_no;
	private int product_no;
	private int category_no;
	private String review_cont;
	private int review_rank;
	private String review_image;
	private String review_date;
	private String review_update;
	
	
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
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
	
	public String getReview_cont() {
		return review_cont;
	}
	public void setReview_cont(String review_cont) {
		this.review_cont = review_cont;
	}
	
	public int getReview_rank() {
		return review_rank;
	}
	public void setReview_rank(int review_rank) {
		this.review_rank = review_rank;
	}
	
	public String getReview_image() {
		return review_image;
	}
	public void setReview_image(String review_image) {
		this.review_image = review_image;
	}
	
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	
	public String getReview_update() {
		return review_update;
	}
	public void setReview_update(String review_update) {
		this.review_update = review_update;
	}
	
}
