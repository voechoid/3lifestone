package com.triplelifestone

class ContactController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def afterInterceptor = { model ->
        println "tracing action uri:"+actionUri
        println "model:"+model
	}

    def index = {
    }


    def associationListJSON = {
        def contactTotal=Contact.count()

        if(contactTotal==0)
        {
            render "{total:"+contactTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start') : 0
            def endCurrentPage = startCurrentPage + pageSize - 1>=contactTotal ? contactTotal - 1 : startCurrentPage + pageSize - 1
            def contactList = Contact.findAll()[startCurrentPage..endCurrentPage]

            def associationList=[]
            contactList.each{item ->
                associationList.add(new HashMap(id: item.id, value: item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{contactTotal:" + contactTotal + ",root:" + json + "}"
            render output
        }
    }

    def listJSON = {
        def contactTotal=Contact.count()

        if(contactTotal==0)
        {
            render "{total:"+contactTotal+",root:[]}"
        } else {
            def pageSize = 15
            def startCurrentPage = params.start ? params.int('start'):0
            def endCurrentPage = startCurrentPage + pageSize - 1>=contactTotal ? contactTotal - 1 : startCurrentPage + pageSize - 1

            def contactList = Contact.findAll()[startCurrentPage..endCurrentPage]
            def renderList=[]
            contactList.each{item ->
                renderList.add(new HashMap(
                    id:item.id,
                    name: item.name,
                    email: item.email,
                    mobile: item.mobile,
                    birthday: item.birthday

                ))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + contactTotal + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {
        def contact = Contact.get(params.id)

        if (contact) {
            try {
                def map=new HashMap(
                    id: contact.id,
                    name: contact.name,
                    email: contact.email,
                    mobile: contact.mobile,
                    birthday: contact.birthday

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
        def contact=new Contact()

        println params.birthTime
        
        contact.name=params.name
        contact.email=params.email
        contact.mobile=params.mobile
        contact.birthday=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.birthday)

        try{
            contact.save()

            render "{success:true,msg:'记录已创建'}";
        }catch(Exception e){
            println "Saving error"+contact.toString()
            println e.toString()

            render "{success:false,msg:'记录创建异常'}";
        }
    }

    def updateJSON = {
        def contact=Contact.get(params.id)
        contact.name=params.name
        contact.email=params.email
        contact.mobile=params.mobile
        contact.birthday=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.birthday)

        try{
            contact.save()
            render "{success:true,msg:'记录已更新'}";
        }catch(Exception e){
            println "Saving error"+contact.toString()
            println e.toString()
            render "{success:false,msg:'记录更新异常'}";
        }
    }

    def deleteJSON = {
        try{
            def contactIdList=[]
            contactIdList=params.id

            for(int i=0;i<contactIdList.size();i++)
            {
                def contact=Contact.get(contactIdList[i])

                contact?.save()
                contact?.delete()
            }

            render "{success:true,msg:'"+contactIdList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
            render "{success:false,msg:'记录删除失败'}";
        }
    }
}