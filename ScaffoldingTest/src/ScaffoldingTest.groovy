/**
 * Created with IntelliJ IDEA.
 * User: bruce_lin_chn
 * Date: 12-8-24
 * Time: 下午9:40
 * To change this template use File | Settings | File Templates.
 */
def template(String tpl, Map map)
{
    def result=tpl
    map.each{key,value->
        result=result.replaceAll("_"+key.toString().toUpperCase()+"_",value)
    }

    return result
}

def navigationGroups =[
        [group: "系统管理", icon:"settings", items:[[name:"sysUser", chn:"用户管理", image:"group.png"],[name:"sysRole", chn:"角色管理", image:"group.png"]]]
]

def navigationGroupTemplate="""
    {title: '_GROUP_', border:false, html: '_ITEMS_',icon: '_ICON_'}
    """.trim()
def navigationItemTemplate="""
    <a id="_NAME_Index" href="#"><center><img src="/triplelifestone_test/images/_IMAGE_"/><br>_CHN_</center></a>
    """.trim()
def itemsHtml=""
navigationGroups[0].items.each{item->
    itemsHtml=itemsHtml+template(navigationItemTemplate,item)

    println itemsHtml
}
navigationGroups[0].items=itemsHtml
println itemsHtml
println navigationGroups[0]
def groupHtml=template(navigationGroupTemplate,navigationGroups[0])
println template(navigationGroupTemplate,navigationGroups[0])
println groupHtml
