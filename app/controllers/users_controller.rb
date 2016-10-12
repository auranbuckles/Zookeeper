class UsersController < ApplicationController

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
		if logged_in? && current_user == @user
			@user.update(bamboo_shoots: @user.bamboo_shoots + 5)
			redirect "/user/#{@user.id}"
		else
			redirect "/user/#{@user.id}/edit"
		end
	end

end