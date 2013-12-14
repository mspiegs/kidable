class PlacesController < ApplicationController
	include PlacesHelper

	before_filter :check_admin, only: :edit
	before_filter :set_place, only: [:show, :destroy, :update, :edit, :scoreme]

	def index
			@place = Place.new
			@search_terms = (params[:search].present? ? params[:search] : [])
			@selected_filters = (params[:filter].present? ? params[:filter] : [])
			@selected_types = (params[:filter_types].present? ? params[:filter_types] : [])
			if @selected_types == [] && @search_terms == []
				params[:filter] || params[:filter_types] ? @places = Place.where(city: params[:filter]) : @places = Place.all
			elsif @selected_filters == [] && @search_terms == []
				params[:filter] || params[:filter_types] ? @places = Place.where(place_type: params[:filter_types]) : @places = Place.all
			elsif @search_terms != []
				@places = Place.search(@search_terms)
			else
				params[:filter] || params[:filter_types] ? @places = Place.where(city: params[:filter], place_type: params[:filter_types]) : @places = Place.all
			end
			


	end

	def show
		if @place.ratings != []
			@rating = Rating.where(place_id: @place.id, user_id: current_user.id).first
		else
			@rating = Rating.create(place_id: @place.id, user_id: current_user.id, score: 0)
		end

	end

	def new
		@place = Place.new
	end

	def edit
	end

	def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
	end


	def create
		@place = Place.new(place_params)

		respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render json: @place, status: :created, location: @place }
      else
        format.html { render action: 'new' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
	end

	def city
		@places = Place.where("city like ?", params[:city])
	end




	private

		def check_admin
			redirect_to place_path and return unless current_user.admin?
		end

		def set_place
			@place = Place.find(params[:id])
		end

		def place_params
			params.require(:place).permit(:name, :address, :address2, :city, :state, :zip, :phone, :kid_menu, :high_chairs, :boosters, :approve_kids, :changing_table, :score, :noise_level, :avatar, :place_type)
		end
end
