<%@ page import="auth.Role" %>



<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="role.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="16" value="${roleInstance?.name}" />
</div>

<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'code', 'error')} required">
	<label for="code">
		<g:message code="role.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="code" maxlength="16" value="${roleInstance?.code}" />
</div>

<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="role.description.label" default="Description" />
		
	</label>
	<g:textField name="description" maxlength="100" value="${roleInstance?.description}" />
</div>

<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'enable', 'error')} ">
	<label for="enable">
		<g:message code="role.enable.label" default="Enable" />
		
	</label>
	<g:checkBox name="enable" chn="是否启用" value="${roleInstance?.enable}" />
</div>

