<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="org.opensaml.saml2.core.Attribute" %>
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

<body class="sticky-footer">

<jsp:include page="/WEB-INF/templates/navigation.jsp"/>

<%
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    SAMLCredential credential = (SAMLCredential) authentication.getCredentials();
    pageContext.setAttribute("authentication", authentication);
    pageContext.setAttribute("credential", credential);
    pageContext.setAttribute("assertion", XMLHelper.nodeToString(SAMLUtil.marshallMessage(credential.getAuthenticationAssertion())));
%>

<div class="breadcrumb-wrapper">
    <ol class="breadcrumb">
        <li><a href="home.jsp"><i class="icon fw fw-home"></i> <span class="hidden-xs">Home</span></a></li>
        <li class="active">Sign up</li>
    </ol>
</div>

<!--content-->
<div class="page-content-wrapper">

    <!-- /#page-content-wrapper -->
    <div class="container-fluid">
        <div class="body-wrapper" ng-app="DeploymentMonitor"  ng-controller="AppCtrl" ng-cloak ng-init="getTasks()">

        <h3 class="page-header">General information</h3>
        
    <form class="form-horizontal" role="form">
        <div class="form-group">
            <label class="col-sm-3 control-label">Name:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out value="${authentication.name}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">Principal:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out value="${authentication.principal}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">Name ID:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out value="${credential.nameID.value}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">IDP:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out value="${credential.authenticationAssertion.issuer.value}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">Assertion issue time:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out value="${credential.authenticationAssertion.issueInstant}"/>" maxlength="250" readonly>
            </div>
        </div>

        <c:if test="${not empty credential}">
            <h3 class="page-header">Principal's SAML attributes</h3>
                <c:forEach var="attribute" items="${credential.attributes}">
                    <div class="form-group">
                        <label class="col-sm-3 control-label"><c:out value="${attribute.name}"/></strong><c:if
                                test="${not empty attribute.friendlyName}"> (<c:out value="${attribute.friendlyName}"/>)</c:if></label>
                        <%
                            Attribute a = (Attribute) pageContext.getAttribute("attribute");
                            String[] attributeValues = credential.getAttributeAsStringArray(a.getName());
                            pageContext.setAttribute("attributeValues", attributeValues);
                        %>
                        <c:forEach var="attributeValue" items="${attributeValues}">
                            <div class="col-sm-9">
                                <input type="text" class="form-control" value="<c:out value="${attributeValue}"/>" maxlength="250" readonly>
                            </div>
                        </c:forEach>
                    </div>
                </c:forEach>
        </c:if>

        <h3 class="page-header">Subject confirmation</h3>
        <div class="form-group">
            <label class="col-sm-3 control-label">Method:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out
                        value="${credential.authenticationAssertion.subject.subjectConfirmations[0].method}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">In response to:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out
                        value="${credential.authenticationAssertion.subject.subjectConfirmations[0].subjectConfirmationData.inResponseTo}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">Not on or after:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out
                        value="${credential.authenticationAssertion.subject.subjectConfirmations[0].subjectConfirmationData.notOnOrAfter}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">Recipient:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out
                        value="${credential.authenticationAssertion.subject.subjectConfirmations[0].subjectConfirmationData.recipient}"/>" maxlength="250" readonly>
            </div>
        </div>

        <h3 class="page-header">Authentication statement</h3>
        <div class="form-group">
            <label class="col-sm-3 control-label">Authentication instance:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out
                        value="${credential.authenticationAssertion.authnStatements[0].authnInstant}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">Session validity:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out
                        value="${credential.authenticationAssertion.authnStatements[0].sessionNotOnOrAfter}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">Authentication context class:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out
                        value="${credential.authenticationAssertion.authnStatements[0].authnContext.authnContextClassRef.authnContextClassRef}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">Session index:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out
                        value="${credential.authenticationAssertion.authnStatements[0].sessionIndex}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">Subject locality:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out
                        value="${credential.authenticationAssertion.authnStatements[0].subjectLocality.address}"/>" maxlength="250" readonly>
            </div>
        </div>

        <h3 class="page-header">Conditions</h3>
        <div class="form-group">
            <label class="col-sm-3 control-label">Not before:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out value="${credential.authenticationAssertion.conditions.notBefore}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">Not on or after:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" value="<c:out
                        value="${credential.authenticationAssertion.conditions.notOnOrAfter}"/>" maxlength="250" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">Audience restriction:</label>

            <c:forEach var="audience"
                       items="${credential.authenticationAssertion.conditions.audienceRestrictions[0].audiences}">
                <div class="col-sm-9">
                    <input type="text" class="form-control" maxlength="250"  readonly value="<c:out
                            value="${audience.audienceURI}"/>">
                </div>
            </c:forEach>
        </div>

    </form>

    <!-- end of form elements -->        
    </div>
    </div>
</div><!-- /#page-content-wrapper -->

<!-- Jquery/Jquery UI JS -->
<script src="libs/jquery/jquery.min.js"></script>
<script src="libs/bootstrap/js/bootstrap.min.js"></script>
<!-- Theme WSO2 JS -->
<script src="theme/js/theme-wso2.min.js"></script>

<footer class="footer">
    <div class="container-fluid">
        <p>WSO2 | &copy; 2016 <a href="http://wso2.com/" target="_blank"><i class="icon fw fw-wso2"></i> Inc</a>.</p>
    </div>
</footer>

</body>
</html>
