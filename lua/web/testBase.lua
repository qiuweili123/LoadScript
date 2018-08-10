--[[通过type判断一个变量的类型]]
local b = "sd";
print(type(b));
print(type(b));
--[[可以使用‘#’测量字符串长度]]
local s = "hello"
print(#s);

--[[lua中的boolean值比较特殊,任何对象都能是boolean，如果为nil，返回false，其他均为true]]
local t = "t";
if t then
    print("true")
else
    print("false");

end
--[[\n不能在开始位置，lua会忽略]]
print("test\n hello")
--[[table的索引是从1开始的，区别于其他语言,可以从输出的结果上看索引是从1开始的]]
local t = { "s", "d", "e" }
for i, v in ipairs(t) do
    print(i, v)
end
print(t[1])
--[[lua的垃圾回收和java一样，对象和引用变量是分开的，当对象没有被引用的时候，垃圾回收器才回收对象]]
local b = {};
b = t;--b 和t同时指向同一应用
t = nil;
print("##" .. b[1]);
--b=nil;
--如果删除某个元素，可以将某个元素设置为nil
b[2] = nil;
--#table可以获得表的长度；
local t = { 237, '1.1b', '2', '4' };
print("table len:" .. #t);
--tonumber()可将字符串转化为数字
--print("converto number:"..tonumber("1b"));
--赋值可以同时写多个，按顺序赋值可以实现交换数据的效果
--初始化table:{"a":0,"b":1} 等价于{a=0,b=1}  等价于c={} c.a=0,c.b=1 
local a, b = "a", "b";
print(a .. "##" .. b);
a, b = b, a--实现数据交换
print("交换后:" .. a .. "##" .. b);
--操作运算符
--取指定保留小数位余数
local x = 1.383
print("取固定2位小数的值:" .. (x - x % 0.01))
--'~='不等操作
print("比较结果:" .. tostring(x ~= b));
--逻辑运算符：and 、or、not 
--对于and操作符，如果第1个操作符返回的是真，将返回第2个比较值，如果为假，返回为第1个操作符,nil==fale
print(nil and 5);--返回false
print(4 and 5); --返回5
--对于or操作符正好与and相反
print(nil or 5);--返回5
x = 4 or 5 --等价于x=(4 or 5) 和其他语言不同 此刻返回的是比较值
print(x)--print(x=x or z);-- 等价于if not x then x=z end，可以设置为默认值
--print(a and b or c);--a==true?b:c 类似的max=(x>y) and x or y 
--fucntion 多重返回值
function fun()
    return "a", "b"
end
print(fun());--返回a 、b

print(fun(), "##c"); -- 当函数与其它表达式在一起的时候，将只返回首个值

--函数变长参数
function foo(...)
    for i = 1, select('#', ...) do
        --get the count of the params
        local arg = select(i, ...);--如果select为数字n,那么select返回它的第n个可变实参，否则只能为字符串"#",这样select会返回变长参数的总数
        print("arg", arg);
    end
end

foo(10, 12, 34, 45);

--lua中的函数都是变量，函数间可以互相的嵌套访问
a = { p = print }
a.p('sdsd', '1111')

--函数是作为"第一类值"（First-Class Value），这表示函数可以存储在变量中，可以通过参数传递给其他函数，或者作为函数的返回
function foo(x)
    return x;
end --等价于foo=function(x) return x end


-- 若将一个函数写在另一个函数之内，那么这个位于内部的函数便可以访问外部函数中的局部变量，这个特征叫做“词法域”
function newCounter()
    local i = 0
    return function()
        -- 匿名函数
        i = i + 1
        return i
    end
end
c1 = newCounter()
print(type(c1), '.注意c1为递归函数.', c1())
print(c1())
c2 = newCounter()
print('看看变了吗', c2())
--newCounter()函数称为闭包函数。其函数体内的局部变量i被称为"非局部变量"，和普通局部变量不同的是:该变量被newCounter函数体内的匿名函数访问并操作。再有就是在函数newCounter返回后，其值仍然被保留并可用于下一次计算.
--Lua每次在给新的闭包变量赋值(c2)时，都会让不同的闭包变量拥有独立的"非局部变量"

--局部函数：通常定义对象属性
--[[
local  foo=function ( n )  --此处的foo是局部的
	return n*foo(n-1);    --此处的foo是全局的 ，两处并不是一个函数，运行时会异常
end
--修改成正确方法
local foo；--先定义局部变量
foo= function ( n )
return n*foo(n-1); 
end
]]

--支持这样一种函数调用的优化，即“尾调用消除”，调用完后不能任何的事情。
--这里需要强调的是，尾调用函数一定是其调用函数的最后一条语句，否则Lua不会进行优化
--迭代器是闭合函数的最佳实践之一。一般有factory工厂函数和一个闭合函数
local function itratorValues(t)
    --工厂
    local i = 0
    return function()
        --匿名函数
        i = i + 1
        if i == 2 then
            return nil
        end
        return t[i]

    end


end
--泛型for
local t = { 11, 12, 14 }
for e in itratorValues(t) do
    print('泛型for：' .. e);--当返回nile时 泛型for会自动退出
end
local t1 = itratorValues(t)

-- print ('t1--',t1())
-- print ("t12--",t1())
--lua无状态迭代器  
print '------lua无状态迭代器'

print '----lua真正的迭代器 ---for循环的实现方式 '
--[[function allwords (f)--迭代器接受一个函数作为参数，并且这个函数在迭代器内部被调用
    -- repeat for each line in the file
    for l in io.lines() do
      -- repeat for each word in the line
      for w in string.gfind(l, "%w+") do
          -- call the function
          f(w)
      end
    end
end
---用for结构完成任务：
local count = 0
for w in allwords() do
    if w == "hello" then count = count + 1 end
end
print(count)
]]

--错误异常

function testError(str)
    local err;
    if type(str) == 'string' then
        err = "错误信息！"

    end

    return '正确', err
end

local str, er = testError('12')

print('sdddddddddddd', str, '##', er);

--面向对象的编程,元表理解
--1.在表中查找，如果找到，返回该元素，找不到则继续

--2.判断该表是否有元表（操作指南），如果没有元表，返回nil，有元表则继续

--3.判断元表有没有__index方法，如果__index方法为nil，则返回nil；如果__index方法是一个表，则重复1、2、3；如果__index方法是一个函数，则返回该函数的返回值
a = { x = 9, y = 4 }
a.__index = function(table, key)
    print("__index", a[key])
    return a[key] .. 'pp'
end
function a.new(self, o)
    o = o or {};
    print('new  obj');
    setmetatable(o, self)
    return o
end

local b = a.new(a);
print(getmetatable(b));
print(b.x, "nnnn")

function rnd(max)
    --lua的第1次random数不靠谱，取第3次的靠谱
    local ret = 0
    math.randomseed(os.time())
    for i = 1, 3 do
        n = math.random(max)
        ret = n
    end
    return ret
end
-- math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
local randomFile = rnd(10);
print("randomFile::", randomFile);
print(os.clock());
local s = os.clock()
local e = os.clock()
print("used time" .. e - s .. " seconds")

-- io测试
-- 注意函数io.lines(filename)和file:lines()的使用有什么不同，实际上后者在函数调用完之后并不会自动关闭文件，代码最后myfie:close()函数的调用没有报错，也说明了这个问题。
-- 直接全部迭代调用
print("\nsecond file content is :")
for cnt in io.lines("E:/privatespace/LoadScript/lua/web/file.txt") do
   -- print(cnt)
end

-- 使用文件描述符迭代
print("\nthird file content is :")
local lines={};
local myfile = io.open("E:/privatespace/LoadScript/lua/web/order/user_shopCart.txt");
for line in myfile:lines() do

    lines[#lines+1]=line;
end

function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

for i, v in ipairs(lines) do
   -- print(v)
 local tmp=    string.split(v,"\t");

    print("&name==\"" ..tmp[1].."\"")

 ---   print(tmp[1].."##"..tmp[2])
end

myfile:close()