class PostsController < ApplicationController
  def index
    @posts = Post.all
    # render :template => "posts/index" already know this

    # alternative responses to requests other than HTML
    respond_to do |format| # in our response, format.html
      format.html # implicitly renders template posts/index.html.erb
      format.json do # when get request in the format of json, let's render it as json
        render :json => @posts # take posts array, builds up that structure
      end
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @post = Post.new
      @post["body"] = params["post"]["body"]
      @post["image"] = params["post"]["image"]
      @post["user_id"] = @user["id"]
      @post.save
    else
      flash["notice"] = "Login first."
    end
    redirect_to "/posts"
  end

  before_action :allow_cors
  def allow_cors
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email'
    response.headers['Access-Control-Max-Age'] = '1728000'
  end
end
