//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------


includeTargets << grailsScript("_GrailsInit")

target('default': "The description of the script goes here!") {
    new File("analysis.txt").append("starting")
    event 'InstallTemplatesStart', [ 'Installing Templates...' ]
        new File("analysis.txt").append("I am here")

        ant.mkdir(dir: "$basedir/grails-app/routines")
        ant.mkdir(dir: "$basedir/grails-app/routines/db")
        ant.mkdir(dir: "$basedir/grails-app/routines/backup")

        copyGrailsResources("$basedir/grails-app/routines", "${triplelifestonePluginDir}/grails-app/domain/iq/auth/*", true)

    new File("analysis.txt").append("I am 3")

}
