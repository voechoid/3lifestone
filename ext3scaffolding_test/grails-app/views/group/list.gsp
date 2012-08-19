
<%@ page import="system.Group" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'group.label', default: 'Group')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-group" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-group" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'group.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="color" title="${message(code: 'group.color.label', default: 'Color')}" />
					
						<g:sortableColumn property="isStupid" title="${message(code: 'group.isStupid.label', default: 'Is Stupid')}" />
					
						<g:sortableColumn property="age" title="${message(code: 'group.age.label', default: 'Age')}" />
					
						<g:sortableColumn property="money" title="${message(code: 'group.money.label', default: 'Money')}" />
					
						<g:sortableColumn property="birthday" title="${message(code: 'group.birthday.label', default: 'Birthday')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${groupInstanceList}" status="i" var="groupInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${groupInstance.id}">${fieldValue(bean: groupInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: groupInstance, field: "color")}</td>
					
						<td><g:formatBoolean boolean="${groupInstance.isStupid}" /></td>
					
						<td>${fieldValue(bean: groupInstance, field: "age")}</td>
					
						<td>${fieldValue(bean: groupInstance, field: "money")}</td>
					
						<td><g:formatDate date="${groupInstance.birthday}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${groupInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
