require 'sinatra/base'
require 'rdiscount'

class SinWiki < Sinatra::Base

  def view_page(page)
    if File.exists?("datastore/#{page}.md")
      erb :view
    else
      redirect "/pages/#{page}/edit"
    end
  end

  def edit_page(page)
    erb :edit
  end

  def delete_page(page)
    if File.exists?("datastore/#{page}.md")
      File.delete("datastore/#{page}.md")
    end
    redirect '/pages/MainPage'
  end

  get '/' do
    redirect '/pages/MainPage'
  end

  get '/pages/:page/?:action?/?' do
    if params[:action] == 'edit'
      edit_page(params[:page])
    elsif params[:action] == 'delete'
      delete_page(params[:page])
    else
      view_page(params[:page])
    end
  end

  post '/pages/:page/edit/?' do
    File.write("datastore/#{params[:page]}.md", params[:textarea])
    redirect "/pages/#{params[:page]}"
  end

end
