<%@ page import="business.Company" %>



<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="company.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="32" required="" value="${companyInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="company.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="type" from="${companyInstance.constraints.type.inList}" required="" value="${companyInstance?.type}" valueMessagePrefix="company.type"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'settingUpDate', 'error')} required">
	<label for="settingUpDate">
		<g:message code="company.settingUpDate.label" default="Setting Up Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="settingUpDate" chn="成立时间" precision="day"  value="${companyInstance?.settingUpDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'summary', 'error')} ">
	<label for="summary">
		<g:message code="company.summary.label" default="Summary" />
		
	</label>
	<g:textArea name="summary" cols="40" rows="5" maxlength="1000" value="${companyInstance?.summary}"/>
</div>

