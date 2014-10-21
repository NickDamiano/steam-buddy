require 'net/http'

class HomeController < ApplicationController
  def index
  end

  def main
    @user = params[:user]

    #call steam api
    #get the user
    #parse

  end

end
