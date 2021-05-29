class Api::V1::AvailableRestaurantsController < ApplicationController
  def index
    if available_restaurants_service.perform
      render json: available_restaurants_service.collection
    else
      render json: { errors: available_restaurants_service.errors }, status: :unprocessable_entity
    end
  end

  private

  def available_restaurants_service
    @_available_restaurants_service ||= AvailableRestaurantsService.new(params)
  end
end
