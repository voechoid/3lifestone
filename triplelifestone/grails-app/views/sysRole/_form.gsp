<%@ page import="iq.auth.SysRole" %>



<div class="fieldcontain ${hasErrors(bean: sysRoleInstance, field: 'code', 'error')} ">
	<label for="code">
		<g:message code="sysRole.code.label" default="Code" />
		
	</label>
	<g:textField name="code" value="${sysRoleInstance?.code}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sysRoleInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="sysRole.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${sysRoleInstance?.description}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sysRoleInstance, field: 'enable', 'error')} ">
	<label for="enable">
		<g:message code="sysRole.enable.label" default="Enable" />
		
	</label>
	<g:checkBox name="enable" value="${sysRoleInstance?.enable}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sysRoleInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="sysRole.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${sysRoleInstance?.name}" />
</div>

