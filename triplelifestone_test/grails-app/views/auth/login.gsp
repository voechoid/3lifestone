<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>系统登录</title>
</head>
<body>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:form action="login">
    <input type="hidden" name="targetUri" value="${targetUri}" />
    <table>
      <tbody>
        <tr>
          <td>用户名称</td>
          <td><input type="text" name="login" value="" /></td>
        </tr>
        <tr>
          <td>密码</td>
          <td><input type="password" name="password" value="" /></td>
        </tr>
        <tr>
          <td />
          <td><input type="submit" value="登录" /></td>
        </tr>
      </tbody>
    </table>
  </g:form>
</body>
</html>
