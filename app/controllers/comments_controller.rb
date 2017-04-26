class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_comment, only: :destroy
    before_action :set_post, only: :create
    
    # POST /posts/:post_id/comments
    # POST /posts/:post_id/comments.json
    def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.post = @post
        
        respond_to do |format|
          if @comment.save
            format.html { redirect_to @post, notice: 'Comment was successfully created.' }
            # format.json { render :show, status: :created, location: @movie }
          else
            format.html { render :new }
            # format.json { render json: @movie.errors, status: :unprocessable_entity }
          end
        end
    end
    
    # DELETE /comments/1
    # DELETE /comments/1.json
    def destroy
        if current_user == @comment.user
            @comment.destroy
            respond_to do |format|
                format.html { redirect_to @comment.post, notice: 'Comment was successfully destroyed.' }
                # format.json { head :no_content }
            end
        else
            respond_to do |format|
                format.html { redirect_to @comment.post, notice: 'Comment was not destroyed. You can only delete your own comments.' }
                # format.json { head :no_content }
            end
        end
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id]) || render_404
    end
    
    def set_post
      @post = Post.find(params[:post_id]) || render_404
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:message)
    end
end
