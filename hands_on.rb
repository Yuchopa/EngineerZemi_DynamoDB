#################### try! ####################

# 公式ドキュメントを参考にしながら、下記のデータ抽出を行ってください。
# https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/DynamoDB/Client.html#query-instance_method
# 
# <Question>
# customer_name = ozawa が、8月1日〜10日の間でカートに入れた品物すべてを取得する。
# Dynamodbのクエリで、product_categoryとpriceのみを予め指定する。

##############################################

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
  dynamodb_table_name = 'EngineerZemi'

  # 各自入力 #######################
  query_hash = {
    table_name: dynamodb_table_name, 
    
  }
  #################################
  dynamodb_query(query_hash)

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