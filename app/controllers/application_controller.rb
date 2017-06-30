class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  patch '/recipes/:id' do
    binding.pry
    @recipe = Recipe.find(params[:id])
    @recipe.update(params[:recipe])
    redirect "/recipes/#{params[:id]}"
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @deleted_recipe = @recipe.name
    Recipe.destroy(params[:id])
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
 end

  post '/recipes' do
    @recipe = Recipe.create(params[:recipe])
    redirect "/recipes/#{@recipe.id}"
  end

end
