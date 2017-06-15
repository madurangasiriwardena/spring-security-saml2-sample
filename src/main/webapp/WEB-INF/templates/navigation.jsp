<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="header header-default">
    <div class="container-fluid">
        <div class="pull-left brand">
            <a href="#">
                <img src="theme/img/logo-inverse.svg" alt="wso2" title="wso2" class="logo">
                <span> Sample Name </span>
            </a>
        </div>
        <ul class="nav navbar-right">
            <li class="visible-inline-block">
                <a class="dropdown" data-toggle="dropdown" aria-expanded="false">
                       <span class="icon fw-stack">
                          <i class="fw fw-circle fw-stack-2x"></i>
                          <i class="fw fw-user fw-stack-1x fw-inverse"></i>
                       </span>
                    <span class="hidden-xs add-margin-left-1x">${authentication.name}<span
                            class="caret"></span></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-right slideInDown" role="menu">
                    <li>Welcome ${authentication.name}</li>
                    <li><a href="profile.jsp">Profile</a></li>
                    <li><a href="saml/logout">Logout</a></li>
                </ul>
            </li>
        </ul>
    </div>
</header>