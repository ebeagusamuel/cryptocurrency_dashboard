namespace :currency_fetcher do
  desc "fetch the cyptocurrencies data from the external site"
  task :fetch_data do
    require 'httparty'
    require 'nokogiri'
    class Scrapper
      attr_reader :url
    
      def initialize(url)
        @url = url
      end

      def get_page_body
        page_body = HTTParty.get(url).body
      rescue
        get_page_body
      end
    
      def scrape
        details_arr = []
        scraped_pages = []
        doc = Nokogiri::HTML(get_page_body)
        doc.css('tr.cmc-table-row').each do |node|
          scraped_pages << node
        end
        scraped_pages.each do |node|
          details_hash = { name: node.css('td.cmc-table__cell--sort-by__name a').text,
                           market_cap: node.css('td.cmc-table__cell--sort-by__market-cap p').text,
                           price: node.css('td.cmc-table__cell--sort-by__price a').text,
                           volume: node.css('td.cmc-table__cell--sort-by__volume-24-h a').text,
                           circulating_supply: node.css('td.cmc-table__cell--sort-by__circulating-supply div').text,
                           change: node.css('td.cmc-table__cell--sort-by__percent-change-24-h div').text }
          details_arr << details_hash
        end
        details_arr
      end
    end
  end

  desc "Update the database with the extracted data"
  task :update_database => [:fetch_data, :environment] do
    scrapper_obj = Scrapper.new('https://coinmarketcap.com/')
    scraped = scrapper_obj.scrape

    Cryptocurrency.create(scraped);
  end
end