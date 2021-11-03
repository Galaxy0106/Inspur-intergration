## 测试环境
略...
## 演示
```shell
## GET请求：得到查询所有满足条件的路由资源条目
curl -i -X GET http://10.7.20.110:19999/v1.0/routings -H "Content-Type: application/json" -H "X-Auth-Token: $token"
## POST请求：得到创建成功后的响应
curl -i -X POST http://10.7.20.110:19999/v1.0/routings -H "Content-Type: application/json" -H "X-Auth-Token: $token" -d @post.json
## PUT请求：更新资源（类型），使用上一步响应中的ID
curl -i -X PUT http://10.7.20.110:19999/v1.0/routings/{id} -H "Content-Type: application/json" -H "X-Auth-Token: $token" -d @put.json
## DELETE请求：删除资源，使用同样的ID
curl -i -X DELETE http://10.7.20.110:19999/v1.0/routings/{id} -H "Content-Type: application/json" -H "X-Auth-Token: $token"
## 确认资源已被删除，指定该ID
curl -i -X GET http://10.7.20.110:19999/v1.0/routings/{id} -H "Content-Type: application/json" -H "X-Auth-Token: $token"
```