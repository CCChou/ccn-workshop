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

## 環境資訊
1. OpenShift 4.14
2. AMQ Stream 2.6.0
3. Maven 3.8.8
4. Java 17

## 環境設定

部署 AMQ Stream (Kafka)
- AMQ Stream Operator

部署 DB
```bash
./script/createdb.sh
```

部署 Kafka 元件
```bash
./script/createkafka.sh
```

部署應用服務
```bash
./script/createservice.sh
```

# Reference
1. [The Containers and Cloud-Native Roadshow Dev Track - Module 4](http://guides-m4-labs-infra.6923.rh-us-east-1.openshiftapps.com/workshop/cloudnative/lab/workshop-environment)