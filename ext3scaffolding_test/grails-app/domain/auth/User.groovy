/*************************************************
 Copyright by www.3lifestone.com, all rights reserved.
 **************************************************
 模型: voechoid
 作者: voechoid@qq.com
 ************************************************ */

package auth

class User {
    static iqDomain = [chn: "用户"]
    static iqLayout = [itemsPerPage: 15]
    static iqNavigation = [group: "系统管理", weight: 2]
    static hasMany = [role:Role]

    String username
    String loginname
    String password
    boolean enable=false

    //字段按照优先级和重要性排序，显示顺序; display默认=true
    static constraints = {
        username attributes: [chn: "姓名"], blank: false, size: 4..16
        loginname attributes: [chn: "登录"], blank: false, size: 4..16, unique: true
        password attributes: [chn: "密码"], blank: false, size: 4..16
        enable attributes: [chn: "是否启用"], blank: false
    }

    String toString() {
        return username+"("+loginname+")"
    }
}