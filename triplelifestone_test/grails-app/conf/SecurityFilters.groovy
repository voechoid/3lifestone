//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------
import iq.auth.*

class SecurityFilters {

    def grailsApplication

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                if(controllerName=="auth")
                {
                    return true
                }
                def authorizationRules=grailsApplication.config.iq.authorizationRules
                def roles = ""
                def sessionLogin=session.getAttribute("login")

                if(sessionLogin!=null)
                {
                    roles=SysUser.findByLogin(sessionLogin).getSysRoles()*.toString().join(",")
                }else{
                    redirect(controller: "auth", action: "logout")
                    return false;
                }
                if(controllerName !="home" && !(controllerName=="user"&& actionName=="profile"))
                {
                    def userAuthorizationRules=[]

                    authorizationRules.each{
                        if(roles.contains(it.key))
                        {
                            it.value.each{rule->
                                userAuthorizationRules << rule
                            }
                        }
                    }

                    //如果有一条规则匹配，则返回true
                    def result=false
                    userAuthorizationRules.each{rule->
                        def rule_controller=rule.controller.replace("*",".*")
                        def rule_action=rule.action.replace("*",".*")

                        if(result ==false && controllerName==~rule_controller && actionName==~rule_action)
                        {
                            result =true
                        }
                    }

                    //说明是未授权的访问
                    //TODO: auth controller中需要增加一个未授权的action, 显示未授权提示，5秒后重定向至登录页面
                    if(result==false)
                    {
                        println "03.not authorization"
                        redirect(controller: "auth", action: "logout")
                    }
                    if(result==true){
                        println "User: ${sessionLogin}, ${controllerName}, ${actionName} authorized!"
                    }
                    return result
                }
            }
            after = {
                
            }
            afterView = {
                
            }
        }
    }
    
}
