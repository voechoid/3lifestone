
<%@ page import="iq.auth.SysRole" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sysRole.label', default: 'SysRole')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-sysRole" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-sysRole" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'sysRole.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="code" title="${message(code: 'sysRole.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'sysRole.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="enable" title="${message(code: 'sysRole.enable.label', default: 'Enable')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${sysRoleInstanceList}" status="i" var="sysRoleInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${sysRoleInstance.id}">${fieldValue(bean: sysRoleInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: sysRoleInstance, field: "code")}</td>
					
						<td>${fieldValue(bean: sysRoleInstance, field: "description")}</td>
					
						<td><g:formatBoolean boolean="${sysRoleInstance.enable}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${sysRoleInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
