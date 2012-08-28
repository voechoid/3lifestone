function addTab(domain, action, chn) {
    var login=${session.name}";
    Ext.Msg.alert('login',login);

    if(login!=null)
    {
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
    }else{
        window.location= "triplelifestone_test/auth/logout";
    }
};