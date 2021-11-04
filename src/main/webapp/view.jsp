<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ page import="java.io.PrintWriter"%>
	<%@ page import="bbs.Bbs"%>
	<%@ page import="bbs.BbsDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/custom.css">
<title>게시판</title>
</head>
<body>
    <%
        String userID = null; 
    	if (session.getAttribute("userID") != null) {
	        userID = (String) session.getAttribute("userID");
	    }
	    int bbsID = 0;
	    if (request.getParameter("bbsID") != null) {
	        bbsID = Integer.parseInt(request.getParameter("bbsID"));
	    }
	    if (bbsID == 0) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('선택한 글이 없습니다.')");
	        script.println("location.href='bbs.jsp'");
	        script.println("</script>");
	    }
	    Bbs bbs = new BbsDAO().getBbs(bbsID); 
    %>
 
    <nav class="navbar navbar-default">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expaned="false">
                <span class="icon-bar"></span> 
                <span class="icon-bar"></span> 
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
        </div>
        <div class="collapse navbar-collapse" id="#bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li class="active"><a href="bbs.jsp">게시판</a></li>
            </ul>
            <%
                if (userID == null) {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" 
                		aria-haspopup="true" aria-expanded="false">
                    	접속하기
                    	<span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>
                    </ul>
				</li>
            </ul>
            <%
                } else {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" 
                		aria-haspopup="true" aria-expanded="false">
                		회원관리
                		<span class="caret"></span>
                	</a>
                    <ul class="dropdown-menu">
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
            <%
                }
            %>
        </div>
    </nav>

    <div class="container">
        <div class="row">
            <table class="table table-striped"
                style="text-align: center; border: 1px solid #dddddd">
                <thead>
                    <tr>
                        <th colspan="3" style="background-color: #eeeeee; text-align: center;">
                        게시판 글 보기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width: 20%;">글 제목</td>
                        <td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>")%></td>
                    </tr>
                    <tr>
                        <td>작성자</td>
                        <td colspan="2"><%=bbs.getUserID()%></td>
                    </tr>
                    <tr>
                        <td>작성일자</td>
                        <td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"+ bbs.getBbsDate().substring(14, 16) + "분"%></td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td colspan="2">
                            <div class="bbs-content" style="min-height: 200px; text-align: left">
                                <%=bbs.getBbsContent().replaceAll(" ", "&nbsp").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>")%>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div id="disqus_thread"></div>
				<script>
				    /**
				    *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
				    *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables    */
				    /*
				    var disqus_config = function () {
				    this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
				    this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
				    };
				    */
				    (function() { // DON'T EDIT BELOW THIS LINE
				    var d = document, s = d.createElement('script');
				    s.src = 'https://bbs-3.disqus.com/embed.js';
				    s.setAttribute('data-timestamp', +new Date());
				    (d.head || d.body).appendChild(s);
				    })();
				</script>
				<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>

            <a href="bbs.jsp" class="btn btn-primary pull-right">목록</a>
            <%
                if (userID != null && userID.equals(bbs.getUserID())) {
            %>
            <a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
            <!-- 삭제 버튼 클릭 시 삭제하시겠습니까 메시지 띄우기 -->
            <a onclick="return confirm('삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
            <%
                }
            %>
        </div>
    </div>
 	<br/>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
 
</html>