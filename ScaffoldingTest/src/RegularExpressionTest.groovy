
/**
 * Created with IntelliJ IDEA.
 * User: bruce_lin_chn
 * Date: 12-8-28
 * Time: 上午8:08
 * To change this template use File | Settings | File Templates.
 */

//Controller: 可用伪正则，action: 可用伪正则, roles: 完全名称，精确匹配
def authorizationRules = [
        "ROLE_ADMIN":[
                [controller: "sys*", action: "*JSON"]
        ],

        "ROLE_USER":[
                [controller: "sysUser", action: "profile"]
        ]
]

controller="sysCustomer"
action="indexJSON"
role="ROLE_ADMIN,ROLE_USER"

//println authorizationRules[role]

//找出用户关联的所有规则
userAuthorizationRules=[]

authorizationRules.each{
    if(role.contains(it.key))
    {
        it.value.each{rule->
            userAuthorizationRules << rule
        }
    }
}

//如果有一条规则匹配，则返回true
result=false
userAuthorizationRules.each{rule->
    rule.controller=rule.controller.replace("*",".*")
    rule.action=rule.action.replace("*",".*")

    if(result ==false && controller==~rule.controller && action==~rule.action)
    {
        result =true
    }
}

println "controller:"+controller
println "action:"+action
println "result:"+result