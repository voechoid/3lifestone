package auth

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def afterInterceptor = { model ->
        println "tracing action uri:"+actionUri
        println "model:"+model
	}

    def index = {
    }

    def associationListJSON = {
        def userTotal=User.count()

        if(userTotal==0)
        {
            render "{total:"+userTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start') : 0
            def endCurrentPage = startCurrentPage + pageSize - 1>=userTotal ? userTotal - 1 : startCurrentPage + pageSize - 1
            def userList = User.findAll()[startCurrentPage..endCurrentPage]

            def associationList=[]
            userList.each{item ->
                associationList.add(new HashMap(id: item.id, value: item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{userTotal:" + userTotal + ",root:" + json + "}"
            render output
        }
    }

    def listJSON = {
        def userTotal=User.count()

        if(userTotal==0)
        {
            render "{total:"+userTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start'):0
            def endCurrentPage = startCurrentPage + pageSize - 1>=userTotal ? userTotal - 1 : startCurrentPage + pageSize - 1

            def userList = User.findAll()[startCurrentPage..endCurrentPage]
            def renderList=[]
            userList.each{item ->
                renderList.add(new HashMap(
                    id:item.id,
                    username: item.username,
                    loginname: item.loginname,
                    password: item.password,
                    enable: item.enable,
                    role: item.role*.toString().join(',')

                ))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + userTotal + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {
        def user = User.get(params.id)

        if (user) {
            try {
                def map=new HashMap(
                    id: user.id,
                    username: user.username,
                    loginname: user.loginname,
                    password: user.password,
                    enable: user.enable,
                    role: user.role*.id

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
        def user=new User()

        println params.birthTime
        
        user.username=params.username
        user.loginname=params.loginname
        user.password=params.password
        user.enable=params.enable?true:false
        if(params.role.tokenize(',').size()>0){
            Role.getAll(params.role.tokenize(',')*.toLong()).each{ role->
                user.addToRole(role)
            }
        }

        try{
            user.save()

            render "{success:true,msg:'记录已创建'}";
        }catch(Exception e){
            println "Saving error"+user.toString()
            println e.toString()

            render "{success:false,msg:'记录创建异常'}";
        }
    }

    def updateJSON = {
        def user=User.get(params.id)
        user.username=params.username
        user.loginname=params.loginname
        user.password=params.password
        user.enable=params.enable?true:false
        def originRole = user.role*.id
        def newRole = params.role.tokenize(',')*.toLong()

        if ((originRole - newRole).size() > 0) {
            Role.getAll(originRole - newRole).each {role ->
                user.removeFromRole(role)
            }
        }
        if ((newRole - originRole).size() > 0) {
            Role.getAll(newRole - originRole).each {role ->
                user.addToRole(role)
            }
        }

        try{
            user.save()
            render "{success:true,msg:'记录已更新'}";
        }catch(Exception e){
            println "Saving error"+user.toString()
            println e.toString()
            render "{success:false,msg:'记录更新异常'}";
        }
    }

    def deleteJSON = {
        try{
            def userIdList=[]
            userIdList=params.id

            for(int i=0;i<userIdList.size();i++)
            {
                def user=User.get(userIdList[i])

                user?.save()
                user?.delete()
            }

            render "{success:true,msg:'"+userIdList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
            render "{success:false,msg:'记录删除失败'}";
        }
    }
}