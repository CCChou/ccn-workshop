# The CCN Roadshow(Dev Track) Module 4 Labs 2022

This repo provides templates, generated Java codes, empty configuration for each labs that developers need to implement cloud-native microservices in workshop. 

The included Java projects and/or installation files are here:

| 名稱 | 說明 |
| --- | --- |
| Coolstore UI | 商店前端頁面 |
| Catalog Service | 產品型錄服務 |
| Inventory Service | 產品庫存服務 | 
| Cart Service | 購物車服務 |
| Order Service | 訂單服務 |
| Payment Service | 付款服務 |

## 架構圖
![](https://github.com/CCChou/ccn-workshop/blob/main/docs/01_architect.png)

## 環境設定

部署 monogdb
```
oc new-app --image quay.io/openshiftlabs/ccn-mongo:4.0 --name=order-database
```

部署資料庫
- Developer Portal --> +ADD 
    - Catalog 
        - Service name: cataglog-database
        - Username: catalog
        - Password: openshift4!
        - Database name: catalog
    - Inventory
        - Service name: inventory-database
        - Username: inventory
        - Password: openshift4!
        - Database name: inventory
    - Cart
        - Service name: cart-redis
        - Password: openshift4!

部署 AMQ Stream (Kafka)
- AMQ Stream Operator

部署各服務元件
```
oc new-app --image quay.io/rhtw/coolstore-ui:v1.0 --name=coolstore-ui
oc new-app --image quay.io/rhtw/catalog:v1.3 --name=catalog
oc new-app --image quay.io/rhtw/inventory:v1.0 --name=inventory
oc new-app --image quay.io/rhtw/cart:v1.0 --name=cart
oc new-app --image quay.io/rhtw/order:v1.0 --name=order
oc new-app --image quay.io/rhtw/payment:v1.0 --name=payment
```

暴露各服務對外端點
```
oc expose svc coolstore-ui
oc expose svc catalog
oc expose svc inventory
oc expose svc cart
oc expose svc order
oc expose svc payment
```

設定環境變數
```
oc set env deploy/coolstore-ui OPENSHIFT_BUILD_NAMESPACE=$(oc project -q)
oc set env deploy/catalog INVENTORY_URL=inventory:8080
```

# Reference
1. [The Containers and Cloud-Native Roadshow Dev Track - Module 4](http://guides-m4-labs-infra.6923.rh-us-east-1.openshiftapps.com/workshop/cloudnative/lab/workshop-environment)