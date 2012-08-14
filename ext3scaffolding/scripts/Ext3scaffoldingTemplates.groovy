includeTargets << grailsScript("_GrailsInit")

target ('default': "Installs the artifact and scaffolding templates") {
    depends(checkVersion, parseArguments)
    event 'InstallTemplatesStart', [ 'Installing Templates...' ]
    targetDir = "${basedir}/src/templates"
    overwrite = false

    // only if template dir already exists in, ask to overwrite templates
    if (new File(targetDir).exists()) {
        //if (!isInteractive || confirmInput("Overwrite existing templates? [y/n]","overwrite.templates")) {
            overwrite = true
        //}
    }
    else {
        ant.mkdir(dir: targetDir)
    }

//    new File("aaa.txt")<< basedir+"\r\n"
//    new File("aaa.txt")<< targetDir+"\r\n"
//    new File("aaa.txt")<< "${basedir}\\plugins\\ext3scaffolding\\src\\templates\\artifacts\\"+"\r\n"
//
//    copyGrailsResources("$targetDir/artifacts/", "$ext3scaffoldingPluginDir\\src\\templates\\artifacts\\*")
//    copyGrailsResources("$targetDir/scaffolding", "${basedir}\\plugins\\ext3scaffolding\\src\\templates\\scaffolding\\*", overwrite)
//    copyGrailsResources("$targetDir/testing", "${basedir}\\plugins\\ext3scaffolding\\src\\templates\\testing\\*", overwrite)

    copyFile "$ext3scaffoldingPluginDir/src/templates/artifacts/DomainClass.groovy","$targetDir/artifacts/DomainClass.groovy"
    ant.mkdir(dir:"${targetDir}/war")
    copyGrailsResource("${targetDir}/war/web.xml", grailsResource("src/war/WEB-INF/web${servletVersion}.template.xml"), overwrite)

    event("StatusUpdate", [ "Templates installed successfully"])
    event 'InstallTemplatesEnd', [ 'Finished Installing Templates.' ]
}

copyFile = { String from, String to ->
    Ant.copy(file: from, tofile: to, overwrite: overwrite)
}