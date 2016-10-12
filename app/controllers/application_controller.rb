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
  		redirect '/'
  	else
	  	erb :signup
	  end
  end

  post '/signup' do
  	redirect '/animals/new'
  end

  get '/login' do
  	if logged_in?
  		redirect '/'
  	else
  		erb :login
  	end
  end

  post '/login' do
  	redirect 'animals'
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