class AnimalsController < ApplicationController

	get '/animals' do
		if logged_in?
			@user = User.find(session[:user_id])
			if @user.animals
				@animals = @user.animals
			else
				render "You currently do not have any animals."
			end
			erb :'/animals/index'
		else
			redirect '/signup'
		end
	end

	# create animals

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

	get '/animals/:id' do

	end	

end