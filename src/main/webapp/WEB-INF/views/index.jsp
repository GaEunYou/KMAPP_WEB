<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%-- header --%>
<%@include file="common/header.jsp"%>

<body>
    <div class="main">
        <div class="main-inner">
            <h1 class="logo"><a href="#"><img src="resources/img/logo/logo02.png" alt="책임운영기관 국립기상과학원"></a></h1>
            <span class="maintle">웹기반 KMAPP 사용자 분석・예측 시스템</span>
            <ul>
                <li id="left">
                    <a href="kmapp">
                        <div class="thumb" style="top:65px;"></div>
                        <strong>분석 시스템</strong>
                    </a>
                </li>
                <li id="right">
                    <a href="dnsc">
                        <div class="thumb"></div>
                        <strong>예측 시스템</strong>
                    </a>
                </li>
            </ul>
        </div>

        <%-- footer --%>
        <%@include file="common/footer.jsp"%>
    </div>
</body>
</html>
