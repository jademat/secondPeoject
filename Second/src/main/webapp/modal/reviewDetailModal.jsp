<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="reviewDto" value="${ ReviewList }"/>	<!-- 해당 상품의 리뷰 리스트 -->
	<!-- Modal -->
    <div class="modal fade" id="reviewDetailModal" tabindex="-1" aria-labelledby="reviewDetailModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <c:forEach items="${ reviewDto }" var="dto">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="reviewDetailModalLabel">Review Details</h5>
                    <button type="button" class="btn-close" data-dismiss="modal"
                        aria-label="Close"></button>
                </div>
                <div class="modal-body" style="max-height: 500px; overflow-y: auto;">
                    <img src="<%= request.getContextPath() %>/resource/img/${ dto.getReview_image() }" alt="Image" class="img-fluid mr-3 mt-1"
                        style="width: 400px;">
                    <p><strong>Reviewer :</strong> ${ dto.getUser_id() }</p>
                    <p><strong>Title :</strong> ${ dto.getReview_title() }</p>
                    <p><strong>Date :</strong> ${dto.getReview_date() }</p>
                    <p><strong>Review :</strong> ${dto.getReview_cont() }</p>
                   <p><strong>Rating:</strong>
				    <c:forEach var="i" begin="1" end="5">
				        <c:choose>
				            <c:when test="${dto.review_rank >= i}">
				                <i class="fas fa-star text-warning"></i> <!-- 금색 별 -->
				            </c:when>
				            <c:otherwise>
				                <i class="far fa-star text-muted"></i> <!-- 회색 별 -->
				            </c:otherwise>
				        </c:choose>
				    </c:forEach>
				</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                        data-dismiss="modal">Close</button>
                </div>
            </div>
            </c:forEach>.
        </div>
    </div>
