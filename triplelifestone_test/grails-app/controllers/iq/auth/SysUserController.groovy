package iq.auth

class SysUserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def afterInterceptor = { model ->
        println "tracing action uri:"+actionUri
        println "model:"+model
	}

    def index = {
    }

    def profile={
        session.login="linyu"
        session.name="林禹"

        if(!session.login)
        {
            redirect(controller: "auth", action: "login")
        }

        [id:    SysUser.findByLogin(session.login)?.id]
    }
    def profileSubmit={
        def sysUser=SysUser(params.id)

        if(sysUser.login!=session.login)
        {
            redirect(controller: "auth", action: "login")
        }

        sysUser.name=params.name
        sysUser.password=paramms.password
        sysUser.enable=params.enable?true:false

        try{
            sysUser.save()

            render "{success:true, msg:'用户信息已更新'}"
        }catch(Exception e)
        {
            println "saving error:"+ sysUser
            println e.toString()

            render "{success:false, msg:'用户信息更新异常，请联系管理员'}"
        }
    }


    def associationListJSON = {
        def sysUserTotal=SysUser.count()

        if(sysUserTotal==0)
        {
            render "{total:"+sysUserTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start') : 0
            def endCurrentPage = startCurrentPage + pageSize - 1>=sysUserTotal ? sysUserTotal - 1 : startCurrentPage + pageSize - 1
            def sysUserList = SysUser.findAll()[startCurrentPage..endCurrentPage]

            def associationList=[]
            sysUserList.each{item ->
                associationList.add(new HashMap(id: item.id, value: item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{sysUserTotal:" + sysUserTotal + ",root:" + json + "}"
            render output
        }
    }

    def listJSON = {
        def sysUserTotal=SysUser.count()

        if(sysUserTotal==0)
        {
            render "{total:"+sysUserTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start'):0
            def endCurrentPage = startCurrentPage + pageSize - 1>=sysUserTotal ? sysUserTotal - 1 : startCurrentPage + pageSize - 1

            def sysUserList = SysUser.findAll()[startCurrentPage..endCurrentPage]
            def renderList=[]
            sysUserList.each{item ->
                renderList.add(new HashMap(
                    id:item.id,
                    name: item.name,
                    login: item.login,
                    password: item.password,
                    enable: item.enable,
                    sysRoles: item.sysRoles*.toString().join(',')

                ))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + sysUserTotal + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {
        def sysUser = SysUser.get(params.id)

        if (sysUser) {
            try {
                def map=new HashMap(
                    id: sysUser.id,
                    name: sysUser.name,
                    login: sysUser.login,
                    password: sysUser.password,
                    enable: sysUser.enable,
                    sysRoles: sysUser.sysRoles*.id

                )

                def json=map as grails.converters.JSON
                def output="{success:true, data:"+json+"}"
                render output
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                render "{success:false,msg:'记录不存在！'}"
            }
        }
        else {
            render "{success:false,msg:'记录不存在！'}"
        }
    }

    def createJSON = {
        def sysUser=new SysUser()

        println params.birthTime
        
        sysUser.name=params.name
        sysUser.login=params.login
        sysUser.password=params.password
        sysUser.enable=params.enable?true:false
        if(params.sysRoles.tokenize(',').size()>0){
            SysRole.getAll(params.sysRoles.tokenize(',')*.toLong()).each{ sysRole->
                sysUser.addToSysRoles(sysRole)
            }
        }

        try{
            sysUser.save()

            render "{success:true,msg:'记录已创建'}";
        }catch(Exception e){
            println "Saving error"+sysUser.toString()
            println e.toString()

            render "{success:false,msg:'记录创建异常'}";
        }
    }

    def updateJSON = {
        def sysUser=SysUser.get(params.id)
        sysUser.name=params.name
        sysUser.login=params.login
        sysUser.password=params.password
        sysUser.enable=params.enable?true:false
        def originSysRoles = sysUser.sysRoles*.id
        def newSysRoles = params.sysRoles.tokenize(',')*.toLong()

        if ((originSysRoles - newSysRoles).size() > 0) {
            SysRole.getAll(originSysRoles - newSysRoles).each {sysRole ->
                sysUser.removeFromSysRoles(sysRole)
            }
        }
        if ((newSysRoles - originSysRoles).size() > 0) {
            SysRole.getAll(newSysRoles - originSysRoles).each {sysRole ->
                sysUser.addToSysRoles(sysRole)
            }
        }

        try{
            sysUser.save()
            render "{success:true,msg:'记录已更新'}";
        }catch(Exception e){
            println "Saving error"+sysUser.toString()
            println e.toString()
            render "{success:false,msg:'记录更新异常'}";
        }
    }

    def deleteJSON = {
        try{
            def sysUserIdList=[]
            sysUserIdList=params.id

            for(int i=0;i<sysUserIdList.size();i++)
            {
                def sysUser=SysUser.get(sysUserIdList[i])

                sysUser?.save()
                sysUser?.delete()
            }

            render "{success:true,msg:'"+sysUserIdList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
            render "{success:false,msg:'记录删除失败'}";
        }
    }
}