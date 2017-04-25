class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :like, :unlike]
    before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
    
    # GET /posts/1
    # GET /posts/1.json
    def show
    end
    
    # GET /posts/new
    def new
        @post = Post.new
    end
    
    # GET /posts/1/edit
    def edit
        unless current_user == @post.user
            respond_to do |format|
                format.html { redirect_to @post, notice: 'You can only edit your own posts' }
            end
        end
    end
    
    # POST /posts
    # POST /posts.json
    def create
        @post = Post.new(post_params)
        @post.user = current_user
        @post.school = current_user.school
        
        respond_to do |format|
          if @post.save
            format.html { redirect_to @post, notice: 'Post was successfully created.' }
            # format.json { render :show, status: :created, location: @movie }
          else
            format.html { render :new }
            # format.json { render json: @movie.errors, status: :unprocessable_entity }
          end
        end
    end
    
    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
        if current_user == @post.user
            respond_to do |format|
                if @post.update(post_params)
                    format.html { redirect_to @post, notice: 'Post was successfully updated.' }
                    # format.json { render :show, status: :ok, location: @movie }
                else
                    format.html { render :edit }
                    # format.json { render json: @movie.errors, status: :unprocessable_entity }
                end
            end
        else
            respond_to do |format|
                format.html { redirect_to @post, notice: 'Post was not updated. You can only update your own posts' }
                # format.json { head :no_content }
            end
        end

    end
    
    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
        if current_user == @post.user
            @post.destroy
            respond_to do |format|
                format.html { redirect_to @post, notice: 'Post was successfully destroyed.' }
                # format.json { head :no_content }
            end
        else
            respond_to do |format|
                format.html { redirect_to @post, notice: 'Post was not destroyed. You can only delete your own posts' }
                # format.json { head :no_content }
            end
        end
        
    end
    
    # POST /posts/1/like
    def like
        unless current_user.liked_posts.include? @post
            like = Like.new
            like.user = current_user
            like.post = @post
            like.save
        end
    end
    
    # POST /posts/1/unlike
    def unlike
        like = Like.find_by ({user: current_user, post: @post})
        like.destroy if like
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id]) || render_404
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:message)
    end
end
