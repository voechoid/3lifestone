/*************************************************
Copyright by www.3lifestone.com, all rights reserved.
**************************************************
模型: voechoid
作者: voechoid@qq.com
*************************************************/

package system

class Group {

    static iqDomain=[chn:"模型"]
    static iqLayout=[itemsPerPage: 15]
	static iqNavigation=[group:"管理",weight:1]

    String      name
    String      color
    boolean     isStupid
    int         age
	float       money
	Date        birthday

	String      multiLine
	String      htmlContent

	//字段按照优先级和重要性排序，显示顺序
    //display默认=true
    static constraints = {
	    name        attributes:[chn:"姓名"],blank:false,size: 1..16
        color       attributes:[chn:"颜色"],blank:false, inList:["红","黄","蓝"]
	    isStupid    attributes:[chn:"傻吗"],blank:false
	    age         attributes:[chn:"年龄"],blank:false,size: 1..16
	    money       attributes:[chn:"金钱"],blank:false,size: 1..16
	    birthday    attributes:[chn:"生日"],blank:false
	    multiLine   attributes:[chn:"多行", widget: "textarea"],blank:true,size: 0..100
	    htmlContent   attributes:[chn:"多行", widget: "htmleditor"],blank:true,size: 0..1000
    }

    String toString()
    {
	    return name
    }
}