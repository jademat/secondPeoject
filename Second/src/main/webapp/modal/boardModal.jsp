<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <!-- board write modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Q&A 작성</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container mt-3">
                        <h3></h3>
                        <p style="color: black;">문의사항이 있으면 말해주세요.</p>
                        <form>
                            <div class="panel-heading clearfix">
                                <form class="input-group col-md-4">
                                    <div class="input-group-btn">
                                        <select class="btn btn-default" ng-model="filterOption">
                                            <span class="caret"></span>
                                            <option ng-repeat="option in filterOptions" value="교환">교환</option>
                                            <option ng-repeat="option in filterOptions" value="환불">환불</option>
                                            <option ng-repeat="option in filterOptions" value="상품문의">상품문의</option>
                                        </select>
                                    </div>
                                    <input type="text" ng-model="query" class="form-control" placeholder="글제목">
                                    <div class="input-group-btn">
                                        <button ng-click="search()" type="submit" class="btn"><i class="glyphicon glyphicon-search"></i></button>
                                    </div>
                                </form>
                            </div>
                            <div>
                                <div class="form-group">
                                    <label for="comment">Comment:</label>
                                    <textarea class="form-control" rows="5" cols="30" id="comment"
                                        placeholder="내용을 입력해주세요" style="resize: none;"></textarea>
                                </div>

                            </div>
                        </form>
                    </div>
                </div>

                <div class="form-group" align = "center">
                    <label for="visibility">글 공개 설정</label>
                    <select class="form-control" name="visibility" id="visibility">
                        <option value="public">공개글</option>
                        <option value="secret">비밀글</option>
                    </select>
                  </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary">작성 완료</button>
                </div>
            </div>
        </div>
    </div>
    <!-- board write modal end -->