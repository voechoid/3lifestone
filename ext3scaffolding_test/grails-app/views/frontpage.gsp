<%
    def navigationGroups=[
        '管理',
        '系统管理'
    ]

    def navigationItems=[
        '管理': """{title: '管理', border:false, html: '<a id="requestmap" href="#"><center><img src="/ext3scaffolding_test/images/group.png"/><br>模型</center></a><a id="company" href="#"><center><img src="/ext3scaffolding_test/images/group.png"/><br>公司</center></a>',iconCls: 'settings'}""",
        '系统管理': """{title: '系统管理', border:false, html: '<a id="user" href="#"><center><img src="/ext3scaffolding_test/images/group.png"/><br>用户</center></a><a id="role" href="#"><center><img src="/ext3scaffolding_test/images/group.png"/><br>角色</center></a>',iconCls: 'settings'}"""
    ]
%>

<html>
<head>
  <title>哈哈客户关系管理系统 -- 3lifestone 提供支持</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<iq:ext_rsc/>
    <style type="text/css">
    html, body {
        font:normal 12px verdana;
        margin:0;
        padding:0;
        border:0 none;
        overflow:hidden;
        height:100%;
    }
    p {
        margin:0px;
    }
    .settings {
        background-image:url(/foundation/ext/resources/icons/fam/folder_wrench.png);
    }
    .nav {
        background-image:url(/foundation/ext/resources/icons/fam/folder_go.png);
    }
    </style>
    <iq:ext_begin />
        
        var viewport = new Ext.Viewport({
            layout: 'border',
            items: [
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
                   println navigationItems[navigationGroups[0]]+','
                   println navigationItems[navigationGroups[1]]
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
                    title: 'Close Me',
                    closable: true,
                    autoScroll: true
                }]
            })
            ]
        });
        Ext.get('requestmap').on('click', function(){addTab('requestmap','模型');});
        Ext.get('role').on('click', function(){addTab('role','角色');});
        Ext.get('user').on('click', function(){addTab('user','用户');});
        Ext.get('company').on('click', function(){addTab('company','公司');});

        function addTab(domain, chn) {
            var mainTabPanel = Ext.getCmp('tabs');
            var tp = null;

            var url ="<iframe src='/ext3scaffolding_test/"+domain+"/index' scrolling='auto' frameborder='0' style='width:100%; height:100%;overflow:hidden;'/>";
            if (!mainTabPanel.getComponent(domain)) {
                tp = new Ext.TabPanel({
                    header: true,
                    iconCls : 'tab',
                    margins: '0 0 0 0',
                    id : domain,
                    enableTabScroll : true,
                    xtype : 'tabpanel',
                    closable : true,
                    title : chn+"管理",
                    html: url,
                    scripts: true,
                    headerCfg: {cls: 'hideHeader'}
                });
                mainTabPanel.add(tp);   
            }
            mainTabPanel.setActiveTab(domain);
        };
    <iq:ext_end />
</head>
<body>
    <!-- use class="x-hide-display" to prevent a brief flicker of the content -->
    <div id="west" class="x-hide-display">
        <p>Hi. I'm the west panel.</p>
    </div>
    <div id="center2" class="x-hide-display">
        <a id="hideit" href="#">Toggle the west region</a>
        <p>My closable attribute is set to false so you can't close me. The other center panels can be closed.</p>
        
        Role auth.Role Role<BR>
        User auth.User User<BR>
        Company business.Company Company<BR>

    </div>
    <div id="center1" class="x-hide-display">
        <p><b>Done reading me? Close me by clicking the X in the top right corner.</b></p>
        <p>Vestibulum semper. Nullam non odio. Aliquam quam. Mauris eu lectus non nunc auctor ullamcorper. Sed tincidunt molestie enim. Phasellus lobortis justo sit amet quam. Duis nulla erat, varius a, cursus in, tempor sollicitudin, mauris. Aliquam mi velit, consectetuer mattis, consequat tristique, pulvinar ac, nisl. Aliquam mattis vehicula elit. Proin quis leo sed tellus scelerisque molestie. Quisque luctus. Integer mattis. Donec id augue sed leo aliquam egestas. Quisque in sem. Donec dictum enim in dolor. Praesent non erat. Nulla ultrices vestibulum quam.</p>
        <p>Duis hendrerit, est vel lobortis sagittis, tortor erat scelerisque tortor, sed pellentesque sem enim id metus. Maecenas at pede. Nulla velit libero, dictum at, mattis quis, sagittis vel, ante. Phasellus faucibus rutrum dui. Cras mauris elit, bibendum at, feugiat non, porta id, neque. Nulla et felis nec odio mollis vehicula. Donec elementum tincidunt mauris. Duis vel dui. Fusce iaculis enim ac nulla. In risus.</p>
        <p>Donec gravida. Donec et enim. Morbi sollicitudin, lacus a facilisis pulvinar, odio turpis dapibus elit, in tincidunt turpis felis nec libero. Nam vestibulum tempus ipsum. In hac habitasse platea dictumst. Nulla facilisi. Donec semper ligula. Donec commodo tortor in quam. Etiam massa. Ut tempus ligula eget tellus. Curabitur id velit ut velit varius commodo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla facilisi. Fusce ornare pellentesque libero. Nunc rhoncus. Suspendisse potenti. Ut consequat, leo eu accumsan vehicula, justo sem lobortis elit, ac sollicitudin ipsum neque nec ante.</p>
        <p>Aliquam elementum mauris id sem. Vivamus varius, est ut nonummy consectetuer, nulla quam bibendum velit, ac gravida nisi felis sit amet urna. Aliquam nec risus. Maecenas lacinia purus ut velit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse sit amet dui vitae lacus fermentum sodales. Donec varius dapibus nisl. Praesent at velit id risus convallis bibendum. Aliquam felis nibh, rutrum nec, blandit non, mattis sit amet, magna. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam varius dignissim nibh. Quisque id orci ac ante hendrerit molestie. Aliquam malesuada enim non neque.</p>
    </div>
    <div id="props-panel" class="x-hide-display" style="width:200px;height:200px;overflow:hidden;">
    </div>
    <div id="south" class="x-hide-display">
        <p>south - generally for informational stuff, also could be for status bar</p>
    </div>
</body>
</html>