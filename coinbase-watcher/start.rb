require 'active_record'
require 'coinbase/wallet'
require 'yaml'

# Configuration
config = YAML.load_file('secrets.yaml')

# Coinbase keys
COINBASE_API_KEY = config['coinbase-api-key']
COINBASE_API_SECRET = config['coinbase-api-secret']

# ActiveRecord configuration
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/coinbase-watcher.db'
)

# Create ActiveRecord schema
ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.table_exists? 'currencies'
    create_table :currencies do |table|
      table.column :name, :string
      table.column :amount, :float
      table.column :conversion, :float

      table.timestamps
    end
  end
end

class Currency < ActiveRecord::Base
end

client = Coinbase::Wallet::Client.new(
  api_key: COINBASE_API_KEY,
  api_secret: COINBASE_API_SECRET
)

# Get BTC, ETH and LTC accounts
accounts = client.accounts.select { |a| %w[BTC ETH LTC].include? a.currency }

# Add current currencies
accounts.each do |account|
  Currency.create(
    name: account.currency,
    amount: account.balance.amount,
    conversion: account.native_balance.amount
  )
end
