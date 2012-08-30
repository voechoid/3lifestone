//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------

package iq

import iq.auth.SysUser

class HomeController {

    def beforeInterceptor = {
        println "with homecontrolleer, before interceptor"
        println actionName
        println actionUri
//        if(session.login==null)
//        {
//            println "redirect by homecontroller, before interceptor"
//            redirect(controller: "auth", action: "login")
//        }
    }
    def index() {
        println "within HomeController"
        println session.login
        println session.sysRoles
    }
}
