<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.saml.SAMLCredential" %>
<%@ page import="org.opensaml.xml.util.XMLHelper" %>
<%@ page import="org.springframework.security.saml.util.SAMLUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp"/>

<%
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    if (authentication != null) {
        SAMLCredential credential = (SAMLCredential) authentication.getCredentials();
        pageContext.setAttribute("authentication", authentication);
        pageContext.setAttribute("credential", credential);
        pageContext.setAttribute("assertion", XMLHelper.nodeToString(SAMLUtil.marshallMessage(credential.getAuthenticationAssertion())));
        session.setAttribute("authentication", authentication);
    } else {
        pageContext.removeAttribute("authentication");
        pageContext.removeAttribute("credential");
        pageContext.removeAttribute("assertion");
    }
%>

<body class="sticky-footer">

<jsp:include page="/WEB-INF/templates/navigation.jsp"/>

<div class="breadcrumb-wrapper">
    <ol class="breadcrumb">
        <li><a href="home.jsp"><i class="icon fw fw-home"></i> <span class="hidden-xs">Home</span></a></li>
        <li class="active">Images</li>
    </ol>
</div>

<!--content-->
<div class="page-content-wrapper">

    <!-- /#page-content-wrapper -->
    <div class="container-fluid">
        <div class="body-wrapper" ng-app="DeploymentMonitor"  ng-controller="AppCtrl" ng-cloak ng-init="getTasks()">

        <h1 class="page-header">Images</h1>
        <img src="sampleImages/sampleImage1.jpg" alt="" width="32%">
        <img src="sampleImages/sampleImage2.jpg" alt="" width="32%">
        <img src="sampleImages/sampleImage4.jpg" alt="" width="32%">
		
    <!-- end of form elements -->        
    </div>
    </div>
</div><!-- /#page-content-wrapper -->

<!-- Jquery/Jquery UI JS -->
<script src="libs/jquery/jquery.min.js"></script>
<script src="libs/bootstrap/js/bootstrap.min.js"></script>
<!-- Theme WSO2 JS -->
<script src="theme/js/theme-wso2.min.js"></script>

<jsp:include page="/WEB-INF/templates/footer.jsp"/>

</body>
</html>
