enable :sessions

get '/' do
  @posts = Post.all
  erb :index
end

get '/login' do
  erb :login
end

get '/posts/:post_id/show' do
  @post = Post.find(params[:post_id])
  @comments = @post.comments
  erb :post
end

post '/user/new' do
  @user = User.new(params[:user])
  #if @user something....
  @user.save
  session[:id] = @user.id
  redirect '/user/profile'
end

post '/user/login' do
  @user = User.where(params[:user]).first
  session[:id] = @user.id
  @user
  redirect '/user/profile'
end

get '/user/profile' do
  if session[:id] != nil
    @user = User.find(session[:id])
    @comments = @user.comments
    erb :profile
  else
    redirect '/login'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get "/posts/:post_id/new/comment" do
  if session[:id] != nil
    @post = Post.find(params[:post_id])
    erb :comment
  else
   redirect '/login'
  end
end 

post "/posts/:post_id/new/comment" do
  @comment = Comment.create(content: params[:content], user: User.find(session[:id]), post: Post.find(params[:post_id]))
  # @comment.save 
  redirect "/posts/#{params[:post_id]}/show"
end 

get "/new/post" do
  erb :new_post
end

post "/new/post" do
  @post = Post.create(title: params[:title], content: params[:content], user: User.find(session[:id]))
  redirect "/"
end
