require 'yaml'
require 'aws-sdk-dynamodb'

# Call
def run!
  credential_hash = YAML.load_file('./credential/key.yml').first
  @dynamodb_client = Aws::DynamoDB::Client.new(
    region: credential_hash['region'],
    access_key_id: credential_hash['aws_access_key_id'],
    secret_access_key: credential_hash['aws_secret_access_key'],
  )
  your_name = credential_hash['your_name']
  dynamodb_table_name = credential_hash['table_name']

  insert_hash = {
    table_name: dynamodb_table_name,
    item: {
      customer_name: your_name,
      unixtime: Time.now().to_i,
      product_category: 'えんぴつ',
      price: 150
    }
  }
  dynamodb_put_item(insert_hash)

  insert_hash[:item] = {
    customer_name: your_name,
    unixtime: Time.now().to_i,
    product_category: '消しゴム',
    price: 100
  }
  dynamodb_put_item(insert_hash)

  puts 'Done!👍'
end

# DynamoDBに1件レコードを追加する
def dynamodb_put_item(hash_item)
  @dynamodb_client.put_item(hash_item)
rescue StandardError => e
  puts "Error! #{e}"
end

run! if $PROGRAM_NAME == __FILE__