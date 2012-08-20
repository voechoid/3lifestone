<%@ page import="iq.auth.SysUser" %>



<div class="fieldcontain ${hasErrors(bean: sysUserInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="sysUser.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="16" value="${sysUserInstance?.name}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sysUserInstance, field: 'login', 'error')} required">
	<label for="login">
		<g:message code="sysUser.login.label" default="Login" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="login" maxlength="16" value="${sysUserInstance?.login}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sysUserInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="sysUser.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" maxlength="16" value="${sysUserInstance?.password}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sysUserInstance, field: 'enable', 'error')} ">
	<label for="enable">
		<g:message code="sysUser.enable.label" default="Enable" />
		
	</label>
	<g:checkBox name="enable" chn="是否启用" value="${sysUserInstance?.enable}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sysUserInstance, field: 'sysRole', 'error')} ">
	<label for="sysRole">
		<g:message code="sysUser.sysRole.label" default="Sys Role" />
		
	</label>
	<g:select name="sysRole" from="${iq.auth.SysRole.list()}" multiple="yes" optionKey="id" size="5" value="${sysUserInstance?.sysRole*.id}" />
</div>

