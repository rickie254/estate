module Building
  extend ActiveSupport::Concern
  included do
    enum profile: [ :fresh, :used ]
  end
end
