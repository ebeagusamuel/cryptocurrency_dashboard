class CreateCryptocurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :cryptocurrencies do |t|
      t.string :name
      t.string :market_cap
      t.string :price
      t.string :volume
      t.string :circulating_supply
      t.string :change
      
      t.timestamps
    end
  end
end
