//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------

package iq.auth

class SysUser {
    static iqDomain = [chn: "用户"]
    static iqLayout = [itemsPerPage: 15]
    static iqNavigation = [group: "系统管理", weight: 2]
    static hasMany = [sysRoles:SysRole]

    String name
    String login
    String password
    boolean enable=false

    //字段按照优先级和重要性排序，显示顺序; display默认=true
    static constraints = {
        name attributes: [chn: "姓名"], blank: false, size: 2..16, unique: true
        login attributes: [chn: "登录名"], blank: false, size: 4..16, unique: true
        password attributes: [chn: "密码",inputType: "password"], blank: false, size: 4..16
        enable attributes: [chn: "是否启用"], blank: false
    }

    static mapping = {
        sysRoles(lazy: false)
    }

    String toString() {
        return name+"("+login+")"
    }
}