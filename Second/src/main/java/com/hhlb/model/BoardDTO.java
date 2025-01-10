package com.hhlb.model;

public class BoardDTO {

	private int board_no;
	private String user_id;
	private String board_title;
	private String board_cont;
	private String board_pwd;
	private String board_date;
	private String board_update;
	private String board_img;
	private int board_hit;
	private String board_type;
	private int board_visible;
	
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	
	public String getBoard_cont() {
		return board_cont;
	}
	public void setBoard_cont(String board_cont) {
		this.board_cont = board_cont;
	}
	
	public String getBoard_pwd() {
		return board_pwd;
	}
	public void setBoard_pwd(String board_pwd) {
		this.board_pwd = board_pwd;
	}
	
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	
	public String getBoard_update() {
		return board_update;
	}
	public void setBoard_update(String board_update) {
		this.board_update = board_update;
	}
	
	public String getBoard_img() {
		return board_img;
	}
	public void setBoard_img(String board_img) {
		this.board_img = board_img;
	}
	
	public int getBoard_hit() {
		return board_hit;
	}
	public void setBoard_hit(int board_hit) {
		this.board_hit = board_hit;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public int getBoard_visible() {
		return board_visible;
	}
	public void setBoard_visible(int board_visible) {
		this.board_visible = board_visible;
	}
	

}
