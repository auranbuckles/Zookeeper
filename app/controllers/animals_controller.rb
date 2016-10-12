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
		if params[:name] != "" && params[:species] != ""
			@animal = Animal.new(name: params[:name], species: params[:species], description: params[:description])
			@user = User.find(session[:user_id])
			@animal.user_id = @user.id
			@animal.save
			redirect '/animals/#{@animal.id}'
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
		if logged_in?
			@animal = Animal.find(params[:id])
			erb :'/animals/edit'
		else
			redirect '/login'
		end
	end

	patch '/animal/:id' do
		@animal = Animal.find(params[:id])
		if logged_in? && @animal.user = current_user && params[:name] != ""
			@animal.update(:name => params[:name], :description => params[:description])
		end
		redirect "/animal/#{@animal.id}"
	end

	# delete action

	delete '/animal/:id' do
		@animal = Animal.find(params[:id])
		@user = User.find(session[:user_id])
		if current_user.id == @animal.user_id
			@animal.destroy
			redirect "/user/#{@user.id}"
		else
			redirect "/animal/#{@animal.id}"
		end
	end

end