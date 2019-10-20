<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문내역</title>
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
	document.getElementById('pagenum').value = pageNum;
	form.action = "/pc/order/order";
	form.submit();
}

function onRegist()
{
	var isdept = document.getElementById('isdept').value;
	if(isdept !=0){
		form.action = "/pc/order/orderregist";
		form.submit();
	}else{
		alert("부서 조직도를 등록해 주세요.");
		return false;
	}
}

function orderDetail(no)
{
	document.getElementById('orderno').value = no;
	form.action = "/pc/order/orderdetail";
	form.submit();
}

</script>

</head>
<body>
	<form id="form" method="post">
		<input type="hidden" id="isdept" name="isdept" value="${data.isdept }">
		<input type="hidden" id="pagenum" name="pagenum" value="0"/>
		<input type="hidden" id="orderno" name="orderno" value="0"/>
		<div class="container margin-t-10 cntbox radiall" style="padding:20px 20px 0 20px; margin-top: 20px;">
			<div class="inbox">
				<div class="clearfix margin-b-10">
					<div class="pull-left" style="position:relative; top:-2px;">
						<div class="input-group input-group-sm">
							<h4 class="pull-left" style="display:block; margin:20px 0 20px 0;"><strong>주문내역</strong></h4>
						</div>
					</div>
				</div>
			</div>

			<table class="table table-hover text-center table-striped ">
				<thead>
					<tr>
						<th class="text-center client-n">번호</th>
						<th class="text-center client-num" style="width:310px;">제목</th>
						<th class="text-center client-num" style="width:70px;">진행상태</th>
						<th class="text-center client-num" style="width:110px;">등록날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${data.list != null}">
						<c:forEach var="list" items="${data.list }">
							<tr style="cursor: pointer; text-align: center;" onclick="orderDetail('${list.no }');">
								<td><fmt:formatNumber value="${list.rownum }" type="number"/></td>
								<td><c:if test="${list.isadminnew == 1 }"><img src="/img/png/new_icon.png" style="width:25px; margin-right:10px;" alt=""></c:if>${list.title }</td>
								<td>
								<c:choose>
									<c:when test="${list.status == 0}">주문</c:when>
									<c:when test="${list.status == 1}">접수</c:when>
									<c:when test="${list.status == 2}">제작</c:when>
									<c:when test="${list.status == 3}">배송</c:when>
									<c:when test="${list.status == 4}">완료</c:when>
									<c:otherwise>취소</c:otherwise>
								</c:choose>
								</td>
								<td>${list.orderdate }</td> 
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
				<tfoot>
					 <tr>
                <td colspan="5" class="text-center">
                  <ul class="pagination">
                    <%@ include file="/WEB-INF/jsp/include/paging.jsp" %>
                  </ul>                 
                </td>
              </tr>
				</tfoot>
			</table>
			<button class="btn btn-primary btn-sm wd100 pull-right" type="button" alt="join" style="margin-left:10px; margin-bottom:20px;" onclick="onRegist();">등록</button>
		</div>
	</form>
</body>
</html>