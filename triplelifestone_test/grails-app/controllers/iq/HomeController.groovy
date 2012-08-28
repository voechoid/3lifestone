//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------

package iq

import iq.auth.SysUser

class HomeController {

    def index() {
        session.login="frank"
        session.name=SysUser.findByLogin(session.login).name
        session.sysRoles=SysUser.findByLogin(session.login).getSysRoles()

        println session.sysRoles
    }
}
