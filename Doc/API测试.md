## Resource routing API
```shell
openstack --os-region-name=RegionOne token issue
# GET
curl -i -X GET http://10.7.20.110:19999/v1.0/routings -H "Content-Type: application/json" -H "X-Auth-Token: $token"
# POST
curl -i -X POST http://10.7.20.110:19999/v1.0/routings -H "Content-Type: application/json" -H "X-Auth-Token: $token" -d {"routing": {"updated_at": null, "created_at": "2016-11-03 03:06:38", "top_id": "09fd7cc9-d169-4b5a-88e8-436ecf4d0bfg", "id": 45, "bottom_id": "dc80f9de-abb7-4ec6-ab7a-94f8fd1e20ek", "project_id": "d937fe2ad1064a37968885a58808f7a3", "pod_id": "444a8ce3-9fb6-4a0f-b948-6b9d31d6b202", "resource_type": "subnet"}}

```