package iq.auth



import org.junit.*
import grails.test.mixin.*

@TestFor(SysRoleController)
@Mock(SysRole)
class SysRoleControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/sysRole/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.sysRoleInstanceList.size() == 0
        assert model.sysRoleInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.sysRoleInstance != null
    }

    void testSave() {
        controller.save()

        assert model.sysRoleInstance != null
        assert view == '/sysRole/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/sysRole/show/1'
        assert controller.flash.message != null
        assert SysRole.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/sysRole/list'

        populateValidParams(params)
        def sysRole = new SysRole(params)

        assert sysRole.save() != null

        params.id = sysRole.id

        def model = controller.show()

        assert model.sysRoleInstance == sysRole
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/sysRole/list'

        populateValidParams(params)
        def sysRole = new SysRole(params)

        assert sysRole.save() != null

        params.id = sysRole.id

        def model = controller.edit()

        assert model.sysRoleInstance == sysRole
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/sysRole/list'

        response.reset()

        populateValidParams(params)
        def sysRole = new SysRole(params)

        assert sysRole.save() != null

        // test invalid parameters in update
        params.id = sysRole.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/sysRole/edit"
        assert model.sysRoleInstance != null

        sysRole.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/sysRole/show/$sysRole.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        sysRole.clearErrors()

        populateValidParams(params)
        params.id = sysRole.id
        params.version = -1
        controller.update()

        assert view == "/sysRole/edit"
        assert model.sysRoleInstance != null
        assert model.sysRoleInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/sysRole/list'

        response.reset()

        populateValidParams(params)
        def sysRole = new SysRole(params)

        assert sysRole.save() != null
        assert SysRole.count() == 1

        params.id = sysRole.id

        controller.delete()

        assert SysRole.count() == 0
        assert SysRole.get(sysRole.id) == null
        assert response.redirectedUrl == '/sysRole/list'
    }
}
