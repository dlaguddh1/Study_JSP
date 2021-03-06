<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	body{
		display: flex;
		flex-direction:column;
		align-items: center;
		justify-content: center;
		color: #F9EBDE;
		background-color: #815854;
	}
</style>
<meta charset="EUC-KR">
<title> 게시판 답변 </title>

<script language="javascript">
	function Check() {
		if(Write.name.value.length < 1){
			alert("작성자를 입력하세요.");
			Write.name.focus();
			return false;
		}
		if(Write.pass.value.length < 1){
			alert("비밀번호를 입력하세요");
			Write.pass.focus();
			return false;
		}
		if (Write.email.value.indexOf("@") + "" == "-1" ||
			Write.email.value.indexOf(".") + "" == "-1" ||
			Write.email.value == "" )
			{ 
				alert("E-mail을 입력하세요.");
				Write.email.focus();
				return false;
			}

		if (Write.title.value.length < 1) {
			alert("글제목을 입력하세요.");
			Write.write_title.focus(); 
			return false;
		      }

		if (Write.contents.value.length < 1) {
			alert("글내용을 입력하세요.");
			Write.content.focus(); 
			return false;
			  }
		Write.submit();
	}

</script>
</head>
<body id="main-column">

	<%
	
	request.setCharacterEncoding("euc-kr");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/jspboard ?serverTimezone=UTC&useSSL=false" , "root" , "1234");
	
	String strSQL = "SELECT * FROM tableboard where num =? ";
	
	PreparedStatement pstmt = conn.prepareStatement(strSQL);
	
	pstmt.setString(1, request.getParameter("num"));
	
	ResultSet rs = pstmt.executeQuery();
	
	rs.next();
	
	
	
	%>

	<b> 게시판 글쓰기 </b>
	<table>
		<tr>
			<td>
				<hr size="1" noshade>
			</td>
		</tr>
	</table>

<form name="Write" action="reply_input.jsp" method="post" onsubmit="return Check()">
	<input type="hidden" name="num" value="<%=request.getParameter("num")%>">

	<table border="0" width="700">
		<tr>
			<td width="100" bgcolor="#815854"> 작성자 </td>
			<td> <input type="text" size="12" name="name"> * 필수 </td>
		</tr>
		<tr>
			<td width="100" bgcolor="#815854"> 비밀번호 </td>
			<td> <input type="password" size="12" name="pass"> * 필수 (게시물 수정 삭제시 필요합니다.) </td>
		</tr>
		<tr>
			<td width="100" bgcolor="#815854"> E-mail </td>
			<td> <input type="text" size="40" maxlength="50" name="email"></td>
		</tr>
		<tr>
			<td colspan="2"><hr size="1" noshade></td>
		</tr>
		<tr>
			<td width="100" bgcolor="#815854"> 글 제목 </td>
			<td> <input type="text" size="70" maxlength="50" name="title" value="└[답변]<%=rs.getString("title")%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td width="100" bgcolor="#815854"> 글 내용 </td>
			<td> <textarea rows="15" cols="70" wrap="virtual" name="contents"></textarea> </td>
		</tr>
		<tr>
			<td colspan="2"><hr size="1" noshade></td>
		</tr>
	</table>
	<table>
		<tr>
			<td width="100" align="center">
				<input type="reset" value="다시작성">
			</td>
			<td width="200" align="center">
				<input type="submit" value="등록">
			</td>
		</tr>
		
	</table>
</form>
</body>
</html>