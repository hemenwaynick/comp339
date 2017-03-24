class PostsController < ApplicationController
  def errorGen
    random1 = Random.new.rand(10)
    random2 = Random.new.rand(4)
    if random1 == 0
      if (random2 == 0) 
        @error_message = "Db connection lost. Could not establish connection."
      elsif (random2 == 1)
        @error_message = "Db connection lost. Transaction was chosen as a deadlock victim."
      elsif (random2 == 2)
        @error_message = "Latency."
      elsif (random2 == 3)
        @error_message = "Unexpected random value."
      end
      render(:file => 'errors/show', :status => 404, :layout => false)
    else
       yield
    end
  end 

  def index
    @posts = Post.all
  end

  def show
    errorGen {
      @post = Post.find(params[:id])
    }
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    errorGen {
      @post = Post.new(post_params)

      if @post.save
        redirect_to @post
      else
        render 'new'
      end
    }
  end

  def update
    errorGen {
      @post = Post.find(params[:id])

      if @post.update(post_params)
        redirect_to @post
      else
        render 'edit'
      end
    }
  end

  def destroy
    errorGen {
      @post = Post.find(params[:id])
      @post.destroy

      redirect_to posts_path
    }
  end

  private
    def post_params
      params.require(:post).permit(:title, :text)
    end
end
