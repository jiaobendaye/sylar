set_group("tests")
set_default(false)

add_deps("sylar")

if is_plat("linux") then
    add_ldflags("-lrt")
end

function all_tests()
    local res = {}
    for _, x in ipairs(os.files("**.cc")) do
        local item = {}
        local s = path.filename(x)
        if s == "test_orm.cc" then
            -- TODO
        else
            table.insert(item, s:sub(1, #s - 3))       -- target
            table.insert(item, path.relative(x, "."))  -- source
            table.insert(res, item)
        end
    end
    return res
end

for _, test in ipairs(all_tests()) do
target(test[1])
    set_kind("binary")
    add_files(test[2])
end
