/*************************************************
 Copyright by www.3lifestone.com, all rights reserved.
 **************************************************
 模型: voechoid
 作者: voechoid@qq.com
 ************************************************ */

package business

class Company {

    static iqDomain = [chn: "公司"]
    static iqLayout = [itemsPerPage: 15]
    static iqNavigation = [group: "管理", weight: 1]

    String name
    String type
    Date settingUpDate

    String summary

    //字段按照优先级和重要性排序，显示顺序
    //display默认=true
    static constraints = {
        name attributes: [chn: "名称"], blank: false, size: 6..32
        type attributes: [chn: "类型"], blank: false, inList: ["国企", "私企", "合资", "独资"]
        settingUpDate attributes: [chn: "成立时间"], blank: false
        summary attributes: [chn: "公司简介", widget: "htmleditor"], blank: true, size: 0..1000
    }

    String toString() {
        return name
    }
}