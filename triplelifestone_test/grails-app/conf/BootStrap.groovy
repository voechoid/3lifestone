import iq.auth.SysRole
import iq.auth.SysUser

class BootStrap {

    def init = { servletContext ->
        new SysRole(name: "管理员", code: "ROLE_ADMIN", description: "系统管理员", enable: true).save(flush: true, failOnError: true)
        new SysRole(name: "用户", code: "ROLE_USER", description: "普通用户", enable: true).save(flush: true, failOnError: true)

        println "Insiding bootstrap:"
        println SysRole.count
        println SysRole.findAll()

        def linyu=new SysUser(name: "林禹",login: "linyu", password: "123456", enable: true)
        linyu.addToSysRoles(SysRole.findByCode("ROLE_ADMIN"))
        linyu.addToSysRoles(SysRole.findByCode("ROLE_USER"))

        linyu.save()

        println SysUser.findByLogin("linyu").sysRoles
    }
    def destroy = {
    }
}
