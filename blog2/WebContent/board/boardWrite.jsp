<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/CustomUtil" prefix="fnlb" %>
<!-- jquery 관련 -->
<script type="text/javascript" src="${fnlb:fnContextPathNormalize(pageContext.request)}/jquery-1.11.0.min.js"></script> 
<!-- Smart Editor 2.0 -->
<script type="text/javascript" src="${fnlb:fnContextPathNormalize(pageContext.request)}/se2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
	var contextRoot = "${fnlb:fnContextPathNormalize(pageContext.request)}";
	
	//목록
	function boardList(){
		location.href = contextRoot + "/boardList.do";
	};
	
	//게시글 저장
	function boardSave(){
		
		editor[0].exec("UPDATE_CONTENTS_FIELD", []);   // 에디터의 내용이 textarea에 적용된다.

		//유효성 체크
		var boardContent = $.trim($("#boardContent").val());
		if($("#boardTitle").val() == null || $("#boardTitle").val() == ""){
			alert("제목을 입력해주세요.");
			$("#boardTitle").focus();
			return;
		}
		if(boardContent == "<p>&nbsp;</p>" || boardContent == "" || boardContent == "<br>"){
			alert("내용을 입력해주세요.");
			$("#boardContent").focus();
			return false;
		}
		
		
		//boardSaveAjax
		var url = contextRoot + "/boardSaveAjax.do";
		var boardNo = "${boardNo}";
		var procMode = "";
		if(boardNo == null || boardNo == ""){
			procMode = "insert";
		}else{
			procMode = "update";
		}
		var params = {
				procMode		:	procMode,
				boardTitle		:	$("#boardTitle").val(),
				boardContent	:	boardContent
		};
		$.ajax({
			url: url,
			type:"post",
			data:params,
			datatype:"json",
			success:function(data) {
				var msg = data.msg;
				var procMode = data.procMode;
				if(procMode == "insert" && msg == "suc"){
					alert("저장되었습니다.");
					var url = contextRoot + "/boardView.do";
					var params = {
							boardNo	:	data.boardNo
					};
					locationToPost(url, params);
				}else if(procMode == "insert" && msg == "fail"){
					alert("저장실패하였습니다.");
					return;
				}else if(procMode == "update" && msg == "suc"){
					alert("수정되었습니다.");
					var url = contextRoot + "/boardView.do";
					var params = {
							boardNo	:	data.boardNo
					};
					locationToPost(url, params);
				}else if(procMode == "update" && msg == "fail"){
					alert("수정실패하였습니다.");
					return;
				}
			}
		});
	};
	
</script>
<div>
	<!-- 버튼 시작 -->
	<div>
		<c:choose>
			<c:when test="${boardNo ne null}">
				<a href="javascript:boardSave();"><span><span> 수정 </span></span></a>
			</c:when>
			<c:otherwise>
				<a href="javascript:boardSave();"><span><span> 저장 </span></span></a>
			</c:otherwise>
		</c:choose>
		<a href="javascript:boardList();"><span><span> 목록 </span></span></a>
	</div>
	<!-- //버튼 끝 -->

	<!-- 테이블 시작 -->
	<div>
		<table summary="게시판 등록" border="1" style="width:100%; text-align:center;">
			<c:choose>
				<c:when test="${boardNo ne null}">
					<caption>게시판 수정</caption>
				</c:when>
				<c:otherwise>
					<caption>게시판 등록</caption>
				</c:otherwise>
			</c:choose>
			<colgroup>
				<col style="width:165px"/>
				<col style="width:325px"/>
				<col style="width:164px"/>
				<col style="width:325px"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">제목</th>
					<td colspan="3">
						<input type="text" style="width: 100%;" id="boardTitle" value="${boardTitle}">
					</td>
				</tr>
				<tr>
					<th scope="row">작성자</th>
					<td id="createUser">${createUser}</td>
					<th scope="row">작성일</th>
					<td id="createDate">${createDate}</td>
				</tr>
				<tr>
					<th scope="row">파일</th>
					<td colspan="3">
						<label for="upFile" id="upFileLabel" ><span><span>  </span></span></label>
						<ul id="upFileList">
						</ul>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<%-- <div class="editView">
							<textarea rows="10" cols="150" id="boardContent">${noticeData.content}</textarea>
						</div> --%>
						<div>
							<textarea id="boardContent" style="width: 100%; height: 200px"><c:out value="${boardContent}"/></textarea>
							<script>
							var editor = [];
							nhn.husky.EZCreator.createInIFrame({
								oAppRef: editor,
							    elPlaceHolder: "boardContent",
							    sSkinURI: (contextRoot + "/se2/SmartEditor2Skin.html"),
							    fCreator: "createSEditor2",
								htParams : {
									fOnBeforeUnload : function(){
									}
								}
							});
							</script>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- //테이블 끝 -->

</div>

<script type="text/javascript">
// Post Submit (window.location.href)
function locationToPost(url, params) 
{
	var temp=document.createElement("form");
	temp.action = url;
	temp.method = "POST";
	temp.style.display = "none";
	for(var x in params) {
		var opt = document.createElement("textarea");
		opt.name = x;
		opt.value = params[x];
		temp.appendChild(opt);
	}
	
	document.body.appendChild(temp);
	temp.submit();
	return temp;
};
</script>