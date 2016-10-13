class AnimalsController < ApplicationController

	get '/animals' do
		@animals = Animal.all
		erb :'/animals/index'
	end

	# create new animal

	get '/animals/new' do
		if logged_in?
			erb :'/animals/new'
		else
			erb :'/signup'
		end
	end

	post '/animals' do
		if logged_in?
			@animal = current_user.animals.create(name: params[:name], species: params[:species], description: params[:description])
			redirect "/animal/#{@animal.id}"
		else
			redirect '/animals/new'
		end
	end

	# show single animal

	get '/animal/:id' do
		@animal = Animal.find(params[:id])
		erb :'/animals/show'
	end	

	# edit actions

	get '/animal/:id/edit' do
		@animal = Animal.find(params[:id])
		if logged_in? && current_user.id == @animal.user.id
			erb :'/animals/edit'
		else
			redirect '/login'
		end
	end

	patch '/animal/:id' do
		@animal = Animal.find(params[:id])
		if logged_in? && current_user.id == @animal.user.id && params[:name] != ""
			@animal.update(:name => params[:name], :description => params[:description])
		end
		redirect "/animal/#{@animal.id}"
	end

	patch '/animal-attributes/:id' do
		@animal = Animal.find(params[:id])
		if logged_in? && current_user.id == @animal.user.id
			@animal.update(appetite: @animal.appetite - 1, happiness: @animal.happiness + 1)
			case appropriate_food
			when "bamboo shoots"
				@animal.user.update(bamboo_shoots: @animal.user.bamboo_shoots - 1)
			when "fish"
				@animal.user.update(fish: @animal.user.fish - 1)
			when "fruits"
				@animal.user.update(fruits: @animal.user.fruits - 1)
			when "grass"
				@animal.user.update(grass: @animal.user.grass - 1)
			when "meat"
				@animal.user.update(meat: @animal.user.meat - 1)
			end
		end
		redirect "/animal/#{@animal.id}"
	end

	# delete action

	delete '/animal/:id' do
		@animal = Animal.find(params[:id])
		@user = User.find(session[:user_id])
		if logged_in? && current_user.id == @animal.user.id
			@animal.destroy
			redirect "/user/#{@user.id}"
		else
			redirect "/animal/#{@animal.id}"
		end
	end

end