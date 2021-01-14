class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :show_exceptions, true   
  end

  get '/' do 
    redirect '/recipes'
  end

  get '/recipes/new' do #loads new form
    erb :new
  end

  #home pg - list w/ link
  get '/recipes' do
    @recipe = Recipe.all 
    erb :index
  end

  # view recipe
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show 
  end

  get '/recipes/:id/edit' do 
    @recipe = Recipe.find(params[:id])
    erb :edit 
  end

  #creates a recipe
  post '/recipes' do  
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  #delete recipe
  delete '/recipes/:id' do
    @recipe = Recipe.delete(params[:id])
    redirect '/recipes'
  end 

  #updates a recipe
  patch '/recipes/:id' do
    params.delete("_method")
    @recipe = Recipe.find(params[:id])
    @recipe.update(params)

    redirect "/recipes/#{@recipe.id}"
  end

end
