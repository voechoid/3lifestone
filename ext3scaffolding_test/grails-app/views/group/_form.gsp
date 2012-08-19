<%@ page import="system.Group" %>



<div class="fieldcontain ${hasErrors(bean: groupInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="group.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="16" value="${groupInstance?.name}" />
</div>

<div class="fieldcontain ${hasErrors(bean: groupInstance, field: 'color', 'error')} required">
	<label for="color">
		<g:message code="group.color.label" default="Color" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="color" from="${groupInstance.constraints.color.inList}" value="${groupInstance?.color}" valueMessagePrefix="group.color"  />
</div>

<div class="fieldcontain ${hasErrors(bean: groupInstance, field: 'isStupid', 'error')} ">
	<label for="isStupid">
		<g:message code="group.isStupid.label" default="Is Stupid" />
		
	</label>
	<g:checkBox name="isStupid" chn="傻吗" value="${groupInstance?.isStupid}" />
</div>

<div class="fieldcontain ${hasErrors(bean: groupInstance, field: 'age', 'error')} required">
	<label for="age">
		<g:message code="group.age.label" default="Age" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="age" value="${fieldValue(bean: groupInstance, field: 'age')}" />
</div>

<div class="fieldcontain ${hasErrors(bean: groupInstance, field: 'money', 'error')} required">
	<label for="money">
		<g:message code="group.money.label" default="Money" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="money" value="${fieldValue(bean: groupInstance, field: 'money')}" />
</div>

<div class="fieldcontain ${hasErrors(bean: groupInstance, field: 'birthday', 'error')} required">
	<label for="birthday">
		<g:message code="group.birthday.label" default="Birthday" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="birthday" chn="生日" precision="day" value="${groupInstance?.birthday}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: groupInstance, field: 'multiLine', 'error')} ">
	<label for="multiLine">
		<g:message code="group.multiLine.label" default="Multi Line" />
		
	</label>
	<g:textField name="multiLine" maxlength="100" value="${groupInstance?.multiLine}" />
</div>

<div class="fieldcontain ${hasErrors(bean: groupInstance, field: 'htmlContent', 'error')} ">
	<label for="htmlContent">
		<g:message code="group.htmlContent.label" default="Html Content" />
		
	</label>
	<g:textArea name="htmlContent" cols="40" rows="5" value="${groupInstance?.htmlContent}" />
</div>

