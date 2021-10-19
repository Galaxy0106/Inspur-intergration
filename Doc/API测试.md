## Resource routing API
```shell
openstack --os-region-name=RegionOne token issue
# GET
curl -i -X GET http://10.7.20.110:19999/v1.0/routings -H "Content-Type: application/json" -H "X-Auth-Token: $token"
# POST
curl -i -X POST http://10.7.20.110:19999/v1.0/routings -H "Content-Type: application/json" -H "X-Auth-Token: $token" -d @post.json
# post.json
# {
#     "routing": {
#         "pod_id": "70586bc1-d54f-4628-938a-dff1fe3e4c5c",
#         "top_id": "09fd7cc9-d169-4b5a-88e8-436ecf4d0bfg",
#         "bottom_id": "dc80f9de-abb7-4ec6-ab7a-94f8fd1e20ek",
#         "project_id": "b35450fd79164af4a0df26149228ddf2",
#         "resource_type": "network"
#     }
# }
# PUT
curl -i -X PUT http://10.7.20.110:19999/v1.0/routings/42 -H "Content-Type: application/json" -H "X-Auth-Token: $token" -d @put.json
# put.json
# {
#     "routing": {
#         "resource_type": "router"
#     }
# }
# DELETE
curl -i -X DELETE http://10.7.20.110:19999/v1.0/routings/{id} -H "Content-Type: application/json" -H "X-Auth-Token: $token"
# DELETE验证
curl -i -X GET http://10.7.20.110:19999/v1.0/routings/{id} -H "Content-Type: application/json" -H "X-Auth-Token: $token"
```
## Asynchronous Job API
```shell
# GET
curl -i -X GET http://10.7.20.110:19999/v1.0/jobs -H "Content-Type: application/json" -H "X-Auth-Token: $token"
# POST
curl -i -X POST http://10.7.20.110:19999/v1.0/jobs -H "Content-Type: application/json" -H "X-Auth-Token: $token" -d @post.json
# {
#     "job": {
#         "type": "seg_rule_setup",
#         "project_id": "b35450fd79164af4a0df26149228ddf2",
#         "resource": {
#             "project_id": "b35450fd79164af4a0df26149228ddf2"
#         }
#     }
# }
# PUT
curl -i -X PUT http://10.7.20.110:19999/v1.0/jobs -H "Content-Type: application/json" -H "X-Auth-Token: $token"
# DELETE
curl -i -X DELETE http://10.7.20.110:19999/v1.0/jobs -H "Content-Type: application/json" -H "X-Auth-Token: $token"
````