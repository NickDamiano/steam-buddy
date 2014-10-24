class FilterController < ApplicationController
  def index
    @id = params[:id]
  end
end