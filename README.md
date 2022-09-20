# EngineerZemi_DynamoDB
データ登録、取得、削除などの基本的なDynamoDBAPIを使い、DynamoDBになれるためのプログラム。  
使用の際は、当日配布するハンズオン用アカウントの認証鍵を自分で登録する必要があります。


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

***

## ハンズオン② AWS SDK編
![image](https://user-images.githubusercontent.com/39322967/191164713-a89e7913-428f-4ce4-a054-82ecdd6fc450.png)


### ・put_item
コマンドを実行してください。
実行すると下記の要領でデータがDynamoDBに入ります。
| カラム名 | 内容 |
| ---- | ---- |
| customer_name | yamlに入力した名前 |
| unixtime | 現在時刻 |
| product_category | えんぴつ |
| price | 150 |

```shell
# 実行コマンド
bundle exec ruby insert_data.rb
```
**try!**  
customer_nameとunixtimeは上と同様で、「消しゴム / 150円」を追加してください。

<br/>

### ・get_item
先程のput_itemで入れたデータを取得してください。
unixtimeをマネジメントコンソールからコピーし、プログラムに貼り付けてコマンドを実行してください。

```shell
# 実行コマンド
bundle exec ruby get_data.rb
```

<br/>

### ・update_item
先程のput_itemで入れた「えんぴつ」のデータを更新します。
unixtimeをマネジメントコンソールからコピーし、プログラムに貼り付けてコマンドを実行してください。

```shell
# 実行コマンド
bundle exec ruby update_item.rb
```

**try!**  
update_itemは **PKとSKの組み合わせがあれば** そのデータを更新しますが、
ない場合は新たにデータを作成するupsertの機能があります。
適当なunixtimeを入力し、upsertができるか試してみてください。

<br/>

### ・query
'2022-09-18'〜'2022-09-20 23:59:59'までに登録したデータをすべて取得します。
下記コマンドを実行してください。

```shell
# 実行コマンド
bundle exec ruby query_data.rb
```

**try!**  
`ハンズオン① マネジメントコンソール編` で入れたデータを取得してください。  
※ 1661997600 = 2022-09-01 11:00:00

**さらにtry!**  
`hands_on.rb` に下記の条件を満たすプログラムを書いて実行して下さい。
```
<Question>
customer_name = ozawa が、8月1日〜10日の間でカートに入れた品物すべてを取得する。
Dynamodbのクエリで、product_categoryとpriceのみを予め指定する。
```
