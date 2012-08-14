package business

class CompanyController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def afterInterceptor = { model ->
        println "tracing action uri:"+actionUri
        println "model:"+model
	}

    def index = {
    }

    def associationListJSON = {
        def companyTotal=Company.count()

        if(companyTotal==0)
        {
            render "{total:"+companyTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start') : 0
            def endCurrentPage = startCurrentPage + pageSize - 1>=companyTotal ? companyTotal - 1 : startCurrentPage + pageSize - 1
            def companyList = Company.findAll()[startCurrentPage..endCurrentPage]

            def associationList=[]
            companyList.each{item ->
                associationList.add(new HashMap(id: item.id, value: item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{companyTotal:" + companyTotal + ",root:" + json + "}"
            render output
        }
    }

    def listJSON = {
        def companyTotal=Company.count()

        if(companyTotal==0)
        {
            render "{total:"+companyTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start'):0
            def endCurrentPage = startCurrentPage + pageSize - 1>=companyTotal ? companyTotal - 1 : startCurrentPage + pageSize - 1

            def companyList = Company.findAll()[startCurrentPage..endCurrentPage]
            def renderList=[]
            companyList.each{item ->
                renderList.add(new HashMap(
                    id:item.id,
                    name: item.name,
                    type: item.type,
                    settingUpDate: item.settingUpDate,
                    summary: item.summary

                ))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + companyTotal + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {
        def company = Company.get(params.id)

        if (company) {
            try {
                def map=new HashMap(
                    id: company.id,
                    name: company.name,
                    type: company.type,
                    settingUpDate: company.settingUpDate,
                    summary: company.summary

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
        def company=new Company()

        println params.birthTime
        
        company.name=params.name
        company.type=params.type
        company.settingUpDate=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.settingUpDate)
        company.summary=params.summary

        try{
            company.save()

            render "{success:true,msg:'记录已创建'}";
        }catch(Exception e){
            println "Saving error"+company.toString()
            println e.toString()

            render "{success:false,msg:'记录创建异常'}";
        }
    }

    def updateJSON = {
        def company=Company.get(params.id)
        company.name=params.name
        company.type=params.type
        company.settingUpDate=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.settingUpDate)
        company.summary=params.summary

        try{
            company.save()
            render "{success:true,msg:'记录已更新'}";
        }catch(Exception e){
            println "Saving error"+company.toString()
            println e.toString()
            render "{success:false,msg:'记录更新异常'}";
        }
    }

    def deleteJSON = {
        try{
            def companyIdList=[]
            companyIdList=params.id

            for(int i=0;i<companyIdList.size();i++)
            {
                def company=Company.get(companyIdList[i])

                company?.save()
                company?.delete()
            }

            render "{success:true,msg:'"+companyIdList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
            render "{success:false,msg:'记录删除失败'}";
        }
    }
}