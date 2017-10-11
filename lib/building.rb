module Building
  extend ActiveSupport::Concern
  included do

    enum profile: [ :fresh, :used ]
    enum position: [ :front, :back ]

  end
end
