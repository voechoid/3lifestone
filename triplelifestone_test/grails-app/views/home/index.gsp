<%
    def tplGenerator={String tpl, Map map->
        def result=tpl
        map.each{key,value->
            result=result.replaceAll("_"+key.toString().toUpperCase()+"_",value)
        }
        return result
    }

    def navigationGroups =[
            [group: "系统管理", icon:"settings", items:[[name:"sysUser", action:"Index", chn:"用户管理", image:"group.png"],[name:"sysRole", action:"Index", chn:"角色管理", image:"group.png"]]]
    ]

    def navigationGroupTemplate="""
    {title: '_GROUP_', border:false, html: '_ITEMS_',icon: '_ICON_'}
    """.trim()
    def navigationItemTemplate="""
    <a id="_NAME__ACTION_" href="#"><center><img src="/triplelifestone_test/images/_IMAGE_"/><br>_CHN_</center></a>
    """.trim()
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
        border:0 none;
        overflow:hidden;
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
                    def itemsHtml=""
                    navigationGroups[0].items.each{item->
                        itemsHtml=itemsHtml+tplGenerator(navigationItemTemplate,item)
                    }
                    navigationGroups[0].items=itemsHtml
                    def groupHtml=tplGenerator(navigationGroupTemplate,navigationGroups[0])
                    println groupHtml
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
        Ext.get('sysUserIndex').on('click', function(){addTab('sysUser','index','用户管理');});
        Ext.get('sysRoleIndex').on('click', function(){addTab('sysRole','index','角色管理');});
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
        
        SysUser iq.auth.SysUser SysUser<BR>
        SysRole iq.auth.SysRole SysRole<BR>

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