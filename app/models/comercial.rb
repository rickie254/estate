class Comercial < Property
  include Building
  monetize :condominium_cents, allow_nil: true

  enum comercial_kind: [ :air, :ground, :residential, :pavilion, :general ]

  def self.query_for_listing filter
    if filter && filter[:comercial_kind]
      where(comercial_kind: filter[:comercial_kind])
    else
      all
    end
  end
end
