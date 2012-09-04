<%@ page import="com.triplelifestone.Contact" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="P3P" content='CP="CAO PSA OUR"'>
    <iq:ext_rsc/>
        <title>联系人管理</title>
    </head>
	<body>
        <div id="contactToolbar"></div>
        <div id="contactCreateWin"></div>
        <div id="contactUpdateWin"></div>
        <div id="contactDetailWin"></div>
        <div id="contactGrid"></div>
    </body>
    <script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();

    var contactCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/triplelifestone_test/contact/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 2, minLengthText: '姓名至少包含2个字符'},
            {fieldLabel: '邮件',name: 'email',xtype: 'textfield', allowBlank: false, blankText: '邮件为必填项'},
            {fieldLabel: '手机',name: 'mobile',xtype: 'textfield', allowBlank: false, blankText: '手机为必填项', maxLength: 11, maxLengthText: '手机至多包含11个字符', minLength: 11, minLengthText: '手机至少包含11个字符'},
            {fieldLabel: '生日',name: 'birthday',xtype:'datefield',format:'Y-m-d'}

        ]
    });

    var contactCreateWin = new Ext.Window({
        el: 'contactCreateWin',
        closable:false,
        layout: 'fit',
        width:400,
        title:'创建联系人',
        height:300,
        layout:'anchor',
		autoScroll:true,
		border:false,
        modal:true,
		closeAction: 'hide',
        items: [contactCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    contactCreateForm.getForm().submit({
                        success:function(contactCreateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            contactCreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.fading_msg.msg('错误', "创建联系人失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    contactCreateWin.hide();
                }
            }
        ]
    });

    var contactUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/triplelifestone_test/contact/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 2, minLengthText: '姓名至少包含2个字符'},
            {fieldLabel: '邮件',name: 'email',xtype: 'textfield', allowBlank: false, blankText: '邮件为必填项'},
            {fieldLabel: '手机',name: 'mobile',xtype: 'textfield', allowBlank: false, blankText: '手机为必填项', maxLength: 11, maxLengthText: '手机至多包含11个字符', minLength: 11, minLengthText: '手机至少包含11个字符'},
            {fieldLabel: '生日',name: 'birthday',xtype:'datefield',format:'Y-m-d'}

        ]
    });

    var contactUpdateWin = new Ext.Window({
        el: 'contactUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改联系人',
        height: 300,
        layout:'anchor',
		autoScroll:true,
		border:false,
		modal:true,
		closeAction: 'hide',
        items: [contactUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    contactUpdateForm.getForm().submit({
                        success:function(contactUpdateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            contactUpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.fading_msg.msg('错误', "更新联系人失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    contactUpdateWin.hide();
                }
            }
        ]
    });

    var contactDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/triplelifestone_test/contact/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 2, minLengthText: '姓名至少包含2个字符', readOnly:true},
            {fieldLabel: '邮件',name: 'email',xtype: 'textfield', allowBlank: false, blankText: '邮件为必填项', readOnly:true},
            {fieldLabel: '手机',name: 'mobile',xtype: 'textfield', allowBlank: false, blankText: '手机为必填项', maxLength: 11, maxLengthText: '手机至多包含11个字符', minLength: 11, minLengthText: '手机至少包含11个字符', readOnly:true},
            {fieldLabel: '生日',name: 'birthday',xtype:'datefield',format:'Y-m-d', readOnly:true}
        ]
    });

    var contactDetailWin = new Ext.Window({
        el: 'contactDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '联系人明细',
        height: 300,
        layout:'anchor',
		autoScroll:true,
		border:false,
		modal:true,
		closeAction: 'hide',
        items: [contactDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    contactDetailWin.hide();
                }
            }
        ]
    });

    var tb = new Ext.Toolbar();
    tb.render('contactToolbar');

    tb.add({
        text: '新建',
        icon: '/triplelifestone_test/images/skin/database_add.png',
        handler:function() {

            contactCreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/triplelifestone_test/images/skin/database_edit.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.fading_msg.msg('注意', "请选择要修改的记录");
            }else{
                contactUpdateForm.getForm().load({
                    url:'/triplelifestone_test/contact/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });

                contactUpdateWin.show();
            }
        }
    }, {
        text: '删除',
        icon: '/triplelifestone_test/images/skin/database_delete.png',
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
                            url: '/triplelifestone_test/contact/deleteJSON',
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
        icon: '/triplelifestone_test/images/skin/database_save.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.fading_msg.msg('注意', "请选择要显示的记录");
            }else{
                contactDetailForm.getForm().load({
                    url:'/triplelifestone_test/contact/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });

                contactDetailWin.show();
            }
        }
    },{
        text: '导入',
        icon: '/triplelifestone_test/images/skin/database_add.png',
        handler:function() {

        }
    },{
        text: '更多',
        icon: '/triplelifestone_test/images/skin/database_add.png',
        handler:function() {

        }
    }, '->',
    {
        xtype: 'textfield',
        name: 'searchBar',
        emptyText: '请输入搜索条件'
    }, {
        text: '搜索',
        icon: '/triplelifestone_test/images/skin/database_search.png',
        handler: function() {
        }
    });

    tb.doLayout();

    var sm = new Ext.grid.CheckboxSelectionModel()
    var cm = new Ext.grid.ColumnModel([
        sm,
        {header:'姓名',dataIndex:'name'},
        {header:'邮件',dataIndex:'email'},
        {header:'手机',dataIndex:'mobile'},
        {header:'生日',dataIndex:'birthday', type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d')}
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/triplelifestone_test/contact/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [

            {name:'name'},
            {name:'email'},
            {name:'mobile'},
            {name:'birthday', type: 'date',  dateFormat:'c'}
        ])
    });

    var grid = new Ext.grid.GridPanel({
        renderTo: 'contactGrid',
        store: store,
        enableColumnMove:false,
        enableColumnResize:true,
        stripeRows:true,
        enableHdMenu: false,
        trackMouseOver: true,
        loadMask:true,
        cm: cm,
        sm: sm,
        height: 459,
        viewConfig: {
            forceFit:true
        },

        bbar: new Ext.PagingToolbar({
            pageSize: 15,
            store: store,
            displayInfo: true,
            displayMsg: '显示第{0}条到第{1}条记录, 共{2}条',
            emptyMsg: '没有记录'
        })
    });

    store.load({params:{start:0,limit:15}});

    grid.on('dblclick', function(e) {
        var id = (grid.getSelectionModel().getSelected()).id;
        if (id == null) {
            Ext.fading_msg.msg('注意', "请选择要修改的记录");
        } else {
            contactUpdateForm.getForm().load({
                url:'/triplelifestone_test/contact/detailJSON?id=' + id,
                success:function(form, action) {
                },
                failure:function() {
                    Ext.fading_msg.msg('错误', "服务器出现错误，稍后再试!");
                }
            });

            contactUpdateWin.show();
        }
    });
});
    </script>
</html>

