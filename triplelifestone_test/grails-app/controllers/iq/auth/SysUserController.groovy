package iq.auth

class SysUserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def afterInterceptor = { model ->
        println "tracing action uri:"+actionUri
        println "model:"+model
	}

    def index = {
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
                    sysRole: item.sysRole*.toString().join(',')

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
                    sysRole: sysUser.sysRole*.id

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
        if(params.sysRole.tokenize(',').size()>0){
            SysRole.getAll(params.sysRole.tokenize(',')*.toLong()).each{ sysRole->
                sysUser.addToSysRole(sysRole)
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
        def originSysRole = sysUser.sysRole*.id
        def newSysRole = params.sysRole.tokenize(',')*.toLong()

        if ((originSysRole - newSysRole).size() > 0) {
            SysRole.getAll(originSysRole - newSysRole).each {sysRole ->
                sysUser.removeFromSysRole(sysRole)
            }
        }
        if ((newSysRole - originSysRole).size() > 0) {
            SysRole.getAll(newSysRole - originSysRole).each {sysRole ->
                sysUser.addToSysRole(sysRole)
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