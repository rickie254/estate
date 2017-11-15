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

  House.find_each do |house|
    add house_path(house.id), :lastmod => house.updated_at
  end

  Apartment.find_each do |apartment|
    add apartment_path(apartment.id), :lastmod => apartment.updated_at
  end

  Comercial.find_each do |comercial|
    add comercial_path(comercial.id), :lastmod => comercial.updated_at
  end

  Terrain.find_each do |terrain|
    add terrain_path(terrain.id), :lastmod => terrain.updated_at
  end

end
