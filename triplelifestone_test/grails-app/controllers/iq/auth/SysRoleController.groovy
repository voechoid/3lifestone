package iq.auth

class SysRoleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def afterInterceptor = { model ->
        println "tracing action uri:"+actionUri
        println "model:"+model
	}

    def index = {
    }


    def associationListJSON = {
        def sysRoleTotal=SysRole.count()

        if(sysRoleTotal==0)
        {
            render "{total:"+sysRoleTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start') : 0
            def endCurrentPage = startCurrentPage + pageSize - 1>=sysRoleTotal ? sysRoleTotal - 1 : startCurrentPage + pageSize - 1
            def sysRoleList = SysRole.findAll()[startCurrentPage..endCurrentPage]

            def associationList=[]
            sysRoleList.each{item ->
                associationList.add(new HashMap(id: item.id, value: item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{sysRoleTotal:" + sysRoleTotal + ",root:" + json + "}"
            render output
        }
    }

    def listJSON = {
        def sysRoleTotal=SysRole.count()

        if(sysRoleTotal==0)
        {
            render "{total:"+sysRoleTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start'):0
            def endCurrentPage = startCurrentPage + pageSize - 1>=sysRoleTotal ? sysRoleTotal - 1 : startCurrentPage + pageSize - 1

            def sysRoleList = SysRole.findAll()[startCurrentPage..endCurrentPage]
            def renderList=[]
            sysRoleList.each{item ->
                renderList.add(new HashMap(
                    id:item.id,
                    name: item.name,
                    code: item.code,
                    description: item.description,
                    enable: item.enable

                ))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + sysRoleTotal + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {
        def sysRole = SysRole.get(params.id)

        if (sysRole) {
            try {
                def map=new HashMap(
                    id: sysRole.id,
                    name: sysRole.name,
                    code: sysRole.code,
                    description: sysRole.description,
                    enable: sysRole.enable

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
        def sysRole=new SysRole()

        println params.birthTime
        
        sysRole.name=params.name
        sysRole.code=params.code
        sysRole.description=params.description
        sysRole.enable=params.enable?true:false

        try{
            sysRole.save()

            render "{success:true,msg:'记录已创建'}";
        }catch(Exception e){
            println "Saving error"+sysRole.toString()
            println e.toString()

            render "{success:false,msg:'记录创建异常'}";
        }
    }

    def updateJSON = {
        def sysRole=SysRole.get(params.id)
        sysRole.name=params.name
        sysRole.code=params.code
        sysRole.description=params.description
        sysRole.enable=params.enable?true:false

        try{
            sysRole.save()
            render "{success:true,msg:'记录已更新'}";
        }catch(Exception e){
            println "Saving error"+sysRole.toString()
            println e.toString()
            render "{success:false,msg:'记录更新异常'}";
        }
    }

    def deleteJSON = {
        try{
            def sysRoleIdList=[]
            sysRoleIdList=params.id

            for(int i=0;i<sysRoleIdList.size();i++)
            {
                def sysRole=SysRole.get(sysRoleIdList[i])

                sysRole?.save()
                sysRole?.delete()
            }

            render "{success:true,msg:'"+sysRoleIdList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
            render "{success:false,msg:'记录删除失败'}";
        }
    }
}