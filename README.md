# The CCN Roadshow(Dev Track) Module 4 Labs 2022

This repo provides templates, generated Java codes, empty configuration for each labs that developers need to implement cloud-native microservices in workshop. 

The included Java projects and/or installation files are here:

| 名稱 | 說明 |
| --- | --- |
| Coolstore UI | 商店前端頁面 |
| Catalog Service | 產品型錄服務 |
| Cart Service | 購物車符術 |
| Inventory Service | 產品庫存服務 | 
| Order Service | 訂單服務 |
| Payment Service | 付款服務 |

## 環境設定

部署 monogdb
```
oc new-app --as-deployment-config --docker-image quay.io/openshiftlabs/ccn-mongo:4.0 --name=order-database
```

部署資料庫
- Developer Portal --> +ADD 

部署 AMQ Stream (Kafka)
- AMQ Stream Operator

部署前端頁面
```
cd $PROJECT_SOURCE/coolstore-ui && npm install --save-dev nodeshift
npm run nodeshift && oc expose svc/coolstore-ui
```

部署各 service
```
mvn clean package -DskipTests -f $PROJECT_SOURCE/cart-service
mvn clean package -DskipTests -f $PROJECT_SOURCE/order-service
mvn clean package -DskipTests -f $PROJECT_SOURCE/payment-service
mvn clean install -Ddekorate.deploy=true -DskipTests -f $PROJECT_SOURCE/catalog-service
```

# Reference
1. [The Containers and Cloud-Native Roadshow Dev Track - Module 4](http://guides-m4-labs-infra.6923.rh-us-east-1.openshiftapps.com/workshop/cloudnative/lab/workshop-environment)