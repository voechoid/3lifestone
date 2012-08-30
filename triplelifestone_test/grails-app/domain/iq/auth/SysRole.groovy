//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------

package iq.auth

class SysRole {
    static iqDomain=[chn:"角色"]
    static iqLayout=[itemsPerPage: 15]
    static iqNavigation=[group:"系统管理",weight:3]

    String      name
    String      code
    String      description
    boolean    enable=true


    //字段按照优先级和重要性排序，显示顺序
    //display默认=true
    static constraints = {
        name        attributes:[chn:"名称"],blank:false,size: 2..16,unique: true
        code        attributes:[chn:"编码"],blank:false,size: 4..16,unique: true
        description attributes:[chn:"简介", widget: "textarea"],blank:true,size: 0..100
        enable      attributes:[chn:"是否启用"],blank:false
    }

    static mapping = {

    }

    String toString()
    {
        return code
    }
}