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