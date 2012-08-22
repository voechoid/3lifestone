//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------

package iq.auth

class AuthController {

    def index() {
        redirect(action: "login", params:params)
    }

    def login() {
        println "within login:"
        println params

        if(params.login && params.password)
        {
            def user=SysUser.findByLogin(params.login)

            if (user!=null && user.enable==true && user.password==params.password)
            {
                session.login=user.login
                session.name=user.name
                session.sysRoles=user.sysRoles

                //redirect(url: "/")
                redirect(controller: "sysUser", action: "index")
            }else{
                render "{success:false,msg:'记录创建异常'}";
            }
        }
    }

    def logout() {
        session.login=null
        session.name=null
        session.sysRoles=null

        redirect(controller: "auth", action: "login")
    }
}
