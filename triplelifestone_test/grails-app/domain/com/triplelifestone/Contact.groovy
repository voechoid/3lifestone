//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------

package com.triplelifestone

class Contact {

    static iqDomain = [chn: "联系人"]
    static iqLayout = [itemsPerPage: 15]
    static iqNavigation = [group: "用户管理", weight: 1]

    String name
    String email
    String mobile
    Date birthday
    static constraints = {
        name        attributes: [chn: "姓名"], blank: false, size: 2..16
        email       attributes: [chn: "邮件"], blank: false
        mobile      attributes: [chn: "手机"], blank: false, size: 11..11
        birthday    attributes: [chn: "生日"], blank: false
    }

    String toString() {
        return name
    }
}