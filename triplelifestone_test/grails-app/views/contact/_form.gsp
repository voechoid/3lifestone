<%@ page import="com.triplelifestone.Contact" %>



<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="contact.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="16" value="${contactInstance?.name}" />
</div>

<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="contact.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="email" value="${contactInstance?.email}" />
</div>

<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'mobile', 'error')} required">
	<label for="mobile">
		<g:message code="contact.mobile.label" default="Mobile" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="mobile" maxlength="11" value="${contactInstance?.mobile}" />
</div>

<div class="fieldcontain ${hasErrors(bean: contactInstance, field: 'birthday', 'error')} required">
	<label for="birthday">
		<g:message code="contact.birthday.label" default="Birthday" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="birthday" chn="生日" precision="day" value="${contactInstance?.birthday}"  />
</div>

