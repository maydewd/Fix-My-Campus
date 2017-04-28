class SchoolsController < ApplicationController
    before_action :set_school, only: [:show, :stats]
    
    # GET /schools
    # GET /schools.json
    def index
        @schools = School.all
    end
    
    # GET /schools/duke
    # GET /schools/fakeschool (404)
    # GET /schools/duke.json
    def show
        @posts = @school.posts
                        .filter_status(params[:statuses])
                        .search(params[:query])
                        .complex_order(params[:sort])
                        .paginate(:page => params[:page], :per_page => 20)
    end
    
    # GET /schools/duke/stats
    # GET /schools/fakeschool/stats (404)
    # GET /schools/duke/stats.json
    def stats
        @most_liked_post = @school.posts.complex_order('top').first
        @most_commented_post = @school.posts.order("comments_count DESC").first
        @average_post_likes = @school.posts.average('likes_count + legacy_numlikes') || 0
        @average_post_comments = @school.posts.average('comments_count') || 0
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
        @school = School.find_by(nickname: params[:nickname]) || render_404
    end
end
