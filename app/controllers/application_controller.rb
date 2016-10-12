require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  	erb :index
  end

  get '/signup' do
  	if logged_in?
  		redirect '/user/:id'
  	else
  		erb :signup
  	end
  end

  post '/signup' do
  	@user = User.new(:username => params[:username], :password => params[:password])
  	@user.save
  	if @user.save && @user.username != "" && @user.password != ""
  		redirect '/login'
  	else
  		redirect '/signup'
	  end
  end

  get '/login' do
  	if logged_in?
  		redirect '/'
  	else
  		erb :login
  	end
  end

  post '/login' do
  	@user = User.find_by(:username => params[:username])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect :'/user/:id'
  	else
  		redirect '/failure'
  	end
  end

  get 'logout' do
  	session.clear
  	redirect '/login'
  end

  helpers do

  	def logged_in?
  		!!session[:user_id]
  	end

  	def current_user
  		User.find(session[:user_id])
  	end

  end

end