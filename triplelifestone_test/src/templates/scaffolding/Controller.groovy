<%=packageName ? "package ${packageName}\n\n" : ''%>class ${className}Controller {<% import grails.persistence.Event %><% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %><% boolean hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate') %>
<%
    grailsApplication=org.codehaus.groovy.grails.commons.ApplicationHolder.application
    appName=grailsApplication.metadata['app.name']

    iqConstraints=domainClass.getConstrainedProperties()

    iqDomainClass=[:]

    iqDomainClass.iqDomain=domainClass.clazz.iqDomain
	iqLayout=domainClass.clazz.iqLayout

    iqDomainClass.properties=[]

    excludedProps = Event.allEvents.toList() << 'version'<< 'id'
    allowedNames = domainClass.persistentProperties*.name  << 'dateCreated' << 'lastUpdated'
    props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name)}
    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))

    for( p in props)
    {
        def map=[:]

        if (p.name == 'version' || p.name=='id'){continue}

        if(p.name=='dateCreated' || p.name=='lastUpdated')
        {
            if(p.name=='dateCreated')
            {
                map.chn = '创建时间'
            }else{
                map.chn = '最近更新'
            }

            map.display=true
            map.association = false
            map.display=true

        }else if(p.isAssociation())
        {
            map.chn = p.getReferencedDomainClass().clazz.iqDomain.chn
            map.association = true
            map.display=true
            map.referenceDomain=p.getReferencedDomainClass()?.getLogicalPropertyName().capitalize()
            map.referenceName=p.getReferencedDomainClass()?.getLogicalPropertyName()
            map.bidirectional=p.isBidirectional()
            map.owningSide=p.isOwningSide()
        }else {
            map.chn = iqConstraints[p.name].attributes.chn
            map.widget = iqConstraints[p.name].attributes.widget
            map.association = false
            map.display=iqConstraints[p.name].display? iqConstraints[p.name].display : true
        }

        map.last = false
        map.name = p.name
        map.p=p

        iqDomainClass.properties << map

    }

    iqDomainClass.properties[-1].last=true

    def ViewToModelConverter(prop, mode) {
        def p=prop.p
        def cp=iqConstraints[prop.name]

        if (p.type == Date.class) {
            if(cp.attributes.widget!="timefield"){
                println "        ${domainClass.propertyName}.${p.name}=(new java.text.SimpleDateFormat(\"yyyy-MM-dd\")).parse(params.${p.name})"
            }else{
                println "        ${domainClass.propertyName}.${p.name}=(new java.text.SimpleDateFormat(\"hh:mm\")).parse(params.${p.name})"
            }
        } else if (p.type == int) {
            println "        ${domainClass.propertyName}.${p.name}=params.${p.name}.toInteger()"
        } else if (p.type == float) {
            println "        ${domainClass.propertyName}.${p.name}=params.${p.name}.toFloat()"
        } else if (p.type == boolean) {
            println "        ${domainClass.propertyName}.${p.name}=params.${p.name}?true:false"
        } else if (p.type == String.class) {
            println "        ${domainClass.propertyName}.${p.name}=params.${p.name}"
        } else if (p.isAssociation()) {
            if(p.isOneToOne() || p.isManyToOne())
            {
                println "        ${domainClass.propertyName}.${p.name}=${prop.referenceDomain}.get(params.${p.name}.toLong())"
            }else{
                if(mode=="create"){
                    println "        if(params.${p.name}.tokenize(',').size()>0){"
                    println "            ${prop.referenceDomain}.getAll(params.${p.name}.tokenize(',')*.toLong()).each{ ${prop.referenceName}->"
                    println "                ${domainClass.propertyName}.addTo${p.name.capitalize()}(${prop.referenceName})"
                    println "            }"
                    println "        }"
                } else {//"update"
                    println "        def origin${p.name.capitalize()} = ${domainClass.propertyName}.${p.name}*.id"
                    println "        def new${p.name.capitalize()} = params.${p.name}.tokenize(',')*.toLong()"
                    println ""
                    println "        if ((origin${p.name.capitalize()} - new${p.name.capitalize()}).size() > 0) {"
                    println "            ${prop.referenceDomain}.getAll(origin${p.name.capitalize()} - new${p.name.capitalize()}).each {${prop.referenceName} ->"
                    println "                ${domainClass.propertyName}.removeFrom${p.name.capitalize()}(${prop.referenceName})"
                    println "            }"
                    println "        }"
                    println "        if ((new${p.name.capitalize()} - origin${p.name.capitalize()}).size() > 0) {"
                    println "            ${prop.referenceDomain}.getAll(new${p.name.capitalize()} - origin${p.name.capitalize()}).each {${prop.referenceName} ->"
                    println "                ${domainClass.propertyName}.addTo${p.name.capitalize()}(${prop.referenceName})"
                    println "            }"
                    println "        }"
                }
            }
        } else {
	        println "UNKNOWN:        ${p}"
        }
    }
%>
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def afterInterceptor = { model ->
        println "tracing action uri:"+actionUri
        println "model:"+model
	}

    def index = {
    }
<% if(className=="SysUser"){%>
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
<%}%>

    def associationListJSON = {
        def ${domainClass.propertyName}Total=${className}.count()

        if(${domainClass.propertyName}Total==0)
        {
            render "{total:"+${domainClass.propertyName}Total+",root:[]}"
        } else {
            def pageSize = <% out<< iqLayout.itemsPerPage %>
            def startCurrentPage = params.start ? params.int('start') : 0
            def endCurrentPage = startCurrentPage + pageSize - 1>=${domainClass.propertyName}Total ? ${domainClass.propertyName}Total - 1 : startCurrentPage + pageSize - 1
            def ${domainClass.propertyName}List = ${className}.findAll()[startCurrentPage..endCurrentPage]

            def associationList=[]
            ${domainClass.propertyName}List.each{item ->
                associationList.add(new HashMap(id: item.id, value: item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{${domainClass.propertyName}Total:" + ${domainClass.propertyName}Total + ",root:" + json + "}"
            render output
        }
    }

    def listJSON = {
        def ${domainClass.propertyName}Total=${className}.count()

        if(${domainClass.propertyName}Total==0)
        {
            render "{total:"+${domainClass.propertyName}Total+",root:[]}"
        } else {
            def pageSize = <% out<< iqLayout.itemsPerPage %>
            def startCurrentPage = params.start ? params.int('start'):0
            def endCurrentPage = startCurrentPage + pageSize - 1>=${domainClass.propertyName}Total ? ${domainClass.propertyName}Total - 1 : startCurrentPage + pageSize - 1

            def ${domainClass.propertyName}List = ${className}.findAll()[startCurrentPage..endCurrentPage]
            def renderList=[]
            ${domainClass.propertyName}List.each{item ->
                renderList.add(new HashMap(
                    id:item.id,
<%
    for(prop in iqDomainClass.properties)
    {
        if (prop.display)
        {
            print "    "*5
            print "${prop.name}: "
            if(prop.association==true && (prop.p.isOneToOne() || prop.p.isManyToOne()))
            {
                print "item.${prop.name}.toString()"
            }else if(prop.association==true)
            {
                print "item.${prop.name}*.toString().join(',')"
            }else
            {
                print "item.${prop.name}"
            }
            if(prop.last==false)
            {
                println ","
            }else{
                println ""
            }
        }
    }
%>
                ))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + ${domainClass.propertyName}Total + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {
        def ${domainClass.propertyName} = ${className}.get(params.id)

        if (${domainClass.propertyName}) {
            try {
                def map=new HashMap(
                    id: ${domainClass.propertyName}.id,
<%
    for(prop in iqDomainClass.properties)
    {
        if (prop.display)
        {
            print "    "*5
            print "${prop.name}: "
            if(prop.association==true && (prop.p.isOneToOne() || prop.p.isManyToOne()))
            {
                print "${domainClass.propertyName}.${prop.name}.id"
            }else if(prop.association==true)
            {
                print "${domainClass.propertyName}.${prop.name}*.id"
            }else
            {
                print "${domainClass.propertyName}.${prop.name}"
            }

            if(prop.last==false)
            {
                println ","
            }else{
                println ""
            }
        }
    }
%>
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
        def ${domainClass.propertyName}=new ${className}()

        println params.birthTime
        
<%
    for(prop in iqDomainClass.properties)
    {
        if (prop.display)
        {
            ViewToModelConverter(prop, "create")
        }
    }
%>
        try{
            ${domainClass.propertyName}.save()

            render "{success:true,msg:'记录已创建'}";
        }catch(Exception e){
            println "Saving error"+${domainClass.propertyName}.toString()
            println e.toString()

            render "{success:false,msg:'记录创建异常'}";
        }
    }

    def updateJSON = {
        def ${domainClass.propertyName}=${className}.get(params.id)
<%
    for(prop in iqDomainClass.properties)
    {
        if (prop.display)
        {
            ViewToModelConverter(prop, "update")
        }
    }
%>
        try{
            ${domainClass.propertyName}.save()
            render "{success:true,msg:'记录已更新'}";
        }catch(Exception e){
            println "Saving error"+${domainClass.propertyName}.toString()
            println e.toString()
            render "{success:false,msg:'记录更新异常'}";
        }
    }

    def deleteJSON = {
        try{
            def ${domainClass.propertyName}IdList=[]
            ${domainClass.propertyName}IdList=params.id

            for(int i=0;i<${domainClass.propertyName}IdList.size();i++)
            {
                def ${domainClass.propertyName}=${className}.get(${domainClass.propertyName}IdList[i])
<%
    for(prop in iqDomainClass.properties)
    {
        if (prop.display && prop.association==true && prop.p.isManyToMany())
        {
            println "    "*4+"${domainClass.propertyName}.${prop.name}?.each{ ${domainClass.propertyName}.removeFrom${prop.name.capitalize()}(it)}"
        }
    }
%>
                ${domainClass.propertyName}?.save()
                ${domainClass.propertyName}?.delete()
            }

            render "{success:true,msg:'"+${domainClass.propertyName}IdList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
            render "{success:false,msg:'记录删除失败'}";
        }
    }
}