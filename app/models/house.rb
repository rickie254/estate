class House < Property
	include Building

	# validates :number_of_rooms, presence: true
	# validates :profile, presence: true

  def self.query_for_listing filter
    if filter
      if filter[:number_of_rooms]
				if filter[:number_of_rooms] == 4
					where("number_of_rooms >= 4")
				else
					where("number_of_rooms = ?", filter[:number_of_rooms])
				end
      end
    else
      all
    end
  end


end
