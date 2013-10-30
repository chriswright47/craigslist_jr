get '/' do
  # Look in app/views/index.erb
  @categories = Category.all
  erb :index
end

get '/posts/:category' do
  @posts = Category.find_by_title(params[:category]).posts
  @category = params[:category]
  erb :posts
end

get '/newpost/:cat_name' do
  @category = params[:cat_name]
  erb :newpost
end

post '/newpost/:cat_name' do
  cat_id = Category.find_by_title(params[:cat_name]).id
  rand_arr = []
  rand_arr << ('0'..'9').to_a
  rand_arr << ('a'..'z').to_a
  edit_url = rand_arr.flatten.shuffle.slice(0, 6).join('')

  Post.create!( content: params[:content],
                price: params[:price],
                email: params[:email],
                category_id: cat_id,
                edit_url: edit_url
                )
  redirect '/posts/<%= params[:cat_name]'
end

get '/edit/:edit_url' do
  @post = Post.find_by_edit_url(params[:edit_url])
  erb :edit
end

post '/edit/:id' do
  post = Post.find(params[:id])
  post.update_attributes(content: params[:content],
                          price: params[:price],
                          email: params[:email] )
    redirect '/'
end

post '/delete/:id' do
  Post.find(params[:id]).destroy
  redirect '/'
end

