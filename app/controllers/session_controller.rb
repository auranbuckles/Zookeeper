class SessionController < ApplicationController

  get '/signup' do
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

end