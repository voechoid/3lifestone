//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function:
//------------------------------------------------------------

import groovy.text.SimpleTemplateEngine

includeTargets << grailsScript("Init")
includeTargets << grailsScript("_GrailsBootstrap")

target(main: "Generate the index page accroding the navigation flag among the domain-classes.") {
    depends(loadApp)
	
	templateFilePath = "$triplelifestonePluginDir/src/templates/_frontpage.gsp"
	outputFilePath = "$basedir/grails-app/views/home/index.gsp"

	File templateFile = new File(templateFilePath)
	if (!templateFile.exists()) {
		println "Shit! $templateFilePath doesn't exist"
		return
	}

	File outFile = new File(outputFilePath)

	def binding = [:]
	
	outFile.withWriter { writer ->
		def template = new SimpleTemplateEngine().createTemplate(templateFile.text)
		template.make(binding).writeTo(writer)
	}

	println "index.gsp generated at $outFile.absolutePath"
}

setDefaultTarget(main)