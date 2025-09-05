set_group("samples")
set_default(false )

add_deps("sylar")

if is_plat("linux") then
    add_ldflags("-lrt")
end


target("my_http_server")
    set_kind("binary")
    add_files("my_http_server.cc")