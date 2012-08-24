<%@ page import="iq.auth.SysUser" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="P3P" content='CP="CAO PSA OUR"'>
    <iq:ext_rsc/>
        <title>用户管理</title>
    </head>
    <style type="text/css">
    #gridContainer {
        width: 100%;
        height: 100%;
    }
    </style>
	<body>
        <div id="sysUserToolbar"></div>
        <div id="sysUserCreateWin"></div>
        <div id="sysUserUpdateWin"></div>
        <div id="sysUserDetailWin"></div>
        <div id="gridContainer"><div id="sysUserGrid"></div></div>
    </body>
    <script type="text/javascript">
Ext.onReady(function(){
    Ext.QuickTips.init();
    var sysRoleStore=new Ext.data.JsonStore({url: '/triplelifestone_test/sysRole/associationListJSON', fields:['id', 'value'],  root: 'root', totalProperty: 'total'});

    var sysUserCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/triplelifestone_test/sysUser/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 2, minLengthText: '姓名至少包含2个字符'},
            {fieldLabel: '登录名',name: 'login',xtype: 'textfield', allowBlank: false, blankText: '登录名为必填项', maxLength: 16, maxLengthText: '登录名至多包含16个字符', minLength: 4, minLengthText: '登录名至少包含4个字符'},
            {fieldLabel: '密码',name: 'password',xtype: 'textfield', inputType: 'password', allowBlank: false, blankText: '密码为必填项', maxLength: 16, maxLengthText: '密码至多包含16个字符', minLength: 4, minLengthText: '密码至少包含4个字符'},
            {boxLabel: '是否启用',name: 'enable',xtype:'checkbox'},
            {name:'sysRoles', fieldLabel: '角色', xtype: 'multiselect', dataFields: ['id','value'],valueField: 'id', displayField: 'value', store: sysRoleStore}

        ]
    });

    var sysUserCreateWin = new Ext.Window({
        el: 'sysUserCreateWin',
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
        items: [sysUserCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    sysUserCreateForm.getForm().submit({
                        success:function(sysUserCreateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            sysUserCreateWin.hide();
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
                    sysUserCreateWin.hide();
                }
            }
        ]
    });

    var sysUserUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/triplelifestone_test/sysUser/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 2, minLengthText: '姓名至少包含2个字符'},
            {fieldLabel: '登录名',name: 'login',xtype: 'textfield', allowBlank: false, blankText: '登录名为必填项', maxLength: 16, maxLengthText: '登录名至多包含16个字符', minLength: 4, minLengthText: '登录名至少包含4个字符'},
            {fieldLabel: '密码',name: 'password',xtype: 'textfield', inputType: 'password', allowBlank: false, blankText: '密码为必填项', maxLength: 16, maxLengthText: '密码至多包含16个字符', minLength: 4, minLengthText: '密码至少包含4个字符'},
            {boxLabel: '是否启用',name: 'enable',xtype:'checkbox'},
            {name:'sysRoles', fieldLabel: '角色', xtype: 'multiselect', dataFields: ['id','value'],valueField: 'id', displayField: 'value', store: sysRoleStore}

        ]
    });

    var sysUserUpdateWin = new Ext.Window({
        el: 'sysUserUpdateWin',
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
        items: [sysUserUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    sysUserUpdateForm.getForm().submit({
                        success:function(sysUserUpdateForm, action) {
                            Ext.fading_msg.msg('信息', action.result.msg);
                            sysUserUpdateWin.hide();
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
                    sysUserUpdateWin.hide();
                }
            }
        ]
    });

    var sysUserDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/triplelifestone_test/sysUser/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 2, minLengthText: '姓名至少包含2个字符', readOnly:true},
            {fieldLabel: '登录名',name: 'login',xtype: 'textfield', allowBlank: false, blankText: '登录名为必填项', maxLength: 16, maxLengthText: '登录名至多包含16个字符', minLength: 4, minLengthText: '登录名至少包含4个字符', readOnly:true},
            {fieldLabel: '密码',name: 'password',xtype: 'textfield', inputType: 'password', allowBlank: false, blankText: '密码为必填项', maxLength: 16, maxLengthText: '密码至多包含16个字符', minLength: 4, minLengthText: '密码至少包含4个字符', readOnly:true},
            {boxLabel: '是否启用',name: 'enable',xtype:'checkbox', readOnly:true},
            {name:'sysRoles', fieldLabel: '角色', xtype: 'multiselect', dataFields: ['id','value'],valueField: 'id', displayField: 'value', store: sysRoleStore, readOnly:true}
        ]
    });

    var sysUserDetailWin = new Ext.Window({
        el: 'sysUserDetailWin',
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
        items: [sysUserDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    sysUserDetailWin.hide();
                }
            }
        ]
    });

    var tb = new Ext.Toolbar();
    tb.render('sysUserToolbar');

    tb.add({
        text: '新建',
        icon: '/triplelifestone_test/images/skin/database_add.png',
        handler:function() {
            sysRoleStore.reload();

            sysUserCreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/triplelifestone_test/images/skin/database_edit.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.fading_msg.msg('注意', "请选择要修改的记录");
            }else{
                sysUserUpdateForm.getForm().load({
                    url:'/triplelifestone_test/sysUser/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
                sysRoleStore.reload();

                sysUserUpdateWin.show();
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
                            url: '/triplelifestone_test/sysUser/deleteJSON',
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
                sysUserDetailForm.getForm().load({
                    url:'/triplelifestone_test/sysUser/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.fading_msg.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
                sysRoleStore.reload();

                sysUserDetailWin.show();
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
        {header:'登录名',dataIndex:'login'},
        {header:'密码',dataIndex:'password'},
        {header:'是否启用',dataIndex:'enable', renderer: function(value){if(value==true)return '是'; else return '否';}},
        {header:'角色',dataIndex:'sysRoles'}
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/triplelifestone_test/sysUser/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [

            {name:'name'},
            {name:'login'},
            {name:'password'},
            {name:'enable'},
            {name:'sysRoles'}
        ])
    });

    var grid = new Ext.grid.GridPanel({
        renderTo: 'sysUserGrid',
        store: store,
        enableColumnMove:false,
        enableColumnResize:false,
        stripeRows:true,
        enableHdMenu: false,
        trackMouseOver: true,
        loadMask:true,
        autoScroll:false,
        
        cm: cm,
        sm: sm,
        height: Ext.get("gridContainer").getHeight()-27,
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
            sysUserUpdateForm.getForm().load({
                url:'/triplelifestone_test/sysUser/detailJSON?id=' + id,
                success:function(form, action) {
                },
                failure:function() {
                    Ext.fading_msg.msg('错误', "服务器出现错误，稍后再试!");
                }
            });
                sysRoleStore.reload();

            sysUserUpdateWin.show();
        }
    });
});
</script>
</html>

