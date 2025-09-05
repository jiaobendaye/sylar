set_project("sylar")

if is_mode("release") then
    set_optimize("faster")
    set_strip("all")
elseif is_mode("debug") then
    set_symbols("debug")
    set_optimize("none")
end

set_languages("gnu90", "c++17")
set_warnings("all")
-- set_exceptions("no-cxx")

add_requires("apt::libzookeeper-mt-dev", {alias = "zookeeper", system=true})
add_requires("apt::libmysqlclient-dev", {alias = "mysql", system=true})
-- add_requires("apt::libboost-all-dev", {alias = "boost", system=true})
add_requires("protobuf-cpp", {alias = "protobuf", configs = {tools = true}})
add_requires("sqlite3 3.50.0+400", {alias = "sqlite3"})
add_requires("boost", "jsoncpp", "yaml-cpp 0.8.0", "hiredis-vip", "tinyxml2", "jemalloc", "libevent", "openssl", "zlib")
add_syslinks("pthread", "dl")

add_packages("jsoncpp", "yaml-cpp", "hiredis-vip", "sqlite3", "tinyxml2", "jemalloc", "libevent", "openssl", "zlib")
add_packages("zookeeper", "mysql", "boost")
add_packages("protobuf", {public = true})

includes("sylar")
add_includedirs(os.projectdir())
includes("tests", "examples", "template", "samples")