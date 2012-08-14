
<%@ page import="business.Company" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'company.label', default: 'Company')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-company" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-company" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'company.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'company.type.label', default: 'Type')}" />
					
						<g:sortableColumn property="settingUpDate" title="${message(code: 'company.settingUpDate.label', default: 'Setting Up Date')}" />
					
						<g:sortableColumn property="summary" title="${message(code: 'company.summary.label', default: 'Summary')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${companyInstanceList}" status="i" var="companyInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${companyInstance.id}">${fieldValue(bean: companyInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: companyInstance, field: "type")}</td>
					
						<td><g:formatDate date="${companyInstance.settingUpDate}" /></td>
					
						<td>${fieldValue(bean: companyInstance, field: "summary")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${companyInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
