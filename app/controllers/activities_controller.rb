class ActivitiesController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  respond_to :html, :xml, :json, :js
 
  def index
    params[:page] ||= 1
        
    @activities = Activity.search(params[:search], params[:page], current_user, sort_column, sort_direction)
    
    respond_with @activities do |format|
      format.js   { render :layout => false}
    end
  end

  def show
    respond_with @activity = Activity.find(params[:id]) do |format|
      format.js   { render :layout => false }
    end
  end

  def new
    @activity = Activity.new(:activity_date => Date.today, :start_time => Time.parse("00:00"), :end_time => Time.parse("00:00"))
    respond_with @activity 
  end

  def edit
    @activity = Activity.find(params[:id])
    respond_with @activity do |format|
      format.js { render :action => "edit", :layout => false }
    end
  end

  def create
    @activity = Activity.new(params[:activity])
    respond_with @activity.save do |format|
      if @activity.invalid?
        # format.js   { render :action => "error", :layout => false }
        return_data = Hash.new()
        return_data[:success] = false
        return_data[:id] = "new"
        return_data[:errors] = @activity.errors
        format.js   { render :layout => false, :json => return_data.to_json }
      else
        format.js   { render :action => "create", :layout => false }
      end 
    end
  end

  def update
    @activity = Activity.find(params[:id])
    respond_with @activity.update_attributes(params[:activity]) do |format|
      if @activity.invalid?
        # format.js   { render :action => "error", :layout => false }
        return_data = Hash.new()
        return_data[:success] = false
        return_data[:id] = @activity.id
        return_data[:errors] = @activity.errors
        format.js   { render :layout => false, :json => return_data.to_json }
      else
        format.js  { render :action => "show", :layout => false }
      end
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    respond_with @activity do |format|
      format.js   { render :action => "destroy", :layout => false }
    end
  end
  
  # calender view
  def calendar
    @activities = current_user.activities
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    respond_with @activity
  end
  
  def list_action
    case params[:action_type]
    when 'delete'
      params[:action_id].each do |id|
        @activity = Activity.find(id)
        @activity.destroy
      end
      params[:page] ||= 1
      @activities = Activity.search(params[:search], params[:page], current_user, sort_column, sort_direction)
      respond_with @activities do |format|
        format.js   { render :action => "destroy", :layout => false }
      end
    end
  end
  
  private
  
  def sort_column
    session[:activity_sort_column] ||= 'activity_date'
    session[:activity_sort_column] = Activity.column_names.include?(params[:sort]) ? params[:sort] : session[:activity_sort_column]
  end
  
  def sort_direction
    session[:activity_sort_direction] ||= 'desc'
    session[:activity_sort_direction] = %w[asc desc].include?(params[:direction]) ? params[:direction] : session[:activity_sort_direction]
  end
  
end
