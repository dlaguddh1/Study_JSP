<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@page import="bbs.*" %>
    <%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-Type" content="text/html; charset = UTF-8">		<%// html 페이지 속성 %>
<meta name="viewport" content="width=device-width" , initial-scale = "1">	<%// 반응형 웹 만들기위해 %>
<link rel="stylesheet" href="css/bootstrap.css">	<%// 스타일시트(부트스트랩) 링크 %>
<title>Insert title here</title>
</head>
<body>

	<%
		String userID = null;
	if(session.getAttribute("userID") !=null){ // 로그인 되어있는경우
		userID = (String)session.getAttribute("userID");
	}
	
	int bbsID = 0;
	
	if(request.getParameter("bbsID") != null){
		
		bbsID = Integer.parseInt(request.getParameter("bbsID")); 
		// 개시물 번호 요청
	}
	if(bbsID == 0){
		
		PrintWriter script = response.getWriter();
		script.print("<script>");
		script.print("alert('존재하지 않는 게시물입니다.');");
		script.print("location.href='bbs.jsp'");
		script.print("</script>");
		
	}

	Bbs bbs  = new BbsDAO().getbbs(bbsID);	// 검색결과
	
	
	// 로그인된 세션이 작성자가 아닐경우
	if( !userID.equals(bbs.getBbsuserID())){
		
		PrintWriter script = response.getWriter();
		script.print("<script>");
		script.print("alert('권한이 없습니다.');");
		script.print("location.href='bbs.jsp'");
		script.print("</script>");
		
	}
	%>

	<nav class="navbar navbar-default">	<%// 메뉴바 선언 %>
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapase-1"
					aria-expanded="false">
				<span class="icon-bar"></span>	<%//오른쪽 아이콘바 %>	
				<span class="icon-bar"></span>	
				<span class="icon-bar"></span>	
			</button>
			<a class="navbar-brand" href="main.jsp">jsp 홈페이지</a>
		</div>
		
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="main.jsp">공지사항</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			
			<%/////////////////////////////////////////////////////////////////////////// %>
			
	
					<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logout.jsp">로그아웃</a></li>
							<li class="active"><a href="Userdata.jsp">회원정보</a></li>
						</ul>
					</li>
				</ul>
		</div>
	</nav>	<%// 메뉴바 끝 %>
	<%/////////////////////////////////////////////////////////////////////////// %>
	
	<div class="container">
		<div>
		<form method="post" action="updateAction.jsp?bbsID=<%=bbs.getBbsID()%>">
			<table class="table table-striped" style="text-align: center; border: 1px solid wheat;">
							<% // table-striped 행마다 색상 구분 %>
				<thead>	<% // 테이블 제목 %>
					<tr>
						<th colspan="3" style="background-color: wheat; text-align: center;">게시물 수정</th>
						
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td><input type="text" name="bbsTitle" value="<%=bbs.getBbsTitle()%>" class="form-control"> </td>
						
					</tr>
					<tr>
						<td><textarea name="bbsContents" class="form-control" style="height: 350px"><%=bbs.getBbsContents() %></textarea> </td>
						
					</tr>
					
				</tbody>
			</table>
			<input type="submit" value="글 수정" class="btn btn-primary pull-right">
		</form>
		</div>
	
	</div>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>