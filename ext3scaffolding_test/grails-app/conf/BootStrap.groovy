import auth.Role

class BootStrap {

    def init = { servletContext ->
        new Role(name: "管理员", code: "ROLE_ADMIN", description: "系统管理员",enable: true ).save()
        new Role(name: "用户", code: "ROLE_USER", description: "系统用户",enable: true ).save()
//        if(Role.findByCode("ROLE_ADMIN")==null)
//        {
//            new Role(name: "管理员", code: "ROLE_ADMIN", description: "系统管理员",enable: true ).save()
//        }
//
//        if(Role.findByCode("ROLE_USER")==null)
//        {
//            new Role(name: "用户", code: "ROLE_USER", description: "系统用户",enable: true ).save()
//        }

        println Role.findAll()
        println Role.findByCode("ROLE_ADMIN")
    }
    def destroy = {
    }
}
