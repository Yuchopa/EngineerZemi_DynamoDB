# EngineerZemi_DynamoDB
データ登録、取得、削除などの基本的なDynamoDBAPIを使い、DynamoDBになれるためのプログラム。  
使用の際は、当日配布するハンズオン用アカウントの認証鍵を自分で登録する必要があります。

### コマンド
```shell
cd EngineerZemi_DynamoDB
bundle install --path vendor/bundle

# ① put_item
bundle exec ruby insert_data.rb

# ② get_item
bundle exec ruby get_data.rb

# ③ query
bundle exec ruby query_data.rb

# ④ update_item
bundle exec ruby update_data.rb
```