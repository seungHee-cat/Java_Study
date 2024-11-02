<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>title</title>


</head>
<body>
	<tiles:insertAttribute name="body"/>
</body>
</html>

<%--토스트 메시지--%>
<div class="z-index-toast position-fixed top-50 start-50 translate-middle-x p-3" style="visibility: hidden">
    <div id="toast" class="toast align-items-center text-white fw-bolder bg-dark" role="alert" aria-live="polite" aria-atomic="true">
        <div class="d-flex justify-content-center">
			<div class="toast-body"></div>
        </div>
    </div>
</div>