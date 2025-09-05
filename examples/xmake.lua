set_group("examples")
set_default(false)

add_deps("sylar")

if is_plat("linux") then
    add_ldflags("-lrt")
end

function all_examples()
    local res = {}
    for _, x in ipairs(os.files("**.cc")) do
        local item = {}
        local s = path.filename(x)
        table.insert(item, s:sub(1, #s - 3))       -- target
        table.insert(item, path.relative(x, "."))  -- source
        table.insert(res, item)
    end
    return res
end

for _, exam in ipairs(all_examples()) do
target(exam[1])
    set_kind("binary")
    add_files(exam[2])
end
