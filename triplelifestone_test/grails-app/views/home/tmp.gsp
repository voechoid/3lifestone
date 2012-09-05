<%--
  Created by IntelliJ IDEA.
  User: bruce_lin_chn
  Date: 12-9-5
  Time: 下午5:24
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title></title>
</head>
<script type="text/javascript">
    function session_check()
    {
        var login='${session.getAttribute("login")}';
        alert(login);
    }

    session_check();
</script>

<body>

</body>
</html>