rule("ragel")
    set_extensions(".rl")
    on_build_file(function (target, sourcefile, opt)
        import("core.project.depend")
        
        -- local targetfile = string.replace(sourcefile, ".rl", ".cc")
        local targetfile = sourcefile .. ".cc"
        depend.on_changed(function ()
            os.vrunv("ragel " .. sourcefile .. " -o " .. targetfile .. " -l -C -G2  --error-format=msvc")
        end, {files = sourcefile})
        
        -- 将生成的文件添加到目标
        target:add("files", targetfile)
    end)

target("sylar")
    set_kind("shared")
    -- set_kind("$(kind)")
    add_rules("protobuf.cpp")

    add_files( "**/*.cc", "*.cc")
    remove_files("main.cc")
    add_files("uri.rl", "http/http11_parser.rl", "http/httpclient_parser.rl", {rule = "ragel"})
    add_files("ns/ns_protobuf.proto", {proto_public = true})


target("sylar-main")
    set_kind("binary")
    add_files("main.cc")
    add_deps("sylar")