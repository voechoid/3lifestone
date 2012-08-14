/*************************************************
Copyright by www.3lifestone.com, all rights reserved.
**************************************************
模型: voechoid
作者: voechoid@qq.com
*************************************************/

<% import grails.persistence.Event %><% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %><%=packageName%>
<%
    GRID_MAX_FIELDS=12
    grailsApplication=org.codehaus.groovy.grails.commons.ApplicationHolder.application
    appName=grailsApplication.metadata['app.name']
    
    iqConstraints=domainClass.getConstrainedProperties()
    
    iqDomainClass=[:]
    
    iqDomainClass.iqDomain=domainClass.clazz.iqDomain
	iqLayout=domainClass.clazz.iqLayout

    iqDomainClass.properties=[]

    excludedProps = Event.allEvents.toList() << 'version'<< 'id'
    allowedNames = domainClass.persistentProperties*.name  << 'dateCreated' << 'lastUpdated'
    props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name)}
    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))

    for( p in props)
    {
        def map=[:]

        if (p.name == 'version' || p.name=='id'){continue}

        if(p.name=='dateCreated' || p.name=='lastUpdated')
        {
            if(p.name=='dateCreated')
            {
                map.chn = '创建时间'    
            }else{
                map.chn = '最近更新'
            }

            map.display=true
            map.association = false
            map.display=true
            
        }else if(p.isAssociation())
        {
            map.chn = p.getReferencedDomainClass().clazz.iqDomain.chn
            map.association = true
            map.display=true
            map.referenceName=p.getReferencedDomainClass()?.getLogicalPropertyName()
            map.bidirectional=p.isBidirectional()
            map.owningSide=p.isOwningSide()
        }else {
            map.chn = iqConstraints[p.name].attributes.chn
            map.widget = iqConstraints[p.name].attributes.widget
            map.association = false
            map.display=iqConstraints[p.name].display? iqConstraints[p.name].display : true
        }

        map.last = false
        map.name = p.name
        map.p=p

        iqDomainClass.properties << map

    }

    iqDomainClass.properties[-1].last=true

    def output(prop,mode)
    {
        def cp=iqConstraints[prop.name]
        def p=prop.p
        
        out << "    "*3
        if (cp.inList != null)
        {
            out << "{fieldLabel: '${prop.chn}',name: '${prop.name}',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:["
            for(int j=0;j<cp.inList.size();j++)
            {
                out << "['${cp.inList[j]}']"
                if(j< cp.inList.size()-1)
                {
                    out << ","
                }
            }
            out <<"]}), emptyText:'请选择${prop.chn}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'"
        } else if (p.type == String.class) {
	        out << "{fieldLabel: '${prop.chn}',name: '${p.name}',xtype: '${cp.attributes.widget?cp.attributes.widget:'textfield'}'"

            if (cp.blank != true) {
                out << ", allowBlank: false, blankText: '${prop.chn}为必填项'"
            }
            if (cp.maxSize != null) {
                out << ", maxLength: ${cp.maxSize}, maxLengthText: '${prop.chn}至多包含${cp.maxSize}个字符'"
            }
            if (cp.minSize != null) {
                out << ", minLength: ${cp.minSize}, minLengthText: '${prop.chn}至少包含${cp.minSize}个字符'"
            }
        } else if (p.type == Date.class) {
            if(cp.attributes.widget!="timefield"){
                out << "{fieldLabel: '${prop.chn}',name: '${p.name}',xtype:'datefield',format:'Y-m-d'"
            }else{
                out << "{fieldLabel: '${prop.chn}',name: '${p.name}',xtype:'timefield',format:'H:i'"
            }
        }else if (p.type == int) {
            out << "{fieldLabel: '${prop.chn}',name: '${p.name}',xtype:'numberfield'"
        }else if (p.type == float) {
            out << "{fieldLabel: '${prop.chn}',name: '${p.name}',xtype:'numberfield',allowDecimals:true"
        }else if (p.type == boolean){
            out << "{boxLabel: '${prop.chn}',name: '${p.name}',xtype:'checkbox'"
        }else if(p.isAssociation()){
            if(p.isOneToOne() || p.isManyToOne())
            {
                out << "{fieldLabel: '${prop.chn}',name: '_${prop.name}',hiddenName: '${prop.name}',xtype: 'combo',triggerAction: 'all', forceSelection: true, editable: false, valueField: 'id', displayField: 'value',emptyText:'请选择${prop.chn}', mode: 'remote', store: ${prop.referenceName}Store"

            }else if(p.isOneToMany() || p.isManyToMany())
            {
                out << "{name:'${prop.name}', fieldLabel: '${prop.chn}', xtype: 'multiselect', dataFields: ['id','value'],valueField: 'id', displayField: 'value', store: ${prop.referenceName}Store"
            }
        }else{
            println p
        }

        if("detail".compareTo(mode)==0){ out << ", readOnly:true" }
        out << "}"
        
        if (prop.last == false) {
            println ","
        }else{
            println ""
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <iq:ext_rsc/>
        <title>${iqDomainClass.iqDomain.chn}管理</title>
    </head>
	<body>
        <div id="${domainClass.propertyName}Toolbar"></div>
        <div id="${domainClass.propertyName}Grid"></div>
        <div id="${domainClass.propertyName}CreateWin"></div>
        <div id="${domainClass.propertyName}UpdateWin"></div>
        <div id="${domainClass.propertyName}DetailWin"></div>
    </body>
    <iq:ext_begin/>
    Ext.QuickTips.init();
<%
	for(prop in iqDomainClass.properties)
    {

    	if (prop.display && prop.association)
        {
            println "    var ${prop.referenceName}Store=new Ext.data.JsonStore({url: '/${appName}/${prop.referenceName}/associationListJSON', fields:['id', 'value'],  root: 'root', totalProperty: 'total'});"
		}
		
	}
%>
    var ${domainClass.propertyName}CreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/${appName}/${domainClass.propertyName}/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
<%
    for(prop in iqDomainClass.properties)
    {
        if (prop.display)
        {
            output(prop,"create")
        }
    }
%>
        ]
    });

    var ${domainClass.propertyName}CreateWin = new Ext.Window({
        el: '${domainClass.propertyName}CreateWin',
        closable:false,
        layout: 'fit',
        width:400,
        title:'创建${iqDomainClass.iqDomain.chn}',
        height:300,
        layout:'anchor',
		autoScroll:true,
		border:false,
        modal:true,
		closeAction: 'hide',
        items: [${domainClass.propertyName}CreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    ${domainClass.propertyName}CreateForm.getForm().submit({
                        success:function(${domainClass.propertyName}CreateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            ${domainClass.propertyName}CreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.fading_msg.msg('错误', "创建${iqDomainClass.iqDomain.chn}失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    ${domainClass.propertyName}CreateWin.hide();
                }
            }
        ]
    });

    var ${domainClass.propertyName}UpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/${appName}/${domainClass.propertyName}/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
<%
    for(prop in iqDomainClass.properties)
    {
        if (prop.display)
        {
            output(prop,"update")
        }
    }
%>
        ]
    });

    var ${domainClass.propertyName}UpdateWin = new Ext.Window({
        el: '${domainClass.propertyName}UpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改${iqDomainClass.iqDomain.chn}',
        height: 300,
        layout:'anchor',
		autoScroll:true,
		border:false,
		modal:true,
		closeAction: 'hide',
        items: [${domainClass.propertyName}UpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    ${domainClass.propertyName}UpdateForm.getForm().submit({
                        success:function(${domainClass.propertyName}UpdateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            ${domainClass.propertyName}UpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.fading_msg.msg('错误', "更新${iqDomainClass.iqDomain.chn}失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    ${domainClass.propertyName}UpdateWin.hide();
                }
            }
        ]
    });

    var ${domainClass.propertyName}DetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/${appName}/${domainClass.propertyName}/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
<%
    for(prop in iqDomainClass.properties)
    {
        if (prop.display)
        {
            output(prop,"detail")
        }
    }
%>        ]
    });

    var ${domainClass.propertyName}DetailWin = new Ext.Window({
        el: '${domainClass.propertyName}DetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '${iqDomainClass.iqDomain.chn}明细',
        height: 300,
        layout:'anchor',
		autoScroll:true,
		border:false,
		modal:true,
		closeAction: 'hide',
        items: [${domainClass.propertyName}DetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    ${domainClass.propertyName}DetailWin.hide();
                }
            }
        ]
    });

    var tb = new Ext.Toolbar();
    tb.render('${domainClass.propertyName}Toolbar');

    tb.add({
        text: '新建',
        icon: '/${appName}/images/skin/database_add.png',
        handler:function() {
<%
	for(prop in iqDomainClass.properties)
    {

    	if (prop.display && prop.association)
        {
			println "            ${prop.referenceName}Store.reload();"
		}

	}
%>
            ${domainClass.propertyName}CreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/${appName}/images/skin/database_edit.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.fading_msg.msg('注意', "请选择要修改的记录");
            }else{
                ${domainClass.propertyName}UpdateForm.getForm().load({
                    url:'/${appName}/${domainClass.propertyName}/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
<%
	for(prop in iqDomainClass.properties)
    {

    	if (prop.display && prop.association)
        {
			println "                ${prop.referenceName}Store.reload();"
		}
		
	}
%>
                ${domainClass.propertyName}UpdateWin.show();
            }
        }
    }, {
        text: '删除',
        icon: '/${appName}/images/skin/database_delete.png',
        handler: function() {
            var count = sm.getCount();
            if (count == 0) {
                Ext.fading_msg.msg('注意', "请选择要删除的记录");
            } else {
                var records = sm.getSelections();
                var id = [];
                for (var i = 0; i < count; i++) {
                    id.push(records[i].id);
                }
                Ext.MessageBox.confirm('信息', '您确定删除编号为' + id + '的记录吗?', function(btn) {
                    if (btn == 'yes') {
                        Ext.Ajax.request({
                            url: '/${appName}/${domainClass.propertyName}/deleteJSON',
                            params: {id:id},
                            success: function(result) {
                                var json_str = Ext.util.JSON.decode(result.responseText);
                                Ext.fading_msg.msg('信息', json_str.msg);
                                store.reload();
                            },
                            failure:function() {
                                Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                            }
                        });
                    }
                });

            }
        }
    }, {
        text: '详细',
        icon: '/${appName}/images/skin/database_save.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.fading_msg.msg('注意', "请选择要显示的记录");
            }else{
                ${domainClass.propertyName}DetailForm.getForm().load({
                    url:'/${appName}/${domainClass.propertyName}/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
<%
	for(prop in iqDomainClass.properties)
    {

    	if (prop.display==true && prop.p.isAssociation())
        {
			println "                ${prop.referenceName}Store.reload();"
		}
		
	}
%>
                ${domainClass.propertyName}DetailWin.show();
            }
        }
    },{
        text: '导入',
        icon: '/${appName}/images/skin/database_add.png',
        handler:function() {

        }
    },{
        text: '更多',
        icon: '/${appName}/images/skin/database_add.png',
        handler:function() {

        }
    }, '->',
    {
        xtype: 'textfield',
        name: 'searchBar',
        emptyText: '请输入搜索条件'
    }, {
        text: '搜索',
        icon: '/${appName}/images/skin/database_search.png',
        handler: function() {
        }
    });

    tb.doLayout();

    var sm = new Ext.grid.CheckboxSelectionModel()
    var cm = new Ext.grid.ColumnModel([
        sm,
<%
	i=0
    for(prop in iqDomainClass.properties)
    {
    	i++
        
        if(i>GRID_MAX_FIELDS){continue}
        
        print "        {header:'${prop.chn}',dataIndex:'${prop.name}'"
        
        if(prop.p.type==boolean)
        {
            print ", renderer: function(value){if(value==true)return '是'; else return '否';}"
        }else if(prop.p.type==Date.class){
            def cp=iqConstraints[prop.name]
            if(cp.attributes.widget=="timefield"){
                print ", type: 'date', renderer: Ext.util.Format.dateRenderer('H:i')"
            }else{
                print ", type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d')"
            }
        }

        print "}"

        if(i<GRID_MAX_FIELDS && prop.last==false)
        {
            println ","
        }		
	}
%>
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/${appName}/${domainClass.propertyName}/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [

<%
	i=0
    for(prop in iqDomainClass.properties)
    {
    	i++
        
        if(i>GRID_MAX_FIELDS){continue}
        
        print "            {name:'${prop.name}'"
        
        if(prop.p.type==Date.class)
        {
            def cp=iqConstraints[prop.name]
            if(cp.attributes.widget=="timefield"){
                print ", type: 'date',  dateFormat:'c'"
            }else{
                print ", type: 'date',  dateFormat:'c'"
            }
        }

        print "}"

        if(i<GRID_MAX_FIELDS && prop.last==false)
        {
            println ","
        }	
	}
%>
        ])
    });

    var grid = new Ext.grid.GridPanel({
        renderTo: '${domainClass.propertyName}Grid',
        store: store,
        enableColumnMove:false,
        enableColumnResize:true,
        stripeRows:true,
        enableHdMenu: false,
        trackMouseOver: true,
        loadMask:true,
        cm: cm,
        sm: sm,
        height: 270,
        viewConfig: {
            forceFit:true
        },

        bbar: new Ext.PagingToolbar({
            pageSize: <% print iqLayout.itemsPerPage %>,
            store: store,
            displayInfo: true,
            displayMsg: '显示第{0}条到第{1}条记录, 共{2}条',
            emptyMsg: '没有记录'
        })
    });

    store.load({params:{start:0,limit:<% print iqLayout.itemsPerPage %>}});

    grid.on('dblclick', function(e) {
        var id = (grid.getSelectionModel().getSelected()).id;
        if (id == null) {
            Ext.fading_msg.msg('注意', "请选择要修改的记录");
        } else {
            ${domainClass.propertyName}UpdateForm.getForm().load({
                url:'/${appName}/${domainClass.propertyName}/detailJSON?id=' + id,
                success:function(form, action) {
                },
                failure:function() {
                    Ext.fading_msg.msg('错误', "服务器出现错误，稍后再试!");
                }
            });
<%
	for(prop in iqDomainClass.properties)
    {

    	if (prop.display && prop.association)
        {
			println "                ${prop.referenceName}Store.reload();"
		}
		
	}
%>
            ${domainClass.propertyName}UpdateWin.show();
        }
    });
    <iq:ext_end/>
</html>

