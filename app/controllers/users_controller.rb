class UsersController < ApplicationController

	# index – all users
	get '/users' do
		@users = User.all
		erb :'/users/index'
	end

	# show action
	# redirected after login

	get '/user/:id' do
		@user = User.find(params[:id])
		@animals = @user.animals
		erb :'/users/show'
	end

	# edit action
	# purchase more food

	get '/user/:id/edit' do
		# if logged_in?
			@user = User.find(params[:id])
			erb :'/users/edit'
		# else
		# 	redirect '/login'
		# end
	end

	patch '/user/:id' do
		@user = User.find(params[:id])
		# if logged_in? && current_user == @user
			@user.update(bamboo_shoots: @user.bamboo_shoots + params[:bamboo_shoots].to_i)
			@user.update(fish: @user.fish + params[:fish].to_i)
			@user.update(fruits: @user.fruits + params[:fruits].to_i)
			@user.update(grass: @user.grass + params[:grass].to_i)
			@user.update(meat: @user.meat + params[:meat].to_i)
			redirect "/user/#{@user.id}"
		# else
		# 	redirect "/user/#{@user.id}/edit"
		# end
	end

end