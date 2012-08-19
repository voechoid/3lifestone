package system

class GroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def afterInterceptor = { model ->
        println "tracing action uri:"+actionUri
        println "model:"+model
	}

    def index = {
    }

    def associationListJSON = {
        def groupTotal=Group.count()

        if(groupTotal==0)
        {
            render "{total:"+groupTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start') : 0
            def endCurrentPage = startCurrentPage + pageSize - 1>=groupTotal ? groupTotal - 1 : startCurrentPage + pageSize - 1
            def groupList = Group.findAll()[startCurrentPage..endCurrentPage]

            def associationList=[]
            groupList.each{item ->
                associationList.add(new HashMap(id: item.id, value: item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{groupTotal:" + groupTotal + ",root:" + json + "}"
            render output
        }
    }

    def listJSON = {
        def groupTotal=Group.count()

        if(groupTotal==0)
        {
            render "{total:"+groupTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start'):0
            def endCurrentPage = startCurrentPage + pageSize - 1>=groupTotal ? groupTotal - 1 : startCurrentPage + pageSize - 1

            def groupList = Group.findAll()[startCurrentPage..endCurrentPage]
            def renderList=[]
            groupList.each{item ->
                renderList.add(new HashMap(
                    id:item.id,
                    name: item.name,
                    color: item.color,
                    isStupid: item.isStupid,
                    age: item.age,
                    money: item.money,
                    birthday: item.birthday,
                    multiLine: item.multiLine,
                    htmlContent: item.htmlContent

                ))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + groupTotal + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {
        def group = Group.get(params.id)

        if (group) {
            try {
                def map=new HashMap(
                    id: group.id,
                    name: group.name,
                    color: group.color,
                    isStupid: group.isStupid,
                    age: group.age,
                    money: group.money,
                    birthday: group.birthday,
                    multiLine: group.multiLine,
                    htmlContent: group.htmlContent

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
        def group=new Group()

        println params.birthTime
        
        group.name=params.name
        group.color=params.color
        group.isStupid=params.isStupid?true:false
        group.age=params.age.toInteger()
        group.money=params.money.toFloat()
        group.birthday=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.birthday)
        group.multiLine=params.multiLine
        group.htmlContent=params.htmlContent

        try{
            group.save()

            render "{success:true,msg:'记录已创建'}";
        }catch(Exception e){
            println "Saving error"+group.toString()
            println e.toString()

            render "{success:false,msg:'记录创建异常'}";
        }
    }

    def updateJSON = {
        def group=Group.get(params.id)
        group.name=params.name
        group.color=params.color
        group.isStupid=params.isStupid?true:false
        group.age=params.age.toInteger()
        group.money=params.money.toFloat()
        group.birthday=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.birthday)
        group.multiLine=params.multiLine
        group.htmlContent=params.htmlContent

        try{
            group.save()
            render "{success:true,msg:'记录已更新'}";
        }catch(Exception e){
            println "Saving error"+group.toString()
            println e.toString()
            render "{success:false,msg:'记录更新异常'}";
        }
    }

    def deleteJSON = {
        try{
            def groupIdList=[]
            groupIdList=params.id

            for(int i=0;i<groupIdList.size();i++)
            {
                def group=Group.get(groupIdList[i])

                group?.save()
                group?.delete()
            }

            render "{success:true,msg:'"+groupIdList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
            render "{success:false,msg:'记录删除失败'}";
        }
    }
}