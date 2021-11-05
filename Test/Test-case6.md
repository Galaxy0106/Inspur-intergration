## 测试环境
略
## 演示
```shell
## GET请求：得到查询所有满足条件的异步任务条目
curl -i -X GET http://10.7.20.110:19999/v1.0/jobs -H "Content-Type: application/json" -H "X-Auth-Token: $token"
## POST请求：得到创建成功后的响应
curl -i -X POST http://10.7.20.110:19999/v1.0/jobs -H "Content-Type: application/json" -H "X-Auth-Token: $token" -d @post.json

## 因为log里都是success，所以put和delete会返回error，属于正常现象

## PUT请求：redo a halted job
curl -i -X PUT http://10.7.20.110:19999/v1.0/jobs/{id} -H "Content-Type: application/json" -H "X-Auth-Token: $token"
## DELETE请求：delete a failed or duplicated job
curl -i -X DELETE http://10.7.20.110:19999/v1.0/jobs/{id} -H "Content-Type: application/json" -H "X-Auth-Token: $token"
```
文档写错了