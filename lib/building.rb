module Building
  extend ActiveSupport::Concern
  included do

    enum profile: [ :fresh, :used ]
    enum positions: [ :front, :back ]

  end
end
