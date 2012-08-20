//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------

package iq

import grails.util.GrailsUtil

class Ext3scaffoldingTagLib {
    static namespace="iq"
    static init=false
    static env="none"
    static name="none"
    static runningWithinPlugin=null

    def init(){
        if(init==false)
        {
            name=grailsApplication.metadata['app.name']
            env=GrailsUtil.getEnvironment()

            if (name =="triplelifestone")
            {
                runningWithinPlugin=true
            }else{
                runningWithinPlugin=false
            }

            init=true
        }
    }

    def link={attrs, body ->
        if(init==false) {init()}
    }

    def url={attrs, body ->
        if(init==false) {init()}
    }

    def ext_rsc={attrs, body ->

        String target=""
        if(init==false) {init()}

        //new File("execlog.txt").append(name)
        //new File("execlog.txt").append(runningWithinPlugin)
        //new File("execlog.txt").append(env)

        if(runningWithinPlugin==false)
        {
            target="""
<link rel="stylesheet" type="text/css" href="/_APPNAME_/plugins/triplelifestone-1.0/ext3/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="/_APPNAME_/plugins/triplelifestone-1.0/ext3/fading-msg.css" />
<link rel="stylesheet" type="text/css" href="/_APPNAME_/plugins/triplelifestone-1.0/ext3/ux/css/MultiSelect.css" />
<script type="text/javascript" src="/_APPNAME_/plugins/triplelifestone-1.0/ext3/adapter/ext/ext-base.js" ></script>
<script type="text/javascript" src="/_APPNAME_/plugins/triplelifestone-1.0/ext3/ext-all.js" ></script>
<script type="text/javascript" src="/_APPNAME_/plugins/triplelifestone-1.0/ext3/ux/MultiSelect.js"></script>
<script type="text/javascript" src="/_APPNAME_/plugins/triplelifestone-1.0/ext3/ext-lang-zh_CN.js" ></script>
<script type="text/javascript" src="/_APPNAME_/plugins/triplelifestone-1.0/ext3/fading-msg.js" ></script>
"""
        }else{
            target="""
<link rel="stylesheet" type="text/css" href="/_APPNAME_/ext3/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="/_APPNAME_/ext3/fading-msg.css" />
<link rel="stylesheet" type="text/css" href="/_APPNAME_/ext3/ux/css/MultiSelect.css" />
<script type="text/javascript" src="/_APPNAME_/ext3/adapter/ext/ext-base.js" ></script>
<script type="text/javascript" src="/_APPNAME_/ext3/ext-all.js" ></script>
<script type="text/javascript" src="/_APPNAME_/ext3/ux/MultiSelect.js"></script>
<script type="text/javascript" src="/_APPNAME_/ext3/ext-lang-zh_CN.js" ></script>
<script type="text/javascript" src="/_APPNAME_/ext3/fading-msg.js" ></script>
"""
        }

        target=target.replaceAll("_APPNAME_",name)
        out << target.trim()
    }

    def ext_begin={attrs, body ->
        out<<"""
<script type="text/javascript">
Ext.onReady(function() {"""
    }

    def ext_end={attrs, body ->
        out<<"""
});
</script>"""
    }
}
