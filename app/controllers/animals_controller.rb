class AnimalsController < ApplicationController

	get '/animals' do
		@animals = Animal.all
		erb :'/animals/index'
	end

	get '/animals/new' do
		if logged_in?
			erb :'/animals/new'
		else
			erb :'/signup'
		end
	end

	post '/animals' do
		if params[:name] != "" && params[:species] != ""
			@animal = Animal.new(name: params[:name], species: params[:species], description: params[:description])
			@user = User.find(session[:user_id])
			@animal.user_id = @user.id
			@animal.save
			redirect_to '/animals/#{@animal.id}'
		else
			redirect_to '/animals/new'
		end
	end

	# show actions

	get '/animal/:id' do
		@animal = Animal.find(params[:id])
		erb :'/animals/show'
	end	

end