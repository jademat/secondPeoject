<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%
request.setAttribute("pageTitle", "Write an Inquiry");
%>

<jsp:include page="../include/header.jsp" />

<style>
textarea {
	width: 700px;
	resize: none;
	border: none;
}

.table-bordered {
	border: 3px solid black; /* 테이블의 외부 테두리 두께 */
}

.table-bordered th, .table-bordered td {
	border: 2px solid black; /* 테이블 셀의 테두리 두께 */
}
</style>
<div class="container">
	<c:set var="cont" value="${bCont }" />
	<table class="table table-bordered">
		<c:if test="${!empty cont }">

			<tr>
				<th>${cont.getBoard_type() }</th>
				<th style="text-align: right;">${cont.getBoard_date().substring(0,10) }</th>
			</tr>
			<tr>
				<th>아이디</th>
				<td>${cont.getUser_id() }</td>
			</tr>
			<tr>
				<th>글제목</th>
				<td>${cont.getBoard_title() }</td>
			</tr>
			<tr>
				<th>글내용</th>
				<td><textarea rows="5" cols="30" readonly>${cont.getBoard_cont() }</textarea></td>
			</tr>

		</c:if>
	</table>

</div>
<div align="center">
	<input type="button" class="btn btn-primary" value="전체목록"
		onclick="location.href = '<%=request.getContextPath()%>/user_board_list.go?board_type=all'">
</div>
<br>

<div class="container">
	<div class="row">
		<table class="table table-striped"
			style="text-align: center; border: 1px solid #dddddd">
				<tr>
					<td align="left" bgcolor="beige">댓글</td>
				</tr>
				<tr>
					<div class="container">
						<div class="row">
							<table class="table table-striped " id = "replyTable"
								style="text-align: center; border: 1px solid #dddddd">
								<tbody>
									<tr>
										<td align="left">아이디 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 작성일</td>
										<td colspan="2"></td>
										<td align="right">
											<form name="p_search">
												<a type="button" class="btn-primary">수정</a>
												<a class="btn-primary">삭제</a>
											</form> 
										</td>
									</tr>
									<tr>
										<td colspan="5" align="left">작성내용</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</tr>
		</table>
	</div>
</div>
<div class="container">
	<div class="form-group">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<tr>
					<td style="border-bottom:none;" valign="middle"><br><br>${sessionScope.user_id }</td>
					<td><input type="text" style="height:100px;" class="form-control" placeholder="상대방을 존중하는 댓글을 남깁시다." name = "cont" id="cont"></td>
					<td><br><br><input type="button" id = "replyBtn" class="btn-primary pull" value="댓글작성"></td>
				</tr>
				
			</table>
	</div>
</div>

<script type="text/javascript">
    var userId = '${sessionScope.user_id}';  // 세션에서 user_id를 가져옵니다.
    

    // 댓글 작성 버튼 클릭 이벤트
    $("#replyBtn").on("click", function() {
        var replyContent = $("#cont").val();  // 댓글 내용
        var boardNo = ${cont.getBoard_no()};  // 게시판 번호는 JSP에서 가져오기

        // AJAX 요청
        $.ajax({
            url: "/second/user_reply_ok.go",  // 댓글 작성 처리 URL
            data: {
                id: userId,            // 로그인된 사용자 ID
                content: replyContent, // 댓글 내용
                bno: boardNo          // 게시판 번호
            },
            dataType: "text",  // 서버에서 텍스트 응답을 받을 것
            success: function(res) {
                if (res > 0) {
                    alert("댓글 작성 성공!");

                    // 댓글 작성 후 전체 댓글 목록을 다시 가져오기
                    getList();

                    // 댓글 입력창 초기화
                    $("input[type=text]").each(function() {
                        $(this).val("");
                    });
                }
            },
            error: function() {
                alert("데이터 통신 오류입니다.");
            }
        });
    });

    // 댓글 목록 가져오기
    function getList() {
        $.ajax({
            url: "<%=request.getContextPath() %>/user_reply.go",
            data: { rno: ${cont.getBoard_no()} },  // 게시판 번호를 전달
            dataType: "xml",
            success: function(res) {
                // 댓글 목록을 테이블에 표시
                $("#replyTable tr:gt(0)").remove();
                let table = "";
                $(res).find("reply").each(function() {
                    table += "<tr>";
                    table += "<td>" + $(this).find("user_id").text() + "</td>";
                    table += "<td>" + $(this).find("reply_cont").text() + "</td>";
                    table += "<td>" + $(this).find("reply_date").text() + "</td>";
                    table += "</tr>";
                });
                $("#replyTable tr:eq(0)").after(table);  // 댓글 목록을 테이블에 추가
            },
            error: function() {
                alert("데이터 통신 오류입니다.");
            }
        });
    }
</script>
<jsp:include page="../include/footer.jsp" />