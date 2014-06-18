#
# Amazon SQS Powered Multi-instance Coding (a.k.a. Workflow)
#   similar works: Route https://github.com/jmettraux/ruote
#

require 'cloudflow'
require_relative 'workers' # => Crawler, Scraper, Fetcher, Converter
require_relative 'models/page' # => Page model (ActiveRecord, Mongoid, etc...)
require_relative 'config/aws' # => set AWS key/secret

cloudflow :crawl do
  func :retrieve do |arg| # TODO: restrict arg schema?
    data = Crawler.crawl arg.url
    page = Page.new data
    page.save

    crawl.retrieve data.urls.map {|url| {url: url}} # => passing Array produces multiple tasks via SQS
    crawl.scrape url: arg.url, page: page # => passes only page.id, rather than whole object, so any object passed via CloudFlow needs object#id and Object#find method.
  end

  func :scrape do |arg|
    data = Scraper.scrape arg.url
    arg.page.update_attributes! data

    crawl.fetch_image urls: data.image_urls do |returned_arg|
      # when it finished
      arg.page.update_attribute! "ready", true
    end
  end

  func :fetch_image do |arg|
    Fetcher.fetch arg.url

    crawl.convert_image url: arg.url
  end

  func :convert_image do |arg|
    Converter.convert url: url
  end
end

