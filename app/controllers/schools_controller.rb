class SchoolsController < ApplicationController
    
    # GET /schools
    def index
        @schools = School.all
    end
    
    # GET /duke
    # GET /fakeschool (404)
    # GET /duke.json
    def show
        @school = School.find_by(nickname: params[:nickname]) || render_404 
        @posts = @school.posts.filter_status(params[:statuses]).search(params[:query]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
    end
end
