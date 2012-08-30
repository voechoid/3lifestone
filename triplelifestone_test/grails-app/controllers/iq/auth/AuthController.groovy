//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------

package iq.auth

class AuthController {
    def beforeInterceptor = {
        println "with authcontrolleer, before interceptor"
        println actionName
        println actionUri
    }
    def index() {
    }

    def login() {
        println "*********auth-login"
    }

    def authenticate(){
        println "*********auth-authenticate"
        println params
        if(params.login && params.password)
        {
            def user=SysUser.findByLogin(params.login)

            if (user!=null && user.enable==true && user.password==params.password)
            {
                session.login=user.login
                session.name=user.name
                session.sysRoles=user.sysRoles

                redirect(controller: "home", action: "index")
            }else{
                [message:"wrong username or password."]
                redirect(controller: "auth", action: "login")
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
