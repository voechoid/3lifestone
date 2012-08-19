/*************************************************
Copyright by www.3lifestone.com, all rights reserved.
**************************************************
模型: voechoid
作者: voechoid@qq.com
*************************************************/

<%@ page import="system.Group" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <iq:ext_rsc/>
        <title>模型管理</title>
    </head>
	<body>
        <div id="groupToolbar"></div>
        <div id="groupGrid"></div>
        <div id="groupCreateWin"></div>
        <div id="groupUpdateWin"></div>
        <div id="groupDetailWin"></div>
    </body>
    <iq:ext_begin/>
    Ext.QuickTips.init();

    var groupCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/ext3scaffolding_test/group/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 1, minLengthText: '姓名至少包含1个字符'},
            {fieldLabel: '颜色',name: 'color',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['红'],['黄'],['蓝']]}), emptyText:'请选择颜色',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {boxLabel: '傻吗',name: 'isStupid',xtype:'checkbox'},
            {fieldLabel: '年龄',name: 'age',xtype:'numberfield'},
            {fieldLabel: '金钱',name: 'money',xtype:'numberfield',allowDecimals:true},
            {fieldLabel: '生日',name: 'birthday',xtype:'datefield',format:'Y-m-d'},
            {fieldLabel: '多行',name: 'multiLine',xtype: 'textarea', maxLength: 100, maxLengthText: '多行至多包含100个字符', minLength: 0, minLengthText: '多行至少包含0个字符'},
            {fieldLabel: '多行',name: 'htmlContent',xtype: 'htmleditor', maxLength: 1000, maxLengthText: '多行至多包含1000个字符', minLength: 0, minLengthText: '多行至少包含0个字符'}

        ]
    });

    var groupCreateWin = new Ext.Window({
        el: 'groupCreateWin',
        closable:false,
        layout: 'fit',
        width:400,
        title:'创建模型',
        height:300,
        layout:'anchor',
		autoScroll:true,
		border:false,
        modal:true,
		closeAction: 'hide',
        items: [groupCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    groupCreateForm.getForm().submit({
                        success:function(groupCreateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            groupCreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.fading_msg.msg('错误', "创建模型失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    groupCreateWin.hide();
                }
            }
        ]
    });

    var groupUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/ext3scaffolding_test/group/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 1, minLengthText: '姓名至少包含1个字符'},
            {fieldLabel: '颜色',name: 'color',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['红'],['黄'],['蓝']]}), emptyText:'请选择颜色',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {boxLabel: '傻吗',name: 'isStupid',xtype:'checkbox'},
            {fieldLabel: '年龄',name: 'age',xtype:'numberfield'},
            {fieldLabel: '金钱',name: 'money',xtype:'numberfield',allowDecimals:true},
            {fieldLabel: '生日',name: 'birthday',xtype:'datefield',format:'Y-m-d'},
            {fieldLabel: '多行',name: 'multiLine',xtype: 'textarea', maxLength: 100, maxLengthText: '多行至多包含100个字符', minLength: 0, minLengthText: '多行至少包含0个字符'},
            {fieldLabel: '多行',name: 'htmlContent',xtype: 'htmleditor', maxLength: 1000, maxLengthText: '多行至多包含1000个字符', minLength: 0, minLengthText: '多行至少包含0个字符'}

        ]
    });

    var groupUpdateWin = new Ext.Window({
        el: 'groupUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改模型',
        height: 300,
        layout:'anchor',
		autoScroll:true,
		border:false,
		modal:true,
		closeAction: 'hide',
        items: [groupUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    groupUpdateForm.getForm().submit({
                        success:function(groupUpdateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            groupUpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.fading_msg.msg('错误', "更新模型失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    groupUpdateWin.hide();
                }
            }
        ]
    });

    var groupDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/ext3scaffolding_test/group/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 1, minLengthText: '姓名至少包含1个字符', readOnly:true},
            {fieldLabel: '颜色',name: 'color',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['红'],['黄'],['蓝']]}), emptyText:'请选择颜色',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values', readOnly:true},
            {boxLabel: '傻吗',name: 'isStupid',xtype:'checkbox', readOnly:true},
            {fieldLabel: '年龄',name: 'age',xtype:'numberfield', readOnly:true},
            {fieldLabel: '金钱',name: 'money',xtype:'numberfield',allowDecimals:true, readOnly:true},
            {fieldLabel: '生日',name: 'birthday',xtype:'datefield',format:'Y-m-d', readOnly:true},
            {fieldLabel: '多行',name: 'multiLine',xtype: 'textarea', maxLength: 100, maxLengthText: '多行至多包含100个字符', minLength: 0, minLengthText: '多行至少包含0个字符', readOnly:true},
            {fieldLabel: '多行',name: 'htmlContent',xtype: 'htmleditor', maxLength: 1000, maxLengthText: '多行至多包含1000个字符', minLength: 0, minLengthText: '多行至少包含0个字符', readOnly:true}
        ]
    });

    var groupDetailWin = new Ext.Window({
        el: 'groupDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '模型明细',
        height: 300,
        layout:'anchor',
		autoScroll:true,
		border:false,
		modal:true,
		closeAction: 'hide',
        items: [groupDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    groupDetailWin.hide();
                }
            }
        ]
    });

    var tb = new Ext.Toolbar();
    tb.render('groupToolbar');

    tb.add({
        text: '新建',
        icon: '/ext3scaffolding_test/images/skin/database_add.png',
        handler:function() {

            groupCreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/ext3scaffolding_test/images/skin/database_edit.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.fading_msg.msg('注意', "请选择要修改的记录");
            }else{
                groupUpdateForm.getForm().load({
                    url:'/ext3scaffolding_test/group/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });

                groupUpdateWin.show();
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
                            url: '/ext3scaffolding_test/group/deleteJSON',
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
                groupDetailForm.getForm().load({
                    url:'/ext3scaffolding_test/group/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });

                groupDetailWin.show();
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
        {header:'姓名',dataIndex:'name'},
        {header:'颜色',dataIndex:'color'},
        {header:'傻吗',dataIndex:'isStupid', renderer: function(value){if(value==true)return '是'; else return '否';}},
        {header:'年龄',dataIndex:'age'},
        {header:'金钱',dataIndex:'money'},
        {header:'生日',dataIndex:'birthday', type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d')},
        {header:'多行',dataIndex:'multiLine'},
        {header:'多行',dataIndex:'htmlContent'}
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/ext3scaffolding_test/group/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [

            {name:'name'},
            {name:'color'},
            {name:'isStupid'},
            {name:'age'},
            {name:'money'},
            {name:'birthday', type: 'date',  dateFormat:'c'},
            {name:'multiLine'},
            {name:'htmlContent'}
        ])
    });

    var grid = new Ext.grid.GridPanel({
        renderTo: 'groupGrid',
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
            groupUpdateForm.getForm().load({
                url:'/ext3scaffolding_test/group/detailJSON?id=' + id,
                success:function(form, action) {
                },
                failure:function() {
                    Ext.fading_msg.msg('错误', "服务器出现错误，稍后再试!");
                }
            });

            groupUpdateWin.show();
        }
    });
    <iq:ext_end/>
</html>

