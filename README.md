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


## ハンズオン① マネジメントコンソール編
![image](https://user-images.githubusercontent.com/39322967/191152553-7530157b-9cc5-4db3-b089-c45a79737c21.png)

#### DynamoDB設計
| 設定項目 | 内容 |
| -------- | -------- |
| テーブル名     | EngineerZemi_ + 自分の名前<br> 例） EngineerZemi_ozawa-yu    |
| パーティションキー | customer_name（string） |
| ソートキー  | unixtime（integer） |
| キャパシティーモード  | オンデマンド |

#### テストデータ
| customer_name | unixtime |
| -------- | -------- |
| 自分の名前（test_user）    | 1661997600     |

※ 1661997600 = 2022-09-01 11:00:00


## ハンズオン② AWS SDK編
![image](https://user-images.githubusercontent.com/39322967/191153324-c81b8547-1a95-4e0a-80a7-01370f986b0f.png)

#### put_item
| カラム名 | 内容 |
| ---- | ---- |
| customer_name | yamlに入力した名前 |
| unixtime | 現在時刻 |
| product_category | えんぴつ |
| price | 150 |

`bundle exec ruby insert_data.rb`

**+α**
customer_nameとunixtimeは上と同様で、「消しゴム / 150円」を追加してください


