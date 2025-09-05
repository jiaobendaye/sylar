set_group("template")
set_default(false)

add_deps("sylar")

target("template")
    set_kind("shared")
    set_targetdir("lib")
    add_files("template/my_module.cc")