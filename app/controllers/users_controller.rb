class UsersController < ApplicationController

	get '/user/:id' do
		@user = User.find(params[:id])
		@animals = @user.animals
		erb :'/users/show'
	end

end