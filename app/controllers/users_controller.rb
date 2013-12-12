class UsersController < ApplicationController

	before_filter :check_admin, only: :index

	def index
		@users = User.all
	end

	private


		def check_admin
			redirect_to places_path and return unless current_user.admin?
		end




end
