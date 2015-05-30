<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/CustomUtil" prefix="fnlb" %>
<!-- jquery 관련 -->
<script type="text/javascript" src="${fnlb:fnContextPathNormalize(pageContext.request)}/jquery-1.11.0.min.js"></script> 

<link rel="stylesheet" href="${fnlb:fnContextPathNormalize(pageContext.request)}/jui-develop/jui.css" />
<script src="${fnlb:fnContextPathNormalize(pageContext.request)}/jui-develop/lib/jquery-1.8.0.min.js"></script>
<script src="${fnlb:fnContextPathNormalize(pageContext.request)}/jui-develop/lib/jquery.binder.js"></script>
<script src="${fnlb:fnContextPathNormalize(pageContext.request)}/jui-develop/js/base.js"></script>
<script src="${fnlb:fnContextPathNormalize(pageContext.request)}/jui-develop/js/core.js"></script>
<script src="${fnlb:fnContextPathNormalize(pageContext.request)}/jui-develop/js/ui/dropdown.js"></script>
<script src="${fnlb:fnContextPathNormalize(pageContext.request)}/jui-develop/js/ui/modal.js"></script>
<script src="${fnlb:fnContextPathNormalize(pageContext.request)}/jui-develop/js/uix/table.js"></script>
<script src="${fnlb:fnContextPathNormalize(pageContext.request)}/jui-develop/js/uix/xtable.js"></script>

<script type="text/javascript">
	var contextRoot = "${fnlb:fnContextPathNormalize(pageContext.request)}";
	
	//게시판 등록
	function boardSave(){
		location.href = contextRoot + "/boardWrite.do";
	};
	
	//게시판 상세
	function boardView(num){
		var url = contextRoot + "/boardView.do";
		var params = {
				boardNo	:	num
		};
		locationToPost(url, params);
	};
	
	$(function(){
		boardList(1);
	});
	
	//목록 조회 ajax
	function boardList(page){
		//boardListAjax
		var url = contextRoot + "/boardListAjax.do";
		var params = {
				page			:	page,
				rec				:	10,
				searchOption	:	$("#searchOption").val(),
				searchItems		:	$("#searchItems").val()
		};
		$.ajax({
			url: url,
			type:"post",
			data:params,
			datatype:"json",
			success:function(data) {
				setBoardList(data);
			}
		});
	};
	
	//목록 셋팅
	function setBoardList(data){
		var page = data.page;
		var rec = data.rec;
		var records = data.records;
		var tempList = data.results;
		var trrArray = [];
		var temp = 0;
		
		$("#tbodyList").empty();
		$("#pagenation").empty();
		
		if(tempList != null && tempList.length > 0){
			for(var i=0; i<tempList.length; i++){
				trrArray[temp++] = "<tr>";
				trrArray[temp++] = "<td>"+tempList[i].numb+"</td>";
				trrArray[temp++] = "<td><a href='javascript:boardView("+tempList[i].boardNo+");'>"+tempList[i].boardTitle+"</td>";
				trrArray[temp++] = "<td>"+tempList[i].fileNo+"</td>";
				trrArray[temp++] = "<td>"+tempList[i].createUser+"</td>";
				trrArray[temp++] = "<td>"+tempList[i].createDate+"</td>";
				trrArray[temp++] = "<td>"+tempList[i].readCount+"</td>";
				trrArray[temp++] = "</tr>";
			}
			Set_Pager("pagenation", page, records, rec, "boardList");
		}else{
			trrArray[temp++] = "<tr align='center'>";
			trrArray[temp++] = "<td colspan='6'>조회 결과가 없습니다. </td>";
			trrArray[temp++] = "</tr>";
		}
		$("#tbodyList").append(trrArray.join(''));
	};
	
</script>
<body class="jui">
<div  align="ceneter">
	<!-- 버튼 시작 -->
		<div>
			<a href="#self" onclick="boardSave();"><span><span> 게시글 등록 </span></span></a>&nbsp;&nbsp;&nbsp;
			<select id="searchOption">
				<option value="create_user">작성자</option>
				<option value="board_title">제목</option>
				<option value="board_content">내용</option>
			</select>
			<input type="text" style="width: 300px;" id="searchItems">
			<a href="javascript:boardList(1);"><span><span> 조회 </span></span></a>
		</div>
		
	<!-- //버튼 끝 -->
</div>

<!-- 테이블 시작 -->
<div>
	<table summary="게시판 리스트 테이블" border="1" style="width:100%; text-align:center;">
		<caption>게시판 리스트</caption>
		<colgroup>
			<col style="width: 84px" />
			<col style="width: 415px" />
			<col style="width: 83px" />
			<col style="width: 105px" />
			<col style="width: 105px" />
			<col style="width: 83px" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">글번호</th>
				<th scope="col">제목</th>
				<th scope="col">파일</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">조회수</th>
			</tr>
		</thead>
		<tbody id="tbodyList">
		</tbody>
	</table>
</div>
<div>
	<div style="margin:0 auto; width:100%; text-align:center;">
		<ul id="pagenation">
		</ul>
	</div>
</div>

<div id="paging_2" class="paging" style="margin-top: 3px;">
			<a href="#" class="prev">Previous</a>
			<div class="list">
			
				<a href="#" class="page active">1</a>
			
				<a href="#" class="page">2</a>
			
				<a href="#" class="page">3</a>
			
				<a href="#" class="page">4</a>
			
				<a href="#" class="page">5</a>
			
		</div>
			<a href="#" class="next">Next</a>
		</div>
		

</body>
<script type="text/javascript">
/* 페이징 관련 function start *****************************************************************************/

/*
 * pageAreaId : 페이징을 넣을 DIV ID
 * pageNum : 요청페이지
 * records : 총 게시건수
 * recordPerPage : 페이지당 표시할 게시건수
 * goFunction : 페이지클릭시 실행할 Function
 */
Set_Pager = function(pageAreaId, pageNum, records, recordPerPage, goFuncName)
{
	var pageHtml = "";
	
	var totalPage = Math.ceil(records/recordPerPage);
	var countPerBlock = 10;								// 한화면에 보여줄 페이지개수
	var curBlock = Math.ceil(pageNum/countPerBlock);	// 현재 화면영역 (1~10/ 11~20)
	var startPage = (curBlock-1) * 10 + 1;
	var lastPage = (curBlock)*10;
	
	var prev = $("<a href='javascript:;' id='prev' title='이전 10개 페이지'> 〈 </a>");
	var next = $("<a href='javascript:;' id='next' title='다음 10개 페이지'> 〉 </a>");
	
	var first = $("<a href='javascript:;' id='first' title='첫 페이지'> 《 </a>");
	var last = $("<a href='javascript:;' id='last' title='마지막 페이지'> 》 </a>");
	
	if(lastPage > totalPage) lastPage = totalPage;
	
	// 페이징 생성
	for(var i = startPage; i <= lastPage; i++)
	{ 
		if(parseInt(pageNum) === i)
			pageHtml += "<a href='#self'>" + i + "</a>";
		else
			pageHtml += "<a href='javascript:" + goFuncName + "(" + i + " , " + recordPerPage + ")'> " + i + " </a>";
	}
	
	// 이전블록 유효하면 이전버튼 이벤트 생성
	if(pageNum > startPage) {
		prev.attr("href", "javascript:" + goFuncName + "("+ (pageNum - 1) + " , " + recordPerPage + ")");
	}
	
	// 다음블록 유효하면 다음버튼 이벤트 생성
	if(pageNum < totalPage) {
		next.attr("href", "javascript:" + goFuncName + "("+ (pageNum + 1) + " , " + recordPerPage + ")");
	}
	
	// 첫페이지가 아니면 이벤트 생성
	if(pageNum != 1){
		first.attr("onclick", "javascript:" + goFuncName + "(" + 1 + " , " + recordPerPage + ")");
	}
	
	// 마지막 페이지가 아니면 이벤트 생성
	if(pageNum != totalPage){
		last.attr("onclick", "javascript:" + goFuncName + "(" + totalPage + " , " + recordPerPage + ")");
	}
	
	$("#" + pageAreaId)
	.append(first)
	.append(prev)
	.append(pageHtml)
	.append(next)
	.append(last)
	;
};

//Post Submit (window.location.href)
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