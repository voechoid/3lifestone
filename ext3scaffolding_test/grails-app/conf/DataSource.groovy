dataSource {
    pooled = true
    dbCreate="update"
    url="jdbc:mysql://localhost/3lifestone?useUnicode=true&characterEncoding=UTF-8"
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:mysql://localhost/3lifestone?useUnicode=true&characterEncoding=UTF-8"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost/3lifestone?useUnicode=true&characterEncoding=UTF-8"
        }
    }

    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost/3lifestone?useUnicode=true&characterEncoding=UTF-8"
            pooled = true
            properties {
               maxActive = 50
               minEvictableIdleTimeMillis=60000
               timeBetweenEvictionRunsMillis=60000
               numTestsPerEvictionRun=3
               validationQuery="SELECT 1"
            }
        }
    }
}
