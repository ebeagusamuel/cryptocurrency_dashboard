class CryptocurrenciesController < ApplicationController
  COINS_PER_PAGE = 100
  def index
    @page = params.fetch(:page, 0).to_i
    @currencies = Cryptocurrency.offset(@page * COINS_PER_PAGE).limit(COINS_PER_PAGE)
  end
end
