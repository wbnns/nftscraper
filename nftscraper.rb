require 'nokogiri'
require 'httparty'

NFT_MARKETPLACE = ''

def nftscraper
  url = NFT_MARKETPLACE
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri.HTML(unparsed_page)
  assets = Array.new
  asset_listings = parsed_page.css('a.Asset')
  asset_listings.each do |asset_listing|
    asset = {
      name: asset_listing.css('div.assetName').text,
      price: asset_listing.css('div.assetPrice').text,
      url: NFT_MARKETPLACE + asset_listing[:href],
    }
    assets << asset
  end
end

nftscraper
