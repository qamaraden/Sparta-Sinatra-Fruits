class PostController < Sinatra::Base

  # puts File.join(File.dirname(__FILE__), '..')

  # set the root of the parent directory of the current File, we've set this value to be the root
  set :root, File.join(File.dirname(__FILE__), '..')

  #sets the views directly correctly
  set :views, Proc.new { File.join(root, "views") }




  configure :development do
    register Sinatra::Reloader
  end

  $fruits = [{
    id: 0,
    title: "Apple",
    body: "An apple is a sweet fruit produced by an apple tree."
},

{
    id: 1,
    title: "Banana",
    body: "A banana is botanically a berry produced by several kinds of large herbaceous flowering plants."
}]

get "/"  do

  @title = "Fruits"

  @posts = $fruits

  erb :'posts/index'

end

get "/new" do
    @title = "New"
    @post = {
      id: "",
      title: "",
      body: ""
    }

  erb :'posts/new'

end

post "/" do
    new_fruit = {
      id: $fruits.length,
      title:params[:title],
      body: params[:body]
    }
    $fruits.push(new_fruit)
    redirect "/"
  end

  get "/:id" do
    id = params[:id].to_i

    @post = $fruits[id]

    erb :'posts/show'


  end

  get "/:id/edit" do
    id = params[:id].to_i
    @title = "Edit"
    @post = $fruits[id]
    @title = "Edit"


  erb :'posts/edit'
  end

  put "/:id" do
    id = params[:id].to_i
    fruit = $fruits[id]

    fruit[:title] = params[:title]
    fruit[:body] = params[:body]

    $fruits[id] = fruit

    redirect "/"
  end

  delete "/:id" do
    id = params[:id].to_i

    $fruits.delete_at(id)

    redirect '/'
  end



end
