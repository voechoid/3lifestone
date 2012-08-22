<%@ page import="iq.auth.SysUser" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="P3P" content='CP="CAO PSA OUR"'>
    <iq:ext_rsc/>
        <title>用户管理</title>
    </head>
	<body>
        <%
            println params
            //println ${sysUserInstance?.id}
        %>
        <div id="sysUserProfileForm" stype="margin:10px;" />
    </body>
    <iq:ext_begin/>
    Ext.QuickTips.init();
    var sysRoleStore=new Ext.data.JsonStore({url: '/triplelifestone_test/sysRole/associationListJSON', fields:['id', 'value'],  root: 'root', totalProperty: 'total'});

    var sysUserUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 150,
        frame: true,
        url: '/triplelifestone_test/sysUser/profileSubmit',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 16, maxLengthText: '姓名至多包含16个字符', minLength: 2, minLengthText: '姓名至少包含2个字符'},
            {fieldLabel: '登录名',name: 'login',xtype: 'textfield', allowBlank: false, blankText: '登录名为必填项', maxLength: 16, maxLengthText: '登录名至多包含16个字符', minLength: 4, minLengthText: '登录名至少包含4个字符'},
            {fieldLabel: '密码',name: 'password',xtype: 'textfield', inputType: 'password', allowBlank: false, blankText: '密码为必填项', maxLength: 16, maxLengthText: '密码至多包含16个字符', minLength: 4, minLengthText: '密码至少包含4个字符'},
            {boxLabel: '是否启用',name: 'enable',xtype:'checkbox', readOnly:true},
            {name:'sysRoles', fieldLabel: '角色', xtype: 'multiselect', dataFields: ['id','value'],valueField: 'id', displayField: 'value', store: sysRoleStore, readOnly:true}
        ],
        buttons:[{
            text:   '更新',
            handler: function(){
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
        }]
    });


    //Ext.Msg.alert('id','${id}');

    sysUserUpdateForm.getForm().load({
        url:'/triplelifestone_test/sysUser/detailJSON?id=${id}',
        success:function(form, action) {
        },
        failure:function() {
            Ext.fading_msg.msg('错误', "服务器出现错误，稍后再试!");
        }
    });
    sysRoleStore.reload();

    sysUserUpdateForm.render("sysUserProfileForm");

    %{--store.load({params:{start:0,limit:15}});--}%

    %{--grid.on('dblclick', function(e) {--}%
        %{--var id = (grid.getSelectionModel().getSelected()).id;--}%
        %{--if (id == null) {--}%
            %{--Ext.fading_msg.msg('注意', "请选择要修改的记录");--}%
        %{--} else {--}%


            %{--sysUserUpdateWin.show();--}%
        %{--}--}%
    %{--});--}%
    <iq:ext_end/>
</html>

