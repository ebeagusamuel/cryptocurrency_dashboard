class CryptocurrenciesController < ApplicationController
  def index
    @currencies = Cryptocurrency.last(100)
  end
end
