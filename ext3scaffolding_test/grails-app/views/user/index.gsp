/*************************************************
Copyright by www.3lifestone.com, all rights reserved.
**************************************************
模型: voechoid
作者: voechoid@qq.com
*************************************************/

<%@ page import="auth.User" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <iq:ext_rsc/>
        <title>用户管理</title>
    </head>
	<body>
        <div id="userToolbar"></div>
        <div id="userGrid"></div>
        <div id="userCreateWin"></div>
        <div id="userUpdateWin"></div>
        <div id="userDetailWin"></div>
    </body>
    <iq:ext_begin/>
    Ext.QuickTips.init();
    var roleStore=new Ext.data.JsonStore({url: '/ext3scaffolding_test/role/associationListJSON', fields:['id', 'value'],  root: 'root', totalProperty: 'total'});

    var userCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/ext3scaffolding_test/user/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'username',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 4, minLengthText: '姓名至少包含4个字符'},
            {fieldLabel: '登录',name: 'loginname',xtype: 'textfield', allowBlank: false, blankText: '登录为必填项', maxLength: 16, maxLengthText: '登录至多包含16个字符', minLength: 4, minLengthText: '登录至少包含4个字符'},
            {fieldLabel: '密码',name: 'password',xtype: 'textfield', allowBlank: false, blankText: '密码为必填项', maxLength: 16, maxLengthText: '密码至多包含16个字符', minLength: 4, minLengthText: '密码至少包含4个字符'},
            {boxLabel: '是否启用',name: 'enable',xtype:'checkbox'},
            {name:'role', fieldLabel: '角色', xtype: 'multiselect', dataFields: ['id','value'],valueField: 'id', displayField: 'value', store: roleStore}

        ]
    });

    var userCreateWin = new Ext.Window({
        el: 'userCreateWin',
        closable:false,
        layout: 'fit',
        width:400,
        title:'创建用户',
        height:300,
        layout:'anchor',
		autoScroll:true,
		border:false,
        modal:true,
		closeAction: 'hide',
        items: [userCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    userCreateForm.getForm().submit({
                        success:function(userCreateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            userCreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.fading_msg.msg('错误', "创建用户失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    userCreateWin.hide();
                }
            }
        ]
    });

    var userUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/ext3scaffolding_test/user/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'username',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 4, minLengthText: '姓名至少包含4个字符'},
            {fieldLabel: '登录',name: 'loginname',xtype: 'textfield', allowBlank: false, blankText: '登录为必填项', maxLength: 16, maxLengthText: '登录至多包含16个字符', minLength: 4, minLengthText: '登录至少包含4个字符'},
            {fieldLabel: '密码',name: 'password',xtype: 'textfield', allowBlank: false, blankText: '密码为必填项', maxLength: 16, maxLengthText: '密码至多包含16个字符', minLength: 4, minLengthText: '密码至少包含4个字符'},
            {boxLabel: '是否启用',name: 'enable',xtype:'checkbox'},
            {name:'role', fieldLabel: '角色', xtype: 'multiselect', dataFields: ['id','value'],valueField: 'id', displayField: 'value', store: roleStore}

        ]
    });

    var userUpdateWin = new Ext.Window({
        el: 'userUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改用户',
        height: 300,
        layout:'anchor',
		autoScroll:true,
		border:false,
		modal:true,
		closeAction: 'hide',
        items: [userUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    userUpdateForm.getForm().submit({
                        success:function(userUpdateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            userUpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.fading_msg.msg('错误', "更新用户失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    userUpdateWin.hide();
                }
            }
        ]
    });

    var userDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/ext3scaffolding_test/user/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'username',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 4, minLengthText: '姓名至少包含4个字符', readOnly:true},
            {fieldLabel: '登录',name: 'loginname',xtype: 'textfield', allowBlank: false, blankText: '登录为必填项', maxLength: 16, maxLengthText: '登录至多包含16个字符', minLength: 4, minLengthText: '登录至少包含4个字符', readOnly:true},
            {fieldLabel: '密码',name: 'password',xtype: 'textfield', allowBlank: false, blankText: '密码为必填项', maxLength: 16, maxLengthText: '密码至多包含16个字符', minLength: 4, minLengthText: '密码至少包含4个字符', readOnly:true},
            {boxLabel: '是否启用',name: 'enable',xtype:'checkbox', readOnly:true},
            {name:'role', fieldLabel: '角色', xtype: 'multiselect', dataFields: ['id','value'],valueField: 'id', displayField: 'value', store: roleStore, readOnly:true}
        ]
    });

    var userDetailWin = new Ext.Window({
        el: 'userDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '用户明细',
        height: 300,
        layout:'anchor',
		autoScroll:true,
		border:false,
		modal:true,
		closeAction: 'hide',
        items: [userDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    userDetailWin.hide();
                }
            }
        ]
    });

    var tb = new Ext.Toolbar();
    tb.render('userToolbar');

    tb.add({
        text: '新建',
        icon: '/ext3scaffolding_test/images/skin/database_add.png',
        handler:function() {
            roleStore.reload();

            userCreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/ext3scaffolding_test/images/skin/database_edit.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.fading_msg.msg('注意', "请选择要修改的记录");
            }else{
                userUpdateForm.getForm().load({
                    url:'/ext3scaffolding_test/user/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
                roleStore.reload();

                userUpdateWin.show();
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
                            url: '/ext3scaffolding_test/user/deleteJSON',
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
                userDetailForm.getForm().load({
                    url:'/ext3scaffolding_test/user/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
                roleStore.reload();

                userDetailWin.show();
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
        {header:'姓名',dataIndex:'username'},
        {header:'登录',dataIndex:'loginname'},
        {header:'密码',dataIndex:'password'},
        {header:'是否启用',dataIndex:'enable', renderer: function(value){if(value==true)return '是'; else return '否';}},
        {header:'角色',dataIndex:'role'}
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/ext3scaffolding_test/user/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [

            {name:'username'},
            {name:'loginname'},
            {name:'password'},
            {name:'enable'},
            {name:'role'}
        ])
    });

    var grid = new Ext.grid.GridPanel({
        renderTo: 'userGrid',
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
            userUpdateForm.getForm().load({
                url:'/ext3scaffolding_test/user/detailJSON?id=' + id,
                success:function(form, action) {
                },
                failure:function() {
                    Ext.fading_msg.msg('错误', "服务器出现错误，稍后再试!");
                }
            });
                roleStore.reload();

            userUpdateWin.show();
        }
    });
    <iq:ext_end/>
</html>

