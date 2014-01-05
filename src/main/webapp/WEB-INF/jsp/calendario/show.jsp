<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<c:url value="/js/jquery-ui-1.10.3/css/ui-lightness/jquery-ui-1.10.3.custom.min.css"/>">
		<script src="<c:url value="/js/jquery-ui-1.10.3/js/jquery-1.9.1.js"/>" charset="utf-8"></script>
		<script src="<c:url value="/js/jquery-ui-1.10.3/js/jquery-ui-1.10.3.custom.min.js"/>" charset="utf-8"></script>
		
		<title>Calendário</title>
	</head>
	
	<body>
		Dates : ${allowDates}
		<form action="/taglib/list" method="POST">
			Date: <tag:multiDatepicker allowDates="${allowDates}" />
			<input type="submit" value="go"/>
		</form>
	</body>

</html>