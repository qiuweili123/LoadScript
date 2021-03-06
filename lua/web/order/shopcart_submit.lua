---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by bitmain.
--- DateTime: 2018/5/31 下午4:40
---

wrk.method = "GET"

---  随机交换顺序
function shuffle(paths)
    local j, k
    local n = #paths
    for i = 1, n do
        j, k = math.random(n), math.random(n)
        paths[j], paths[k] = paths[k], paths[j]
    end
    return paths
end

function non_empty_lines_from(file)
    --  if not file_exists(file) then return {} end
    lines = {}
    for line in io.lines(file) do
        if not (line == '') then
            lines[#lines + 1] = line
        end
    end
    return shuffle(lines)
end

function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter == '') then
        return false
    end
    local pos, arr = 0, {}
    -- for each divider found
    for st, sp in function()
        return string.find(input, delimiter, pos, true)
    end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

userCarts = non_empty_lines_from("user_shopCart.txt")

length = #userCarts

counter = 1

function response(status, headers, body)
    -- print(status..body)
end

function request()

    local userCart = string.split(userCarts[counter], "\t");
    counter = counter + 1
    if counter > length then
        counter = 1
    end

    local path = wrk.path .. "?userId=" .. userCart[1] .. "&shopcartIds=" .. tostring(userCart[2]);
    -- print("path: [" .. path .."]")

    --   local body = '{"userId":"' .. path .. '","productId":"00020180508095447784qx6Aduql071E",  "count":1, "fittingIds":["00020180117170455462Vj8Xc1jb06A6","00020180117170455462Vj8Xc1jb06A6"]}'

    --return wrk.format(wrk.method,wrk.path,wrk.headers,wrk.body)
    -- return wrk.format(wrk.method,path)
    --  print("path=="..wrk.path)
    return wrk.format(nil, path, nil, nil)
end

