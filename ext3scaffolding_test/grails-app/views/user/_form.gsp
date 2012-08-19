<%@ page import="auth.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" maxlength="16" value="${userInstance?.username}" />
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'loginname', 'error')} required">
	<label for="loginname">
		<g:message code="user.loginname.label" default="Loginname" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="loginname" maxlength="16" value="${userInstance?.loginname}" />
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" maxlength="16" value="${userInstance?.password}" />
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'enable', 'error')} ">
	<label for="enable">
		<g:message code="user.enable.label" default="Enable" />
		
	</label>
	<g:checkBox name="enable" chn="是否启用" value="${userInstance?.enable}" />
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'role', 'error')} ">
	<label for="role">
		<g:message code="user.role.label" default="Role" />
		
	</label>
	<g:select name="role" from="${auth.Role.list()}" multiple="yes" optionKey="id" size="5" value="${userInstance?.role*.id}" />
</div>

