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

  # 各自入力 #######################
  unixtime = 
  #################################

  update_hash = {
    table_name: dynamodb_table_name, 
    expression_attribute_values: {
      ":price" => 18000, 
      ":product_category" => 'えんぴつ 10ダース', 
    }, 
    key: {
      'customer_name' => your_name,
      'unixtime' => unixtime
    }, 
    update_expression: "SET price = :price, product_category = :product_category",
    return_values: 'UPDATED_NEW'
  }
  dynamodb_update_item(update_hash)

  puts 'Done!👍'
end

# 返り値に含まれているBigDecimal型の数字を一括でintに変更
def convert_bigdecimal(hash)
  hash.each{ |k, v| hash[k] = v.to_i if v.is_a?(BigDecimal) }
end

# DynamoDBにある条件に合うデータを更新する
def dynamodb_update_item(table_item)
  result = @dynamodb_client.update_item(table_item)
  puts "#-UPDATE ITEM-# #{table_item}"
  puts '-----'
  puts convert_bigdecimal(result[:attributes])
  puts '-----'
rescue StandardError => e
  puts "Error! #{e}"
end

run! if $PROGRAM_NAME == __FILE__