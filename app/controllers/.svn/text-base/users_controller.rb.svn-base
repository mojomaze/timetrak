class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  respond_to :html, :js
  
  # GET /users
  def index
    params[:page] ||= 1
    params[:search] ||= params[:term]
    @users = User.search(params[:search], params[:page], sort_column, sort_direction)
    respond_with @users
  end
  
  # GET /users/1
  # GET /users/1.js
  def show
    @user = User.find(params[:id])
    respond_with @user do |format|
      format.js   { render :layout => false }
    end
  end

  # GET /users/new
  def new
    @user = User.new
    respond_with @user do |format|
      format.html { render :action => "show" }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    respond_with @user do |format|
      format.js { render :action => "edit", :layout => false }
    end
  end
  
  # POST /users
  def create
    @user = User.new(params[:user])
    @user.save
    respond_with @user do |format|
      if @user.invalid?
        format.js { render :action => "error", :layout => false }
      else
        format.js { render :action => "update", :layout => false }
      end
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    respond_with @user.update_attributes(params[:user]) do |format|
      if @user.invalid?
        format.js { render :action => "error", :layout => false }
      else
        format.js { render :action => "update", :layout => false }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with @user
  end
  
  def list_action
    case params[:action_type]
    when 'delete'
      params[:action_id].each do |id|
        @user = User.find(id)
        @user.destroy
      end
      params[:page] ||= 1
      @users = User.search(params[:search], params[:page], sort_column, sort_direction)
      respond_with @users do |format|
        format.js   { render :action => "destroy", :layout => false }
      end
    end
  end
  
  private
  
  def sort_column
    # set defualt sort column
    
    session["user_sort_column"] ||= 'username'
    session["user_sort_column"] = User.column_names.include?(params[:sort]) ? params[:sort] : session["user_sort_column"]
  end
  
  def sort_direction
    # set default sort direction
    session["user_sort_direction"] ||= 'asc'
    session["user_sort_direction"] = %w[asc desc].include?(params[:direction]) ? params[:direction] : session["user_sort_direction"]
  end
end
