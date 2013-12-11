class Place < ActiveRecord::Base
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "200x200>" }
	has_many :comments
	has_many :ratings

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

	def scoreme
		self.kid_menu ? kid_menu = 100 : kid_menu = 0

		boosters = self.boosters ? 75 : 0
		high_chairs = self.high_chairs ? 100 : 0
		changing_table = self.changing_table ? 80 : 0

		noise = self.noise_level.to_i * 20

		total = (kid_menu + boosters + noise + high_chairs + changing_table + 55) / 5


	end

end
