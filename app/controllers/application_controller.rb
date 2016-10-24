require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
    set :session_secret, "animalsarecute"
  end

  get '/' do
    @users = User.all
  	erb :index
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

  	def username_exists?
      User.find_by(:username => params[:username])
    end

    def is_authorized?
      @user = User.find(params[:id])
      current_user.id == @user.id
    end

    def appropriate_food
      species = @animal.species
      case species
      when "dolphin", "penguin", "brown bear", "polar bear", "seal"
        "fish"
      when "panda"
        "bamboo shoots"
      when "elephant", "monkey", "sloth", "ape"
        "fruits"
      when "lion", "tiger", "cheetah", "red fox", "wolf"
        "meat"
      when "kangaroo", "zebra", "buffalo", "elk", "deer", "rhino"
        "grass"
      end
    end

  end

end