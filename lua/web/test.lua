package.path = package.path .. ";C:\\Users\\liqiuwei\\Desktop\\Le\\lua\\Openrestynginx\\resty\\*.lua"
--local   cfg=  require("conf.cfg");
local hash = require "resty.core.hash";
print(package.path);
--print(cfg.DEFAULT_COOKIE_NAME);
--print(DEFAULT_COOKIE_NAME1);

-- for n in pairs(cfg) do
--  print(n)
-- end



--[[测试局部变量和全局变量的性能对比 
块状注释
 local v1,v2;
 local v3 = DEFAULT_COOKIE_NAME1;
local t1 =os.clock ()
 
for i=1,100000000 do
 v1=cfg.DEFAULT_COOKIE_NAME
end 

local t2 =os.clock () 
print("通过对象访问局部变量："..(t2-t1))

local t1 =os.clock ()
for i=1,100000000 do
   v2=DEFAULT_COOKIE_NAME1
end  
local t2 =os.clock () 
print("直接访问全局变量："..(t2-t1))


local t1 =os.clock ()
for i=1,100000000 do
   v1=v3
end  
local t2 =os.clock () 
print("优化局部变量访问全局变量："..(t2-t1))
]]

--test tmetatable，在调用table不存在的字段时，会调用__index元方法
local t = {
    name = "hehe",
}

local mt = {
    __index = function(t, key)
        print("虽然你调用了我不存在的字段，不过没关系，我能探测出来：" .. key);
        -- table.insert(t,"89");
        for k, v in pairs(t) do
            print(k, '##', v)
            table.insert(t, key)
        end


    end
}
setmetatable(t, mt);

for k, v in pairs(t) do
    print("kkk", k, v)
end
print(t.money);

print("--------------------------------------------");
--test Metatable
--定义2个表

a = { 5, 6, 9 }
b = { 7, 8 }
--用c来做Metatable

c = {}
--重定义加法操作

c.__add = function(op1, op2)
    for _, item in ipairs(op2) do
        table.insert(op1, item)
    end
    return op1
end

--将a的Metatable设置为c

setmetatable(a, c)
--d现在的样子是{5,6,7,8}

d = a + b

for k, v in pairs(d) do
    print(k, v)
end
