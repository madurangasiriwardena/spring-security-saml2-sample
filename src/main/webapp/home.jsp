<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="org.opensaml.xml.util.XMLHelper" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.saml.SAMLCredential" %>
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
    } else {
        pageContext.removeAttribute("authentication");
        pageContext.removeAttribute("credential");
        pageContext.removeAttribute("assertion");
    }
%>

<body class="sticky-footer" style="background-color:#efefef;">
<br>
<div class="page-content-wrapper">
    <div class="container">
        <div class="login-form-wrapper">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                    <div class="brand-container add-margin-bottom-5x">
                        <h3 class="text-center-sm text-center-xs text-center-md text-right">Welcome to </h3>

                        <h2 class="text-center-sm text-center-xs text-center-md text-right">Spring SAML</h2>

                        <p class="text-center-sm text-center-xs text-center-md text-right">Powered by</p>

                        <div class="row">
                            <div class="col-xs-6 col-sm-3 col-md-9 col-lg-9 center-block float-remove-sm float-remove-xs pull-right-md pull-right-lg">
                                <img class="img-responsive brand-spacer" src="theme/img/IS.png"
                                     alt="wso2-Identity-server">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9 login">
                    <div class="data-container">
                        <c:if test="${empty authentication}">
                            <h3>Sign in to view photos</h3>
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-12 col-md-5 col-lg-5">
                                    <p><a href="saml/login">Sign In</a></p>
                                </div>
                            </div>
                        </c:if>
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-5 col-lg-10 add-margin-top-3x">
                                <comment>This is a small description about the sample. This may give a
                                    beif explanation on what this sample is about
                                </comment>
                                <p><a href="http://google.lk">Read more</a></p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-5 col-lg-10 add-margin-top-3x">
                                <comment>Download metadata for this application</comment>
                                <p><a href="saml/metadata">Click here</a></p>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<!-- /#page-content-wrapper -->

<!-- footer -->
<footer class="footer">
    <div class="container-fluid">
        <p>
            WSO2 | &copy;
            <script>document.write((new Date().getFullYear()).toString());</script>
            <a href="http://wso2.com/" target="_blank"><i class="icon fw fw-wso2"></i> Inc</a>.
        </p>
    </div>
</footer>

<!-- Jquery/Jquery UI JS -->
<script src="libs/jquery/jquery.min.js"></script>
<script src="libs/bootstrap/js/bootstrap.min.js"></script>
<!-- Theme WSO2 JS -->
<script src="theme/js/theme-wso2.min.js"></script>
<script>
    $('.login-form-wrapper').parents('body').addClass('background-grey');
</script>

</body>
</html>
