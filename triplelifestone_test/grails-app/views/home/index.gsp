<%
    def navigationGroups=[
        '系统管理'
    ]

    def navigationItems=[
        '系统管理': """{title: '系统管理', border:false, html: '<a id="sysUserProfile" href="#"><center><img src="/triplelifestone_test/images/group.png"/><br>个人信息</center></a><a id="sysUserIndex" href="#"><center><img src="/triplelifestone_test/images/group.png"/><br>用户</center></a><a id="sysRoleIndex" href="#"><center><img src="/triplelifestone_test/images/group.png"/><br>角色</center></a>',iconCls: 'settings'}"""
    ]
%>

<html>
<head>
  <title>哈哈客户关系管理系统</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<iq:ext_rsc/>
    <style type="text/css">
    html, body {
        font:normal 12px verdana;
        margin:0;
        padding:0;
        height:100%;
    }
    p {
        margin:0px;
    }
    .settings {
        background-image:url(/triplelifestone_test/images/skin/small.png);
    }
    </style>
    <iq:ext_begin />
        var viewport = new Ext.Viewport({
            layout: 'border',
            items: [
            {
                region: 'north',
                contentEl: 'header_box',
                height: 42
            },
            {
                region: 'south',
                contentEl: 'footer',
                height: 18
            },
            {
                region: 'west',
                id: 'west',
                title: '功能导航',
                split: true,
                width: 150,
                minSize: 150,
                maxSize: 250,
                collapsible: false,
                margins: '0 0 0 5',
                layout: {
                    type: 'accordion',
                    animate: true
                },
                items: [
<%
                   println navigationItems[navigationGroups[0]]
              %>

                ]
            },
            new Ext.TabPanel({
                id: 'tabs',
                region: 'center',
                deferredRender: false,
                activeTab: 0,
                items: [{
                    contentEl: 'center1',
                    title: '我的桌面',
                    closable: false,
                    autoScroll: true
                }]
            })
            ]
        });

        Ext.get('sysUserProfile').on('click', function(){addTab('sysUser','profile','个人信息');});
        Ext.get('sysUserIndex').on('click', function(){addTab('sysUser','index','用户管理');});
        Ext.get('sysRoleIndex').on('click', function(){addTab('sysRole','index','角色管理');});

    <iq:ext_end />
</head>
<body>
    <!-- use class="x-hide-display" to prevent a brief flicker of the content -->
    <div id="header_box" class="header_box">
        <div class="banner">福建富士通信息软件有限公司</div><div class="topmenu">个人设置&nbsp;意见反馈</div>
    </div>

    <div id="footer">
        <p><center></font>三生石科技版权所有 2012-2012</center></p>
    </div>
    <div id="center1" class="x-hide-display">
        <p><b>放置、代办事项、日程、通信录等元素</b></p>
    </div>
</body>
</html>