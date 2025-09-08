
rule("ragel")
    set_extensions(".rl")
    on_buildcmd_file(function(target, batchcmds, sourcefile, opt)
        import("lib.detect.find_tool")
        import("core.project.depend")

        local ragel = assert(find_tool("ragel"), "ragel not found!")

        local targetfile = sourcefile .. ".cc"
        local objectfile = target:objectfile(targetfile)

        -- print("ragel: " .. sourcefile .. " -> " .. targetfile .. " -> " .. objectfile)

        -- 将生成的文件添加到目标
        depend.on_changed(function ()
            batchcmds:show_progress(opt.progress, "${color.build.object}compiling.rl %s", sourcefile)
            os.vrunv("ragel " .. sourcefile .. " -o " .. targetfile .. " -l -C -G2  --error-format=msvc")
        end, {files = sourcefile})


        local objectdir = path.directory(objectfile)
        batchcmds:mkdir(objectdir)
        batchcmds:compile(targetfile, objectfile, {configs = {}})

        target:add("files", targetfile)

        local depmtime = os.mtime(targetfile)
        batchcmds:add_depfiles(sourcefile)
        batchcmds:set_depmtime(depmtime)
        batchcmds:set_depcache(target:dependfile(targetfile))
    end)

target("pb")
    set_kind("object")
    add_rules("protobuf.cpp")
    add_files("ns/ns_protobuf.proto", {proto_public = true})
    -- add_files("ns/ns_protobuf.proto", {rule = "genpb"})


target("sylar")
    set_kind("shared")
    add_files( "**/*.cc", "*.cc", "**/*.c")
    remove_files("main.cc")
    remove_files("orm/*.cc")
    add_deps("pb")
    add_files("uri.rl", "http/http11_parser.rl", "http/httpclient_parser.rl", {rule = "ragel"})


target("orm")
    set_kind("binary")
    add_files("orm/*.cc")
    add_deps("sylar")


target("sylar-main")
    set_kind("binary")
    add_files("main.cc")
    add_deps("sylar")