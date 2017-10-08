class House < Property
	validates :number_of_rooms, presence: true
end
