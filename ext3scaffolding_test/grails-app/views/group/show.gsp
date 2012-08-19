
<%@ page import="system.Group" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'group.label', default: 'Group')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-group" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-group" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list group">
			
				<g:if test="${groupInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="group.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${groupInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupInstance?.color}">
				<li class="fieldcontain">
					<span id="color-label" class="property-label"><g:message code="group.color.label" default="Color" /></span>
					
						<span class="property-value" aria-labelledby="color-label"><g:fieldValue bean="${groupInstance}" field="color"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupInstance?.isStupid}">
				<li class="fieldcontain">
					<span id="isStupid-label" class="property-label"><g:message code="group.isStupid.label" default="Is Stupid" /></span>
					
						<span class="property-value" aria-labelledby="isStupid-label"><g:formatBoolean boolean="${groupInstance?.isStupid}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupInstance?.age}">
				<li class="fieldcontain">
					<span id="age-label" class="property-label"><g:message code="group.age.label" default="Age" /></span>
					
						<span class="property-value" aria-labelledby="age-label"><g:fieldValue bean="${groupInstance}" field="age"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupInstance?.money}">
				<li class="fieldcontain">
					<span id="money-label" class="property-label"><g:message code="group.money.label" default="Money" /></span>
					
						<span class="property-value" aria-labelledby="money-label"><g:fieldValue bean="${groupInstance}" field="money"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupInstance?.birthday}">
				<li class="fieldcontain">
					<span id="birthday-label" class="property-label"><g:message code="group.birthday.label" default="Birthday" /></span>
					
						<span class="property-value" aria-labelledby="birthday-label"><g:formatDate date="${groupInstance?.birthday}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupInstance?.multiLine}">
				<li class="fieldcontain">
					<span id="multiLine-label" class="property-label"><g:message code="group.multiLine.label" default="Multi Line" /></span>
					
						<span class="property-value" aria-labelledby="multiLine-label"><g:fieldValue bean="${groupInstance}" field="multiLine"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupInstance?.htmlContent}">
				<li class="fieldcontain">
					<span id="htmlContent-label" class="property-label"><g:message code="group.htmlContent.label" default="Html Content" /></span>
					
						<span class="property-value" aria-labelledby="htmlContent-label"><g:fieldValue bean="${groupInstance}" field="htmlContent"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${groupInstance?.id}" />
					<g:link class="edit" action="edit" id="${groupInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
