class FilterController < ApplicationController
  def index
    @id = params[:id]
  end

  def apply_filters 
    binding.pry
    1
  end
end