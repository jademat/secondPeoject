<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="orderDetailModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="orderDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="orderDetailModalLabel">주문상세내역</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                   <table class = "table table">
                       <tr>
                        <th>이름</th>
                        <td ></td>  <!-- 이름 -->
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td ></td>  <!-- 연락처 -->
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td ></td>  <!-- 주소 -->
                    </tr>
                        
                       
                   </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
                    
                </div>
            </div>
        </div>
    </div>