import iq.auth.*

//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------

class SecurityFilters {

    def authorizationRules = [
            "ROLE_ADMIN":[
                    [controller: "sys*", action: "*JSON"]
            ],

            "ROLE_USER":[
                    [controller: "sysUser", action: "profile"]
            ]
    ]

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                println "*************************with in security filter:"
                println "session.login:"+ session.login
                println "controller:"+controllerName
                println "action:"+actionName

//                if(controllerName=="auth")
//                {
//                    println "user is authing"
//                }else if(!session.login)
//                {
//                    println "01.no login ..."
//                    redirect(controller: "auth", action: "login")
//                }else if(controllerName !="home" && !(controllerName=="user"&& actionName=="profile"))
//                {
//                    println "02.not basic visit"
//
//                    def roles = SysUser.findByLogin(session.login).getSysRoles().join(",")
//
//                    def userAuthorizationRules=[]
//
//                    authorizationRules.each{
//                        if(roles.contains(it.key))
//                        {
//                            it.value.each{rule->
//                                userAuthorizationRules << rule
//                            }
//                        }
//                    }
//
//                    //如果有一条规则匹配，则返回true
//                    result=false
//                    userAuthorizationRules.each{rule->
//                        rule.controller=rule.controller.replace("*",".*")
//                        rule.action=rule.action.replace("*",".*")
//
//                        if(result ==false && controller==~rule.controller && action==~rule.action)
//                        {
//                            result =true
//                        }
//                    }
//
//                    //说明是未授权的访问
//                    //TODO: auth controller中需要增加一个未授权的action, 显示未授权提示，5秒后重定向至登录页面
//                    if(result==false)
//                    {
//                        println "03.not authorization"
//                        redirect(controller: "auth", action: "logout")
//                    }
//                }
            }
            after = {
                
            }
            afterView = {
                
            }
        }
    }
    
}
