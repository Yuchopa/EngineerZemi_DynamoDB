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

  #################################

  update_hash = {
    table_name: dynamodb_table_name, 
    
  }
  dynamodb_query(update_hash)

  puts 'Done!👍'
end

# 返り値に含まれているBigDecimal型の数字を一括でintに変更
def convert_bigdecimal(hash)
  hash.each{ |k, v| hash[k] = v.to_i if v.is_a?(BigDecimal) }
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