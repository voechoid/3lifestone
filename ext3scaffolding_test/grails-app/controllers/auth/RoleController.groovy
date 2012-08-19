package auth

class RoleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def afterInterceptor = { model ->
        println "tracing action uri:"+actionUri
        println "model:"+model
	}

    def index = {
    }

    def associationListJSON = {
        def roleTotal=Role.count()

        if(roleTotal==0)
        {
            render "{total:"+roleTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start') : 0
            def endCurrentPage = startCurrentPage + pageSize - 1>=roleTotal ? roleTotal - 1 : startCurrentPage + pageSize - 1
            def roleList = Role.findAll()[startCurrentPage..endCurrentPage]

            def associationList=[]
            roleList.each{item ->
                associationList.add(new HashMap(id: item.id, value: item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{roleTotal:" + roleTotal + ",root:" + json + "}"
            render output
        }
    }

    def listJSON = {
        def roleTotal=Role.count()

        if(roleTotal==0)
        {
            render "{total:"+roleTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start'):0
            def endCurrentPage = startCurrentPage + pageSize - 1>=roleTotal ? roleTotal - 1 : startCurrentPage + pageSize - 1

            def roleList = Role.findAll()[startCurrentPage..endCurrentPage]
            def renderList=[]
            roleList.each{item ->
                renderList.add(new HashMap(
                    id:item.id,
                    name: item.name,
                    code: item.code,
                    description: item.description,
                    enable: item.enable

                ))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + roleTotal + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {
        def role = Role.get(params.id)

        if (role) {
            try {
                def map=new HashMap(
                    id: role.id,
                    name: role.name,
                    code: role.code,
                    description: role.description,
                    enable: role.enable

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
        def role=new Role()

        println params.birthTime
        
        role.name=params.name
        role.code=params.code
        role.description=params.description
        role.enable=params.enable?true:false

        try{
            role.save()

            render "{success:true,msg:'记录已创建'}";
        }catch(Exception e){
            println "Saving error"+role.toString()
            println e.toString()

            render "{success:false,msg:'记录创建异常'}";
        }
    }

    def updateJSON = {
        def role=Role.get(params.id)
        role.name=params.name
        role.code=params.code
        role.description=params.description
        role.enable=params.enable?true:false

        try{
            role.save()
            render "{success:true,msg:'记录已更新'}";
        }catch(Exception e){
            println "Saving error"+role.toString()
            println e.toString()
            render "{success:false,msg:'记录更新异常'}";
        }
    }

    def deleteJSON = {
        try{
            def roleIdList=[]
            roleIdList=params.id

            for(int i=0;i<roleIdList.size();i++)
            {
                def role=Role.get(roleIdList[i])

                role?.save()
                role?.delete()
            }

            render "{success:true,msg:'"+roleIdList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
            render "{success:false,msg:'记录删除失败'}";
        }
    }
}