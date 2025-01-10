<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <!-- board write modal -->
    <div class="modal fade" id="boardWriteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">게시물 작성</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container mt-3">
                        <h3></h3>
                        <p style="color: black;">문의사항이 있으면 말해주세요.</p>
                        <form method="post" action="user_boardWrite.go">
                        <!-- user_id를 hidden 필드로 추가 -->
                        <input type="hidden" name="user_id" value="${user_id}">
                        
                        <!-- 게시글 타입 선택 -->
                        <div class="panel-heading clearfix">
                            <div class="input-group col-md-4">
                                <div class="input-group-btn">
                                    <select class="btn btn-default" name="board_type">
                                        <option value="Exchange">교환</option>
                                        <option value="Refund ">환불</option>
                                        <option value="Inquiry">상품문의</option>
                                    </select>
                                </div>
                                <input type="text" name="board_title" class="form-control" placeholder="글제목" required>
                            </div>
                        </div>

                        <!-- 내용 입력 -->
                        <div class="form-group">
                            <label for="comment">내용:</label>
                            <textarea class="form-control" rows="5" name="board_content" id="comment" placeholder="내용을 입력해주세요" style="resize: none;" required></textarea>
                        </div>

                        <!-- 글 공개 설정 -->
                        <div class="form-group" align="center">
                            <label for="visibility">글 공개 설정</label>
                            <select class="form-control" name="board_visible" id="visibility">
                                <option value="1">공개</option>
                                <option value="0">비공개</option>
                            </select>
                        </div>

                        <!-- 작성 완료 버튼과 취소 버튼 -->
                        <div class="modal-footer">
                            <button type="reset" class="btn btn-secondary" data-dismiss="modal">취소</button>
                            <button type="submit" class="btn btn-primary">작성 완료</button>
                        </div>
                    </form> <!-- 여기에서 form 태그 닫힘 -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- board write modal end -->