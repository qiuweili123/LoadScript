# -*- coding: utf8 -*-
import requests;
import json;

r = requests.get("http://localhost:8082/consumer/groupList.query");

if r.status_code != 200:
    print("status code not equale 200")

jsonObj = r.json();
# print(jsonObj);

groupList = [];
dataList = jsonObj.get("data");
for data in dataList:
    if data.get("diffTotal") > 0:
        groupList.append(data)

header = {
    'name': 'q_warn',
    'action': 'warn'
}

if len(groupList) > 0:
    for group in groupList:
        r = requests.post(
            "http://alert.bitmain.com.cn/api/sqs?auth=QIAe3LmhUd5yMTE40P8KJkfHVtr9Wjo7&opt=put&name=q_warn",
            data={
                "trigger": "rocketmq_mes_delay_rule",
                "message": "rocketMq消息堆积" + str(group.get("diffTotal")) + "，topic" + str(group.get("group"))
            }, headers=header);

