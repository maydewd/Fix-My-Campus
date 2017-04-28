class SchoolsController < ApplicationController
    before_action :set_school, only: [:show, :stats]
    
    # GET /schools
    def index
        @schools = School.all
    end
    
    # GET /duke
    # GET /fakeschool (404)
    # GET /duke.json
    def show
        @posts = @school.posts
                        .filter_status(params[:statuses])
                        .search(params[:query])
                        .complex_order(params[:sort])
                        .paginate(:page => params[:page], :per_page => 20)
    end
    
    # GET /duke
    # GET /fakeschool (404)
    # GET /duke.json
    def stats
        @most_liked_post = @school.posts.complex_order('top').first
        @most_commented_post = @school.posts.order("comments_count DESC").first
        @average_post_likes = @school.posts.average('likes_count + legacy_numlikes') || 0
        @average_post_comments = @school.posts.average('comments_count') || 0
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
        @school = School.find_by(nickname: params[:nickname])
    end
end
