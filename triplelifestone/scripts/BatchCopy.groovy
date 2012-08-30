
//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------
//import org.apache.tools.ant.taskdefs.Ant
//import groovy.text.SimpleTemplateEngine

includeTargets << grailsScript("_GrailsInit")

target ('default': "Installs the artifact and scaffolding templates") {
    depends(checkVersion, parseArguments)
    event 'InstallTemplatesStart', [ 'Installing Templates...' ]
    targetDir = "$basedir/src/"
    overwrite = true


    try{
        //读取内容，写入文件
        new File("${triplelifestonePluginDir}/src/templates/domain/").listFiles().each{file->
            //new File("${targetDir}/${file.name}").append(new File("${triplelifestonePluginDir}/src/templates/domain/${file.name}").getText("UTF-8"))
            new File("$basedir/src/"+file.name).write(new File("${triplelifestonePluginDir}/src/templates/domain/${file.name}").getText("UTF-8"))

            //result="copy ${triplelifestonePluginDir}/src/templates/domain/${file.name} ${targetDir}".execute()
            //new File("wonderful.txt").append(result+"\r\n")
        }
    }catch(Exception e){
        new File("wonderful.txt").append(e.message+"\r\n")
    }

    // only if template dir already exists in, ask to overwrite templates
    ant.mkdir(dir: "$basedir/grails-app/routines")

    event("StatusUpdate", [ "Templates installed successfully"])
}

copyFile = { String from, String to ->
    Ant.copy(file: from, tofile: to, overwrite: overwrite)
}