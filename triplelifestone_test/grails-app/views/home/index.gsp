<%@ page import="iq.auth.*" %>
<%

    def navigationGroupTemplate="{title: '_GROUP_', border:false, html: \"_ITEMS_\",icon: '_ICON_'}"
    def navigationItemTemplate="<a id='_CONTROLLER__ACTION_' href='#'><center><img src='/triplelifestone_test/images/_IMAGE_'/><br>_CHN_</center></a>"

    def tplGenerator={String tpl, Map map->
        def result=tpl
        map.each{key,value->
            result=result.replaceAll("_"+key.toString().toUpperCase()+"_",value)
        }
        return result
    }


    def roles = SysUser.findByLogin(session.login).getSysRoles().join(",")
    def authorizationRules=grailsApplication.config.iq.authorizationRules
    def userAuthorizationRules=[]

    authorizationRules.each{
        if(roles.contains(it.key))
        {
            it.value.each{rule->
                userAuthorizationRules << rule
            }
        }
    }

    def isAuthorized={controller,action->
        result=false
        userAuthorizationRules.each{rule->
            rule_controller=rule.controller.replace("*",".*")
            rule_action=rule.action.replace("*",".*")

            if(result ==false && controller==~rule_controller && action==~rule_action) result=true
        }

        return result
    }
    def navigationGroups=[
        [group:'用户管理', icon:'settings', items:[
            [controller: 'contact', action:'Index', chn: '联系人', image: 'group.png']        ,
            [controller: 'sysUser', action:'Index', chn: '用户', image: 'group.png']
        ]]
,
        [group:'系统管理', icon:'settings', items:[
            [controller: 'sysRole', action:'Index', chn: '角色', image: 'group.png']
        ]]
    ]
%>

<html>
<head>
  <title>三生石客户关系管理系统</title>
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
    <script type="text/javascript">
Ext.onReady(function() {
    var viewport = new Ext.Viewport({
        layout: 'border',
        items: [
            new Ext.BoxComponent({
                region: 'north',
                height: 40, // give north and south regions a height
                autoEl: {
                    tag: 'div',
                    html:'<div class="banner">三生石客户关系管理系统</div><div class="topmenu"><iq:logout_link/>&nbsp;个人设置&nbsp;意见反馈</div>'
                }
            }),
            new Ext.BoxComponent({
                region: 'south',
                height: 20, // give north and south regions a height
                autoEl: {
                    tag: 'div',
                    html:'<div id="footer">三生石科技有限公司&#160;&#169;&#160;2012&#160;版权所有<div>'
                }
            }),
            {
                region: 'west',
                id: 'navigation',
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
    def userNavigationGroups=[]
    for (naviGroup in navigationGroups) {
        naviGroup.items.each{item->
            if(isAuthorized(item.controller, item.action))
            {
                userNavigationGroups << naviGroup.group
            }
        }
    }
    userNavigationGroups=userNavigationGroups.unique()
    for (naviGroup in navigationGroups) {
        if(!userNavigationGroups.contains(naviGroup.group)){continue}
        items=[]
        naviGroup.items.each{item->
            if(isAuthorized(item.controller, item.action))
            {
                items << item
            }
        }
        groupItemsHtml=""
        naviGroup.items=items
        naviGroup.items.each{item-> groupItemsHtml=groupItemsHtml+tplGenerator(navigationItemTemplate, item)}

        naviGroup.items=groupItemsHtml

        print tplGenerator(navigationGroupTemplate,naviGroup)

        if(naviGroup.group!=userNavigationGroups[-1])
        {
            println ","
        }else{
            println ""
        }
    }
%>

                ]
            },
            new Ext.TabPanel({
                id: 'tabs',
                region: 'center',
                deferredRender: false,
                height: '100%',
                activeTab: 0,
                items: [{
                    contentEl: 'desktop',
                    title: '我的桌面',
                    closable: false,
                    autoScroll: true
                }]
            })
            ]
        });
        if(Ext.get('contactIndex')!=null){Ext.get('contactIndex').on('click', function(){ addTab('contact','index','联系人管理');});}
        if(Ext.get('sysRoleIndex')!=null){Ext.get('sysRoleIndex').on('click', function(){ addTab('sysRole','index','角色管理');});}
        if(Ext.get('sysUserIndex')!=null){Ext.get('sysUserIndex').on('click', function(){ addTab('sysUser','index','用户管理');});}

});

function sessionCheck(){
    var login='${session.getAt("login")}';

    if(login==null)
    {
        window.location="/triplelifestone_test/auth/logout";
    }
}
function addTab(domain, action, chn) {
    sessionCheck();

    var mainTabPanel = Ext.getCmp('tabs');
    var tp = null;

    if (!mainTabPanel.getComponent(domain+action)) {
        var url ="<iframe src='/triplelifestone_test/"+domain+"/"+action+"' scrolling='false' frameborder='0' style='width:100%; height:100%;overflow:hidden;'/>";
        tp = new Ext.TabPanel({
            header: true,
            iconCls : 'tab',
            margins: '0 0 0 0',
            id : domain+action,
            enableTabScroll : true,
            xtype : 'tabpanel',
            closable : true,
            title : chn,
            html: url,
            scripts: true,
            headerCfg: {cls: 'hideHeader'}
        });
        mainTabPanel.add(tp);
    }
    mainTabPanel.setActiveTab(domain+action);
};
</script>
</head>
<body>
    <div id="desktop" class="x-hide-display">
    <p>这是我的桌面</p>
    </div>
</body>
</html>