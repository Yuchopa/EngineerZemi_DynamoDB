# EngineerZemi_DynamoDB
データ登録、取得、削除などの基本的なDynamoDBAPIを使い、DynamoDBになれるためのプログラム。  
使用の際は、当日配布するハンズオン用アカウントの認証鍵を自分で登録する必要があります。

### コマンド
```shell
cd EngineerZemi_DynamoDB
bundle install --path vendor/bundle

# ① put_item
ruby insert_data.rb

# ② get_item
ruby get_data.rb

# ③ query
ruby query_data.rb

# ④ update_item
ruby update_data.rb
```