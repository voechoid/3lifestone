
<%@ page import="auth.Role" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-role" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-role" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'role.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="code" title="${message(code: 'role.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'role.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="enable" title="${message(code: 'role.enable.label', default: 'Enable')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${roleInstanceList}" status="i" var="roleInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${roleInstance.id}">${fieldValue(bean: roleInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: roleInstance, field: "code")}</td>
					
						<td>${fieldValue(bean: roleInstance, field: "description")}</td>
					
						<td><g:formatBoolean boolean="${roleInstance.enable}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${roleInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
