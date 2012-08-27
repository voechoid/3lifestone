import iq.auth.*

class BootStrap {

    def init = { servletContext ->
        new SysRole(name: "系统管理员", code: "ROLE_ADMIN", description: "系统管理员", enable: true).save(flush: true, failOnError: true)
        new SysRole(name: "系统用户", code: "ROLE_USER", description: "系统用户", enable: true).save(flush: true, failOnError: true)

        println "Insiding bootstrap:"
        println SysRole.count
        println SysRole.findAll()

        def frank=new SysUser(name: "弗兰克",login: "frank", password: "123456", enable: true)
        frank.addToSysRoles(SysRole.findByCode("ROLE_ADMIN"))
        frank.addToSysRoles(SysRole.findByCode("ROLE_USER"))

        frank.save()

        println SysUser.findByLogin("frank").sysRoles
    }
    def destroy = {
    }
}
