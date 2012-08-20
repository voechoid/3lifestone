import iq.auth.SysRole

class BootStrap {

    def init = { servletContext ->
        new SysRole(name: "管理员", code: "ROLE_ADMIN", description: "系统管理员", enable: true).save(flush: true, failOnError: true)
        new SysRole(name: "用户", code: "ROLE_USER", description: "普通用户", enable: true).save(flush: true, failOnError: true)

        println "Insiding bootstrap:"
        println SysRole.count
        println SysRole.findAll()
    }
    def destroy = {
    }
}
