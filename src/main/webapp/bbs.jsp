<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.PrintWriter" %>
    <%@page import="bbs.BbsDAO" %>
    <%@page import="bbs.Bbs" %>
    <%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹사이트</title>
<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration: none; 
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber")!=null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>	
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID==null){
			%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
						aria-haspopup="true" aria-expanded="false">
						접속하기
						<span class="caret"></span>
					</a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp">로그인</a>
					<li><a href="join.jsp">회원가입</a>
				</ul>
				</li>
				</ul>
			<%		
				} else{
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
						aria-haspopup="true" aria-expanded="false">
						회원관리
						<span class="caret"></span>
					</a>
				<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp">로그아웃</a>
				</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	<section class="container">
		<form method="get" action="bbs.jsp" class="form-inline mt-3">
			<select name="BBSDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="번호">번호</option>
				<option value="제목">제목</option>
				<option value="작성자">작성자</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportrModal">신고</a>
		</form>
	</section>
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times</span>
					</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0;i<list.size(); i++){
					%>
					
					<tr>
						<td><%=list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle() %></a></td>
						<td><%=list.get(i).getUserID() %></td>
						<td><%=list.get(i).getBbsDate().substring(0, 11)+list.get(i).getBbsDate().substring(11, 13)+"시"+list.get(i).getBbsDate().substring(14, 16)+"분" %></td>
					</tr>
					
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber!=1){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber-1 %>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				} if(bbsDAO.nextPage(pageNumber+1)){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber+1 %>" class="btn btn-success btn-arraw-right">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>