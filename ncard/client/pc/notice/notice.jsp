<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>공지사항</title>
    <style>
*{text-decoration:none;}
.pull-right ul ul{display:none;}
.pull-right ul li:hover > ul {display:block; float:top;}
li {list-style:none; text-decoration:none; float:left;}
	</style>

<script language="javascript">

//페이지
function pageMove(pageNum) 
{
	document.getElementById('pageNum').value = pageNum;
	form.action = "/pc/notice/notice";
	form.submit();
}

function noticeDetail(no)
{
	var url = '/pc/notice/noticedetail?no=' + no;
	
	window.open(url, '공지사항', "width=1000,height=415,top=0,left=0 scrollbars=yes,resizeable=yes,left=450,top=150");
}

</script>

</head>
<body>
	<form id="form" method="post">
		<input type="hidden" id="pageNum" name="pageNum" size="10" value="0">
		<input type="hidden" id="pagingURL" name="pagingURL" size="100">
		<div class="container margin-t-10 cntbox radiall" style="padding:20px 20px 0 20px; margin-top: 20px;">
			<div class="inbox">
				<div class="clearfix margin-b-10">
					<div class="pull-left" style="position:relative; top:-2px;">
						<div class="input-group input-group-sm">
							<h4 class="pull-left" style="display:block; margin:20px 0 20px 0;"><strong>공지사항</strong></h4>
						</div>
					</div>
				</div>
			</div>

			<table class="table table-hover text-center table-striped ">
				<thead>
					<tr>
						<th class="text-center client-n">번호</th>
						<th class="text-center client-num" style="width:310px;">제목</th>
						<th class="text-center client-num" style="width:110px;">등록날짜</th>
						<th class="text-center client-num" style="width:70px;">열람수</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${data.list != null}">
						<c:forEach var="list" items="${data.list }" varStatus="i">
							<tr style="cursor: pointer; text-align: center;" onclick="noticeDetail(${list.no});">
								<td><fmt:formatNumber value="${data.startno - i.index }" type="number"/></td>
								<td style="text-align: left;">${list.title }</td>
								<td>${list.date }</td>
								<td>${list.count }</td> 
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
				<tfoot>
					 <tr>
                <td colspan="4" class="text-center">
                  <ul class="pagination">
                    <%@ include file="/WEB-INF/jsp/include/paging.jsp"%>
                  </ul>                 
                </td>
              </tr>
				</tfoot>
			</table>
		</div>
	</form>
</body>
</html>