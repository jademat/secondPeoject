<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setAttribute("pageTitle", "Write inquiry");
%>	
<jsp:include page="../include/header.jsp" />


<style>
.pagination {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}
</style>
<div class="container mt-3">
	<c:set var="user_id" value="${sessionScope.user_id}" />
	<c:set var="blist" value="${blist }" />
	<table class="table table">
		<tr align="center">
			<th><a href="<%=request.getContextPath()%>/user_board_list.go?board_type=all">전체보기</a></th>
			<th><a
				href="<%=request.getContextPath()%>/user_board_list.go?board_type=notice">공지사항</a></th>
			<th><a
				href="<%=request.getContextPath()%>/user_board_list.go?board_type=exchange">교환</a></th>
			<th><a
				href="<%=request.getContextPath()%>/user_board_list.go?board_type=refund">환불</a></th>
			<th><a
				href="<%=request.getContextPath()%>/user_board_list.go?board_type=inquiry">상품문의</a></th>
		</tr>
	</table>
	<table class="table table-hover">
		<tr>
			<th width="5%">No.</th>
			<th width="10%">타입</th>
			<th width="50%">글 제목</th>
			<th width="15%">아이디</th>
			<th>작성일자</th>
		</tr>
		<c:if test="${!empty blist }">
			<c:forEach items="${blist}" var="dto">
				<tr
					onClick="location.href='user_boardDetail.go?no=${dto.getBoard_no() }'">
					<td>${dto.getBoard_no() }</td>
					<td>${dto.getBoard_type() }</td>
					<td>
					    <c:choose>
					        <c:when test="${dto.board_visible == 0}">
					            <c:choose>
					                <c:when test="${dto.getUser_id() == user_id}">
					                    비밀글 입니다.
					                </c:when>
					                <c:otherwise>
					                    비공개글입니다.
					                </c:otherwise>
					            </c:choose>
					        </c:when>
					        <c:otherwise>
					            <c:choose>
					                <c:when test="${dto.board_type == 'notice'}">
					                    <span style="color: red; font-weight: bold;">${dto.board_title}</span> <!-- board_type이 'notice'일 때 빨간색 -->
					                </c:when>
					                <c:otherwise>
					                    ${dto.board_title} <!-- 일반적인 제목 -->
					                </c:otherwise>
					            </c:choose>
					        </c:otherwise>
					    </c:choose>
					</td>
					<td>${dto.getUser_id() }</td>
					<td>${dto.getBoard_date().substring(0,10) }</td>
				</tr>
			</c:forEach>
		</c:if>

		<c:if test="${empty blist }">
			<td colspan="5" align="center">게시물이 없습니다.</td>
		</c:if>

	</table>
</div>
<br>
<br>
<div class="container">
	<ul class="pagination">
		<c:if test="${page > block }">
			<li class="page-item "><a class="page-link"
				href="user_board_list.go?board_type=${board_type }&page=${startBlock - 1 }">Previous</a></li>
		</c:if>
		<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			<c:if test="${i == page}">
				<li class="page-item active"><a class="page-link"
					href="user_board_list.go?board_type=${board_type }&page=${i }">${i }</a></li>
			</c:if>
			<c:if test="${i != page}">
				<li class="page-item"><a class="page-link"
					href="user_board_list.go?board_type=${board_type }&page=${i }">${i }</a></li>
			</c:if>
		</c:forEach>
			<c:if test="${endBlock < allPage}">
			<li class="page-item"><a class="page-link" href="user_board_list.go?board_type=${board_type }&page=${endBlock + 1 }">Next</a></li>
			</c:if>
	</ul>
</div>

<br>
<br>
<c:if test="${!empty user_id}">
	<div align="center">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#boardWriteModal">글쓰기</button>
	</div>
</c:if>

<jsp:include page="../modal/boardWriteModal.jsp" />
<jsp:include page="../include/footer.jsp" />