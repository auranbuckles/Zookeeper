class UsersController < ApplicationController

	get '/user/:id' do
		@user = User.find(params[:id])
		erb :'/users/show'
	end

end