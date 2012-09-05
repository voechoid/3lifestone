<%
	import org.codehaus.groovy.grails.commons.GrailsClassUtils
	def application = org.codehaus.groovy.grails.commons.ApplicationHolder.application
	def applicationName=application.metadata['app.name']
	print "<"
	println "%"
    println """
    def navigationGroupTemplate="{title: '_GROUP_', border:false, html: \\\"_ITEMS_\\\",icon: '_ICON_'}"
    def navigationItemTemplate="<a id='_NAME__ACTION_' href='#'><center><img src='/${applicationName}/images/_IMAGE_'/><br>_CHN_</center></a>"
    def tplGenerator={String tpl, Map map->
        def result=tpl
        map.each{key,value->
            result=result.replaceAll("_"+key.toString().toUpperCase()+"_",value)
        }
        return result
    }
    """

    println "    def navigationGroups=["

	//找出带有导航菜单标志的Domain Classes
	def navigatableDomains=[]
	application.getArtefacts("Domain").each{domainClass->
		iqNavigation=GrailsClassUtils.getStaticPropertyValue(domainClass.clazz, "iqNavigation")
		if(iqNavigation!=null)
		{
			navigatableDomains.add(domainClass)
		}
	}

	//找出不重复的导航菜单组名称
	def groups=(navigatableDomains*.clazz.iqNavigation["group"]).unique()
    for(group in groups)
    {
		println "        [group:'"+group+"', icon:'settings', items:["
        def weightsOfGroup=(navigatableDomains*.clazz.iqNavigation["weight"]).unique().sort()

        def groupOfDomains=[]
        for(domain in navigatableDomains)
        {
            if(group==domain.clazz.iqNavigation.group)
            {
                groupOfDomains << domain
            }
        }

        def groupDomainsCounter=0

        for(weight in weightsOfGroup)
        {

            for(domain in groupOfDomains)
            {
                if(group==domain.clazz.iqNavigation.group && weight==domain.clazz.iqNavigation.weight)
                {
                    groupDomainsCounter=groupDomainsCounter+1
                    name=domain.clazz.name.toString().tokenize('.')[-1][0].toLowerCase()+domain.clazz.name.toString().tokenize('.')[-1][1..-1]
                    chn=domain.clazz.iqDomain.chn
                    action="index"
                    print "    "*3
                    print "[name: '$name', action:'Index', chn: '$chn', image: 'group.png']"

                    if(groupDomainsCounter!=groupOfDomains.size())
                    {
                        println "        ,"
                    }else{
                        println ""
                    }
                }
            }
        }

        println "        ]]"

        if(group!=groups[-1])
        {
            println ","
        }
	}
    println "    ]"
	print "%"
	println ">"
%>
<html>
<head>
  <title>${application.config.iq.app.name}</title>
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
        background-image:url(/${applicationName}/images/skin/small.png);
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
                    html:'<div class="banner">${application.config.iq.app.banner}</div><div class="topmenu"><iq:logout_link/>&nbsp;个人设置&nbsp;意见反馈</div>'
                }
            }),
            new Ext.BoxComponent({
                region: 'south',
                height: 20, // give north and south regions a height
                autoEl: {
                    tag: 'div',
                    html:'<div id="footer">${application.config.iq.app.footer}<div>'
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
                        print "<"
                        print "%"
    println """
    for (naviGroup in navigationGroups) {
        def groupItemsHtml=""
        naviGroup.items.each{item-> groupItemsHtml=groupItemsHtml+tplGenerator(navigationItemTemplate, item)}
        naviGroup.items=groupItemsHtml
        print tplGenerator(navigationGroupTemplate,naviGroup)
        if(naviGroup!=navigationGroups[-1])
        {
            println ","
        }else{
            println ""
        }
    }"""
                        print "%"
                        println ">" %>
                ]
            },
            new Ext.TabPanel({
                id: 'tabs',
                region: 'center',
                deferredRender: false,
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
<%
            navigatableDomains.each{domain->

                    domainName=domain.clazz.name.toString().tokenize('.')[-1][0].toLowerCase()+domain.clazz.name.toString().tokenize('.')[-1][1..-1]
                    domainChn=domain.clazz.iqDomain.chn
                    println "        Ext.get('${domainName}Index').on('click', function(){ addTab('${domainName}','index','${domainChn}管理');});"
            
            }
%>
});
function addTab(domain, action, chn) {
    var login='\${session.name?session.name:"NO_AUTH"}';
    if(login!="NO_AUTH")
    {
        var mainTabPanel = Ext.getCmp('tabs');
        var tp = null;

        if (!mainTabPanel.getComponent(domain+action)) {
            var url ="<iframe src='/${applicationName}/"+domain+"/"+action+"' scrolling='false' frameborder='0' style='width:100%; height:100%;overflow:hidden;'/>";
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
    }else{
        window.location= "/${applicationName}/auth/logout";
    }
};
</script>
</head>
<body>
    <div id="desktop" class="x-hide-display">
    <p>这是我的桌面</p>
    </div>
</body>
</html>