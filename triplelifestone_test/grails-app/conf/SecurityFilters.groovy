//------------------------------------------------------------
//	Author: voechoid
//	Date: 2012/8/20
//	Function: 
//------------------------------------------------------------

class SecurityFilters {

    static authenticatedActions = [
            [controller: 'sysUser', action: '*', roles: ['ROLE_ADMIN']],
            [controller: 'sysUser', action: '*', roles: ['ROLE_ADMIN']],
            [controller: 'sysRole', action: '*', roles: ['ROLE_ADMIN']]
    ]

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                
            }
            after = {
                
            }
            afterView = {
                
            }
        }
    }
    
}
