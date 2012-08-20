
<%@ page import="iq.auth.SysUser" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sysUser.label', default: 'SysUser')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-sysUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-sysUser" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list sysUser">
			
				<g:if test="${sysUserInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="sysUser.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${sysUserInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sysUserInstance?.login}">
				<li class="fieldcontain">
					<span id="login-label" class="property-label"><g:message code="sysUser.login.label" default="Login" /></span>
					
						<span class="property-value" aria-labelledby="login-label"><g:fieldValue bean="${sysUserInstance}" field="login"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sysUserInstance?.password}">
				<li class="fieldcontain">
					<span id="password-label" class="property-label"><g:message code="sysUser.password.label" default="Password" /></span>
					
						<span class="property-value" aria-labelledby="password-label"><g:fieldValue bean="${sysUserInstance}" field="password"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sysUserInstance?.enable}">
				<li class="fieldcontain">
					<span id="enable-label" class="property-label"><g:message code="sysUser.enable.label" default="Enable" /></span>
					
						<span class="property-value" aria-labelledby="enable-label"><g:formatBoolean boolean="${sysUserInstance?.enable}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sysUserInstance?.sysRole}">
				<li class="fieldcontain">
					<span id="sysRole-label" class="property-label"><g:message code="sysUser.sysRole.label" default="Sys Role" /></span>
					
						<g:each in="${sysUserInstance.sysRole}" var="s">
						<span class="property-value" aria-labelledby="sysRole-label"><g:link controller="sysRole" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${sysUserInstance?.id}" />
					<g:link class="edit" action="edit" id="${sysUserInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
