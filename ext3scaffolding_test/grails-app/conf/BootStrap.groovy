
class BootStrap {

    def init = { servletContext ->
        //println org.codehaus.groovy.grails.commons.ApplicationHolder.application.metadata['app.name']
        println grails.util.GrailsUtil.getEnvironment()
    }
    def destroy = {
    }
}
