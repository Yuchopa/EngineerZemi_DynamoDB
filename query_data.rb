require 'yaml'
require 'aws-sdk-dynamodb'
require "time"

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
  start_ts = '2022-09-18'
  end_ts = '2022-09-20 23:59:59'
  #################################

  query_hash = {
    table_name: dynamodb_table_name,
    expression_attribute_values: {
      ':key' => your_name,
      ':start_unixtime' => Time.parse(start_ts).to_i,
      ':end_unixtime' => Time.parse(end_ts).to_i,
    }, 
    key_condition_expression: 'customer_name = :key AND unixtime BETWEEN :start_unixtime AND :end_unixtime', 
  }
  dynamodb_query(query_hash)

  puts 'Done!👍'
end

# 返り値に含まれているBigDecimal型の数字を一括でintに変更
def convert_bigdecimal(array)
  array.each{ |hash|
    hash.each{ |k, v| hash[k] = v.to_i if v.is_a?(BigDecimal) }
  }
end

# DynamoDBから条件に合うすべてのデータを取得する
def dynamodb_query(table_item)
  result = @dynamodb_client.query(table_item)
  puts "#-QUERY-# #{table_item}"
  puts '-----'
  puts convert_bigdecimal(result[:items])
  puts '-----'
rescue StandardError => e
  puts "Error! #{e}"
end

run! if $PROGRAM_NAME == __FILE__