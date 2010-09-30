class ProjectsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  respond_to :html, :js
  
  def index
    params[:page] ||= 1
    params[:search] ||= params[:term]
    @projects = Project.search(params[:search], params[:page], sort_column, sort_direction)
    
    respond_with @projects do |format|
      format.js   { render :action => "index", :layout => false }
    end
  end

  def show
    @project = Project.find(params[:id])
    @users_total = @project.activities.hours_by_user
    @users_billed = @project.activities.billed.hours_by_user
    @users_nonbilled = @project.activities.non_billed.hours_by_user
    @services_total = @project.activities.hours_by_service
    @services_billed = @project.activities.billed.hours_by_service
    @services_nonbilled = @project.activities.non_billed.hours_by_service
    @types_total = @project.activities.hours_by_activity_type
    @types_billed = @project.activities.billed.hours_by_activity_type
    @types_nonbilled = @project.activities.non_billed.hours_by_activity_type
    respond_with @project do |format|
      format.js   { render :layout => false }
    end
  end

  def new
    @project = Project.new
    respond_with @project do |format|
      format.html { render :action => "show" }
    end
  end

  def edit
    @project = Project.find(params[:id])
    respond_with @project do |format|
      format.js { render :action => "edit", :layout => false }
    end
  end
  
  def create  
    @project = Project.new(params[:project])
    @project.save
    
    respond_with @project do |format|
      if @project.invalid?
        format.js { render :action => "error", :layout => false }
      else
        format.js { render :action => "update", :layout => false }
      end
    end
  end

  def update
    @project = Project.find(params[:id])

    respond_with @project.update_attributes(params[:project]) do |format|
      if @project.invalid?
        format.js { render :action => "error", :layout => false }
      else
        format.js { render :action => "update", :layout => false }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_with @project
  end
  
  def list_action
    case params[:action_type]
    when 'delete'
      params[:action_id].each do |id|
        @project = Project.find(id)
        @project.destroy
      end
      params[:page] ||= 1
      @projects = Project.search(params[:search], params[:page], sort_column, sort_direction)
      respond_with @projects do |format|
        format.js   { render :action => "destroy", :layout => false }
      end
    end
  end
  
  private
  
  def sort_column
    session[:project_sort_column] ||= 'number'
    session[:project_sort_column] = Project.column_names.include?(params[:sort]) ? params[:sort] : session[:project_sort_column]
  end
  
  def sort_direction
    session[:project_sort_direction] ||= 'desc'
    session[:project_sort_direction] = %w[asc desc].include?(params[:direction]) ? params[:direction] : session[:project_sort_direction]
  end
end
