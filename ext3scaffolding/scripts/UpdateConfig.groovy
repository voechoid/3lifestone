/*************************************************
 Copyright by www.3lifestone.com, all rights reserved.
 **************************************************
 voechoid
 voechoid@qq.com
 ************************************************ */

includeTargets << grailsScript("Init")

target(main: "Update the main project config file") {
    config=new File("$basedir/grails-app/conf/Config.groovy")
    if(config.text.contains("grails.converters.json.date = 'javascript'")==false)
    {
        config << """
//3lifestone modify start
grails.converters.json.date = 'javascript'
//3lifestone modify end
"""
        event("StatusUpdate", [ "the main project config is updated"])
    }else{
        event("StatusUpdate", [ "the main project config is already updated"])
    }
}

setDefaultTarget(main)
