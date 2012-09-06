//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------

package iq

import iq.auth.SysUser

class HomeController {

    def index() {
        println "within HomeController"
        println session.login
        println session.sysRoles
    }
}
