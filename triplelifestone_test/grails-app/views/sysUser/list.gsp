
<%@ page import="iq.auth.SysUser" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sysUser.label', default: 'SysUser')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-sysUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-sysUser" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'sysUser.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="login" title="${message(code: 'sysUser.login.label', default: 'Login')}" />
					
						<g:sortableColumn property="password" title="${message(code: 'sysUser.password.label', default: 'Password')}" />
					
						<g:sortableColumn property="enable" title="${message(code: 'sysUser.enable.label', default: 'Enable')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${sysUserInstanceList}" status="i" var="sysUserInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${sysUserInstance.id}">${fieldValue(bean: sysUserInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: sysUserInstance, field: "login")}</td>
					
						<td>${fieldValue(bean: sysUserInstance, field: "password")}</td>
					
						<td><g:formatBoolean boolean="${sysUserInstance.enable}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${sysUserInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
