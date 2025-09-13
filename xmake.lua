set_project("sylar")

set_policy("package.requires_lock", true)

add_rules("mode.debug", "mode.release")

if is_mode("release") then
    set_optimize("faster")
    set_strip("all")
elseif is_mode("debug") then
    set_symbols("debug")
    set_optimize("none")
end

set_languages("c11", "c++17")
set_warnings("all")
add_cxflags("-fPIC") 
-- set_exceptions("no-cxx")

add_requires("apt::libzookeeper-mt-dev", {alias = "zookeeper", system=true})
add_requires("apt::libmysqlclient-dev", {alias = "mysql", system=true})
-- add_requires("apt::libboost-all-dev", {alias = "boost", system=true})
add_requires("protobuf-cpp", {alias = "protobuf", configs = {tools = true}})
add_requires("boost 1.83.0", "jsoncpp", "sqlite3", "yaml-cpp", "hiredis-vip", "tinyxml2", "jemalloc", "libevent", "openssl", "zlib")
add_syslinks("pthread", "dl")

add_packages("jsoncpp", "yaml-cpp", "hiredis-vip", "sqlite3", "tinyxml2", "jemalloc", "libevent", "openssl", "zlib")
add_packages("zookeeper", "mysql", "boost", "protobuf")

includes("sylar")
add_includedirs(os.projectdir())
includes("tests", "examples", "template", "samples")