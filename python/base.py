# 强制指定编码，不加默认utf8
# -*- coding: utf8 -*-
print("tesse")
'''
多行注释
'''
# 使用缩进代替{}
if True:
    print("true")
else:
    print("false")
# 字符串
str = 'abcd';
print(str)
# 多行字符串
mulst = """1.这是一个段落
2.多行字符串
"""
print(mulst)
# 字符串的截取的语法格式如下：变量[头下标:尾下标],Python 中的字符串有两种索引方式，从左往右以 0 开始，从右往左以 -1 开始。
str = 'abcd'
print(str[0:-1])
print(str[2:])  # 输出从第三个开始的后的所有字符
print(str[2])
#  记住：空行也是程序代码的一部分。
# 同一行显示多条语句
import sys;

x = 'runoob';
sys.stdout.write(x + '\n')
# 从某个模块中导入某个函数,格式为： from somemodule import somefunction
'''
不可变数据（3 个）：Number（数字）、String（字符串）、Tuple（元组） 
可变数据（3 个）：List（列表）、Dictionary（字典）、Set（集合）。
Number:int、float、bool、complex
'''
a,b, c = 1, 2.0, True
print(type(a),"#######",type(b))
print("c type " +" join")
#list可以放置不同的数据类型
list = [ 'abcd', 786 , 2.23, 'runoob', 70.2 ]

print(len(list));
# 数组
tuple = ( 'abcd', 786 , 2.23, 'runoob', 70.2  )
# set
student_ = {'Tom', 'Jim', 'Mary', 'Tom', 'Jack', 'Rose'}
#dirc 字典  hash
tinydict = {'name': 'runoob', 'code': 1, 'site': 'www.runoob.com'}
print(tinydict.get("name"))

# list del
aList = [123, 'xyz', 'zara', 'abc', 'xyz'];

del aList[1]
print(aList);
del aList[2]
print(aList);
