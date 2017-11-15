# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://zordanimoveis.com.br"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.public_path = 'tmp/'

SitemapGenerator::Sitemap.sitemaps_host = ENV['S3_URL']

SitemapGenerator::Sitemap.create do
  add root_path

  add apartments_path
  add houses_path
  add comercials_path
  add terrains_path

  add new_customer_property_path

  Property.find_each do |property|
    add property, :lastmod => property.updated_at
  end

end
