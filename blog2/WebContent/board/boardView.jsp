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
	
	//수정
	function boardUpdate(){
		var url = contextRoot + "/boardWrite.do";
		var params = {
				boardNo	:	"${boardView.boardNo}"
		};
		locationToPost(url, params);
	};
	
	//삭제
	function boardDelete(){
		var url = contextRoot + "/boardDeleteAjax.do";
		var params = {
				boardNo	:	"${boardView.boardNo}"
		};
		$.ajax({
			url: url,
			type:"post",
			data:params,
			datatype:"json",
			success:function(data) {
				if(data.msg == "suc"){
					alert("삭제되었습니다.");
					location.href = contextRoot + "/boardList.do";
				}else{
					alert("삭제실패하였습니다.");
					return;
				}
			}
		});
	};
</script>
<div>
	<!-- 버튼 시작 -->
	<div>
		<a href="javascript:boardUpdate();"><span><span> 수정 </span></span></a>
		<a href="javascript:boardDelete();"><span><span> 삭제 </span></span></a>
		<a href="javascript:boardList();"><span><span> 목록 </span></span></a>
	</div>
	<!-- //버튼 끝 -->

	<!-- 테이블 시작 -->
	<div>
		<table summary="게시글 상세" border="1" style="width:100%; text-align:center;">
			<caption>게시글 상세</caption>
			<colgroup>
				<col style="width:165px"/>
				<col style="width:325px"/>
				<col style="width:164px"/>
				<col style="width:325px"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">제목</th>
					<td>${boardView.boardTitle}</td>
					<th scope="row">조회수</th>
					<td>${boardView.readCount}</td>
				</tr>
				<tr>
					<th scope="row">작성자</th>
					<td>${boardView.createUser}</td>
					<th scope="row">작성일</th>
					<td>${boardView.createDate}</td>
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
						<div>
							${boardView.boardContent}
						</div>
						<%-- <div>
							<textarea name="boardContent" id="boardContent" style="width: 100%; height: 200px"><c:out value="${noticeData.content}"/></textarea>
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
						</div> --%>
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