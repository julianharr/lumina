class CharitiesController < ApplicationController
  def index
    if params[:query].present?
      @charities = Charity.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @charities = Charity.all
    end
  end
end
