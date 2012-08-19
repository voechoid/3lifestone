/*************************************************
Copyright by www.3lifestone.com, all rights reserved.
**************************************************
模型: voechoid
作者: voechoid@qq.com
*************************************************/

<%@ page import="auth.Role" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <iq:ext_rsc/>
        <title>角色管理</title>
    </head>
	<body>
        <div id="roleToolbar"></div>
        <div id="roleGrid"></div>
        <div id="roleCreateWin"></div>
        <div id="roleUpdateWin"></div>
        <div id="roleDetailWin"></div>
    </body>
    <iq:ext_begin/>
    Ext.QuickTips.init();

    var roleCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/ext3scaffolding_test/role/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '名称',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '名称为必填项', maxLength: 16, maxLengthText: '名称至多包含16个字符', minLength: 4, minLengthText: '名称至少包含4个字符'},
            {fieldLabel: '编码',name: 'code',xtype: 'textfield', allowBlank: false, blankText: '编码为必填项', maxLength: 16, maxLengthText: '编码至多包含16个字符', minLength: 4, minLengthText: '编码至少包含4个字符'},
            {fieldLabel: '简介',name: 'description',xtype: 'textarea', maxLength: 100, maxLengthText: '简介至多包含100个字符', minLength: 0, minLengthText: '简介至少包含0个字符'},
            {boxLabel: '是否启用',name: 'enable',xtype:'checkbox'}

        ]
    });

    var roleCreateWin = new Ext.Window({
        el: 'roleCreateWin',
        closable:false,
        layout: 'fit',
        width:400,
        title:'创建角色',
        height:300,
        layout:'anchor',
		autoScroll:true,
		border:false,
        modal:true,
		closeAction: 'hide',
        items: [roleCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    roleCreateForm.getForm().submit({
                        success:function(roleCreateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            roleCreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.fading_msg.msg('错误', "创建角色失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    roleCreateWin.hide();
                }
            }
        ]
    });

    var roleUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/ext3scaffolding_test/role/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '名称',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '名称为必填项', maxLength: 16, maxLengthText: '名称至多包含16个字符', minLength: 4, minLengthText: '名称至少包含4个字符'},
            {fieldLabel: '编码',name: 'code',xtype: 'textfield', allowBlank: false, blankText: '编码为必填项', maxLength: 16, maxLengthText: '编码至多包含16个字符', minLength: 4, minLengthText: '编码至少包含4个字符'},
            {fieldLabel: '简介',name: 'description',xtype: 'textarea', maxLength: 100, maxLengthText: '简介至多包含100个字符', minLength: 0, minLengthText: '简介至少包含0个字符'},
            {boxLabel: '是否启用',name: 'enable',xtype:'checkbox'}

        ]
    });

    var roleUpdateWin = new Ext.Window({
        el: 'roleUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改角色',
        height: 300,
        layout:'anchor',
		autoScroll:true,
		border:false,
		modal:true,
		closeAction: 'hide',
        items: [roleUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    roleUpdateForm.getForm().submit({
                        success:function(roleUpdateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            roleUpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.fading_msg.msg('错误', "更新角色失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    roleUpdateWin.hide();
                }
            }
        ]
    });

    var roleDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/ext3scaffolding_test/role/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '名称',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '名称为必填项', maxLength: 16, maxLengthText: '名称至多包含16个字符', minLength: 4, minLengthText: '名称至少包含4个字符', readOnly:true},
            {fieldLabel: '编码',name: 'code',xtype: 'textfield', allowBlank: false, blankText: '编码为必填项', maxLength: 16, maxLengthText: '编码至多包含16个字符', minLength: 4, minLengthText: '编码至少包含4个字符', readOnly:true},
            {fieldLabel: '简介',name: 'description',xtype: 'textarea', maxLength: 100, maxLengthText: '简介至多包含100个字符', minLength: 0, minLengthText: '简介至少包含0个字符', readOnly:true},
            {boxLabel: '是否启用',name: 'enable',xtype:'checkbox', readOnly:true}
        ]
    });

    var roleDetailWin = new Ext.Window({
        el: 'roleDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '角色明细',
        height: 300,
        layout:'anchor',
		autoScroll:true,
		border:false,
		modal:true,
		closeAction: 'hide',
        items: [roleDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    roleDetailWin.hide();
                }
            }
        ]
    });

    var tb = new Ext.Toolbar();
    tb.render('roleToolbar');

    tb.add({
        text: '新建',
        icon: '/ext3scaffolding_test/images/skin/database_add.png',
        handler:function() {

            roleCreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/ext3scaffolding_test/images/skin/database_edit.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.fading_msg.msg('注意', "请选择要修改的记录");
            }else{
                roleUpdateForm.getForm().load({
                    url:'/ext3scaffolding_test/role/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });

                roleUpdateWin.show();
            }
        }
    }, {
        text: '删除',
        icon: '/ext3scaffolding_test/images/skin/database_delete.png',
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
                            url: '/ext3scaffolding_test/role/deleteJSON',
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
        icon: '/ext3scaffolding_test/images/skin/database_save.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.fading_msg.msg('注意', "请选择要显示的记录");
            }else{
                roleDetailForm.getForm().load({
                    url:'/ext3scaffolding_test/role/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });

                roleDetailWin.show();
            }
        }
    },{
        text: '导入',
        icon: '/ext3scaffolding_test/images/skin/database_add.png',
        handler:function() {

        }
    },{
        text: '更多',
        icon: '/ext3scaffolding_test/images/skin/database_add.png',
        handler:function() {

        }
    }, '->',
    {
        xtype: 'textfield',
        name: 'searchBar',
        emptyText: '请输入搜索条件'
    }, {
        text: '搜索',
        icon: '/ext3scaffolding_test/images/skin/database_search.png',
        handler: function() {
        }
    });

    tb.doLayout();

    var sm = new Ext.grid.CheckboxSelectionModel()
    var cm = new Ext.grid.ColumnModel([
        sm,
        {header:'名称',dataIndex:'name'},
        {header:'编码',dataIndex:'code'},
        {header:'简介',dataIndex:'description'},
        {header:'是否启用',dataIndex:'enable', renderer: function(value){if(value==true)return '是'; else return '否';}}
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/ext3scaffolding_test/role/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [

            {name:'name'},
            {name:'code'},
            {name:'description'},
            {name:'enable'}
        ])
    });

    var grid = new Ext.grid.GridPanel({
        renderTo: 'roleGrid',
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
            roleUpdateForm.getForm().load({
                url:'/ext3scaffolding_test/role/detailJSON?id=' + id,
                success:function(form, action) {
                },
                failure:function() {
                    Ext.fading_msg.msg('错误', "服务器出现错误，稍后再试!");
                }
            });

            roleUpdateWin.show();
        }
    });
    <iq:ext_end/>
</html>

