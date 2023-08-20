# satahiko
aws platform using terafform

## terraform準備
こちらを参考に
https://soulimpact20141.amebaownd.com/posts/47144499

## 初期化処理
```
cd ./env/prod
terraform init
```

## AWSリソース作成
```
cd ./env/prod
# 適応する前にRoute53でホストゾーン(DNSでいうドメイン取得)作成をすること
# 作成されたホストゾーンに紐づくdomainとhostzone-idのコンソール入力必須
terraform apply
```

## AWSリソース破棄
```
# elastic ipはnat-gwやec2が起動してなくても課金されるため、利用時以外は基本的にリソースを破棄すること
terraform destroy
```