class Place < ActiveRecord::Base
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "200x200>" }
	has_many :comments
	has_many :ratings
	geocoded_by :address_create

	before_save :scoreme_new
	after_validation :geocode

	scope :san_diego, -> { where("city like ?", "%San Diego%") }

	validates :address, presence: true

	def self.search(search)
		if search
			where("name like ?", "%#{search}%")
		else
			find(:all)
		end
	end

	def average_rating
		Float(self.ratings.sum(:score)) / Float(self.ratings.size)
	end

	def scoreme_new
			kid_menu = self.kid_menu ? 80 : 20

			self.boosters ? boosters = 50 : boosters = 25
			self.high_chairs ? high_chairs = 100 : high_chairs = 5
			self.changing_table ? changing_table = 90 : changing_table = 15
			noise = self.noise_level.to_i * 20
			if self.average_rating.nan?
				place_rating = 25
			elsif self.average_rating == 0.0
				place_rating = 25
			else 
				place_rating = self.average_rating * 40.0
			end
				
			total = kid_menu + boosters + noise + high_chairs + changing_table + place_rating

			score1 = (Float(total)/620.0) * 100
			self.score = score1
	end


	def scoreme
		kid_menu = self.kid_menu ? 80 : 20

		self.boosters ? boosters = 50 : boosters = 25
		self.high_chairs ? high_chairs = 100 : high_chairs = 5
		self.changing_table ? changing_table = 90 : changing_table = 15
		noise = self.noise_level.to_i * 20
		if self.average_rating == 0.0
			rating = 25
		else 
			rating = self.average_rating * 40.0
		end
		total = kid_menu + boosters + noise + high_chairs + changing_table + rating

		score1 = (Float(total)/620.0) * 100 

		self.update_columns(score: score1)


	end

	def address_create
		self.address + ' ' + self.city + ', ' + self.state
	end

end
