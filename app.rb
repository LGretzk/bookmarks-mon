require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/bookmarks'
require_relative 'database_connection_setup'
require 'uri'
require 'sinatra/flash'
require_relative './lib/comment'

class BookmarkManager < Sinatra::Base
  enable :method_override, :sessions
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World'
  end

  get '/bookmarks' do 
    @bookmarks = Bookmarks.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/add' do
    erb :'bookmarks/add'
  end

  post '/bookmarks' do
    url = params[:new_url]
    title = params[:title]
    flash[:notice] = "You must submit a valid URL." unless Bookmarks.add(url, title)
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmarks.delete(params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmarks.find(params[:id])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmarks.update(params[:url], params[:title], params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(params[:comment], params[:id])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end