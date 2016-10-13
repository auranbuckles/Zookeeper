require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
    set :session_secret, "animalsarecute"
  end

  get '/' do
  	erb :index
  end

  get '/signup' do
  	if flash[:error]
  		flash[:error] = "Username and password fields required."
  	end
  	if logged_in?
      @user = current_user
      redirect "/user/#{@user.id}"
  	else
  		erb :signup
  	end
  end

  post '/signup' do
  	@user = User.new(:username => params[:username], :password => params[:password])
  	if @user.valid? && username_exists? == nil
  		@user.save
  		session[:user_id] = @user.id
  		redirect "/user/#{@user.id}"
  	else
  		flash[:error]
  		redirect '/signup'
	  end
  end

  get '/login' do
  	if logged_in?
      @user = current_user
  		redirect "/user/#{@user.id}"
  	else
  		erb :login
  	end
  end

  post '/login' do
  	@user = User.find_by(:username => params[:username])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect "/user/#{@user.id}"
  	else
  		redirect '/login'
  	end
  end

  get '/logout' do
  	session.clear
  	redirect '/'
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
      when "dolphin" || "penguin" || "brown bear" || "polar bear" || "seal"
        "fish"
      when "panda"
        "bamboo shoots"
      when "elephant" || "monkey" || "sloth" || "ape"
        "fruits"
      when "lion" || "tiger" || "cheetah" || "red fox" || "wolf"
        "meat"
      when "kangaroo" || "zebra" || "buffalo" || "elk" || "deer" || "rhino"
        "grass"
      end
    end

  end

end