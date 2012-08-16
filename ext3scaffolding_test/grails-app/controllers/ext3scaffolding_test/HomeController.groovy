package ext3scaffolding_test

class HomeController {

    def index() { }
    def secured() {
        render "This page requires a user to be logged in"
    }
}
