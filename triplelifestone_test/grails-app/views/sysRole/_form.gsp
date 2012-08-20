<%@ page import="iq.auth.SysRole" %>



<div class="fieldcontain ${hasErrors(bean: sysRoleInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="sysRole.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="16" value="${sysRoleInstance?.name}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sysRoleInstance, field: 'code', 'error')} required">
	<label for="code">
		<g:message code="sysRole.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="code" maxlength="16" value="${sysRoleInstance?.code}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sysRoleInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="sysRole.description.label" default="Description" />
		
	</label>
	<g:textField name="description" maxlength="100" value="${sysRoleInstance?.description}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sysRoleInstance, field: 'enable', 'error')} ">
	<label for="enable">
		<g:message code="sysRole.enable.label" default="Enable" />
		
	</label>
	<g:checkBox name="enable" chn="是否启用" value="${sysRoleInstance?.enable}" />
</div>

