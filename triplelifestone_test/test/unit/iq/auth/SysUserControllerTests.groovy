package iq.auth



import org.junit.*
import grails.test.mixin.*

@TestFor(SysUserController)
@Mock(SysUser)
class SysUserControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/sysUser/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.sysUserInstanceList.size() == 0
        assert model.sysUserInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.sysUserInstance != null
    }

    void testSave() {
        controller.save()

        assert model.sysUserInstance != null
        assert view == '/sysUser/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/sysUser/show/1'
        assert controller.flash.message != null
        assert SysUser.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/sysUser/list'

        populateValidParams(params)
        def sysUser = new SysUser(params)

        assert sysUser.save() != null

        params.id = sysUser.id

        def model = controller.show()

        assert model.sysUserInstance == sysUser
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/sysUser/list'

        populateValidParams(params)
        def sysUser = new SysUser(params)

        assert sysUser.save() != null

        params.id = sysUser.id

        def model = controller.edit()

        assert model.sysUserInstance == sysUser
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/sysUser/list'

        response.reset()

        populateValidParams(params)
        def sysUser = new SysUser(params)

        assert sysUser.save() != null

        // test invalid parameters in update
        params.id = sysUser.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/sysUser/edit"
        assert model.sysUserInstance != null

        sysUser.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/sysUser/show/$sysUser.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        sysUser.clearErrors()

        populateValidParams(params)
        params.id = sysUser.id
        params.version = -1
        controller.update()

        assert view == "/sysUser/edit"
        assert model.sysUserInstance != null
        assert model.sysUserInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/sysUser/list'

        response.reset()

        populateValidParams(params)
        def sysUser = new SysUser(params)

        assert sysUser.save() != null
        assert SysUser.count() == 1

        params.id = sysUser.id

        controller.delete()

        assert SysUser.count() == 0
        assert SysUser.get(sysUser.id) == null
        assert response.redirectedUrl == '/sysUser/list'
    }
}
