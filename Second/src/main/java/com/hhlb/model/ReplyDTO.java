package com.hhlb.model;

public class ReplyDTO {

	private int reply_no;
	private int board_no;
	private int user_no;
	private String reply_cont;
	private String reply_date;
	private String reply_update;
	
	
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	
	public String getReply_cont() {
		return reply_cont;
	}
	public void setReply_cont(String reply_cont) {
		this.reply_cont = reply_cont;
	}
	
	public String getReply_date() {
		return reply_date;
	}
	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}
	
	public String getReply_update() {
		return reply_update;
	}
	public void setReply_update(String reply_update) {
		this.reply_update = reply_update;
	}
	
}
