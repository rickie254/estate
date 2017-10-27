class Terrain < Property
  enum terrain_kind: [ :rural, :farm, :residential, :comercial, :condominium ]

  def self.query_for_listing filter
    if filter && filter[:terrain_kind]
      where(terrain_kind: filter[:terrain_kind])
    else
      all
    end
  end
end
