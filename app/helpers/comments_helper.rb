module CommentsHelper
	def set_place
		@place = Place.find(params[:place_id])
	end
end
